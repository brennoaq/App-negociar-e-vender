import 'package:flutter/material.dart';
import 'package:negociar_e_vender/values.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'db_helper.dart';

class Nova_simulacao2 extends StatefulWidget {
  String ramo;

  Nova_simulacao2(this.ramo);

  @override
  _State createState() => _State(ramo);
}

class _State extends State<Nova_simulacao2> {
  MoneyMaskedTextController controller_debito_concorrente;
  MoneyMaskedTextController controller_credito_concorrente;
  MoneyMaskedTextController controller_debito_oferecido;
  MoneyMaskedTextController controller_credito_oferecido;

  String value;
  String ramo;

  Future<Map<String, Map<String, Concorrente>>> concorrentes;

  _State(this.ramo);

  @override
  void initState() {
    controller_debito_concorrente = MoneyMaskedTextController(
        rightSymbol: '%', decimalSeparator: '.', thousandSeparator: '');
    controller_credito_concorrente = MoneyMaskedTextController(
        rightSymbol: '%', decimalSeparator: '.', thousandSeparator: '');
    controller_debito_oferecido = MoneyMaskedTextController(
        rightSymbol: '%', decimalSeparator: '.', thousandSeparator: '');
    controller_credito_oferecido = MoneyMaskedTextController(
        rightSymbol: '%', decimalSeparator: '.', thousandSeparator: '');

    concorrentes = getConcorrentes();

    super.initState();
  }

  Future<Map<String, Map<String, Concorrente>>> getConcorrentes() async {
    final dbHelper = DatabaseHelper.instance;
    final list = await dbHelper.queryAllRows(DatabaseHelper.tableTaxas);
    final map = Map<String, Map<String, Concorrente>>();
    list.forEach((item) {
      map[item['name']] = (map[item['name']] ?? Map<String, Concorrente>())
        ..[item['ramo']] = Concorrente(item);
    });

    value = map.keys.first;

    return map;
  }

  @override
  void dispose() {
    controller_debito_concorrente.dispose();
    controller_credito_concorrente.dispose();
    controller_debito_oferecido.dispose();
    controller_credito_oferecido.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simulador'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Informações de taxa',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text('Os campos obrigatórios estão sinalizados com *'),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Concorrente *'),
                    FutureBuilder(
                      future: concorrentes,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                          return Text("lista com erro");
                        } else if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return DropdownButton(
                            isExpanded: true,
                            value: value,
                            items: List<DropdownMenuItem>.generate(
                                snapshot.data.length,
                                (index) => DropdownMenuItem(
                                      child: Text(
                                          snapshot.data.keys.toList()[index]),
                                      value: snapshot.data.keys.toList()[index],
                                    )),
                            onChanged: (value) {
                              setState(() {
                                this.value = value;
                              });
                            },
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Débito',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: FutureBuilder(
                            future: concorrentes,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                print(snapshot.error);
                                return Text("lista com erro");
                              } else if (!snapshot.hasData) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Taxa do concorrente *',
                                    labelStyle: TextStyle(fontSize: 13),
                                  ),
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  controller: controller_debito_concorrente
                                    ..updateValue(
                                        snapshot.data[value][ramo].debito),
                                  enabled: false,
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Desconto oferecido *',
                                labelStyle: TextStyle(fontSize: 13)),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            controller: controller_debito_oferecido,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Crédito',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: FutureBuilder(
                            future: concorrentes,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                print(snapshot.error);
                                return Text("lista com erro");
                              } else if (!snapshot.hasData) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return TextField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Taxa do concorrente *',
                                      labelStyle: TextStyle(fontSize: 13)),
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  controller: controller_credito_concorrente
                                    ..updateValue(
                                        snapshot.data[value][ramo].credito),
                                  enabled: false,
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Desconto oferecido *',
                                labelStyle: TextStyle(fontSize: 13)),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            controller: controller_credito_oferecido,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                height: 50,
                color: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        child: Text(
                          'Simular',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        alignment: Alignment.center,
                      ),
                      Align(
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.white,
                        ),
                        alignment: Alignment.centerRight,
                      )
                    ],
                  ),
                ),
              ),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}

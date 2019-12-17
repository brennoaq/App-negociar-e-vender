import 'package:flutter/material.dart';
import 'package:negociar_e_vender/values.dart';

import 'db_helper.dart';

class Nova_simulacao2 extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Nova_simulacao2> {
  TextEditingController controller_debito_concorrente;
  TextEditingController controller_credito_concorrente;

  String value;

  Future<Map<String, Concorrente>> concorrentes;

  _State();

  @override
  void initState() {
    controller_debito_concorrente = TextEditingController();
    controller_credito_concorrente = TextEditingController();

    concorrentes = getConcorrentes();

    super.initState();
  }

  Future<Map<String, Concorrente>> getConcorrentes() async {
    final dbHelper = DatabaseHelper.instance;
    final list = await dbHelper.queryAllRows(DatabaseHelper.tableTaxas);
    final map = Map<String, Concorrente>();
    list.forEach((item) {
      map[item['name']] = Concorrente(item);
    });

    value = map.keys.first;

    return map;
  }

  @override
  void dispose() {
    controller_debito_concorrente.dispose();
    controller_credito_concorrente.dispose();
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
                                      child: Text(snapshot.data.keys.toList()[index]),
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
                                    ..text =
                                        (snapshot.data[value].debito as double)
                                            .toStringAsPrecision(3),
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
                                    ..text =
                                        (snapshot.data[value].credito as double)
                                            .toStringAsPrecision(3),
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

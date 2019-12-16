import 'package:flutter/material.dart';
import 'package:negociar_e_vender/values.dart';

class Nova_simulacao2 extends StatefulWidget {

  String ramo;

  Nova_simulacao2({@required this.ramo});

  @override
  _State createState() => _State(ramo);
}

class _State extends State<Nova_simulacao2> {
  static const _itens_text = ['Burguer king', 'MC Donalds', 'Bobs', 'Subway'];

  TextEditingController controller_debito_concorrente;
  TextEditingController controller_credito_concorrente;

  String value;
  String ramo;

  _State(this.ramo);

  @override
  void initState() {
    controller_debito_concorrente = TextEditingController();
    controller_credito_concorrente = TextEditingController();

//    controller_debito_concorrente.text = taxas[ramo].debito.toStringAsPrecision(3);
//    controller_credito_concorrente.text = taxas[ramo].credito.toStringAsPrecision(3);

    value = _itens_text[0];

    super.initState();
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
                    DropdownButton(
                      isExpanded: true,
                      value: value,
                      items: List<DropdownMenuItem>.generate(
                          _itens_text.length,
                          (index) => DropdownMenuItem(
                                child: Text(_itens_text[index]),
                                value: _itens_text[index],
                              )),
                      onChanged: (value) {
                        setState(() {
                          this.value = value;
                        });
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
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Taxa do concorrente *',
                              labelStyle: TextStyle(fontSize: 13),
                            ),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            controller: controller_debito_concorrente,
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
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Taxa do concorrente *',
                                labelStyle: TextStyle(fontSize: 13)),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            controller: controller_credito_concorrente,
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

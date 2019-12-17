import 'package:flutter/material.dart';
import 'package:negociar_e_vender/main.dart';
import 'package:negociar_e_vender/values.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'db_helper.dart';

class Nova_simulacao3 extends StatefulWidget {
  String ramo;

  Nova_simulacao3(this.ramo);

  @override
  _State createState() => _State(ramo);
}

class _State extends State<Nova_simulacao3> {
  String ramo;

  _State(this.ramo);

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
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Taxas da simulação permitidas',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Todas as taxas simuladas são permitidas.',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      'Ofereça ao seu cliente.',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text('Tipo',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17)),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text('Concorrente',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17)),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text('Proposta',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17)),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text('Débito'),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text('3,5%'),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            '2,5%',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text('Crédito'),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text('4,5%'),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            '4,21%',
                            style: TextStyle(color: Colors.green),
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
                width: double.infinity,
                height: 50,
                color: Colors.grey,
                child: Center(
                  child: Text(
                    'Proposta aceita',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
              onTap: () {
                AlertDialogAceitarProposta(context);
              },
            ),
            GestureDetector(
              child: Container(
                width: double.infinity,
                height: 50,
                color: Colors.white,
                child: Center(
                  child: Text(
                    'Recusar',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

AlertDialogAceitarProposta(context) {
  // configura o button
  Widget HomeButton = FlatButton(
    child: Text(
      "Voltar para inicio",
      style: TextStyle(color: Colors.black),
    ),
    onPressed: () {
      Navigator.popUntil(
          context, ModalRoute.withName(Navigator.defaultRouteName));
    },
  );

  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
    title: Text(
      "Aceite do cliente",
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
    ),
    content: Text("Resposta gravada no banco de dados!"),
    actions: [
      HomeButton,
    ],
  );

  // exibe o dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}

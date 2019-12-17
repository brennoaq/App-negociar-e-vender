import 'package:flutter/material.dart';
import 'package:negociar_e_vender/main.dart';
import 'package:negociar_e_vender/values.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'db_helper.dart';

class Nova_simulacao3 extends StatefulWidget {
  double debito;
  double credito;
  double descontoDebito;
  double descontoCredito;
  double minDebito;
  double minCredito;

  Nova_simulacao3({
    @required this.debito,
    @required this.credito,
    @required this.descontoDebito,
    @required this.descontoCredito,
    @required this.minDebito,
    @required this.minCredito,
  });

  @override
  _State createState() => _State(
      debito, credito, descontoDebito, descontoCredito, minDebito, minCredito);
}

class _State extends State<Nova_simulacao3> {
  double debito;
  double credito;
  double descontoDebito;
  double descontoCredito;
  double minDebito;
  double minCredito;

  _State(this.debito, this.credito, this.descontoDebito, this.descontoCredito,
      this.minDebito, this.minCredito);

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
                          child: Text('${debito.toStringAsPrecision(3)}%'),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            '${descontoDebito.toStringAsPrecision(3)}%',
                            style: TextStyle(
                                color: descontoDebito >= minDebito
                                    ? Colors.green
                                    : Colors.red),
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
                          child: Text('${credito.toStringAsPrecision(3)}%'),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            '${descontoCredito.toStringAsPrecision(3)}%',
                            style: TextStyle(
                                color: descontoCredito >= minCredito
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ),
                      ],
                    ),
                    getTextMin()
                  ],
                ),
              ),
            ),
            getButtonsMin(),
          ],
        ),
      ),
    );
  }

  Widget getTextMin() {
    if (descontoDebito < minDebito || descontoCredito < minCredito) {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
            'O valor de taxa mínima para débito é ${minDebito.toStringAsPrecision(3)}%, enquanto para crédito é ${minCredito.toStringAsPrecision(3)}%.'),
      );
    } else {
      return Container();
    }
  }

  Widget getButtonsMin() {
    if (descontoDebito < minDebito || descontoCredito < minCredito) {
      return GestureDetector(
        child: Container(
          width: double.infinity,
          height: 50,
          color: Colors.grey,
          child: Center(
            child: Text(
              'Reajustar',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      );
    }
    return Column(
      children: <Widget>[
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
            AlertDialogAceitarProposta(context, "Aceite do cliente", "Resposta gravada no banco de dados!");
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
          onTap: () {
            AlertDialogAceitarProposta(context, "Recusado", "A proposta foi recusada!");
          },
        ),
      ],
    );
  }
}

AlertDialogAceitarProposta(context, title, message) {
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
      title,
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
    ),
    content: Text(message),
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
    barrierDismissible: false,
  );
}

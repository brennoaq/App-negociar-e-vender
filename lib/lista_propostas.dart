import 'package:flutter/material.dart';
import 'package:negociar_e_vender/db_helper.dart';
import 'package:negociar_e_vender/values.dart';

class Lista_propostas extends StatefulWidget {
  @override
  _Lista_propostasState createState() => _Lista_propostasState();
}

class _Lista_propostasState extends State<Lista_propostas> {
  Future<List<Proposta_aceita>> propostas;

  _Lista_propostasState() {
    this.propostas = getPropostas();
  }

  Future<List<Proposta_aceita>> getPropostas() async {
    final db = DatabaseHelper.instance;
    final list = await db.queryAllRows(DatabaseHelper.tablePropostas);
    return list.map((item) => Proposta_aceita(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Propostas aceitas"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder(
            future: propostas,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Text("Lista com erro");
              } else if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                if ((snapshot.data as List).isEmpty) {
                  return Center(
                      child: Text('Você não tem propostas aceitas :('));
                } else
                  return ListView(
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}

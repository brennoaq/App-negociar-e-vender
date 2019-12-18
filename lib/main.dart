import 'package:flutter/material.dart';
import 'package:negociar_e_vender/db_helper.dart';
import 'package:negociar_e_vender/lista_propostas.dart';
import 'package:negociar_e_vender/nova_simulacao.dart';

void main() {
  runApp(MaterialApp(home: SafeArea(child: MyApp())));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Simulação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: <Widget>[
              Hero(
                tag: "effect",
                child: RaisedButton(
                  color: Colors.grey,
                  child: Container(
                      width: double.infinity,
                      height: 50,
                      child: Center(
                        child: Text(
                          'Nova simulação',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Nova_simulacao()),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              OutlineButton(
                child: Container(
                    width: double.infinity,
                    height: 50,
                    child: Center(
                        child: Text(
                      'Visualizar propostas aceitas',
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Lista_propostas()),
                  );
                },
                borderSide: BorderSide(
                  color: Colors.grey, //Color of the border
                  style: BorderStyle.solid, //Style of the border
                  width: 2, //width of the border
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text('Limpar banco de dados'),
                onPressed: () async {
                  final db_helper = DatabaseHelper.instance;
                  await db_helper.deleteDatabaseByPath();
                  _displaySnackBar(
                      context, 'Banco de dados excluído com sucesso!');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _displaySnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}

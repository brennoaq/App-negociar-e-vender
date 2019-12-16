import 'package:flutter/material.dart';
import 'package:negociar_e_vender/nova_simulacao.dart';

void main() {
  runApp(MaterialApp(home: SafeArea(child: MyApp())));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simulação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('Nova simulação'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Nova_simulacao()),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text('Visualizar propostas aceitas'),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}

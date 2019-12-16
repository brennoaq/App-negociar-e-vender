import 'package:flutter/material.dart';
import 'package:negociar_e_vender/nova_simulacao2.dart';
import 'package:negociar_e_vender/values.dart';

import 'db_helper.dart';

class Nova_simulacao extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Nova_simulacao> {
  String value;
  Future<List<String>> ramos;

  @override
  void initState() {
    ramos = _getRamos();
    super.initState();
  }

  Future<List<String>> _getRamos() async {
    final dbHelper = DatabaseHelper.instance;
    final list = await dbHelper.queryAllRows(DatabaseHelper.table);
    final rlist = list.map((item) {
      return item['name'] as String;
    }).toList();
    this.value = rlist[0];
    return rlist;
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
                      'Dados do cliente',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text('Os campos obrigatórios estão sinalizados com *'),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'CPF *',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Telefone *',
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Ramo de atividade *'),
                    FutureBuilder(
                      future: ramos,
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
                                      child: Text(snapshot.data[index]),
                                      value: snapshot.data[index],
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
                          'Próximo',
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Nova_simulacao2(ramo: value)),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

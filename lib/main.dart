import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:negociar_e_vender/db_helper.dart';
import 'package:negociar_e_vender/nova_simulacao.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
                  _getCSV();
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

  _getCSV() async {
    final db = DatabaseHelper.instance;
    final list = await db.queryAllRows(DatabaseHelper.tablePropostas);
    final csvList = List<List<dynamic>>();
    csvList.add([
      'id',
      'cpf',
      'email',
      'phone',
      'ramo',
      'data',
      'concorrente',
      'taxa de debito concorrente',
      'taxa de credito concorrente',
      'porcentagem de desconto debito em (%)',
      'porcentagem de desconto credito em (%)',
      'taxa final debito',
      'taxa final credito'
    ]);
    final itensList = list.map((item) {
      final sublist = List<dynamic>();
      sublist.add(item['id']);
      sublist.add(item['cpf']);
      sublist.add(item['email']);
      sublist.add(item['phone']);
      sublist.add(item['ramo']);
      final date = DateTime.fromMicrosecondsSinceEpoch(int.parse(item['timestamp']));
      sublist.add(date.toString());
      sublist.add(item['concorrente']);
      sublist.add(item['taxa_concorrente_debito']);
      sublist.add(item['taxa_concorrente_credito']);
      sublist.add(item['desconto_debito']);
      sublist.add(item['desconto_credito']);
      sublist.add(item['taxa_final_debito']);
      sublist.add(item['taxa_final_credito']);
      return sublist;
    }).toList();

    csvList.addAll(itensList);

    String csv = const ListToCsvConverter().convert(csvList);

    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
      String dir = (await (Platform.isAndroid
                  ? getExternalStorageDirectory()
                  : getApplicationDocumentsDirectory()))
              .absolute
              .path +
          "/";
      final file = "$dir";
      File f = new File(file + "propostasaceita.csv");
      f.writeAsString(csv);
      OpenFile.open(f.absolute.path);

    }
  }
}

import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:negociar_e_vender/nova_simulacao2.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'db_helper.dart';

class Nova_simulacao extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Nova_simulacao> {
  String value;
  Future<List<String>> ramos;
  MaskedTextController controllerCPF, controllerPHONE;
  TextEditingController controllerEmail;
  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    ramos = _getRamos();
    controllerCPF = MaskedTextController(mask: '000.000.000-00');
    controllerPHONE = MaskedTextController(mask: '(00) 00000-0000');
    controllerEmail = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    controllerCPF.dispose();
    controllerPHONE.dispose();
    controllerEmail.dispose();
    super.dispose();
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
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Dados do cliente',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text('Os campos obrigatórios estão sinalizados com *'),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'CPF *',
                                ),
                                keyboardType: TextInputType.number,
                                controller: controllerCPF,
                                validator: (value) {
                                  final cpf = controllerCPF.text
                                      .replaceAll(new RegExp(r'[-.]'), '');
                                  if (!CPFValidator.isValid(cpf)) {
                                    return 'CPF inválido!';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Telefone *',
                                ),
                                keyboardType: TextInputType.phone,
                                controller: controllerPHONE,
                                validator: (value) {
                                  String phone = controllerPHONE.text
                                      .replaceAll(new RegExp(r'[-() ]'), '');
                                  final regExp = new RegExp(r"[0-9]{11}");
                                  if (!regExp.hasMatch(phone)) {
                                    return 'Telefone inválido!';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: controllerEmail,
                          validator: (value) {
                            final email = controllerEmail.text;
                            final regExp = new RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                            if (email.isNotEmpty && !regExp.hasMatch(email)) {
                              return 'Email inválido!';
                            }
                            return null;
                          },
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
              ),
            ),
            Hero(
              tag: "effect",
              child: GestureDetector(
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
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none),
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
                  if (_formKey.currentState.validate()) {
                    String cpf =
                        controllerCPF.text.replaceAll(new RegExp(r'[-.]'), '');
                    String phone = controllerPHONE.text
                        .replaceAll(new RegExp(r'[-() ]'), '');
                    String email = controllerEmail.text.isEmpty
                        ? null
                        : controllerEmail.text;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Nova_simulacao2(value, cpf, phone, email)),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

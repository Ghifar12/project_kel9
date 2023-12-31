import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_kel9/config/asset.dart';
import 'package:project_kel9/event/event_db.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _controllerUsername = TextEditingController();
  var _controllerPass = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Asset.colorPrimaryDark,
              ),
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(left: 20, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    child: Image(
                        image: NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/UNIVERSITASTEKNOKRAT.png/480px-UNIVERSITASTEKNOKRAT.png")),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Asset Kampus',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Universitas Teknokrat Indonesia',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) =>
                            value == '' ? 'Jangan Kosong' : null,
                        controller: _controllerUsername,
                        style: TextStyle(
                          color: Asset.colorPrimaryDark,
                        ),
                        decoration: InputDecoration(
                            hintText: 'username',
                            hintStyle: TextStyle(
                              color: Asset.colorPrimaryDark,
                            ),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Asset.colorPrimaryDark,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Asset.colorPrimary,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Asset.colorPrimary,
                                width: 1,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.people,
                              color: Asset.colorPrimaryDark,
                            )),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (value) =>
                            value == '' ? 'Jangan Kosong' : null,
                        controller: _controllerPass,
                        style: TextStyle(
                          color: Asset.colorPrimaryDark,
                        ),
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'password',
                            hintStyle: TextStyle(
                              color: Asset.colorPrimaryDark,
                            ),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Asset.colorPrimaryDark,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Asset.colorPrimary,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Asset.colorPrimary,
                                width: 1,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: Asset.colorPrimaryDark,
                            )),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Asset.colorPrimaryDark,
                        ),
                        width: double.infinity,
                        child: InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              EventDb.login(_controllerUsername.text,
                                  _controllerPass.text);
                              _controllerUsername.clear();
                              _controllerPass.clear();
                            }
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 12,
                            ),
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'developed by kelompok 9',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

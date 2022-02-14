import 'package:app/services/reconhecimento_facial_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginPage'),
      ),
      body: Container(
        child: Center(
          child: IconButton(
              onPressed: () {
                Get.toNamed("/funcionario");
              },
              icon: Icon(Icons.login)),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login feito com sucesso")),
      body: Center(
        child: Text(
          "Bem-vindo!",
          style: TextStyle(fontSize: 24, color: Colors.green),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SucessScreen extends StatelessWidget {
    @override
      Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: Text("Login realizado com sucesso!")),
            body: Center(
                child: Text(
                    "Bem-vind@!",
                    style: TextStyle(fontSize: 24, color: const Color.fromARGB(255, 116, 24, 17)),
                ),
            )
        );
    }
}
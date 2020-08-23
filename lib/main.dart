import 'dart:convert';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String info = "Digite os valores e pressione Calcular para descobrir seu IMC";

  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  String validarForm(String value) {
    if (value.isEmpty) {
      return "Preencha este campo";
    }
  }

  void resetaCampos() {
    setState(() {
      alturaController.text = "";
      pesoController.text = "";
      info = "Digite os valores e pressione Calcular para descobrir seu IMC";
    });
  }

  void calculaIMC() {
    var altura = double.parse(alturaController.text) *
        double.parse(alturaController.text);

    double resultado = double.parse(pesoController.text) / altura;
    if (resultado < 18.5) {
      setState(() {
        info = "Abaixo do Peso" + " IMC = ${resultado.toStringAsPrecision(4)}";
      });
    } else if (resultado <= 24.9) {
      setState(() {
        info = "Peso normal " + " IMC = ${resultado.toStringAsPrecision(4)}";
      });
    } else if (resultado >= 25.0 || resultado <= 29.9) {
      setState(() {
        info = "Sobrepeso" + " IMC = ${resultado.toStringAsPrecision(4)}";
      });
    } else if (resultado >= 30.0 || resultado <= 34.9) {
      setState(() {
        info =
            "Obesidade Grau 1" + " IMC = ${resultado.toStringAsPrecision(4)}";
      });
    } else if (resultado >= 35.0 || resultado <= 39.9) {
      setState(() {
        info =
            "Obesidade Grau 2" + " IMC = ${resultado.toStringAsPrecision(4)}";
      });
    } else {
      setState(() {
        info =
            "Obesidade Mórbida" + " IMC = ${resultado.toStringAsPrecision(4)}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de Imc"),
          centerTitle: true,
          backgroundColor: Colors.red[600],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: resetaCampos,
              iconSize: 40.0,
              color: Colors.white,
              disabledColor: Colors.grey[400],
            )
          ],
        ),
        backgroundColor: Colors.grey[50],
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
          child: Form(
              key: keyForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    size: 120.0,
                    color: Colors.red[400],
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso Kg",
                        labelStyle: TextStyle(color: Colors.red)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 19.0),
                    controller: pesoController,
                    validator: (value) => validarForm(value),
                  ),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Altura Cm",
                          labelStyle: TextStyle(color: Colors.red)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red, fontSize: 19.0),
                      controller: alturaController,
                      validator: (value) => validarForm(value)),
                  Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 30),
                    child: Container(
                      height: 45.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (keyForm.currentState.validate()) {
                            calculaIMC();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 23),
                        ),
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Text(
                    info,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[400], fontSize: 18),
                  )
                ],
              )),
        ));
  }
}

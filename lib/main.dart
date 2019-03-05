import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}

// Define a Custom Form Widget
class MyCustomForm extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyCustomForm> {
  String title = 'Calculadora IMC';
  TextEditingController peso = TextEditingController();
  TextEditingController altura = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText = "Insira seus dados.";

  String _getClassificacao(double imc) {
    String classificacao;

    if (imc < 18.5) {
      classificacao = 'Magreza';
    } else if (imc < 24.9) {
      classificacao = 'Saudável';
    } else if (imc < 29.9) {
      classificacao = 'Sobrepeso';
    } else if (imc < 34.9) {
      classificacao = 'Obesidade Grau I';
    } else if (imc < 39.9) {
      classificacao = 'Obesidade Grau II';
    } else {
      classificacao = 'Obesidade Grau III';
    }

    return classificacao;
  }

  void _refreshDados() {
    peso.text = "";
    altura.text = "";

    setState(() {
      _infoText = "Insira seus dados.";
    });
  }

  void _calculaIMC() {
    setState(() {
      double dPeso = double.parse(peso.text.toString());
      double dAltura = (double.parse(altura.text.toString())) / 100;
      double imc = (dPeso / (dAltura * dAltura));

      _infoText = "${_getClassificacao(imc)} (${(imc.toStringAsPrecision(4))})";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(title),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: _refreshDados,
                )
              ],
            ),
            body: SingleChildScrollView(
                child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    size: 100.0,
                    color: Colors.green,
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                      child: TextFormField(
                        controller: peso,
                        validator: (value){
                          if(value.isEmpty){
                            return "Insira seu peso.";
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Peso',
                            labelText: 'Peso',
                            border: OutlineInputBorder()),
                      )),
                  Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                      child: TextFormField(
                        validator: (value){
                          if(value.isEmpty){
                            return "Insira sua altura.";
                          }
                        },
                        controller: altura,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Altura(cm)',
                            labelText: 'Altura(cm)',
                            border: OutlineInputBorder()),
                      )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
                    child: SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: RaisedButton(
                          color: Colors.green,
                          onPressed:(){
                            if(_formKey.currentState.validate()){
                              _calculaIMC();
                            }
                          },
                          child: Text(
                            'Calcular IMC',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        )),
                  ),
                  Padding(
                    child: Text(
                      _infoText,
                      style: TextStyle(color: Colors.green, fontSize: 20.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  )
                ],
              ),
            ))));
  }
}

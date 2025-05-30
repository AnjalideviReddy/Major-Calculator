import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _outputHistory = "";
  String _output = "0";
  String _operand = "";
  int _num1 = 0;
  int _num2 = 0;

  void _buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _outputHistory = "";
      _output = "0";
      _operand = "";
      _num1 = 0;
      _num2 = 0;
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "x" ||
        buttonText == "/") {
      _num1 = int.parse(_output);
      _operand = buttonText;
      _outputHistory = "$_num1 $_operand ";
      _output = "0";
    } else if (buttonText == "=") {
      _num2 = int.parse(_output);
      int result = 0;
      if (_operand == "+") {
        result = _num1 + _num2;
      } else if (_operand == "-") {
        result = _num1 - _num2;
      } else if (_operand == "x") {
        result = _num1 * _num2;
      } else if (_operand == "/") {
        result = _num1 ~/ _num2; // Division using integers
      }
      _output = result.toString();
      _outputHistory += "$_num2 = $_output";
    } else {
      if (_output == "0") {
        _output = buttonText;
      } else {
        _output += buttonText;
      }
    }

    setState(() {});
  }

  Widget _buildButton(String buttonText, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: OutlinedButton(
          onPressed: () => _buttonPressed(buttonText),
          style: OutlinedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(20.0),
            backgroundColor: color,
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors
                .black, // Black background for the area above the horizontal line
            child: Column(
              children: [
                Container(
                  color: Colors.black, // Black background for history area
                  padding:
                      EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
                  child: Text(
                    _outputHistory,
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
                Container(
                  color: Colors.black, // Black background for output area
                  padding:
                      EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      _output,
                      style: TextStyle(fontSize: 48.0, color: Colors.white),
                      textAlign: TextAlign.end, // Align text to the right
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("*", color: Colors.grey),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("/", color: Colors.grey),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("+", color: Colors.grey),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildButton("=", color: Colors.orange),
                  _buildButton("0"),
                  _buildButton("C", color: Colors.grey),
                  _buildButton("-", color: Colors.grey),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

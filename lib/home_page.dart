import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

bool _light = false;

ThemeData _darkTheme = ThemeData.dark();
ThemeData _lightTheme = ThemeData.light();

class _HomePageState extends State<HomePage> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  // _HomePageState obj = _HomePageState();
  buttonPressed(String txt) {
    setState(() {
      if (txt == "AC") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (txt == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (txt == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = "${exp.evaluate(EvaluationType.REAL, cm)}";
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = txt;
        } else {
          equation += txt;
        }
      }
    });
  }

  Widget buildButton(String txt, double size, Color color) {
    return TextButton(
        onPressed: () => buttonPressed(txt),
        child: Text(txt, style: TextStyle(fontSize: size, color: color)));
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _light ? _lightTheme : _darkTheme,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  // height: 100,
                  // color: Colors.green,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: Text(
                          equation,
                          style: TextStyle(fontSize: equationFontSize),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                        child: Text(
                          result,
                          style: TextStyle(fontSize: resultFontSize),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  // height: 100,
                  // color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildButton('AC', 20, Colors.orange[700]),
                          buildButton('⌫', 25, Colors.orange[700]),
                          buildButton("%", 20, Colors.orange[700]),
                          buildButton("÷", 25, Colors.orange[700]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildButton("7", 25, Colors.blue),
                          buildButton("8", 25, Colors.blue),
                          buildButton("9", 25, Colors.blue),
                          buildButton("×", 25, Colors.orange[700]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildButton("4", 25, Colors.blue),
                          buildButton("5", 25, Colors.blue),
                          buildButton("6", 25, Colors.blue),
                          buildButton("-", 30, Colors.orange[700]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildButton("1", 25, Colors.blue),
                          buildButton("2", 25, Colors.blue),
                          buildButton("3", 25, Colors.blue),
                          buildButton("+", 25, Colors.orange[700]),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Switch(
                                  onChanged: (value) {
                                    setState(() {
                                      _light = value;
                                    });
                                  },
                                  value: _light)),
                          buildButton("0", 25, Colors.blue),
                          buildButton(".", 25, Colors.blue),
                          Container(
                            // margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.circular(40),
                                color: Colors.orange[700]),
                            child: buildButton("=", 30, Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

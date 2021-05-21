import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String equation = '0';
  String result = "";
  String expression = '';

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == 'C'){
        equation = "0";
        result = '0';
      }else if (buttonText == 'Del') {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = '0';
        }
        } else if (buttonText == "=") {
          expression = equation;
          equation = expression.replaceAll('X', '*');
          try {
            Parser p = Parser();
            Expression exp = p.parse(expression);

            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          } catch (e) {
            result = 'ERROR';
          }
        } else {
          if (equation == '0') {
            equation = buttonText;
          } else {
            equation = equation + buttonText;
          }
      }
    });
  }

  Widget myButton(
      String buttonText,// texto do botao
      Color colour, // cor do container
      Color textColor, // cor do texto
  ){
    return GestureDetector(
      onTap: (){
        buttonPressed(buttonText);
      },
      child: Padding(
        padding: EdgeInsets.all(14),
        child:Container(
          height: 70,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colour,
          ),
          child: Center(
            child: Text('$buttonText',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),
            ),
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
              child:Container(
                color: Colors.indigo[100],
                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                alignment: Alignment.centerRight,
                child: Text(equation,
                style: TextStyle(
                  fontSize: 30
                ),),
              )
          ),
          Expanded(
            flex: 2,
              child:Container(
                color: Colors.indigo[100],
                padding: EdgeInsets.symmetric(vertical: 24, horizontal:12 ),
                alignment: Alignment.centerRight,
                child: Text(result,
                style: TextStyle(
                  fontSize: 30
                ),),
              )
          ),
          Expanded(
            flex: 6,
              child:Container(
                color: Colors.indigo[100],
                padding: EdgeInsets.only(top: 24, bottom: 12),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          myButton('C', Colors.indigo[500], Colors.white),
                          myButton('Del', Colors.indigo[200], Colors.indigo[700]),
                          myButton('%', Colors.indigo[200], Colors.indigo[700]),
                          myButton('/', Colors.indigo[200], Colors.indigo[700]),
                            ]
                            ),
                          ),
                    Expanded(
                      child: Row(
                        children: [
                          myButton('7', Colors.grey[350], Colors.black),
                             myButton('8', Colors.grey[350], Colors.black),
                             myButton('9', Colors.grey[350], Colors.black),
                              myButton('X', Colors.indigo[200], Colors.indigo[700]),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                             myButton('4', Colors.grey[350], Colors.black),
                              myButton('5', Colors.grey[350], Colors.black),
                              myButton('6', Colors.grey[350], Colors.black),
                              myButton('+', Colors.indigo[200], Colors.indigo[700]),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                            myButton('1', Colors.grey[350], Colors.black),
                             myButton('2', Colors.grey[350], Colors.black),
                              myButton('3', Colors.grey[350], Colors.black),
                              myButton('-', Colors.indigo[200], Colors.indigo[700]),

                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(
                          width: 177,
                          child: myButton('0', Colors.grey[350], Colors.black),
                          ),
                            myButton('.', Colors.grey[350], Colors.black),
                            myButton('=', Colors.indigo[400], Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          )
        ],
      ),
    );
  }
}

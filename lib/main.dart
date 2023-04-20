import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}
const operatorColor = Color(0xff272727);
const buttonColor = Color(0xff191919);
const orangeColor = Color(0xffd9802e);


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  double firstNum =0.0;
  double secondNum =0.0;
  var input ='';
  var output ='';
  var operation = '';
  var hideInput = false;
  var outputSize = 34.0;

  onButtonClick(value){
    if(value == 'AC'){
      input ='';
      output ='';
    }else if(value == '<'){
      if(input.isNotEmpty){
        input = input.substring(0,input.length-1);
      }
    }else if(value == '='){
      if(input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if(output.endsWith(".0")){
          output = output.substring(0,output.length-2);
        }
        input = output;
        hideInput = true;
        outputSize = 52.0;
      }
    }else{
      input = input + value;
      hideInput = false;
      outputSize = 34.0;
    }
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(child: Container(
            padding: EdgeInsets.all(12),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(hideInput? '' : input,style: TextStyle(fontSize: 48,color: Colors.white),),
                SizedBox(height: 20,),
                Text(output,style: TextStyle(fontSize: outputSize,color: Colors.white.withOpacity(0.7)))
              ],
            ),
          )),
          Row(children: [
            button(text: "AC",buttonbgColor: operatorColor,tColor: orangeColor),
            button(text: "<",buttonbgColor: operatorColor,tColor: orangeColor),
            button(text: "",buttonbgColor: Colors.transparent),
            button(text: "/",buttonbgColor: operatorColor,tColor: orangeColor),
          ],),

          Row(children: [
            button(text: "7"),
            button(text: "8"),
            button(text: "9"),
            button(text: "x",buttonbgColor: operatorColor,tColor: orangeColor),
          ],),

          Row(children: [
            button(text: "4"),
            button(text: "5"),
            button(text: "6"),
            button(text: "-",buttonbgColor: operatorColor,tColor: orangeColor),
          ],),

          Row(children: [
            button(text: "1"),
            button(text: "2"),
            button(text: "3"),
            button(text: "+",buttonbgColor: operatorColor,tColor: orangeColor),
          ],),

          Row(children: [
            button(text: "%",tColor: orangeColor,buttonbgColor: operatorColor),
            button(text: "0"),
            button(text: "."),
            button(text: "=",buttonbgColor: orangeColor),
          ],)
        ],
      )
    );
  }
  Widget button({
    text,tColor=Colors.white,buttonbgColor = buttonColor,}){
    return Expanded(child: Container(
      margin: const EdgeInsets.all(8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(22),
          // foregroundColor: buttonbgColor,
          primary:buttonbgColor

        ),
        onPressed:() => onButtonClick(text),
        child: Text(text,style: TextStyle(fontSize: 18,color: tColor,fontWeight: FontWeight.bold),),
      ),
    ));
  }
}

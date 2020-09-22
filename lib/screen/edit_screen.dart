import 'package:flutter/material.dart';
import 'package:flutter_exam/data/person.dart';

class EditParameter{
  final int person_id;
  const EditParameter(this.person_id);
}

class EditScreen extends StatefulWidget {
  int person_id;
  EditScreen(this.person_id);
  
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  
  String str_score;
  bool edit;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    
    if(widget.person_id != -1){
      edit = true;
      _controller = TextEditingController(text: person[widget.person_id].name);
      str_score = person[widget.person_id].score.toString();
    }
      
    else{
      edit = false;
      _controller = TextEditingController();
      str_score = '0';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _buttonAction(String str){
    setState(() {
      if(str == '0' && str_score == '0'){
        //do noting
      }
      else if(str == 'CLR'){
        str_score = '0';
      }
      else if(str == 'OK'){
        if( _controller.text.isEmpty ){
          showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Text('Error'),
                content: Text(
                  'Please fill in name.',
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => {Navigator.pop(context)},
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
        else{
          if(edit){
            person[widget.person_id].name = _controller.text;
            person[widget.person_id].score = int.parse(str_score);
            Navigator.pop(context);
          }
          else{
            person.add(Person(_controller.text, int.parse(str_score)));
            Navigator.pop(context);
          }
        }
      }
      else if(str != '0' && str_score == '0'){
        str_score = str;
      }
      else{
        str_score += str;
      }
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add or Edit'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: 150,
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Name', style: TextStyle(fontSize: 30.0)),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: _controller,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30.0)
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.cyanAccent,
              height: 100,
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.center,
              child: Text(
                this.str_score,
                style: TextStyle(fontSize: 70.0, fontWeight: FontWeight.bold),                
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row( 
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CustomButton('7'),
                      CustomButton('8'),
                      CustomButton('9'),
                    ],
                  ),
                  Row( 
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CustomButton('4'),
                      CustomButton('5'),
                      CustomButton('6'),
                    ],
                  ),
                  Row( 
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CustomButton('1'),
                      CustomButton('2'),
                      CustomButton('3'),
                    ],
                  ),
                  Row( 
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CustomButton('CLR'),
                      CustomButton('0'),
                      CustomButton('OK'),
                    ],
                  ),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }

  Widget CustomButton(String str){
    return Expanded(
      child: GestureDetector(
        child: Container(
          height: 100,
          width: 100,
          margin: EdgeInsets.all(1),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1),
          ),
          child: Text(
            str,
            style: TextStyle(fontSize: 30),
          ),
        ),
        onTap: () => {_buttonAction(str)},
      ),
    );
  }
}


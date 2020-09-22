import 'package:flutter/material.dart';
import 'package:flutter_exam/config/routes.dart';
import 'package:flutter_exam/data/person.dart';
import 'package:flutter_exam/screen/detail_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15.0),
              alignment: Alignment.centerLeft,
              decoration: UnderlineTabIndicator(borderSide: BorderSide(width: 1.0)),
              child: Text(
                'My List',
                style: TextStyle(fontSize: 50.0),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 200,
              child: _ListView(),
            ),
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {},
      ),
    );
  }
}

class _ListView extends StatelessWidget {
   
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: person.length,
      itemBuilder: (BuildContext context, int index){
        return DataCard(person[index], index, context);
      },
    );
  }

  Widget DataCard(Person data, int index, BuildContext context){
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: UnderlineTabIndicator(borderSide: BorderSide(width: 1.0)),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              alignment: Alignment.centerRight,
              child: Text(
                (index + 1).toString(),
                style: TextStyle(fontSize: 25.0),
              ),
            ),
            Container(
              width: 280,
              alignment: Alignment.centerLeft,
              child: Text(
                data.name,
                style: TextStyle(fontSize: 25.0),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                data.score.toString(),
                style: TextStyle(fontSize: 50.0),
              ),
            ),
          ],
        ),
      ),
      onTap: () => {
        Navigator.of(context).pushNamed(AppRoutes.detail, arguments: DetailParameter(index))
      },
    ); 
  }
}


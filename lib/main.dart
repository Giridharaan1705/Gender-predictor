import "package:flutter/material.dart";
import "dart:convert";
import "package:http/http.dart" as http;


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _nameController = TextEditingController();
  var result;

  predictGender(String name) async {
    var url = "https://api.genderize.io/?name=$name";
    var res = await http.get(url);
    var body = jsonDecode(res.body);

    result = "Gender: ${body['gender']}, Probability: ${body['probability']}";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Gender Predictor",style: TextStyle(fontWeight: FontWeight.w200,
        fontFamily:'Lobster',
        color: Colors.lightGreenAccent ),),
        centerTitle: true,
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Enter a name to predict its gender : ",style:TextStyle(fontSize:20.0,
            fontWeight:FontWeight.bold,
            color:Colors.white,
            fontFamily: 'Lobster'),),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: _nameController,
                autofocus: false,
                decoration: InputDecoration(
                    labelText: "Enter a name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
              ),
            ),
            RaisedButton(
              onPressed: () => predictGender(_nameController.text),
              child: Text("Predict"),
            ),
            if (result != null) Text(result,style: TextStyle(color: Colors.lightGreenAccent,
            fontFamily: 'Lobster'),),
              
          ],
        
              
        ),
      ),
    );
  }
}


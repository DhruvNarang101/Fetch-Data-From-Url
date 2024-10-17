import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(){
  runApp(MaterialApp(
    home:HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}
class HomePageState extends State<HomePage>{
  final String url = "https://swapi.dev/api/people/";
  List data = [];

  @override
  void initState(){
    super.initState();
    getJSONData();
  }

  Future<void> getJSONData() async{
    var response = await http.get(
      Uri.parse(url),
      //only accepts the json response
      headers:{"Accept" : "application/json"}
    );
    print(response.body);

    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['results'];
    });
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        title: const Text(
          "HTTP GET (JSON)",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context,int index){
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                 Card(
                  child: Container(
                    child: Text(
                      data[index]['name'],
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                    ),
                    padding: const EdgeInsets.all(20.0),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
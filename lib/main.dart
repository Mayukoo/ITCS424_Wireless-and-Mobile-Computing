import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'globals.dart' as globals;
import 'title.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainContextApp(),
    );
  }
}

class MainContextApp extends StatefulWidget {
  @override
  createState() => ContextState();
}
class ContextState extends State<MainContextApp> {
  var _lolitem = [];
  final _headerText = const TextStyle(fontSize: 18.0);
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( title.appName),
      ),
      body:

      Column(
        children: <Widget>[
          InkWell(
            child: Text(title.result),
            onTap: () {
              setState(() {
                title.result = "Total Result : 0";
                globals.resultprice = 0;
              });
            },
          ),
          Expanded(
              child:       ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _lolitem.length,
                  itemBuilder: (BuildContext context, int position) {
                    return _buildRow(position);
                  }



              ),
          )
        ],
      )




    );
  }

  Widget _buildRow(int i) {
    return ListTile(
        leading: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 44,
            minHeight: 44,
            maxWidth: 44,
            maxHeight: 44,
          ),
          child: Image.network("${_lolitem[i]["thumbnail"]}", fit: BoxFit.cover),
        ),
        title: Text(
          "${_lolitem[i]["title"]}",
          style: _headerText,
        ), subtitle: Text( "${_lolitem[i]["price"]}")
        ,onTap: (){
      globals.resultprice = globals.resultprice + int.parse("${_lolitem[i]["price"]}");
      setState(() {
        title.result = "Total Price : " + globals.resultprice.toString();
      });
          
    },



    );
  }

  _loadData() async {
    String dataURL = "http://mfstudioxth.000webhostapp.com/lolitem.json";
    http.Response response = await http.get(dataURL);
    setState(() {
      _lolitem = json.decode(response.body);
    });
  }
}
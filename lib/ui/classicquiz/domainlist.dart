import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterheritageolympiad/modal/domains/Domains.dart';
import 'package:http/http.dart' as http;


class Domainlist extends StatefulWidget {
  @override
  DomainlistState createState() => new DomainlistState();
}

class DomainlistState extends State<Domainlist> {

  List<Domains>? data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.parse("http://3.108.183.42/api/domains"),
        // headers: {
        //   "Accept": "application/json"
        // }
    );

    setState(() {
      data = json.decode(response.body);
    });

    print(data![1]);

    return "Success!";
  }

  @override
  void initState(){
    getData();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Listviews"), backgroundColor: Colors.blue),
      body: ListView.builder(
        itemCount: data == null ? 0 : data?.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
            child: Text(data![index].toString()),
          );
        },
      ),
    );
  }
}

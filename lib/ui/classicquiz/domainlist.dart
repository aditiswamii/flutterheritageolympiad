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
  String? data;
  var superheros_length;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  void getData() async {
    http.Response response =
    await http.get(Uri.parse("http://3.108.183.42/api/domains"));
    if (response.statusCode == 200) {
      data = response.body; //store response as string
      setState(() {
        superheros_length = jsonDecode(
            data!)['data']; //get all the data from json string superheros
        print(superheros_length.length); // just printed length of data
      });
      var venam = jsonDecode(data!)['data'][4]['name'];
      print(venam);
    } else {
      print(response.statusCode);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Http Example"),
      ),
      body: ListView.builder(
        itemCount: superheros_length == null ? 0 : superheros_length.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              // leading: Image.network(
              //   jsonDecode(data)['data'][index]['url'],
              //   fit: BoxFit.fill,
              //   width: 100,
              //   height: 500,
              //   alignment: Alignment.center,
              // ),
              title: Text(jsonDecode(data!)['data'][index]['name']),
              subtitle: Text(jsonDecode(data!)['data'][index]['id'].toString()),
            ),
          );
        },
      ),
    );
  }
  // List<Domains>? data;
  //
  // Future<String> getData() async {
  //   var response = await http.get(
  //       Uri.parse("http://3.108.183.42/api/domains"),
  //       // headers: {
  //       //   "Accept": "application/json"
  //       // }
  //   );
  //
  //   setState(() {
  //     data = json.decode(response.body);
  //   });
  //
  //   print(data![1]);
  //
  //   return "Success!";
  // }
  //
  // @override
  // void initState(){
  //   getData();
  // }
  //
  // @override
  // Widget build(BuildContext context){
  //   return Scaffold(
  //     appBar: AppBar(title: Text("Listviews"), backgroundColor: Colors.blue),
  //     body: ListView.builder(
  //       itemCount: data == null ? 0 : data?.length,
  //       itemBuilder: (BuildContext context, int index){
  //         return Card(
  //           child: Text(data![index].toString()),
  //         );
  //       },
  //     ),
  //   );
  // }
}

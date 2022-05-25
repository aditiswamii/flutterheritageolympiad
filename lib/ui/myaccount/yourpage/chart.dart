import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../modal/xpgainchart/GetXPGainChartResponse.dart';
import '../../../utils/StringConstants.dart';
import 'barchartgraph.dart';
import 'barchartmodel.dart';
import 'package:http/http.dart' as http;

import 'dart:convert' as convert;

class BarChartDemo extends StatefulWidget {
  @override
  _BarChartDemoState createState() => _BarChartDemoState();
}

class _BarChartDemoState extends State<BarChartDemo> {
  GetXpGainChartResponse? getXpGainChartResponse;
  var data;
  var xpdata;
  var snackBar;
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // final List<BarChartModel> data = [
  //   BarChartModel(
  //     year: "2014",
  //     financial: 250,
  //     color: charts.ColorUtil.fromDartColor(Color(0xFF47505F)),
  //   ),
  //   BarChartModel(
  //     year: "2015",
  //     financial: 300,
  //     color: charts.ColorUtil.fromDartColor(Colors.red),
  //   ),
  //   BarChartModel(
  //     year: "2016",
  //     financial: 100,
  //     color: charts.ColorUtil.fromDartColor(Colors.green),
  //   ),
  //   BarChartModel(
  //     year: "2017",
  //     financial: 450,
  //     color: charts.ColorUtil.fromDartColor(Colors.yellow),
  //   ),
  //   BarChartModel(
  //     year: "2018",
  //     financial: 630,
  //     color: charts.ColorUtil.fromDartColor(Colors.lightBlueAccent),
  //   ),
  //   BarChartModel(
  //     year: "2019",
  //     financial: 1000,
  //     color: charts.ColorUtil.fromDartColor(Colors.pink),
  //   ),
  //   BarChartModel(
  //     year: "2020",
  //     financial: 400,
  //     color: charts.ColorUtil.fromDartColor(Colors.purple),
  //   ),
  // ];
  var username;
  var country;
  var userid;
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });

    xpgainchart(userid.toString(),"");
  }
  @override
  void initState() {
    super.initState();

    userdata();
  }
  xpgainchart(String userid, String contactid) async {
    showLoaderDialog(context);
    http.Response response = await http
        .post(Uri.parse(StringConstants.BASE_URL + "xpgainchart"), body: {
      'user_id': userid.toString(),
      'contact_id': contactid.toString()
    });

    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['status'] == 200) {
        setState(() {
          xpdata = jsonResponse; //get all the data from json string superheros
          print(xpdata.length);
          print(xpdata.toString());
          print("mnth : " + jsonResponse['data']['mnth'].toString());
          print("totalxp" + jsonResponse['data']['totalxp'].toString());
          print("max" + jsonResponse['data']['max'].toString());
          print("totalquiz" + jsonResponse['data']['totalquiz'].toString());

          onxpsuccess(xpdata);
        });

        var venam = jsonDecode(data!)['data'];
        print(venam);
      } else {
        snackBar = SnackBar(
          content: Text(jsonResponse['message']),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      Navigator.pop(context);
      print(response.statusCode);
    }
  }

  onxpsuccess(xpdata) {

    //  xplist=List.from(xpdata['data']['mnth']);
    print("mnth : " + xpdata['data']['mnth'].toString());
    print("userdata" + xpdata['data']['totalxp'].toString());
    print("userdata" + xpdata['data']['max'].toString());
    print("userdata" + xpdata['data']['totalquiz'].toString());
  }


  @override
  Widget build(BuildContext context) {
    List data1=xpdata['data']['mnth'];
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Animated Bar Chart Demo"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              BarChartGraph(
                data: data1,
              ),

            ],
          ),

        ),
      ),
    );
  }
}
import 'dart:convert';
import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../colors/colors.dart';
import '../../../utils/StringConstants.dart';
import '../../rightdrawer/right_drawer.dart';
import 'package:CultreApp/ui/homepage/homepage.dart';
import '../shopproducts_page.dart';

class ProductList extends StatefulWidget{

  ProductList({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<ProductList>{
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var data;
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
 var productdata;
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country =prefs.getString("country");
      userid= prefs.getString("userid");
    });

    getproduct("", "") ;
  }
  getproduct(String userid ,String searchkey) async {
    try {
      http.Response response = await http.get(
        Uri.parse(StringConstants.BASE_URL+"get_all_products")
      );

      if (response.statusCode == 200) {
        data = response.body; //store response as string
        setState(() {
          productdata = jsonDecode(
              data!)['data']; //get all the data from json string superheros
          print(productdata.length); // just printed length of data
        });

        var venam = jsonDecode(data!)['data'];
        print(venam);
      } else {
        print(response.statusCode);
      }
    } catch (e) {

      log(e.toString());
    }
  }
  onsuccess(){

  }
  // showLoaderDialog(BuildContext context) {
  //   AlertDialog alert = AlertDialog(
  //     content: new Row(
  //       children: [
  //         CircularProgressIndicator(),
  //         Container(
  //             margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
  //       ],),
  //   );
  //   showDialog(barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
   userdata();
  }
  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ShopPage()));
    // Do some stuff.
    return true;
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      endDrawerEnableOpenDragGesture: true,
      endDrawer: MySideMenuDrawer(),
      body:Container(

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child:Container( color: Colors.white.withAlpha(100),
          margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Stack(
              children: [

                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    color: Colors.white,
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
                          alignment: Alignment.centerLeft,

                          padding: EdgeInsets.all(5),
                          child: Center(
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  HomePage()));
                                },
                                child:  Image.asset("assets/images/home_1.png",height: 40,width: 40,),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 20, 10),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 5.0),
                          child: GestureDetector(
                            onTap: () {
                              _scaffoldKey.currentState!.openEndDrawer();
                            },
                            child: Image.asset(
                                "assets/images/side_menu_2.png", height: 40,
                                width: 40),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment(0,100),
                  // height: MediaQuery.of(context).size.height-120,
                  margin: const EdgeInsets.fromLTRB(20, 90, 20, 10),
                  child: ListView(
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: const Text("SHOP",style: TextStyle(fontSize: 18,color:Colors.black,fontFamily: "Nunito"))),
                        Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child:  Text("PRODUCT",style: TextStyle(fontSize: 18,color: Colors.black,fontFamily: "Nunito"))),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text(
                              "Scroll down see all updates, search by keywords, or filter update by type.",
                              style: TextStyle(fontSize: 14,
                                  color: ColorConstants.txt)
                          ),
                        ),
                        productdata==null?const Center(
                          child: CircularProgressIndicator(),
                        )
                            : Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: ListView.builder(
                              physics: ClampingScrollPhysics(parent: BouncingScrollPhysics()),
                              shrinkWrap: true,
                              itemCount: jsonDecode(data!)['data'].length,
                              itemBuilder: (BuildContext context, int index) {
                                return
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      // if you need this
                                      side: BorderSide(
                                        color: Colors.grey.withOpacity(0.2),
                                        width: 1,
                                      ),
                                    ),
                                    child: ListBody(
                                      children: [
                                        Container(
                                          height: 300,
                                          color: ColorConstants.lightgrey200,
                                          child: Image.network(jsonDecode(data!)['data'][index]['images'][0],fit: BoxFit.fill,),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                          child: ListBody(
                                            children: [

                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                child: Text(jsonDecode(data!)['data'][index]['name'],style: TextStyle(fontSize: 16,color: Colors.black,fontFamily: "Nunito")),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                child: Text(jsonDecode(data!)['data'][index]['description'],style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: "Nunito")),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(jsonDecode(data!)['data'][index]['price'],style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: "Nunito")),
                                                    GestureDetector(
                                                        onTap: (){
                                                          Share.share(jsonDecode(data!)['data'][index]['link'], subject: 'Share link');
                                                        },
                                                        child: Container(
                                                          padding: EdgeInsets.all(5),
                                                          decoration: BoxDecoration(
                                                            color:  Colors.orange,
                                                            borderRadius: BorderRadius.circular(20),
                                                          ),

                                                            child: Text("PURCHASE",style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: "Nunito")))),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                              }),
                        ),
                      ]
                  ),
                ),


              ]
          ),
        ),
      ),
    );
  }




}
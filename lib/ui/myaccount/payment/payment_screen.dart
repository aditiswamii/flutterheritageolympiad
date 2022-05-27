import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/dialog/cancelplan/cancelplan_dialog.dart';
import 'package:flutterheritageolympiad/ui/myaccount/myaccount_page.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/homepage/welcomeback_page.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';


class PaymentScreen extends StatefulWidget{

  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}


class _PaymentScreenState extends State<PaymentScreen> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  void initState() {

    super.initState();
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
      //endDrawerEnableOpenDragGesture: true,
      endDrawer: MySideMenuDrawer(),
      body: Container(
        decoration:BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/debackground.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomePage()));
                        },
                        child: Image.asset(
                            "assets/images/home_1.png", height: 40, width: 40),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 60, 0, 10),
                    child: const Text("PAYMENTS", style: TextStyle(
                        fontSize: 24, color: ColorConstants.txt))),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                      "You can change or cancel your existing plan.\nChanges will take effects from next billing.",
                      style: TextStyle(fontSize: 15,
                          color: ColorConstants.txt)
                  ),
                ),
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    decoration: BoxDecoration(
                        color: Colors.white),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        // if you need this
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                            child: Text("CURRENT PLAN",style: TextStyle(color: ColorConstants.txt,fontSize: 14),),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    end: Alignment.center,
                                    colors: ColorConstants.gradient,
                                  ),
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: GFProgressBar(
                                percentage: 0.6,
                                lineHeight: 30,
                                alignment: MainAxisAlignment.spaceBetween,
                                child:  Text('15 days remaining', textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15, color: Colors.white),
                                ),
                                backgroundColor: Colors.transparent,
                                progressBarColor: Colors.transparent,
                              )
                          ),

                      Container(
                        height: 120,
                        width: 250,
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage("assets/images/yellowbackground.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("BASIC", style: TextStyle(fontSize: 12, color: ColorConstants.yellow200)),
                            Text("INR 299/mo", style: TextStyle(fontSize: 16, color: ColorConstants.yellow200)),
                          ],
                        ),
                    ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                          padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
                          height: 150,
                          width: 150,
                          decoration: const BoxDecoration(
                              color: ColorConstants.verdigris
                          ),
                          child: GestureDetector(
                              onTap: () {
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => const MyAccountPage()));
                              },
                              child: Text("CHANGE\nYOUR PLAN",style: TextStyle(color: Colors.white,fontSize: 18),textAlign: TextAlign.center,)),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
                          height: 150,
                          width: 150,
                          decoration: const BoxDecoration(
                              color: ColorConstants.red
                          ),
                          child: GestureDetector(
                              onTap: () {
                                AlertDialog errorDialog = AlertDialog(
                                  backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(
                                            20.0)), //this right here
                                    title: Container(
                                        height: 200,
                                        width: 150,
                                        alignment: Alignment.center,
                                        child: DialogCancelPlan()));
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                    errorDialog);
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>  ReadContacts()));
                              },
                              child: Text("CANCEL\nYOUR PLAN",style: TextStyle(color: Colors.white,fontSize: 18),textAlign: TextAlign.center,)),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: FractionalOffset.bottomCenter,
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: ColorConstants.red,
                          onPrimary: Colors.white,
                          elevation: 3,
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          fixedSize: const Size(100, 40),
                          //////// HERE
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyAccountPage()));
                        },
                        child: const Text(
                          "GO BACK",
                          style: TextStyle(
                              color: ColorConstants.lightgrey200, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: ColorConstants.verdigris,
                          onPrimary: Colors.white,
                          elevation: 3,
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          fixedSize: const Size(100, 40),
                          //////// HERE
                        ),
                        onPressed: () {
                          // AlertDialog errorDialog = AlertDialog(
                          //     shape: RoundedRectangleBorder(
                          //         borderRadius:
                          //         BorderRadius.circular(
                          //             20.0)), //this right here
                          //     title: Container(
                          //         height: 250,
                          //         width: 250,
                          //         alignment: Alignment.center,
                          //         child: DialogCancelPlan()));
                          // showDialog(
                          //     context: context,
                          //     builder: (BuildContext context) =>
                          //     errorDialog);
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (
                          //             context) => const PhonebookScreen()));
                        },
                        child: const Text(
                          "LET'S GO!",
                          style: TextStyle(
                              color: ColorConstants.lightgrey200, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),

              ]
          ),
        ),
      ),
    );
  }
}


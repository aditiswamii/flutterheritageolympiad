
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/forgetpassword/forget_viewmodal.dart';
import 'package:flutterheritageolympiad/ui/login/login_page.dart';
import 'package:flutterheritageolympiad/ui/login/login_viewmodal.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/StringConstants.dart';
import 'forget_presenter.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;


class ForgetPassword extends StatefulWidget{

  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<ForgetPassword> implements ForgetPasswordView{
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var forgetdata;
  var snackBar;
  var data;
  TextEditingController emailController = TextEditingController();
  late ForgetPasswordPresenter  _presenter;
  // forgetpass(String email) async {
  //   http.Response response = await http.post(
  //       Uri.parse(StringConstants.BASE_URL + "forgetPassword"),
  //       body: {
  //         'email': email.toString()
  //       });
  //   showLoaderDialog(context);
  //
  //   print("changepassapi");
  //   var jsonResponse = convert.jsonDecode(response.body);
  //   if (response.statusCode == 200) {
  //     Navigator.pop(context);
  //     data = response.body;
  //     if (jsonResponse['status'] == 200) {
  //       forgetdata = jsonResponse[
  //       'data'];
  //       print("data" + forgetdata.toString());
  //       setState(() {
  //         forgetdata = jsonResponse[
  //         'data'];
  //       });
  //
  //       //get all the data from json string superheros
  //       print("length" + forgetdata.length.toString());
  //
  //
  //     } else {
  //       snackBar = SnackBar(
  //         content: Text(
  //           jsonResponse['message'].toString(),textAlign: TextAlign.center,),
  //       );
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(snackBar);
  //       // onsuccess(null);
  //       log(jsonResponse['message']);
  //     }
  //   } else {
  //     Navigator.pop(context);
  //     print(response.statusCode);
  //   }
  // }
  // showLoaderDialog(BuildContext context) {
  //   AlertDialog alert = AlertDialog(
  //     content: new Row(
  //       children: [
  //         CircularProgressIndicator(),
  //         Container(
  //             margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
  //       ],
  //     ),
  //   );
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  @override
  void initState() {
    super.initState();
    _presenter = ForgetPasswordPresenter(this);
    //autoLogIn();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 100, 20, 10),
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child:  Image.asset("assets/images/tho_logo.png"),height: 80,width: 200,),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: const Text("Forget Password", style: TextStyle(
                      fontSize: 22, color: ColorConstants.txt))),
              Container(
                height: 60,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: TextFormField(
                  maxLines: 1,
                  controller: emailController,
                  obscureText: false,
                  maxLength: 150,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    filled: true,
                    //fillColor: ColorConstants.Omnes_font,
                    hintText: 'Email ID',
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ColorConstants.verdigris,
                    onPrimary: Colors.white,
                    elevation: 3,
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    fixedSize: const Size(100, 30),
                    //////// HERE
                  ),
                  onPressed: () {
                   _presenter.forgetpassword(emailController.text.toString());
                    // _presenter.login(emailController.text.toString(),
                    //     passwordController.text.toString());
                  },
                  child: const Text(
                    "SUBMIT",
                    style: TextStyle(color: Colors.white,
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),),
    );
  }

  @override
  void forget() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const LoginPage()));
  }


}


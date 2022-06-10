
import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/ui/forgetpassword/forget_viewmodal.dart';


import 'package:CultreApp/uinew/loginpage.dart';
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

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    _presenter = ForgetPasswordPresenter(this);

    //autoLogIn();
  }


  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(color: Colors.white.withAlpha(100),
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
                    if(emailController.text.isNotEmpty){
                      _presenter.forgetpassword(context,emailController.text.toString());
                    }else{
                      snackBar = SnackBar(
                        content: Text("Please enter email"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }

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
    snackBar = SnackBar(
      content: Text("Change password link has been sent to your email. Please check your email!"),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) =>  LoginScreen()));

  }


}


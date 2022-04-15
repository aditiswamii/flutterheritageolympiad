
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/forgetpassword/forgetpassword.dart';
import 'package:flutterheritageolympiad/ui/login/login_viewmodal.dart';
import 'package:flutterheritageolympiad/ui/signup/signup_page.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';
import 'package:flutterheritageolympiad/uinew/signuppage.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../modal/getloginresponse/GetLoginResponse.dart';
import '../utils/StringConstants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;



class LoginScreen extends StatefulWidget{

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<LoginScreen> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _passwordVisible = false;
  bool value = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var data;
  var snackbar;
  bool isLoggedIn = false;
  String emailadd = '';
  @override
  void initState() {
    super.initState();

  }
  void loginapi(String email, password) async {
    http.Response response = await http
        .post(Uri.parse(StringConstants.BASE_URL+'login'),
        body: {
          'email': email.toString(),
          'password': password.toString()
        });
    if (response.statusCode == 200) {
      data = response.body;
      if(getLoginResponseFromJson(data!).status==200) {
        print(jsonDecode(data!)['success'].toString());
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        String logindata = jsonEncode(
            getLoginResponseFromJson(data!).data);
        prefs.setString('logindata', logindata);



        Loginuser(getLoginResponseFromJson(data!).data);
      }else{
        snackbar = SnackBar(
          content: Text(
              getLoginResponseFromJson(data!).message.toString()),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackbar);
      }
    } else {
      const snackBar = SnackBar(
        content: Text(
            'Login Failed'),
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);
      print(response.statusCode);
    }
  }
Loginuser(Data? data){
  Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (BuildContext context) => WelcomePage()));
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
            image: AssetImage("assets/signup_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 120, 20, 10),
          child: Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: const Text("LOG IN", style: TextStyle(
                      fontSize: 24, color: ColorConstants.Omnes_font))),
              Flexible(child:
              Container(
                height: 60,
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child:TextFormField(
                  controller: emailController,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    filled: true,
                    // labelText: 'Username or Email ID',
                    hintText: 'Username or Email ID',
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                ) ,
              ),),
              Flexible(child:
              Container(
                height: 60,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: !_passwordVisible,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    // hasFloatingPlaceholder: true,
                    filled: true,
                    //fillColor: Colors.grey.withOpacity(0.1),
                    // labelText: "Password",
                    hintText: "Password",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _passwordVisible = true;
                        });
                      },
                      onPanCancel: () {
                        setState(() {
                          _passwordVisible = false;
                        });
                      },
                      child: Icon(
                          _passwordVisible ? Icons.visibility : Icons
                              .visibility_off),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "*Password needed";
                    }
                  },
                  // onSaved: (value) {
                  // _setPassword(value);
                  // },
                ),),),

              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.white,
                        elevation: 3,
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        fixedSize: const Size(150, 50),
                        //////// HERE
                      ),
                      onPressed: () {

                        if(emailController.text.isNotEmpty) {
                          if (passwordController.text.isNotEmpty) {
                           loginapi(emailController.text.toString(), passwordController.text.toString());
                            // _presenter.login(emailController.text.toString(),
                            //     passwordController.text.toString());
                          }else{
                            const snackBar = SnackBar(
                              content: Text('Please fill password'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        }else{
                          const snackBar = SnackBar(
                            content: Text('Please fill email'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: const Text(
                        "LET'S GO",
                        style: TextStyle(color: ColorConstants.Omnes_font,
                            fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgetPassword()));
                      },
                      child: Text("Forget Password?",style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: ColorConstants.Omnes_font)),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  Stepone()));
                    },
                    child: Text("I don't have an account", style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: ColorConstants.Omnes_font),),
                  )),

            ],
          ),
        ),),
    );
  }


}

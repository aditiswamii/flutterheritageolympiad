
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/forgetpassword/forgetpassword.dart';

import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';
import 'package:flutterheritageolympiad/uinew/signuppage.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../modal/getloginresponse/GetLoginResponse.dart';
import '../utils/StringConstants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;



class LoginScreen extends StatefulWidget{
  LoginScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<LoginScreen> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _passwordVisible = true;
  bool value = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var data;
  var snackbar;
  //bool isLoggedIn = false;
  String emailadd = '';
  @override
  void initState() {
    super.initState();
    //autoLogIn();
  }

  void loginapi(String email, password) async {
    http.Response response = await http
        .post(Uri.parse(StringConstants.BASE_URL+'login'),
        body: {
          'email': email.toString(),
          'password': password.toString()
        });
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
        print(jsonDecode(data!)['data'].toString());
        print(jsonDecode(data!)['data']["id"].toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if(jsonResponse['status']==200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("loggedin", true);
        //  String logindata = jsonEncode(getLoginResponseFromJson(data!).data.toString());
        //prefs.setString('logindata', logindata);
        prefs.setString('issocial',
            jsonDecode(data!)['data']["isSocial"].toString());
        prefs.setString(
            "username", jsonDecode(data!)['data']["name"].toString());
        prefs.setString("profileComplete",
            jsonDecode(data!)['data']["profileComplete"].toString());
        prefs.setString("userid", jsonDecode(data!)['data']["id"].toString());
        prefs.setString("profileImage",
            jsonDecode(data!)['data']["profileImage"].toString());
        prefs.setString(
            "gender", jsonDecode(data!)['data']["gender"].toString());
        prefs.setString(
            "lastName", jsonDecode(data!)['data']["lastName"].toString());
        prefs.setString(
            "stateId", jsonDecode(data!)['data']["stateId"].toString());
        prefs.setString("age", jsonDecode(data!)['data']["age"].toString());
        prefs.setString(
            "country", jsonDecode(data!)['data']["country"].toString());
        prefs.setString(
            "flagicon", jsonDecode(data!)["flag"].toString());
        prefs.setString(
            "agegroup", jsonDecode(data!)["age_group"].toString());
        Loginuser(jsonDecode(data!)['data']);
        print(jsonDecode(data!)['data'].toString());
      }else{
        Navigator.pop(context);
        const snackBar = SnackBar(
          content: Text(
              'Invalid Login Credentials',textAlign: TextAlign.center,),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      Navigator.pop(context);
      const snackBar = SnackBar(
        content: Text(
            'Login Failed'),
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);
      print(response.statusCode);
    }
  }
Loginuser(jsonDecode){
  Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (BuildContext context) => WelcomePage()));
}
  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
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
            image: AssetImage("assets/images/signup_bg.jpg"),
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
                      fontSize: 24, color: ColorConstants.txt))),
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
                  obscureText: _passwordVisible,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    // hasFloatingPlaceholder: true,
                    filled: true,
                    //fillColor: Colors.grey.withOpacity(0.1),
                    // labelText: "Password",
                    hintText: "Password",
                    suffixIcon: IconButton(
                        icon: Icon(
                            _passwordVisible ?  Icons.visibility_off:Icons.visibility ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        }),
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
                            showLoaderDialog(context);
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
                        style: TextStyle(color: ColorConstants.txt,
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
                          color: ColorConstants.txt)),
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
                        color: ColorConstants.txt),),
                  )),

            ],
          ),
        ),),
    );
  }


}


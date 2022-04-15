import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/ui/almostthere/almostthere_page.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/login/login_page.dart';
import 'package:flutterheritageolympiad/uinew/loginpage.dart';
import 'package:flutterheritageolympiad/uinew/registerpage.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/SharedObjects.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../modal/steponeresponse/GetStepOneResponse.dart';
import '../utils/StringConstants.dart';
class Stepone extends StatefulWidget {
   Stepone({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<Stepone> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatpasswordController = TextEditingController();
 var data;
 var snackbar;
  bool value = false;
  void steponeapi( String email, String username, String password) async {
    http.Response response = await http
        .post(Uri.parse(StringConstants.BASE_URL+'stepone'),
        body: {
  'email':email.toString(),
  'username':username.toString(),
  'password':password.toString()

        });
    if (response.statusCode == 200) {
      data = response.body;
      if(getStepOneResponseFromJson(data!).status==200) {
        print(jsonDecode(data!)['success'].toString());
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        String code = jsonEncode(
            getStepOneResponseFromJson(data!).data);
        prefs.setString('verifycode', code);
        prefs.setString('loggedin', "true");


        signup(getStepOneResponseFromJson(data!).data);
      }else{
      snackbar = SnackBar(
          content: Text(
              getStepOneResponseFromJson(data!).message.toString()),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackbar);
      }
    } else {
      print(response.statusCode);
    }
  }
  signup(int? data){
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) =>RegisterPage()));
  }

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.remove(myInterceptor);
    //autoLogIn();
  }
  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
    // Do some stuff.
    return true;
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
          margin: EdgeInsets.fromLTRB(20, 100, 20, 10),
          child: Column(children: [
            Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: const Text("SIGN UP",
                    style: TextStyle(
                        fontSize: 24, color: ColorConstants.Omnes_font))),
            Flexible(
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: TextFormField(
                  controller: emailController,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Email ID*',
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                ),
              ),
            ),
            Flexible(
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: TextFormField(
                  controller: usernameController,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Username*',
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                ),
              ),
            ),
            Flexible(
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  cursorColor: ColorConstants.Omnes_font,
                  obscuringCharacter: "*",
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    // hasFloatingPlaceholder: true,
                    hintText: 'Password*',
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                ),
              ),
            ),
            Flexible(
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: TextFormField(
                  controller: repeatpasswordController,
                  obscureText: true,
                  cursorColor: ColorConstants.Omnes_font,
                  obscuringCharacter: "*",
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    // hasFloatingPlaceholder: true,
                    hintText: 'Repeat Password*',
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "I agree to the terms and conditions*",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: ColorConstants.Omnes_font),
                    ),
                    Checkbox(
                      value: value,
                      onChanged: (newvalue) {
                        setState(() {
                          value = newvalue!;
                        });
                      },
                    )
                  ]),
            ),
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
                if (emailController.text.isNotEmpty) {
                  if (usernameController.text.isNotEmpty) {
                    if(passwordController.text.isNotEmpty ){
                    if (passwordController.text.toString() == repeatpasswordController.text.toString()) {
                      steponeapi(emailController.text.toString(),
                          usernameController.text.toString(),
                          repeatpasswordController.text.toString());
                      // _presenter.register(
                      //     emailController.text.toString(),
                      //     usernameController.text.toString(),
                      //     passwordController.text.toString());
                    } else {
                      const snackBar = SnackBar(
                        content: Text('Please check password'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
                    else {
                      const snackBar = SnackBar(
                        content: Text('Please fill password'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }else {
                    const snackBar = SnackBar(
                      content: Text('Please fill username'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                } else {
                  const snackBar = SnackBar(
                    content: Text('Please fill email address'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: const Text(
                "NEXT",
                style:
                TextStyle(color: ColorConstants.Omnes_font, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
        ),
      ),
    );
  }


}

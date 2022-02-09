
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/forgetpassword/forgetpassword.dart';
import 'package:flutterheritageolympiad/ui/login/login_viewmodal.dart';
import 'package:flutterheritageolympiad/ui/signup/signup_page.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_presenter.dart';


void main() {

  runApp(const MaterialApp(

    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
}
class LoginPage extends StatefulWidget{

  const LoginPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<LoginPage> implements LoginViewModal{
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _passwordVisible = false;
  bool value = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
   late LoginScreenPresenter  _presenter;
  bool isLoggedIn = false;
  String name = '';
  @override
  void initState() {
    super.initState();
    _presenter = LoginScreenPresenter(this);
    autoLogIn();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');
    print(userId);
    if (userId != null) {
      setState(() {
        isLoggedIn = true;
        _presenter = LoginScreenPresenter(this);
        name = userId;
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>const WelcomePage()));
      return;
    }
  }
  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', "");

    setState(() {
      name = '';
      isLoggedIn = false;
    });

  }

  Future<void> loginUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var email=prefs.getString('username');
    var password=prefs.getString('password');
    prefs.setString('is_social', "0");
    setState(() {

      name = emailController.text;
      isLoggedIn = true;
    });
    if(emailController.text.toString()==email.toString() &&passwordController.text.toString()==password.toString()) {
      _presenter.login(emailController.text.toString(),
          passwordController.text.toString());
      //emailController.clear();
    }
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
              image: AssetImage("assets/login_bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 100, 20, 10),
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
                      fillColor: Colors.white.withOpacity(0.5),
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
                              loginUser();
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
                                builder: (context) => const SignupPage()));
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

  @override
  Future<void> onLoginSuccess() async {
    isLoggedIn ? logout() : loginUser();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) => WelcomePage(),
        ),
            (Route<dynamic> route) => true);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('username');

    setState(() {

      name = emailController.text;
      isLoggedIn = true;
    });

    emailController.clear();
  }
  }


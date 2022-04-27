
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/forgetpassword/forget_viewmodal.dart';
import 'package:flutterheritageolympiad/ui/login/login_page.dart';
import 'package:flutterheritageolympiad/ui/login/login_viewmodal.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forget_presenter.dart';



void main() {

  runApp(const MaterialApp(

    debugShowCheckedModeBanner: false,
    home: ForgetPassword(),
  ));
}
class ForgetPassword extends StatefulWidget{

  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<ForgetPassword> implements ForgetPasswordView{
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  late ForgetPasswordPresenter  _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = ForgetPasswordPresenter(this);
    //autoLogIn();
  }

  // void autoLogIn() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? userId = prefs.getString('username');
  //   print(userId);
  //   if (userId != null) {
  //     setState(() {
  //       // isLoggedIn = true;
  //       // name = userId;
  //     });
  //     //Navigator.of(context).pushReplacementNamed("/home");
  //     return;
  //   }
  // }
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
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child:  Image.asset("assets/tho_logo.png"),height: 80,width: 200,),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: const Text("Forget Password", style: TextStyle(
                      fontSize: 22, color: ColorConstants.txt))),
              Flexible(child:
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
              ),),

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

  // @override
  // void onLoginSuccess() {
  //   Navigator.of(context).pushAndRemoveUntil(
  //       MaterialPageRoute(
  //         builder: (BuildContext context) => WelcomePage(),
  //       ),
  //           (Route<dynamic> route) => false);
  // }
}


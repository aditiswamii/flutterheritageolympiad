
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/ui/forgetpassword/forgetpassword.dart';

import 'package:flutterheritageolympiad/ui/homepage/welcomeback_page.dart';
import 'package:flutterheritageolympiad/uinew/registerpage.dart';
import 'package:flutterheritageolympiad/uinew/signuppage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../fcm/fcm.dart';
import '../modal/getloginresponse/GetLoginResponse.dart';
import '../utils/StringConstants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


FCM _msgService = FCM();
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

  firebasefun() async{
    WidgetsFlutterBinding.ensureInitialized();

    // TODO: Link app with Firebase (use FlutterFire CLI tools)
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await _msgService.init();
  }
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print(" --- background message received ---");
    print(message.notification!.title);
    print(message.notification!.body);
  }

  @override
  void initState() {
    super.initState();
   // firebasefun();
    //autoLogIn();
  }

  void loginapi(String email, password) async {
    http.Response response = await http
        .post(Uri.parse(StringConstants.BASE_URL+'login'),
        body: {
          'email': email.toString(),
          'password': password.toString()
        });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (response.statusCode == 200) {
      Navigator.pop(context);
      data = response.body;
        print(jsonDecode(data!)['data'].toString());
        print(jsonDecode(data!)['data']["id"].toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if(jsonResponse['status']==200) {

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
        if(jsonDecode(data!)['data'].toString().isNotEmpty){
          prefs.setString("userid", jsonDecode(data!)['data']["id"].toString());
          prefs.setString(
              "name", jsonDecode(data!)['data']["username"].toString());
          prefs.setString('issocial',
              jsonDecode(data!)['data']["isSocial"].toString());
          prefs.setString(
              "gender", jsonDecode(data!)['data']["gender"].toString());
          OpenProfile(jsonDecode(data!)['data']);
        }
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
  OpenProfile(jsonDecode){
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => RegisterPage(userid: jsonDecode(data!)['data']["id"].toString(),)));
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
              ),
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
                ),),

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
                alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  Stepone()));
                    },
                    child: Row(
                      children: [
                        Text("I don't have an account", style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: ColorConstants.txt),textAlign: TextAlign.center,),
                      ],
                    ),
                  )),
              Container(margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Card(
                  child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(4),
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: () {
                          // signupgoogle(context);
                        },
                        child: Row(
                          children: [
                            Image.asset("assets/images/google_512.png",height: 20,width: 20,),
                            Text("Sign in with Google", style: TextStyle(
                                decoration: TextDecoration.underline,fontSize: 16,
                                color: ColorConstants.txt),textAlign: TextAlign.center,),
                          ],
                        ),
                      )),
                ),
              ),
              Container(margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Card(
                  child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(4),
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>  Stepone()));
                        },
                        child: Row(
                          children: [
                            Image.asset("assets/images/facebook_512.png",height: 20,width: 20,),
                            Text("Sign in with Facebook", style: TextStyle(
                                decoration: TextDecoration.underline,fontSize: 16,
                                color: ColorConstants.txt),textAlign: TextAlign.center,),
                          ],
                        ),
                      )),
                ),
              ),
              Container(margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Card(
                  child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(4),
                      padding: EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>  Stepone()));
                        },
                        child: Row(
                          children: [
                            Image.asset("assets/images/twitter_icon.png",height: 20,width: 20,),
                            Text("Sign in with twitter", style: TextStyle(
                                decoration: TextDecoration.underline,fontSize: 16,
                                color: ColorConstants.txt),textAlign: TextAlign.center,),
                          ],
                        ),
                      )),
                ),
              ),

            ],
          ),
        ),),
    );
  }
// // function to implement the google signin
//
// // creating firebase instance
//   final FirebaseAuth auth = FirebaseAuth.instance;
//
//   Future<void> signupgoogle(BuildContext context) async {
//     final GoogleSignIn googleSignIn = GoogleSignIn();
//     final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication =
//       await googleSignInAccount.authentication;
//       final AuthCredential authCredential = GoogleAuthProvider.credential(
//           idToken: googleSignInAuthentication.idToken,
//           accessToken: googleSignInAuthentication.accessToken);
//
//       // Getting users credential
//       UserCredential result = await auth.signInWithCredential(authCredential);
//       User? user = result.user;
//
//       if (result != null) {
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => LoginScreen()));
//
//       }
//
//       // if result not null we simply call the MaterialpageRoute,
//       // for go to the HomePage screen
//     }
//   }



}


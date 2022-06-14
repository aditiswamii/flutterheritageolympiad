
import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:flutter_login_facebook/flutter_login_facebook.dart';

import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/ui/forgetpassword/forgetpassword.dart';

import 'package:CultreApp/ui/homepage/homepage.dart';
import 'package:CultreApp/uinew/registerpage.dart';
import 'package:CultreApp/uinew/signuppage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_login/twitter_login.dart';


import '../fcm/fcm.dart';
import '../modal/getloginresponse/GetLoginResponse.dart';
import '../utils/StringConstants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class LoginScreen extends StatefulWidget{
  LoginScreen({Key? key}) : super(key: key);

  @override
  State createState() => _State();
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
  GoogleSignInAccount? _currentUser;
  String _contactText = '';
  Map _userObj = {};
  bool _isLoggedIn = false;
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
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      log("1");
      log(_currentUser!.email);
      if (_currentUser != null) {

        _handleGetContact(_currentUser!);
      }
    });
    _googleSignIn.signInSilently();

  }
  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],

  );

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    log(user.email);
    socialloginapi(user.email, 1);
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
    json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
          (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
            (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {

        return name['displayName'] as String?;
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    // print("Hello");
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> handleSignOut() => _googleSignIn.disconnect();

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
        builder: (BuildContext context) => HomePage()));
  }
  void socialloginapi(String email,int type) async {
    http.Response response = await http
        .post(Uri.parse(StringConstants.BASE_URL+'login'),
        body: {
          'email': email.toString(),
          'is_social': type.toString()
        });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (response.statusCode == 200) {
      // Navigator.pop(context);
      data = response.body;
      print(jsonDecode(data!)['data'].toString());
      print(jsonDecode(data!)['data']["id"].toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if(jsonResponse['status']==200) {
        if (prefs.getString("profileComplete") == "1") {
          prefs.setBool("loggedin", true);
          prefs.setString('issocial', '1');
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
          prefs.setBool('setProfileComplete', true);
          Loginuser(jsonDecode(data!)['data']);
          print(jsonDecode(data!)['data'].toString());
        } else {
          prefs.setString('issocial', "1");
          prefs.setBool('setProfileComplete', false);
          OpenProfile(jsonDecode(data!)['data']);
        }
      }else {
        // Navigator.pop(context);
        const snackBar = SnackBar(
          content: Text(
            'Invalid Login Credentials', textAlign: TextAlign.center,),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      // Navigator.pop(context);
      const snackBar = SnackBar(
        content: Text(
            'Login Failed'),
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);
      print(response.statusCode);
    }
  }
  void twitterloginapi(String twitterid,String username) async {
    http.Response response = await http
        .post(Uri.parse(StringConstants.BASE_URL+'login'),
        body: {
          'social_id': twitterid.toString(),
          'is_social': "3",
          'username':username.toString()
        });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (response.statusCode == 200) {
      // Navigator.pop(context);
      data = response.body;
      log(jsonDecode(data!)['data'].toString());
      log(jsonDecode(data!)['data']["id"].toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if(jsonResponse['status']==200) {
        if (prefs.getString("profileComplete") == "1") {
          prefs.setBool("loggedin", true);
          prefs.setString('issocial', '1');
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
          prefs.setBool('setProfileComplete', true);
          Loginuser(jsonDecode(data!)['data']);
          print(jsonDecode(data!)['data'].toString());
        } else {
          prefs.setString('issocial', "3");
          prefs.setBool('setProfileComplete', false);
          OpenProfile(jsonDecode(data!)['data']);
        }
      }else {
        // Navigator.pop(context);
        const snackBar = SnackBar(
          content: Text(
            'Invalid Login Credentials', textAlign: TextAlign.center,),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      // Navigator.pop(context);
      const snackBar = SnackBar(
        content: Text(
            'Login Failed'),
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);
      print(response.statusCode);
    }
  }
  void facebookloginapi(String facebookid,String username) async {
    http.Response response = await http
        .post(Uri.parse(StringConstants.BASE_URL+'login'),
        body: {
          'social_id': facebookid.toString(),
          'is_social': "2",
          'username':username.toString()
        });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (response.statusCode == 200) {
      // Navigator.pop(context);
      data = response.body;
      print(jsonDecode(data!)['data'].toString());
      print(jsonDecode(data!)['data']["id"].toString());
      var jsonResponse = convert.jsonDecode(response.body);
      if(jsonResponse['status']==200) {
        if (prefs.getString("profileComplete") == "1") {
          prefs.setBool("loggedin", true);
          prefs.setString('issocial', '1');
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
          prefs.setBool('setProfileComplete', true);
          Loginuser(jsonDecode(data!)['data']);
          print(jsonDecode(data!)['data'].toString());
        } else {
          prefs.setString('issocial', "3");
          prefs.setBool('setProfileComplete', false);
          OpenProfile(jsonDecode(data!)['data']);
        }
      }else {
        // Navigator.pop(context);
        const snackBar = SnackBar(
          content: Text(
            'Invalid Login Credentials', textAlign: TextAlign.center,),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      // Navigator.pop(context);
      const snackBar = SnackBar(
        content: Text(
            'Login Failed'),
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar);
      print(response.statusCode);
    }
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
          child: ListView(
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
                      child: Text(_contactText,style: TextStyle(
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
              if(Platform.isAndroid)
                Container(margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Card(
                    child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(4),
                        padding: EdgeInsets.all(4),
                        child: GestureDetector(
                          onTap: () {
                            //_handleSignIn();
                            signupgoogle(context);
                          },
                          child: Row(
                            children: [
                              Image.asset("assets/images/google_512.png",height: 20,width: 20,),
                              Container(margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text("Sign in with Google", style: TextStyle(
                                  fontSize: 16,
                                    color: Colors.black),textAlign: TextAlign.center,),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              if(Platform.isIOS)
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
                              Image.asset("assets/images/applelogo.png",height: 20,width: 20,),
                              Container(margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text("Sign in with Apple", style: TextStyle(
                                   fontSize: 16,
                                    color: Colors.black),textAlign: TextAlign.center,),
                              ),
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
                          fbLogin();
                        },
                        child: Row(
                          children: [
                            Image.asset("assets/images/facebook_512.png",height: 20,width: 20,),
                            Container(margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text("Sign in with Facebook", style: TextStyle(
                                 fontSize: 16,
                                  color: Colors.black),textAlign: TextAlign.center,),
                            ),
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
                          twitterlogin();

                        },
                        child: Row(
                          children: [
                            Image.asset("assets/images/twitter_icon.png",height: 20,width: 20,),
                            Container(margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text("Sign in with twitter", style: TextStyle(
                                fontSize: 16,
                                  color: Colors.black),textAlign: TextAlign.center,),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
    // Container(
    // child: _isLoggedIn
    // ? Column(
    // children: [
    // Image.network(_userObj["picture"]["data"]["url"]),
    // Text(_userObj["name"]),
    // Text(_userObj["email"]),
    // TextButton(
    // onPressed: () {
    // FacebookAuth.instance.logOut().then((value) {
    // setState(() {
    // _isLoggedIn = false;
    // _userObj = {};
    // });
    // });
    // },
    // child: Text("Logout"))
    // ],
    // )
    //     : Center(
    // child: ElevatedButton(
    // child: Text("Login with Facebook"),
    // onPressed: () async {
    // FacebookAuth.instance.login(
    // permissions: ["public_profile", "email"]).then((value) {
    // FacebookAuth.instance.getUserData().then((userData) {
    // setState(() {
    // _isLoggedIn = true;
    // _userObj = userData;
    // });
    // });
    // });
    // },
    // ),
    // ),
    // ),

            ],
          ),
        ),),
    );
  }

  twitterlogin() async {
    final twitterLogin = TwitterLogin(

      apiKey: 'LYAl31FIc1RVG8re8sBEzAX3Y',

      apiSecretKey: 'LqBKt1XAk7SVQIY5UpSBjKdKHkohcuk8mvclkRTRIXRXaYgLRV',

      redirectURI: 'https://cultre.app/twittercall',
    );
    final authResult = await twitterLogin.login();
    switch (authResult.status!) {
      case TwitterLoginStatus.loggedIn:
        print("succ");
        twitterloginapi(authResult.user!.id.toString(), authResult.user!.name.toString());
          FirebaseAuth.instance.signInWithCredential(
          TwitterAuthProvider.credential(
            accessToken: authResult.authToken!,
            secret: authResult.authTokenSecret!,
          ),
        );
        break;
      case TwitterLoginStatus.cancelledByUser:
        print("cancel");
        // cancel
        break;
      case TwitterLoginStatus.error:
        print("error");
        // error
        break;
    }
  }
// function to implement the google signin

// creating firebase instance
  final FirebaseAuth auth = FirebaseAuth.instance;

   signupgoogle(BuildContext context) async {
    log("hi");
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    log(googleSignIn.currentUser!.email);
    log(googleSignInAccount.toString());
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      log(googleSignInAccount.email);
      // Getting users credential
      UserCredential result =  auth.signInWithCredential(authCredential) as UserCredential;
      User? user = result.user;
      if (user != null) {
        log("name : ${user.displayName!.toString()}");
        log("email : ${user.email!.toString()}");
        socialloginapi(user.email!, 1);


      }

      // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }
  final plugin1 = FacebookLogin(debug: true);
  String? _sdkVersion;
  FacebookAccessToken? _token;
  FacebookUserProfile? _profile;
  String? _email;
  String? _imageUrl;

   _updateLoginInfo() async {
    final plugin = plugin1;
    final token = await plugin.accessToken;
    FacebookUserProfile? profile;
    log("profile:${profile!.name!.toString()}");
    String? email;
    String? imageUrl;
    log(profile.name.toString());
    if (token != null) {
      profile = await plugin.getUserProfile();
      if (token.permissions.contains(FacebookPermission.email.name)) {
        email = await plugin.getUserEmail();
        log(email.toString());
      }
      imageUrl = await plugin.getProfileImageUrl(width: 100);
    }

    setState(() {
      _token = token;
      _profile = profile;
      _email = email;
      _imageUrl = imageUrl;
    });
  }
  Future<void> _getSdkVersion() async {
    final sdkVesion = await plugin1.sdkVersion;
    setState(() {
      _sdkVersion = sdkVesion;
    });
  }
  Future<void> fbLogin()async{
     log("fblogin");



      final LoginResult result = await FacebookAuth.i.login(); // by default we request the email and the public profile
      log("result: ${result.toString()}");
      if (result.status == LoginStatus.success) {
        // you are logged

        final AccessToken accessToken = result.accessToken!;
        log("accessToken:"+accessToken.toString());
        final userData = await FacebookAuth.i.getUserData();
        log(userData['id'].toString());
        log("userData:"+userData.toString());
        facebookloginapi(userData['id'].toString(), userData['name'].toString());
        print(userData['name']);
      }else{

      }


  }
  Future<void> fbLogout()async{
    await FacebookAuth.instance.logOut();
    setState(() {});
  }

}




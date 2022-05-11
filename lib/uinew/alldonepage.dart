import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/dialog/emailresend/emailresend_dialog.dart';
import 'package:flutterheritageolympiad/ui/alldone/alldone_presenter.dart';
import 'package:flutterheritageolympiad/ui/alldone/alldone_viewmodal.dart';
import 'package:flutterheritageolympiad/ui/login/login_page.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';
import 'package:flutterheritageolympiad/uinew/registerpage.dart';
import 'package:flutterheritageolympiad/uinew/signuppage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modal/getemailverify/GetEmailVerifyResponse.dart';
import '../utils/StringConstants.dart';
import 'loginpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;



class AllDoneScreen extends StatefulWidget {
  var email;
 AllDoneScreen({Key? key,required this.email}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<AllDoneScreen> {
  TextEditingController otpController = TextEditingController();
  bool value = false;
var userid;
  var data;
  var snackbar;
  void email() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(otpController.text.toString()==prefs.getString('verifycode'))
    emailverifyapi(widget.email, prefs.getString('verifycode')!, prefs.getString('issocial').toString());
  }
  void emailverifyapi( String email, String otp, String is_social) async {
    http.Response response = await http
        .post(Uri.parse(StringConstants.BASE_URL+'email_verify'),
        body: {
          'email':email,
          'otp':otp,
          'is_social':is_social,
        });
    if (response.statusCode == 200) {
      data = response.body;
      if(getEmailVerifyResponseFromJson(data!).status==200) {
        print(jsonDecode(data!)['success'].toString());
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        String registerdata = jsonEncode(
            getEmailVerifyResponseFromJson(data!).data);
        prefs.setString('registerdata', registerdata);
        setState(() {
          var email = getEmailVerifyResponseFromJson(data!).data!.email.toString();
          userid = getEmailVerifyResponseFromJson(data!).data!.id.toString();
          var username=getEmailVerifyResponseFromJson(data!).data!.username.toString();
          prefs.setString('email',getEmailVerifyResponseFromJson(data!).data!.email.toString( ));
          prefs.setString('userid',getEmailVerifyResponseFromJson(data!).data!.id.toString());
          prefs.setString('username',getEmailVerifyResponseFromJson(data!).data!.username.toString());
        });
        onsuccess(getEmailVerifyResponseFromJson(data!).data,userid);
      }else{
        snackbar = SnackBar(
          content: Text(
              getEmailVerifyResponseFromJson(data!).message.toString()),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackbar);
      }
    } else {
      print(response.statusCode);
    }
  }
 onsuccess(Data? data, userid){
   Navigator.pushReplacement(
       context,
       MaterialPageRoute(
           builder: (context) =>  RegisterPage( userid: userid,)));
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
        MaterialPageRoute(builder: (BuildContext context) => Stepone()));
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
            image: AssetImage("assets/images/login_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 70, 0, 10),
                  child: const Text("ALL DONE!",
                      style: TextStyle(
                          fontSize: 24, color: ColorConstants.txt))),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: const Text(
                      "To start using the app,please verify your email address",
                      style: TextStyle(
                          fontSize: 18, color: ColorConstants.txt))),
              Flexible(child:
              Container(
                height: 60,
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child:TextFormField(
                  controller: otpController,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    border: InputBorder.none,
                    // labelText: 'Username or Email ID',
                    hintText: 'Verify code',
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                ) ,
              ),),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.white,
                    elevation: 3,
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    fixedSize: const Size(100, 50),
                    //////// HERE
                  ),
                  onPressed: () {
                    email();
                    //emailverifyapi(email, otp, is_social);
                  },
                  child: const Text(
                    "NEXT",
                    style: TextStyle(
                        color: ColorConstants.txt, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: const Divider(
                  color: ColorConstants.txt,
                  height: 2,
                  indent: 10,
                  endIndent: 10,
                  thickness: 2,
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: const Text(
                      "Haven't gotten an email?We can send it again!",
                      style: TextStyle(
                          fontSize: 18, color: ColorConstants.txt))),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 20, 10),
                alignment: Alignment.centerLeft,
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
                        fixedSize: const Size(100, 50),
                        //////// HERE
                      ),
                      onPressed: () {
                        AlertDialog errorDialog = AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0)), //this right here
                            title: Container(
                                height: 250,
                                width: 250,
                                alignment: Alignment.center,
                                child: DialogEmailResend()));
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => errorDialog);
                      },
                      child: const Text(
                        "RESEND",
                        style: TextStyle(
                            color: ColorConstants.txt, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  contentPadding:
                                  EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  titleTextStyle: TextStyle(
                                      fontSize: 12, color: ColorConstants.txt),
                                  title:  Image.asset(
                                    "assets/images/hint.png",
                                    height: 50,
                                    width: 100,
                                    alignment: Alignment.center,
                                  ),
                                  content: Text(
                                    'Check your spam!',
                                    style: TextStyle(color: ColorConstants.txt),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              });
                          // Navigator.pushReplacement(context,
                          //     MaterialPageRoute(builder: (context) => const VjournoMain()));
                        },
                        child: Image.asset(
                          "assets/images/hint.png",
                          height: 50,
                          width: 100,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}

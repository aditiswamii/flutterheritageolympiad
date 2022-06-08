
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';

import 'package:flutterheritageolympiad/ui/myaccount/myaccount_page.dart';
import 'package:flutterheritageolympiad/ui/quiz/let_quiz.dart';
import 'package:flutterheritageolympiad/ui/shopproduct/shopproducts_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../uinew/loginpage.dart';
import '../feed/feed.dart';
import '../feed/savedpost/savedpost.dart';

void main() {

  runApp( MaterialApp(
    theme: ThemeData(fontFamily: "Nunito"),
    debugShowCheckedModeBanner: false,
    home: MySideMenuDrawer(),
  ));
}
class MySideMenuDrawer extends StatefulWidget{

  const MySideMenuDrawer({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<MySideMenuDrawer> {
  bool isLoggedIn = false;
  String name = '';
  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('loggedin');
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginScreen()));
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return Drawer(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 5.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8)
          ),
          child: ListView(

            children: [
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: 4),
                 trailing: Image.asset("assets/images/cross.png",height: 20,width: 20),
                 onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),


              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                 title: const Text('My Account',style:TextStyle(fontSize: 18,color: ColorConstants.menu_text),textAlign: TextAlign.end,),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  MyAccountPage()));

                  //Navigator.pop(context);
                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                  title: const Text('My Feed',style:TextStyle(fontSize: 18,color: ColorConstants.menu_text),textAlign: TextAlign.end,),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FeedPage()));
                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                title: const Text('Saved Posts',style:TextStyle(fontSize: 18,color: ColorConstants.menu_text),textAlign: TextAlign.end,),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SavedPost()));

                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                   title: const Text('Quizzes',style:TextStyle(fontSize: 18,color: ColorConstants.menu_text),textAlign: TextAlign.end,),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QuizPage()));
                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                    title: const Text('Shop',style:TextStyle(fontSize: 18,color: ColorConstants.menu_text),textAlign: TextAlign.end,),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ShopPage()));
                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                   title: const Text('About Us',style:TextStyle(fontSize: 18,color: ColorConstants.menu_text),textAlign: TextAlign.end,),
                onTap: () {
                  Navigator.pop(context);

                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                title: const Text('FAQ',style:TextStyle(fontSize: 18,color: ColorConstants.menu_text),textAlign: TextAlign.end,),
                onTap: () {
                  Navigator.pop(context);

                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                title: const Text('HELP AND SUPPORT',style:TextStyle(fontSize: 18,color: ColorConstants.menu_text),textAlign: TextAlign.end,),
                onTap: () {
                  Navigator.pop(context);

                },
              ),

              ListTile(
                   title: const Text('Log Out',style:TextStyle(fontSize: 18,color: ColorConstants.menu_text,decoration: TextDecoration.underline),textAlign: TextAlign.end,),
                onTap: () {
                     logout();
                },
              ),
            ],
          ),
        ),

    );
  }
}
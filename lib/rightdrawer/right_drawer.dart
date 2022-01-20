
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';

void main() {

  runApp(const MaterialApp(

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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return Drawer(
        child: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 5.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.9)
          ),
          child: ListView(

            children: [
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: 1),
                 trailing: Image.asset("assets/side_menu.png",height: 40,width: 40),
                 onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                   title: const Text('SUBSCRIPTION PLANS\nMENTIONED HERE',style:TextStyle(fontSize: 15,color:ColorConstants.menu_text),textAlign: TextAlign.end,),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),

              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                 title: const Text('My Account',style:TextStyle(fontSize: 15,color: ColorConstants.menu_text),textAlign: TextAlign.end,),
                onTap: () {
                  Navigator.pop(context);

                  //Navigator.pop(context);
                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                  title: const Text('My Feed',style:TextStyle(fontSize: 15,color: ColorConstants.menu_text),textAlign: TextAlign.end,),
                onTap: () {
                  //Navigator.pop(context);

                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: const Text('SAVED POSTS',style:TextStyle(fontSize: 12,color: ColorConstants.menu_text),textAlign: TextAlign.end,),
                onTap: () {
                  Navigator.pop(context);

                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: const Text('NEWS AND NOTICES',style:TextStyle(fontSize: 12,color: ColorConstants.menu_text),textAlign: TextAlign.end,),
                onTap: () {
                  Navigator.pop(context);

                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                   title: const Text('Quizzes',style:TextStyle(fontSize: 15,color: ColorConstants.menu_text),textAlign: TextAlign.end,),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                    title: const Text('Shop',style:TextStyle(fontSize: 15,color: ColorConstants.menu_text),textAlign: TextAlign.end,),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                   title: const Text('Plans',style:TextStyle(fontSize: 15,color: ColorConstants.menu_text),textAlign: TextAlign.end,),
                onTap: () {
                  Navigator.pop(context);

                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                    title: const Text('Performance',style:TextStyle(fontSize: 15,color: ColorConstants.menu_text),textAlign: TextAlign.end,),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                   title: const Text('About us',style:TextStyle(fontSize: 15,color: ColorConstants.menu_text),textAlign: TextAlign.end,),
                onTap: () {

                 // Navigator.pop(context);
                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: const Text('FAQ',style:TextStyle(fontSize: 12,color: ColorConstants.menu_text),textAlign: TextAlign.end,),
                onTap: () {
                  Navigator.pop(context);

                },
              ),
              ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                title: const Text('HELP AND SUPPORT',style:TextStyle(fontSize: 12,color: ColorConstants.menu_text),textAlign: TextAlign.end,),
                onTap: () {
                  Navigator.pop(context);

                },
              ),

              ListTile(
                   title: const Text('Log Out',style:TextStyle(fontSize: 15,color: ColorConstants.menu_text,decoration: TextDecoration.underline),textAlign: TextAlign.end,),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),

    );
  }
}
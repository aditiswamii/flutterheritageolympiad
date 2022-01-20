
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';

void main() => runApp(const MySidemenuDrawer());

class MySidemenuDrawer extends StatelessWidget {
  const MySidemenuDrawer({Key? key}) : super(key: key);

  static const appTitle = '';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,

      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return  Drawer(
        child: ListView(

          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5)
              ),
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 5.0),
                child: GestureDetector(
                  onTap: () {
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => const VjournoMain()));
                  },
                  child:  Image.asset("assets/side_menu.png",height: 40,width: 40),
                ),
              )
            ),

            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -2),
              tileColor: Colors.black.withOpacity(0.5),
              minLeadingWidth: 30,
                 title: const Text('SUBSCRIPTION PLANS\nMENTIONED HERE',style:TextStyle(fontSize: 15,color:ColorConstants.menu_text)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),

            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -2),
              tileColor: Colors.black.withOpacity(0.5),
              minLeadingWidth: 30,
               title: const Text('My Account',style:TextStyle(fontSize: 15,color: ColorConstants.menu_text)),
              onTap: () {
                Navigator.pop(context);

                //Navigator.pop(context);
              },
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -2),
              tileColor: Colors.black.withOpacity(0.5),
              minLeadingWidth: 30,
                title: const Text('My Feed',style:TextStyle(fontSize: 15,color: ColorConstants.menu_text)),
              onTap: () {

                Column(
                  children: [
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                      tileColor: Colors.black.withOpacity(0.5),
                      minLeadingWidth: 30,
                      title: const Text('SAVED POSTS',style:TextStyle(fontSize: 15,color: ColorConstants.menu_text)),
                      onTap: () {
                        Navigator.pop(context);

                      },
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                      tileColor: Colors.black.withOpacity(0.5),
                      minLeadingWidth: 30,
                      title: const Text('NEWS AND NOTICES',style:TextStyle(fontSize: 15,color: ColorConstants.menu_text)),
                      onTap: () {
                        Navigator.pop(context);

                      },
                    ),

                  ],
                );

                //Navigator.pop(context);

              },
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -2),
              tileColor: Colors.black.withOpacity(0.5),
              minLeadingWidth: 30,
                 title: const Text('Quizzes',style:TextStyle(fontSize: 15,color: ColorConstants.menu_text)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -2),
              tileColor: Colors.black.withOpacity(0.5),
              minLeadingWidth: 30,
                  title: const Text('Shop',style:TextStyle(fontSize: 15,color: ColorConstants.menu_text)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -2),
              tileColor: Colors.black.withOpacity(0.5),
              minLeadingWidth: 30,
                 title: const Text('Plans',style:TextStyle(fontSize: 15,color: ColorConstants.menu_text)),
              onTap: () {
                Navigator.pop(context);

              },
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -2),
              tileColor: Colors.black.withOpacity(0.5),
              minLeadingWidth: 30,
                  title: const Text('Performance',style:TextStyle(fontSize: 15,color: ColorConstants.menu_text)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -2),
              tileColor:Colors.black.withOpacity(0.5),
              minLeadingWidth: 30,
                 title: const Text('About us',style:TextStyle(fontSize: 15,color: ColorConstants.menu_text)),
              onTap: () {
                Column(
                  children: [
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                      tileColor: Colors.black.withOpacity(0.5),
                      minLeadingWidth: 30,
                      title: const Text('FAQ',style:TextStyle(fontSize: 15,color: ColorConstants.menu_text)),
                      onTap: () {
                        Navigator.pop(context);

                      },
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -2),
                      tileColor: Colors.black.withOpacity(0.5),
                      minLeadingWidth: 30,
                      title: const Text('HELP AND SUPPORT',style:TextStyle(fontSize: 15,color: ColorConstants.menu_text)),
                      onTap: () {
                        Navigator.pop(context);

                      },
                    ),

                  ],
                );
               // Navigator.pop(context);
              },
            ),
            ListTile(
              tileColor: Colors.black.withOpacity(0.5),
              minLeadingWidth: 30,
                 title: const Text('Log Out',style:TextStyle(fontSize: 15,color: ColorConstants.menu_text,decoration: TextDecoration.underline)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),

    );
  }
}
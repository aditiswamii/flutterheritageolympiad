
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/ui/classicquiz/questionpageview/questions.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/dialog/duelinvitereceive/duelinvite_receivedialog.dart';
import 'package:flutterheritageolympiad/ui/duelquiz/duel_quiz.dart';

import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/tournamentquiz/tournament_quiz.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';

import '../invitecontact.dart';

void main() {

  runApp(const MaterialApp(

    debugShowCheckedModeBanner: false,
    home: PhonebookScreen(),
  ));
}
class PhonebookScreen extends StatefulWidget{

  const PhonebookScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<PhonebookScreen> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  Iterable<Contact>? _contacts;
bool add =true;
  @override
  void initState() {
    getContacts();
    super.initState();
  }

  Future<void> getContacts() async {
    //Make sure we already have permissions for contacts when we get to this
    //page, so we can just retrieve it
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      endDrawerEnableOpenDragGesture: true,
      endDrawer: MySideMenuDrawer(),
      body:Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child:Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WelcomePage()));
                        },
                        child:  Image.asset("assets/home_1.png",height: 40,width: 40),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState!.openEndDrawer();
                        },
                        child:  Image.asset("assets/side_menu_2.png",height: 40,width: 40),
                      ),
                    ),
                  ],
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 60, 0, 10),
                    child: const Text("PHONEBOOK,",style: TextStyle(fontSize: 24,color: ColorConstants.Omnes_font))),
                   Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: const Text("You have 50 contacts.You may add or invite.",style: TextStyle(fontSize: 15,color: ColorConstants.Omnes_font))),
                _contacts != null
                //Build a list view of all contacts, displaying their avatar and
                // display name
                    ?Expanded(
                      child: Flexible(
                          child: Container(
                              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              decoration: const BoxDecoration(color: Colors.white),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  // if you need this
                                  side: BorderSide(
                                    color: Colors.grey.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child:ListView.builder(
                       shrinkWrap:true,
                       itemCount: _contacts!.length,
                       itemBuilder: (BuildContext context, int index) {
                         Contact? contact = _contacts!.elementAt(index);
                         return Container(
                             decoration:
                              BoxDecoration(
                                 border:  Border(
                                     bottom:  BorderSide(color: Colors.grey)
                                 )
                             ),
                           margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                           child: ListTile(
                             contentPadding:
                             const EdgeInsets.symmetric(
                                 vertical: 2, horizontal: 18),
                             leading: (contact.avatar != null &&
                                 contact.avatar!.isNotEmpty)
                                 ? CircleAvatar(
                               backgroundImage: MemoryImage(contact.avatar!),
                             )
                                 : CircleAvatar(
                               child: Text(contact.initials(),
                                 style: TextStyle(color: Colors.white),),
                               backgroundColor: ColorConstants.myfeed,
                             ),
                             title: Text(contact.displayName ?? ''),
                             trailing: ElevatedButton(
                               style: ElevatedButton.styleFrom(
                                 primary: Colors.red,
                                 onPrimary: Colors.white,
                                 elevation: 3,
                                 alignment: Alignment.center,
                                 shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(30.0)),
                                 fixedSize: const Size(60, 20),
                                 //////// HERE
                               ),
                               onPressed: () {
                                 Navigator.pushReplacement(
                                     context,
                                     MaterialPageRoute(
                                         builder: (
                                             context) => const WelcomePage()));
                               },
                               child: const Text(
                                 "Add",
                                 style: TextStyle(
                                     color: Colors.white, fontSize: 16),
                                 textAlign: TextAlign.center,
                               ),
                             ),
                             //This can be further expanded to showing contacts detail
                             // onPressed().
                           ),

                         );
                       }
                          ),
                        ),
                      )
                      ),
                    ): Center(child: const CircularProgressIndicator()),

                Container(
                  alignment: FractionalOffset.bottomCenter,
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: ColorConstants.red,
                          onPrimary: Colors.white,
                          elevation: 3,
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          fixedSize: const Size(100, 40),
                          //////// HERE
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InviteContactScreen()));
                        },
                        child: const Text(
                          "GO BACK",
                          style: TextStyle(
                              color: ColorConstants.to_the_shop, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: ColorConstants.verdigris,
                          onPrimary: Colors.white,
                          elevation: 3,
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          fixedSize: const Size(100, 40),
                          //////// HERE
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (
                                      context) => const PhonebookScreen()));
                        },
                        child: const Text(
                          "LET'S GO!",
                          style: TextStyle(
                              color: ColorConstants.to_the_shop, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }

}

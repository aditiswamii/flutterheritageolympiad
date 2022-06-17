import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../colors/colors.dart';
import '../../../../modal/PhoneContact.dart';
import '../../../../utils/StringConstants.dart';
import '../../../rightdrawer/right_drawer.dart';
import 'package:CultreApp/ui/homepage/homepage.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../invitecontact.dart';
import '../invitecontactlink/invitecontact_link.dart';
class PhonebookPage extends StatefulWidget {
  @override
  _PhonebookPageState createState() => _PhonebookPageState();
}

class _PhonebookPageState extends State<PhonebookPage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Contact>? _contacts;
  bool _permissionDenied = false;
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  var data;
  var snackBar;
  var checkdata;
  var importdata;
  var contactlist;
  List<String>? listv =[].cast<String>().toList(growable: true);
  List<String>? friendList =[].cast<String>().toList(growable: true);
  List<PhoneContact>? phcoList=[].cast<PhoneContact>().toList(growable: true);
  List<String>? cultreList=[].cast<String>().toList(growable: true);
  List<String>? totphcoList  = [].cast<String>().toList(growable: true);
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });
    print("userdata");
    //calTheme();
    _fetchContacts();
    phcoList!.clear();
   // checkfriend(userid.toString());

  }
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    userdata();
  }


  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => InviteContactScreen()));
    // Do some stuff.
    return true;
  }
  addfriend(String userid,String mobiles) async {
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "add_friend"),
        body: {'user_id': userid.toString(),
          'mobile':mobiles.toString()
        });
    // showLoaderDialog(context);
    print("addfriendapi");
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      // Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {

        snackBar = SnackBar(
          content: Text(
            jsonResponse['message'].toString(),textAlign: TextAlign.center,),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);

      } else {
        snackBar = SnackBar(
          content: Text(
            jsonResponse['message'].toString(),textAlign: TextAlign.center,),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
        // onsuccess(null);
        log(jsonResponse['message']);
      }
    } else {
      // Navigator.pop(context);
      print(response.statusCode);
    }
  }
  checkfriend(String userid) async {
    http.Response response = await http.post(
        Uri.parse("${StringConstants.BASE_URL}check_friend"),
        body: {'user_id': userid.toString()});
    // showLoaderDialog(context);

    print("checkfriendapi");
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      // Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {
        checkdata = jsonResponse[
        'data'];
        print("data" + checkdata.toString());
        setState(() {
          checkdata = jsonResponse[
          'data'];
          onchecksuccess(checkdata);
        });
        //get all the data from json string superheros
        print("length" + checkdata.length.toString());


      } else {
        snackBar = SnackBar(
          content: Text(
            jsonResponse['message'].toString(),textAlign: TextAlign.center,),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
        // onsuccess(null);
        log(jsonResponse['message']);
      }
    } else {
      // Navigator.pop(context);
      print(response.statusCode);
    }
  }
  onchecksuccess(checkdata){
    if(checkdata!=null) {
      setState(() {
        listv=List.from(checkdata);
      });
    friendphone(listv);
    //   for (int i=0;i< checkdata.length;i++){
    //   setState(() {
    //   listv!.add(checkdata[i].toString());
    //   friendphone(listv);
    //   });
    // }
  }
  }
  friendphone(List<String>? listvv){
    friendList!.clear();
    setState(() {
      friendList=List.from(listvv!);
    });

    // friendList!.addAll(listv!);
    setcontacts();
  }
  setcontacts(){
    _fetchContacts();
  }
  importcontact(String userid, List<String> contacts) async {
    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "import_contact"),
        body: {
          'user_id': userid.toString(),
          'mobiles': contacts.toString()
        });
    // showLoaderDialog(context);

    print("importcontactapi");
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      // Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {
        importdata = jsonResponse[
        'data'];
        print("data" + importdata.toString());
        setState(() {
          importdata = jsonResponse[
          'data'];
        });
        onimportsuccess(importdata);
        //get all the data from json string superheros
        print("length" + checkdata.length.toString());


      }else if(jsonResponse['status'] == 201) {
        log(jsonResponse['message']);
          onimportsuccess(listv);
      }else {
        snackBar = SnackBar(
          content: Text(
            jsonResponse['message'].toString(),textAlign: TextAlign.center,),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
        // onsuccess(null);
        log(jsonResponse['message']);
      }
    } else {
      // Navigator.pop(context);
      print(response.statusCode);
    }
  }
  onimportsuccess(importdata){
    if(data!=null) {
      for (int i=0;i< data.length;i++){
        setState(() {
          listv!.add(data[i].toString());
          cultreuser(listv);
        });
      }
    }
  }
  cultreuser(List<String>? listv){
    cultreList!.clear();
    cultreList!.addAll(listv!);
    for(int i =0;i< phcoList!.length;i++) {
      for(int j =0;j< phcoList![i].phone!.length;j++){
        var obj = PhoneContact();

        if(phcoList![i].status==0){
          obj.name = phcoList![i].name;
          obj.id = phcoList![i].id;
          obj.status = 2;
         obj.phone = List as List<String>?;
         log(phcoList![i].phone![j].toString());
          // Log.e("phone",""+phcoList[i].phone!!.get(j)!!.toString())
          obj.phone!.add(phcoList![i].phone![j].toString());
          phcoList![i] = obj;
        }
      }
    }
  }
  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts();
      setState(() => _contacts = contacts);
    }
    for(int i =0;i<_contacts!.length;i++) {
      for (int j = 0; j < _contacts![i].phones.length; j++) {
        setState(() {
          totphcoList!.add(_contacts![i].phones[j].number);
          log(totphcoList.toString());
        });

      }
    }

    // totphcoList=List.from(_contacts!);
    // contactlist= List.from(_contacts!);
   importcontact(userid.toString(), totphcoList!);
   //checkfriend(userid.toString());
  }
  // showLoaderDialog(BuildContext context) {
  //   AlertDialog alert = AlertDialog(
  //     content: new Row(
  //       children: [
  //         CircularProgressIndicator(),
  //         Container(
  //             margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
  //       ],
  //     ),
  //   );
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    if (_permissionDenied) return Center(child: Text('Permission denied'));
    if (_contacts == null) return Container(height: MediaQuery.of(context).size.height, decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/debackground.jpg"),
        fit: BoxFit.cover,
      ),
    ),
        child: Center(child: CircularProgressIndicator()));
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      endDrawerEnableOpenDragGesture: true,
      endDrawer: MySideMenuDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/debackground.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  alignment: Alignment.centerLeft,

                  padding: EdgeInsets.all(5),
                  child: Center(
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        },
                        child:  Image.asset("assets/images/home_1.png",height: 40,width: 40,),
                      ),
                    ),
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
                    child:  Image.asset("assets/images/side_menu_2.png",height: 40,width: 40),
                  ),
                ),
              ],
            ),
            Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: const Text("PHONEBOOK,",
                    style: TextStyle(fontSize: 24, color: ColorConstants.txt))),
            Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    Text("You have",
                        style: TextStyle(fontSize: 15, color: ColorConstants.txt)),
                    Container( margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text(_contacts!.length.toString(),
                          style: TextStyle(fontSize: 15, color: ColorConstants.txt)),
                    ),
                    Container( margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text("contacts. You may add or invite.",
                          style: TextStyle(fontSize: 15, color: ColorConstants.txt)),
                    ),
                  ],
                )),
            Container(
              child: ListView.builder(
                  physics: ClampingScrollPhysics(
                      parent: BouncingScrollPhysics()),
                shrinkWrap: true,
                  itemCount: _contacts!.length,
                  itemBuilder: (context, i) {
                    //contactlist.add(_contacts![i].phones[i].number);
                    // importcontact(userid.toString());
                    return Card(
                      child: ListTile(
                        leading: Container(
                          height: 30,
                          width: 30,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: ColorConstants.yellow200,
                              shape: BoxShape.circle
                          ),
                          child: Center(child: Text(_contacts![i].displayName[0]
                              .toUpperCase()
                              .toString())),
                        ),
                        title: Container(child: Text(
                            "${_contacts![i].displayName[0].toUpperCase() +
                                _contacts![i].displayName.substring(1)}")),
                        trailing: Container(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: ColorConstants.verdigris,
                              onPrimary: Colors.white,
                              elevation: 3,
                              alignment: Alignment.center,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              //fixedSize: const Size(100, 40),
                              //////// HERE
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ContactInviteLink()));
                            },
                            child: const Text(
                              "Invite",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ]),
        ),
      ),
    );
  }
}

// class PhoneContact {
//   String? id ;
//   String? name  ;
//   int status  = 0;
//   List<String>? phone;
//
// }

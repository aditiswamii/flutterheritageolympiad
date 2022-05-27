// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutterheritageolympiad/colors/colors.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// class DialogContactReceive extends StatefulWidget{
//   var name;
//   var id;
//   var image;
//   var index;
//   var link;
//   DialogContactReceive({Key? key,required this.id,required this.name,required this.image,
//    required this.link,required this.index}) : super(key: key);
//
//   @override
//   _State createState() => _State();
// }
//
//
// class _State extends State<DialogContactReceive> {
//   var diffi;
//   var speed;
//   var domainsel;
//   var username;
//   var country;
//   var userid;
//   userdata() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       username = prefs.getString("username");
//       country =prefs.getString("country");
//       userid= prefs.getString("userid");
//     });
//
//   }
//   var data;
//   var acceptdata;
//   acceptinvite(String userid) async {
//     showLoaderDialog(context);
//     http.Response response =
//     await http.post(Uri.parse(StringConstants.BASE_URL + "accept_invitation"), body: {
//       'user_id': userid.toString(),
//     });
//     var jsonResponse = convert.jsonDecode(response.body);
//     if (response.statusCode == 200) {
//       Navigator.pop(context);
//       if (jsonResponse['status'] == 200) {
//         data = response.body;
//         //final responseJson = json.decode(response.body);//store response as string
//         setState(() {
//           myinvdata = jsonResponse; //get all the data from json string superheros
//           print(myinvdata.length);
//           print(myinvdata.toString());
//         });
//         onsuccess(myinvdata);
//         // var venam = jsonDecode(data!)['data'];
//         // print(venam);
//         //last_id
//
//       } else {
//         snackBar = SnackBar(
//           content: Text(
//               jsonResponse['message']),
//         );
//         ScaffoldMessenger.of(context)
//             .showSnackBar(snackBar);
//       }
//     } else {
//       Navigator.pop(context);
//       print(response.statusCode);
//     }
//
//   }
//   @override
//   void initState() {
//     super.initState();
//     userdata();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body:Container(
//             height:250,
//             // width: 250,
//             alignment: Alignment.center,
//             margin: EdgeInsets.fromLTRB(0,10,0,10),
//             padding: EdgeInsets.all(10),
//             child:ListView(
//               children: [
//                 Container(
//                     alignment: Alignment.center,
//                     margin:EdgeInsets.only(bottom: 10),
//                     decoration: BoxDecoration(
//                         color:Colors.white
//                     ),
//                     child: Text('Contact Invitation Received From',textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.txt,fontSize:18 ,fontWeight: FontWeight.w600),)
//                 ),
//                 Container(
//                     alignment: Alignment.center,
//                     margin:EdgeInsets.only(bottom: 10),
//                     decoration: BoxDecoration(
//                         color:Colors.white
//                     ),
//                     child: Text(widget.name.toString(),textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.txt,fontSize: 18 ),)
//                 ),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//                   height: 100,
//                   width: 100,
//                   child: Center(
//                     child: Container(
//                       height: 100,
//                       width: 100,
//                       child: CircleAvatar(
//                         radius: 30.0,
//                         backgroundImage:
//                         NetworkImage(widget.image.toString()),
//                         backgroundColor: Colors.transparent,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           primary: ColorConstants.red,
//                           onPrimary: Colors.white,
//                           elevation: 3,
//                           alignment: Alignment.center,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30.0)),
//                           fixedSize: const Size(100, 40),
//                           //////// HERE
//                         ),
//                         onPressed: () {
//                           // Navigator.pushReplacement(
//                           //     context,
//                           //     MaterialPageRoute(
//                           //         builder: (context) => DuelModeMain()));
//                         },
//                         child: const Text(
//                           "REJECT",
//                           style: TextStyle(
//                               color: Colors.white, fontSize: 14),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           primary: ColorConstants.verdigris,
//                           onPrimary: Colors.white,
//                           elevation: 3,
//                           alignment: Alignment.center,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30.0)),
//                           fixedSize: const Size(100, 40),
//                           //////// HERE
//                         ),
//                         onPressed: () {
//                           // Navigator.pushReplacement(
//                           //     context,
//                           //     MaterialPageRoute(
//                           //         builder: (context) => const WelcomePage()));
//                         },
//                         child: const Text(
//                           "ACCEPT",
//                           style: TextStyle(
//                               color: Colors.white, fontSize:14),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             )
//         )
//     );
//   }
// }

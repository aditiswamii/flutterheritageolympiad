// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutterheritageolympiad/colors/colors.dart';
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: DialogDuelInviteReceive(),
//   ));
// }
// class DialogDuelInviteReceive extends StatefulWidget{
//   const DialogDuelInviteReceive({Key? key}) : super(key: key);
//
//   @override
//   _State createState() => _State();
// }
//
//
// class _State extends State<DialogDuelInviteReceive> with WidgetsBindingObserver {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body:Container(
//           // height:250,
//           // width: 250,
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
//                     child: Text('Duel Invite Received from',textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.Omnes_font,fontSize: 24 ),)
//                 ),
//                 Container(
//                     alignment: Alignment.center,
//                     margin:EdgeInsets.only(bottom: 10),
//                     decoration: BoxDecoration(
//                         color:Colors.white
//                     ),
//                     child: Text('HANA21',textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.Omnes_font,fontSize: 24 ),)
//                 ),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//                   height: 100,
//                   width: 100,
//                   child: CircleAvatar(
//                     radius: 30.0,
//                     backgroundImage:
//                     AssetImage("assets/profile.png"),
//                     backgroundColor: Colors.transparent,
//                   ),
//                 ),
//                 Container(
//                   child: Text(
//                     "QUIZ SUMMARY",
//                     style: TextStyle(
//                         color: ColorConstants.Omnes_font, fontSize: 15),
//                   ),
//                 ),
//                 Flexible(
//                   child: Container(
//                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
//                     decoration: const BoxDecoration(color: Colors.white),
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         // if you need this
//                         side: BorderSide(
//                           color: Colors.grey.withOpacity(0.3),
//                           width: 1,
//                         ),
//                       ),
//                       child:
//                       Column(
//                         children: [
//                           Container(
//                              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
//                             child: Row(
//                               children: [
//                                 Text(
//                                   "DIFFICULTY:",
//                                   style: TextStyle(
//                                       color: ColorConstants.Omnes_font,
//                                       fontSize: 15),
//                                 ),
//                                 Text(
//                                   "HARD",
//                                   style: TextStyle(
//                                       color: ColorConstants.Omnes_font,
//                                       fontSize: 15),
//                                 ),
//                               ],
//                             ),
//
//                           ),
//                           Container(
//                             // margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
//                             child: Row(
//
//                               children: [
//                                 Text(
//                                   "SPEED:",
//                                   style: TextStyle(
//                                       color: ColorConstants.Omnes_font,
//                                       fontSize: 15),
//                                 ),
//                                 Text(
//                                   "REGULAR",
//                                   style: TextStyle(
//                                       color: ColorConstants.Omnes_font,
//                                       fontSize: 15),
//                                 ),
//                               ],
//                             ),
//
//                           ),
//                           Container(
//                             alignment: Alignment.centerLeft,
//                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
//                             child: Column(
//                               children: [
//                                 Container(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     "DOMAINS SELECTED:",textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       color: ColorConstants.Omnes_font,
//                                       fontSize: 15,),
//                                   ),
//                                 ),
//                                 Container(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     "Knowlege traditions",textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                         color: ColorConstants.Omnes_font,
//                                         fontSize: 15),
//                                   ),
//                                 ),
//                                 Container(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     "Literature and Languages",textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                         color: ColorConstants.Omnes_font,
//                                         fontSize: 15),
//                                   ),
//                                 ),
//                                 Container(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     "Performing Arts",textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                         color: ColorConstants.Omnes_font,
//                                         fontSize: 15),
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//             Flexible(
//               child: Container(
//                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         primary: ColorConstants.red,
//                         onPrimary: Colors.white,
//                         elevation: 3,
//                         alignment: Alignment.center,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30.0)),
//                         fixedSize: const Size(70, 40),
//                         //////// HERE
//                       ),
//                       onPressed: () {
//                         // Navigator.pushReplacement(
//                         //     context,
//                         //     MaterialPageRoute(
//                         //         builder: (context) => DuelModeMain()));
//                       },
//                       child: const Text(
//                         "REJECT",
//                         style: TextStyle(
//                             color: ColorConstants.to_the_shop, fontSize: 14),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         primary: ColorConstants.verdigris,
//                         onPrimary: Colors.white,
//                         elevation: 3,
//                         alignment: Alignment.center,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30.0)),
//                         fixedSize: const Size(70, 40),
//                         //////// HERE
//                       ),
//                       onPressed: () {
//                         // Navigator.pushReplacement(
//                         //     context,
//                         //     MaterialPageRoute(
//                         //         builder: (context) => const WelcomePage()));
//                       },
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           const Text(
//                             "ACCEPT",
//                             style: TextStyle(
//                                 color: ColorConstants.to_the_shop, fontSize:14),
//                             textAlign: TextAlign.center,
//                           ),
//                           TweenAnimationBuilder<Duration>(
//                               duration: Duration(seconds:60),
//                               tween: Tween(begin: Duration(seconds:60), end: Duration.zero),
//                               onEnd: () {
//                                 Navigator.of(context).pop();
//                               },
//                               builder: (BuildContext context, Duration value, Widget? child) {
//                                 final minutes = value.inMinutes;
//                                 final seconds = value.inSeconds % 60;
//                                 return Padding(
//                                     padding: const EdgeInsets.symmetric(vertical: 5),
//                                     child: Text('(${seconds}S)',
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             color: ColorConstants.to_the_shop,
//                                             fontSize:12)));
//                               }),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//               ],
//             )
//         )
//     );
//   }
// }

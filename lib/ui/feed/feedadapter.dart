



import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutterheritageolympiad/modal/feedresponse/GetFeedResponse.dart' as Feedresponse;
import 'package:flutterheritageolympiad/modal/feedtagfilter/GetTagFilterResponse.dart' as TagFilterResponse;
import 'package:flutterheritageolympiad/ui/feed/feed.dart';
import 'package:flutterheritageolympiad/ui/feed/feedpresenter.dart';
import 'package:flutterheritageolympiad/ui/feed/feedview.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../colors/colors.dart';

class FeedAdapter with ChangeNotifier {


  PageController _pageController = PageController();
  int activePage = 1;
  List<Feedresponse.Data>? databean = [].cast<Feedresponse.Data>().toList(
      growable: true);
  List<TagFilterResponse.Data>? tagdata;

  // getFeed(userid.toString(), "0", "", "", "");

  void updateData(List<Feedresponse.Data> list) {
    // setState(() {
      databean!.addAll(list);
   // });


    notifyListeners(); // To rebuild the Widget
  }


  void cleanData() {
    databean!.clear();

    notifyListeners();
  }

  void updateItem(int type, int pos) {
    Feedresponse.Data? data = databean![pos];
    data.isSaved = type;
    if (type == 1) {
      data.savepost! + 1;
    } else {
      data.savepost! - 1;
    }
    databean![pos] = data;
    notifyListeners();
  }

  Feedresponse.Data getItem(int pos) {
    return databean!.elementAt(pos);
  }
}
  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
  //     child: ListView.builder(
  //         physics: ClampingScrollPhysics(
  //             parent: BouncingScrollPhysics()),
  //         shrinkWrap: true,
  //         itemCount: databean!.length,
  //         itemBuilder: (BuildContext context, int index) {
  //           var ischecked=databean![index].isSaved;
  //           var check= ischecked==1?true:false;
  //           return Card(
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(5),
  //               // if you need this
  //               side: BorderSide(
  //                 color: Colors.grey.withOpacity(0.2),
  //                 width: 1,
  //               ),
  //             ),
  //             child: ListBody(
  //               children: [
  //                 if(databean
  //                 ![index].mediaType.toString().isNotEmpty)
  //                   Container(
  //                     height: 300,
  //                     child: PageView.builder(
  //                         itemCount: databean!
  //                         [index].media!
  //                             .length,
  //                         pageSnapping: true,
  //                         controller: _pageController,
  //                         onPageChanged: (page) {
  //                           setState(() {
  //                             activePage = page;
  //                           });
  //                         },
  //                         itemBuilder: (context, pagePosition) {
  //                           return Container(
  //                             decoration: BoxDecoration(
  //                                 image: DecorationImage(
  //                                     image: NetworkImage(
  //                                         databean!
  //                                         [index]
  //                                         .media!
  //                                         [pagePosition]),
  //                                     fit: BoxFit.contain)),
  //                             child: Container(
  //                               margin: EdgeInsets.all(10),
  //                               alignment:
  //                               Alignment.bottomCenter,
  //                               height: 40,
  //                               child: Row(
  //                                   mainAxisAlignment:
  //                                   MainAxisAlignment
  //                                       .center,
  //                                   children: indicators(
  //                                       databean!
  //                                       [index].media!
  //                                           .length,
  //                                       activePage)),
  //                             ),
  //                           );
  //                         }),
  //                   ),
  //                 Container(
  //                   margin: const EdgeInsets.fromLTRB(
  //                       10, 10, 10, 10),
  //                   child: ListBody(
  //                     children: [
  //                       Container(
  //                         margin: const EdgeInsets.fromLTRB(
  //                             0, 10, 0, 10),
  //                         child: Text(
  //                             databean![index].title!,
  //                             style: TextStyle(
  //                                 fontSize: 16,
  //                                 color: Colors.black,
  //                                 fontFamily: "Nunito")),
  //                       ),
  //                       Container(
  //                         margin: const EdgeInsets.fromLTRB(
  //                             0, 10, 0, 10),
  //                         child: ReadMoreText(
  //                           databean![index].description!
  //                           ,
  //                           trimLines: 5,
  //                           textAlign: TextAlign.justify,
  //                           style: TextStyle(fontSize: 14,color:Colors.black,),
  //                           colorClickableText: Colors.black,
  //                           trimMode: TrimMode.Line,
  //                           trimCollapsedText: 'Read more',
  //                           trimExpandedText: 'Read less',
  //                           lessStyle: TextStyle(
  //                               fontSize: 14,
  //                               color: Colors.blue,
  //                               fontFamily: "Nunito"),
  //                           moreStyle:TextStyle(
  //                               fontSize: 14,
  //                               color: Colors.blue,
  //                               fontFamily: "Nunito"),
  //                         ),
  //                       ),
  //                       Container(
  //                         height: 32,
  //
  //                         child: ListView.builder(
  //                             scrollDirection: Axis.horizontal,
  //                             physics: ClampingScrollPhysics(
  //                                 parent:
  //                                 BouncingScrollPhysics()),
  //                             shrinkWrap: true,
  //                             itemCount:
  //                             databean!
  //                             [index].tags!
  //                                 .length,
  //                             itemBuilder:
  //                                 (BuildContext context,
  //                                 int index1) {
  //
  //                               return GestureDetector(
  //                                 onTap: (){
  //                                  FeedPresenter(view!).gettagfilter(context,userid.toString(),tagdata!
  //                                  [index].tags!
  //                                  [index1].toString(), "0");
  //
  //                                 },
  //                                 child: Card(
  //                                   elevation: 2,
  //                                   color: Colors.deepOrange,
  //                                   shape: RoundedRectangleBorder(
  //                                     borderRadius:
  //                                     BorderRadius.circular(
  //                                         20),
  //                                     // if you need this
  //                                     side: BorderSide(
  //                                       color: Colors.grey
  //                                           .withOpacity(0.2),
  //                                       width: 1,
  //                                     ),
  //                                   ),
  //                                   child: Container(
  //                                     padding: EdgeInsets.all(4),
  //                                     child: Center(
  //                                       child: Text(tagdata!
  //                                       [index].tags!
  //                                       [index1],style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               );
  //                             }),
  //                       ),
  //                       Container(
  //                         margin: const EdgeInsets.fromLTRB(
  //                             0, 10, 0, 10),
  //                         child: Row(
  //                           mainAxisAlignment:
  //                           MainAxisAlignment
  //                               .spaceBetween,
  //                           children: [
  //
  //                             Container(
  //                               child: Row(
  //                                 children: [
  //                                   GestureDetector(
  //                                     onTap: () {
  //                                       setState(() {
  //                                         check=!check;
  //                                         check==true?ischecked=1:ischecked=0;
  //                                       });
  //                                       check=!check;
  //                                       check==true?ischecked=1:ischecked=0;
  //                                       FeedPresenter(view!).savepost(context,userid.toString(), databean![index].id.toString(),
  //                                           ischecked.toString() );
  //                                     },
  //                                     child: Container(
  //                                         child: ischecked != 1
  //                                             ? Image.asset(
  //                                           "assets/images/folder_2.png",
  //                                           height: 30,
  //                                           width: 30,
  //                                           color: ColorConstants
  //                                               .lightgrey200,
  //                                         )
  //                                             : Image.asset(
  //                                           "assets/images/folder.png",
  //                                           height: 30,
  //                                           width: 30,
  //                                           color: Colors
  //                                               .deepOrange,
  //                                         )),
  //                                   ),
  //                                   Container(
  //                                     margin: const EdgeInsets
  //                                         .fromLTRB(
  //                                         5, 0, 0, 0),
  //                                     child: Text(
  //                                         databean!
  //                                         [index].savepost
  //                                             .toString(),
  //                                         style: TextStyle(
  //                                             fontSize: 14,
  //                                             color: databean![index].isSaved !=
  //                                                 1
  //                                                 ? Colors
  //                                                 .black54
  //                                                 : Colors
  //                                                 .deepOrange,
  //                                             fontFamily:
  //                                             "Nunito")),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                             Container(
  //                               child: Row(
  //                                 children: [
  //                                   GestureDetector(
  //                                       onTap: () {
  //                                         // Share.share(jsonDecode(data!)['data'][index]['external_link'], subject: 'Share link');
  //                                       },
  //                                       child: Image.asset(
  //                                         "assets/images/calendary.png",
  //                                         height: 30,
  //                                         width: 30,
  //                                       )),
  //                                   GestureDetector(
  //                                       onTap: () {
  //                                         Share.share(
  //                                             databean!
  //                                             [index].externalLink!,
  //                                             subject:
  //                                             'Share link');
  //                                       },
  //                                       child: Image.asset(
  //                                         "assets/images/exporty.png",
  //                                         height: 30,
  //                                         width: 30,
  //                                       )),
  //                                 ],
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       // Container(
  //                       //  child:Event(
  //                       //
  //                       //  ),
  //                       //)
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           );
  //         }),
  //   );
  // }
  // List<Widget> indicators(imagesLength, currentIndex) {
  //   return List<Widget>.generate(imagesLength, (index) {
  //     return Container(
  //       margin: EdgeInsets.all(3),
  //       width: 10,
  //       height: 10,
  //       decoration: BoxDecoration(
  //           color: currentIndex == index ? Colors.white : Colors.grey,
  //           shape: BoxShape.circle),
  //     );
  //   });
  // }



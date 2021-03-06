import 'dart:convert';
import 'dart:developer';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/modal/savedpost/GetSavePostResponse.dart';
import 'package:CultreApp/ui/feed/feed.dart';

import 'package:CultreApp/ui/rightdrawer/right_drawer.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../utils/StringConstants.dart';

import 'dart:convert' as convert;

import 'package:CultreApp/ui/homepage/homepage.dart';

class SavedPost extends StatefulWidget {
  SavedPost({Key? key}) : super(key: key);

  @override
  SavedPostState createState() => SavedPostState();
}

class SavedPostState extends State<SavedPost> {
  TextEditingController controller = TextEditingController();
  PageController _pageController = PageController();
  // TextEditingController controller = TextEditingController();
  // List<Data> _searchResult = [];
  // List<Data> _userDetails = [];
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  var feeddata;
  var data;
  var snackBar;
  var savedata;
  List<Data>? savefdata;
  int activePage = 1;
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });

    getsavedpost(userid.toString());
  }
  // gettagfilter(String userid ,String searchkey,String type) async {
  //
  //   http.Response response = await http.get(
  //       Uri.parse(StringConstants.BASE_URL + "tagfilter?searchkey=$searchkey&type=$type&user_id=$userid")
  //   );
  //   showLoaderDialog(context);
  //   var jsonResponse = convert.jsonDecode(response.body);
  //   if (response.statusCode == 200) {
  //     data = response.body;
  //     Navigator.pop(context);
  //     if (jsonResponse['status'] == 200) {
  //       setState(() {
  //         tagdata = jsonDecode(
  //             data!)['data']; //get all the data from json string superheros
  //         print(tagdata.length);
  //       });
  //       onsuccess1(getTagFilterResponseFromJson(data).data);
  //       var venam = jsonDecode(data!)['data'];
  //       print(venam);
  //     } else {
  //       onsuccess(null);
  //       snackBar = SnackBar(
  //         content: Text(
  //             jsonResponse['message']),
  //       );
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(snackBar);
  //     }
  //   } else {
  //     Navigator.pop(context);
  //     // onsuccess(null);
  //     print(response.statusCode);
  //   }
  //
  // }
  // onsuccess1(List<Data>? list){
  //
  //   setState(() {
  //     tagfdata=list ;
  //   });
  //   print(tagfdata.toString());
  // }

  getsavedpost(String id) async {
    http.Response response = await http
        .get(Uri.parse(StringConstants.BASE_URL + "save_feed?id=$id"));
    showLoaderDialog(context);
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      data = response.body;
      Navigator.pop(context);
      if (jsonResponse['status'] == 200) {
        setState(() {
          savedata = jsonDecode(
              data!)['data']; //get all the data from json string superheros
          print(savedata.length);
        });
        onsuccess(getSavePostResponseFromJson(data!).data);
        var venam = jsonDecode(data!)['data'];
        print(venam);
      } else {
        onsuccess(null);
        snackBar = SnackBar(
          content: Text(jsonResponse['message']),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      Navigator.pop(context);
      // onsuccess(null);
      print(response.statusCode);
    }
  }

  onsuccess(List<Data>? list) {
    setState(() {
      savefdata = list;
    });
    print(savefdata.toString());
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7), child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => FeedPage(
              seldomain: "",
              themes: "",
              contents: "",
            )));
    // Do some stuff.
    return true;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      endDrawerEnableOpenDragGesture: true,
      endDrawer: const MySideMenuDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          // color: Colors.white.withAlpha(100),
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Stack(children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                color: Colors.white,
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(5),
                      child: Center(
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            },
                            child: Image.asset(
                              "assets/images/home_1.png",
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 20, 10),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState!.openEndDrawer();
                        },
                        child: Image.asset("assets/images/side_menu_2.png",
                            height: 40, width: 40),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: const Alignment(0, 100),
              // height: MediaQuery.of(context).size.height-120,
              margin: const EdgeInsets.fromLTRB(20, 90, 20, 10),
              child: ListView(children: [
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: const Text("YOU SAVED",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: "Nunito"))),

                // Card(
                //   child: ListTile(
                //     leading: Icon(Icons.search),
                //     title: TextFormField(
                //       controller: controller,
                //       textInputAction: TextInputAction.search,
                //       onFieldSubmitted: onSearchTextChanged,
                //       decoration: InputDecoration(
                //           hintText: 'Search', border: InputBorder.none),
                //     ),
                //     trailing: controller.text.isNotEmpty
                //         ? IconButton(
                //       icon: Icon(Icons.cancel),
                //       onPressed: () {
                //         controller.clear();
                //         onSearchTextChanged('');
                //       },
                //     )
                //         : IconButton(
                //       icon: Icon(Icons.cancel,color: Colors.white,),
                //       onPressed: () {
                //         controller.clear();
                //         onSearchTextChanged('');
                //       },
                //     ),
                //   ),
                // ),

                savedata != null
                    ? Center(
                        child: Container(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: ListView.builder(
                                physics: const ClampingScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                shrinkWrap: true,
                                itemCount: savedata.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      // if you need this
                                      side: BorderSide(
                                        color: Colors.grey.withOpacity(0.2),
                                        width: 1,
                                      ),
                                    ),
                                    child: ListBody(
                                      children: [
                                        SizedBox(
                                          height: 300,
                                          child: PageView.builder(
                                              itemCount: savefdata![index]
                                                  .media!
                                                  .length,
                                              pageSnapping: true,
                                              controller: _pageController,
                                              onPageChanged: (page) {
                                                setState(() {
                                                  activePage = page;
                                                });
                                              },
                                              itemBuilder:
                                                  (context, pagePosition) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              savefdata![index]
                                                                      .media![
                                                                  pagePosition]),
                                                          fit: BoxFit.cover)),
                                                  child: Container(
                                                    margin: const EdgeInsets.all(10),
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    height: 40,
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: indicators(
                                                            savefdata![index]
                                                                .media!
                                                                .length,
                                                            activePage)),
                                                  ),
                                                );
                                              }),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 10, 10, 10),
                                          child: ListBody(
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 10),
                                                child: Text(
                                                    savefdata![index].title!,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontFamily: "Nunito")),
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 10),
                                                child: ReadMoreText(
                                                  savefdata![index]
                                                      .description!,
                                                  trimLines: 5,
                                                  textAlign: TextAlign.justify,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                  colorClickableText:
                                                      Colors.black,
                                                  trimMode: TrimMode.Line,
                                                  trimCollapsedText:
                                                      'Read more',
                                                  trimExpandedText: 'Read less',
                                                  lessStyle: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.blue,
                                                      fontFamily: "Nunito"),
                                                  moreStyle: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.blue,
                                                      fontFamily: "Nunito"),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 42,
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    physics: const ClampingScrollPhysics(
                                                        parent:
                                                            BouncingScrollPhysics()),
                                                    shrinkWrap: true,
                                                    itemCount: savefdata![index]
                                                        .tags!
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index1) {
                                                      return GestureDetector(
                                                        onTap: () {},
                                                        child: Card(
                                                          elevation: 2,
                                                          color:
                                                              Colors.deepOrange,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            // if you need this
                                                            side: BorderSide(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.2),
                                                              width: 1,
                                                            ),
                                                          ),
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                    8),
                                                            child: Center(
                                                              child: Text(
                                                                savefdata![index]
                                                                        .tags![
                                                                    index1],
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {},
                                                            child: Container(
                                                                child: savefdata![index]
                                                                            .isSaved !=
                                                                        1
                                                                    ? Image
                                                                        .asset(
                                                                        "assets/images/folder_2.png",
                                                                        height:
                                                                            30,
                                                                        width:
                                                                            30,
                                                                        color: ColorConstants
                                                                            .lightgrey200,
                                                                      )
                                                                    : Image
                                                                        .asset(
                                                                        "assets/images/folder.png",
                                                                        height:
                                                                            30,
                                                                        width:
                                                                            30,
                                                                        color: Colors
                                                                            .deepOrange,
                                                                      )),
                                                          ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    5, 0, 0, 0),
                                                            child: Text(
                                                                savefdata![
                                                                        index]
                                                                    .savepost!
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: savefdata![index].isSaved !=
                                                                            1
                                                                        ? Colors
                                                                            .black54
                                                                        : Colors
                                                                            .deepOrange,
                                                                    fontFamily:
                                                                        "Nunito")),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 60,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          GestureDetector(
                                                              onTap: () {
                                                                log("cal click");
                                                                Add2Calendar
                                                                    .addEvent2Cal(
                                                                  buildEvent(
                                                                      title: savefdata![
                                                                              index]
                                                                          .title!,
                                                                      desc: savefdata![
                                                                              index]
                                                                          .description!),
                                                                );
                                                                // Share.share(jsonDecode(data!)['data'][index]['external_link'], subject: 'Share link');
                                                              },
                                                              child:
                                                                  Image.asset(
                                                                "assets/images/calendary.png",
                                                                height: 25,
                                                                width: 25,
                                                              )),
                                                          GestureDetector(
                                                              onTap: () {
                                                                Share.share(
                                                                    savefdata![
                                                                            index]
                                                                        .externalLink!,
                                                                    subject:
                                                                        'Share link');
                                                              },
                                                              child:
                                                                  Image.asset(
                                                                "assets/images/exporty.png",
                                                                height: 25,
                                                                width: 25,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Container(
                                              //  child:Event(
                                              //
                                              //  ),
                                              //)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),
                      )
                    : feeddata == null
                        ? Center(
                            child: Container(),
                          )
                        : Container(
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: ListView.builder(
                                physics: const ClampingScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                shrinkWrap: true,
                                itemCount: jsonDecode(data!)['data'].length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      // if you need this
                                      side: BorderSide(
                                        color: Colors.grey.withOpacity(0.2),
                                        width: 1,
                                      ),
                                    ),
                                    child: ListBody(
                                      children: [
                                        SizedBox(
                                          height: 300,
                                          child: PageView.builder(
                                              itemCount:
                                                  jsonDecode(data!)['data']
                                                          [index]['media']
                                                      .length,
                                              pageSnapping: true,
                                              controller: _pageController,
                                              onPageChanged: (page) {
                                                setState(() {
                                                  activePage = page;
                                                });
                                              },
                                              itemBuilder:
                                                  (context, pagePosition) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              jsonDecode(data!)[
                                                                              'data']
                                                                          [
                                                                          index]
                                                                      ['media'][
                                                                  pagePosition]),
                                                          fit: BoxFit.contain)),
                                                  child: Container(
                                                    margin: const EdgeInsets.all(10),
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    height: 40,
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: indicators(
                                                            jsonDecode(data!)[
                                                                            'data']
                                                                        [index]
                                                                    ['media']
                                                                .length,
                                                            activePage)),
                                                  ),
                                                );
                                              }),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 10, 10, 10),
                                          child: ListBody(
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 10),
                                                child: Text(
                                                    jsonDecode(data!)['data']
                                                        [index]['title'],
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontFamily: "Nunito")),
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 10),
                                                child: Text(
                                                  jsonDecode(data!)['data']
                                                      [index]['description'],
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontFamily: "Nunito"),
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 32,
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    physics: const ClampingScrollPhysics(
                                                        parent:
                                                            BouncingScrollPhysics()),
                                                    shrinkWrap: true,
                                                    itemCount: jsonDecode(
                                                                data!)['data']
                                                            [index]['tags']
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index1) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          // gettagfilter(userid.toString(),jsonDecode(
                                                          //     data!)['data']
                                                          // [index]['tags']
                                                          // [index1].toString(), "0");
                                                        },
                                                        child: Card(
                                                          elevation: 2,
                                                          color:
                                                              Colors.deepOrange,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            // if you need this
                                                            side: BorderSide(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.2),
                                                              width: 1,
                                                            ),
                                                          ),
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                    4),
                                                            child: Center(
                                                              child: Text(
                                                                jsonDecode(data!)[
                                                                            'data']
                                                                        [index][
                                                                    'tags'][index1],
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {},
                                                            child: Container(
                                                                child: jsonDecode(data!)['data'][index]
                                                                            [
                                                                            'is_saved'] !=
                                                                        1
                                                                    ? Image
                                                                        .asset(
                                                                        "assets/images/folder_2.png",
                                                                        height:
                                                                            30,
                                                                        width:
                                                                            30,
                                                                        color: ColorConstants
                                                                            .lightgrey200,
                                                                      )
                                                                    : Image
                                                                        .asset(
                                                                        "assets/images/folder.png",
                                                                        height:
                                                                            30,
                                                                        width:
                                                                            30,
                                                                        color: Colors
                                                                            .deepOrange,
                                                                      )),
                                                          ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    5, 0, 0, 0),
                                                            child: Text(
                                                                jsonDecode(data!)['data']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'savepost']
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: jsonDecode(data!)['data'][index]['is_saved'] !=
                                                                            1
                                                                        ? Colors
                                                                            .black54
                                                                        : Colors
                                                                            .deepOrange,
                                                                    fontFamily:
                                                                        "Nunito")),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 60,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          GestureDetector(
                                                              onTap: () {
                                                                log("cal click");
                                                                Add2Calendar
                                                                    .addEvent2Cal(
                                                                  buildEvent(
                                                                      title: jsonDecode(data!)['data']
                                                                              [
                                                                              index]
                                                                          [
                                                                          'title'],
                                                                      desc: jsonDecode(data!)['data']
                                                                              [
                                                                              index]
                                                                          [
                                                                          'description']),
                                                                );
                                                                // Share.share(jsonDecode(data!)['data'][index]['external_link'], subject: 'Share link');
                                                              },
                                                              child:
                                                                  Image.asset(
                                                                "assets/images/calendary.png",
                                                                height: 30,
                                                                width: 30,
                                                              )),
                                                          GestureDetector(
                                                              onTap: () {
                                                                Share.share(
                                                                    jsonDecode(data!)['data']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'external_link'],
                                                                    subject:
                                                                        'Share link');
                                                              },
                                                              child:
                                                                  Image.asset(
                                                                "assets/images/exporty.png",
                                                                height: 30,
                                                                width: 30,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              // Container(
                                              //  child:Event(
                                              //
                                              //  ),
                                              //)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => FeedPage(
                              seldomain: "",
                              themes: "",
                              contents: "",
                            )));
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    child: const Center(
                        child: Text(
                      'BACK TO FEED',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    )),
                  ),
                )
              ]),
            ),
          ]),
        ),
      ),
    );
  }

  Event buildEvent({Recurrence? recurrence, String? title, String? desc}) {
    return Event(
      title: title!,
      description: desc!,
      location: 'Cultre App',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(minutes: 30)),
      allDay: false,
      iosParams: const IOSParams(
        reminder: Duration(minutes: 40),
      ),
      // androidParams: AndroidParams(
      //   // emailInvites: ["test@example.com"],
      // ),
      recurrence: recurrence,
    );
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.white : Colors.grey,
            shape: BoxShape.circle),
      );
    });
  }

  // onSearchTextChanged(String text) {
  //   savedata=null;
  //   feeddata=null;
  //   if (text.isNotEmpty) {
  //
  //
  //     // showLoaderDialog(context);
  //     gettagfilter(userid.toString(), text,"1");
  //   } else {
  //
  //     // showLoaderDialog(context);
  //     getFeed(userid.toString(), "0", "", "", "");
  //   }
  //   print(text);
  //   log(text);
  //
  //   setState(() {});
  // }
}

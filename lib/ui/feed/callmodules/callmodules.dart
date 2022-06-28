import 'dart:developer';

import 'package:CultreApp/ui/feed/feed.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

import 'package:back_button_interceptor/back_button_interceptor.dart';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/ui/feed/imageview.dart';

import 'package:CultreApp/modal/feedresponse/GetFeedResponse.dart' as Feedresponse;
import 'package:CultreApp/ui/rightdrawer/right_drawer.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../utils/StringConstants.dart';

import '../../../modal/feedtagfilter/GetTagFilterResponse.dart';
import 'dart:convert' as convert;
class CallModules extends StatefulWidget {
  var contents;
  var themes;
  var seldomain;
  var module;
  var feeddata;
  var type;
  CallModules({Key? key, this.seldomain, this.contents, this.themes,required this.module,required this.feeddata,required this.type}) : super(key: key);

  @override
  _CallModulesState createState() => _CallModulesState();
}

class _CallModulesState extends State<CallModules> with ChangeNotifier{
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
  var tagdata;
  bool rlshow=true;
  List<Data>?tagfdata;
  int activePage = 0;
  int feed_page_id  = 0;

  List<Feedresponse.Data>? databean = [].cast<Feedresponse.Data>().toList(
      growable: true);
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
      databean=widget.module;
    });


  }
  savepost(String userid ,String feed_id,int  type,int pos) async {

    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "savefeed"),body: {
      'user_id':userid.toString(),
      'feed_id':feed_id.toString(),
      'type':type.toString()
    }
    );
    //showLoaderDialog(context);
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      data = response.body;
      // Navigator.pop(context);
      if (jsonResponse['status'] == 200) {
        updateItem(type, pos);
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      } else {

        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {

      print(response.statusCode);
    }

  }

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    userdata();
//    _presenter = FeedPresenter(this);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => FeedPage(feeddata: widget.feeddata, seldomain: '', themes: '',)));
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
          color: Colors.white.withAlpha(100),
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: ListView(children: [

            ListBody(children: [

              SizedBox(
                height: 50,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap:(){

                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 5,right: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          padding:  const EdgeInsets.all(4),height: 35, width: 35,
                          child: Center(
                            child: Card(
                              elevation: 3,
                              child: widget.type=="2"?Image.asset("assets/images/modules.png",fit: BoxFit.cover,
                              ):widget.type=="1"?Image.asset("assets/images/single_posts.png",fit: BoxFit.cover,
                              ):Image.asset("assets/images/collections.png",fit: BoxFit.cover,
                              ),
                            ),
                          ),),
                      ),
                      GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(4),
                          child: const Center(
                            child: Text("Sample feed for testing",
                              style: TextStyle(color: ColorConstants.txt,fontSize: 22),textAlign: TextAlign.center,),
                          ),
                        ),


                      ),
                    ]
                ),
              ),
              Container(
                height: 50,
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>FeedPage(contents: widget.contents, themes: widget.themes, seldomain: widget.seldomain,feeddata: widget.feeddata)));



                  },
                  child: Image.asset("assets/images/left_arrow.png",height: 40,width: 40,color: ColorConstants.txt,),
                ),
              ),

              databean != null
                  ?  Center(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: ListView.builder(
                      physics: const ClampingScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      shrinkWrap: true,
                      itemCount:  databean!.length,
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
                              if( databean!=null)
                                SizedBox(
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      PageView.builder(
                                          itemCount: databean![index].media!.length,
                                          pageSnapping: true,
                                          controller: _pageController,
                                          onPageChanged: (page) {
                                            setState(() {
                                              activePage = page;
                                            });
                                          },
                                          itemBuilder: (context, pagePosition) {
                                            return  GestureDetector(
                                              onTap:(){
                                                Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(builder: (BuildContext context) =>
                                                        ImageviewFeed(gallery:  databean![index].media!, index: pagePosition , contents: widget.contents, themes: widget.themes,
                                                          seldomain: widget.seldomain, image:  databean![index].media![pagePosition], typef: 3,module: widget.module, feeddata: widget.feeddata,)));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(databean![index].media![pagePosition]),
                                                        fit: BoxFit.cover)),

                                              ),
                                            );
                                          }),
                                      Container(
                                        height: 50,
                                        padding:const EdgeInsets.all(8),
                                        alignment: Alignment.topLeft,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap:(){

                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(left: 5,right: 5),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                padding:  const EdgeInsets.all(3),height: 30, width: 30,
                                                child: Center(
                                                  child: Card(
                                                    elevation: 3,
                                                    child: databean![index].type=="Modules"?Image.asset("assets/images/modules.png",fit: BoxFit.cover,
                                                    ):databean![index].type=="Single Posts"?Image.asset("assets/images/single_posts.png",fit: BoxFit.cover,
                                                    ):Image.asset("assets/images/collections.png",fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),),
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                Share.share(databean![index].title! +"\n"+
                                                    databean![index].description! +"\n"+ databean![index].media!.toString(), subject: 'share');

                                              },
                                              child: SizedBox(height: 30, width: 30,
                                                child: Image.asset("assets/images/share_feed.png",fit: BoxFit.cover,
                                                ),),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
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
                                                  databean![index].media!.length,
                                                  activePage)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(
                                    10, 10, 10, 10),
                                child: ListBody(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: Text(
                                          databean![index].title!,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontFamily: "Nunito")),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: ReadMoreText(
                                        databean![index].description!,
                                        trimLines: 5,
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(fontSize: 14,color:Colors.black,),
                                        colorClickableText: Colors.black,
                                        trimMode: TrimMode.Line,
                                        trimCollapsedText: 'Read more',
                                        trimExpandedText: 'Read less',
                                        lessStyle: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.blue,
                                            fontFamily: "Nunito"),
                                        moreStyle:const TextStyle(
                                            fontSize: 14,
                                            color: Colors.blue,
                                            fontFamily: "Nunito"),
                                      ),

                                    ),
                                    SizedBox(
                                      height: 42,

                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          physics: const ClampingScrollPhysics(
                                              parent:
                                              BouncingScrollPhysics()),
                                          shrinkWrap: true,
                                          itemCount:
                                          databean![index].tags!.length,
                                          itemBuilder:
                                              (BuildContext context,
                                              int index1) {
                                            return GestureDetector(
                                              onTap: (){

                                              },
                                              child: Card(
                                                elevation: 2,
                                                color: Colors.deepOrange,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      20),
                                                  // if you need this
                                                  side: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Container(
                                                  padding: const EdgeInsets.all(8),
                                                  child: Center(
                                                    child: Text(databean![index].tags![index1],
                                                      style: const TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
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
                                                      child:databean![index].isSaved != 1
                                                          ? Image.asset(
                                                        "assets/images/folder_2.png",
                                                        height: 30,
                                                        width: 30,
                                                        color: ColorConstants
                                                            .lightgrey200,
                                                      )
                                                          : Image.asset(
                                                        "assets/images/folder.png",
                                                        height: 30,
                                                        width: 30,
                                                        color: Colors
                                                            .deepOrange,
                                                      )),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets
                                                      .fromLTRB(
                                                      5, 0, 0, 0),
                                                  child: Text(
                                                      databean![index].savepost!
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: databean![index].isSaved != 1
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
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      log("cal click");
                                                      Add2Calendar.addEvent2Cal(
                                                        buildEvent(title:databean![index].title!,desc:  databean![index].description! ),
                                                      );
                                                      // Share.share(jsonDecode(data!)['data'][index]['external_link'], subject: 'Share link');
                                                    },
                                                    child: Image.asset(
                                                      "assets/images/calendary.png",
                                                      height: 25,
                                                      width: 25,
                                                    )),
                                                GestureDetector(
                                                    onTap: () {
                                                      Share.share(
                                                          databean![index].externalLink!,
                                                          subject:
                                                          'Share link');
                                                    },
                                                    child: Image.asset(
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
              ):Container()


              // if(feeddata!=null)
              //   Visibility(child:showmore(context),visible: rlshow,replacement: const SizedBox.shrink(),)

            ]),
          ]),
        ),

      ),

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

  Event buildEvent({Recurrence? recurrence,String? title, String? desc}) {
    return Event(
      title: title!,
      description: desc!,
      location: 'Cultre App',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(minutes: 30)),
      allDay: false,
      iosParams: const IOSParams(
        reminder: const Duration(minutes: 40),
      ),
      // androidParams: AndroidParams(
      //   // emailInvites: ["test@example.com"],
      // ),
      recurrence: recurrence,
    );
  }



  void updateData(List<Feedresponse.Data> list) {
    setState(() {
      databean!.addAll(list);
    });


    notifyListeners(); // To rebuild the Widget
  }


  void cleanData() {
    setState(() {
      databean!.clear();
    });


    notifyListeners();
  }

  void updateItem(int type, int pos) {
    Feedresponse.Data? data = databean![pos];
    data.isSaved = type;
    if (type == 1) {
      setState(() {
        data.savepost= (data.savepost!) + 1;
      });

    } else {
      setState(() {
        data.savepost= (data.savepost!) - 1;
      });

    }
    setState(() {
      databean![pos] = data;
    });

    notifyListeners();
  }

  Feedresponse.Data getItem(int pos) {
    return databean!.elementAt(pos);
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:CultreApp/ui/feed/callmodules/callmodules.dart';
import 'package:CultreApp/ui/feed/tagfeed/tagfeed.dart';

import 'package:back_button_interceptor/back_button_interceptor.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/services.dart';
import 'package:CultreApp/colors/colors.dart';
import 'package:CultreApp/ui/feed/feedpresenter.dart';
import 'package:CultreApp/ui/feed/feedview.dart';
import 'package:CultreApp/ui/feed/filterpage/filterpage.dart';
import 'package:CultreApp/ui/feed/imageview.dart';
import 'package:CultreApp/ui/feed/savedpost/savedpost.dart';

import 'package:CultreApp/modal/feedresponse/GetFeedResponse.dart' as Feedresponse;
import 'package:CultreApp/modal/feedtagfilter/GetTagFilterResponse.dart' as TagFilterResponse;
import 'package:CultreApp/ui/rightdrawer/right_drawer.dart';
import 'package:CultreApp/ui/shopproduct/shopproducts_page.dart';
import 'package:CultreApp/utils/apppreference.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../utils/StringConstants.dart';
import '../../modal/feedtagfilter/GetTagFilterResponse.dart';
import 'package:CultreApp/ui/homepage/homepage.dart';
import 'dart:convert' as convert;
class FeedPage extends StatefulWidget {
  var contents;
  String? themes;
  String? seldomain;
  List<Feedresponse.Data>? feeddata;
  FeedPage({Key? key,required this.seldomain,this.contents,required  this.themes,this.feeddata}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> with ChangeNotifier{

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
  var moduledata;
  var modulefdata;
  bool rlshow=true;
  int activePage = 0;
  int feed_page_id  = 0;
  List<Feedresponse.Data>? tagfilterd = [].cast<Feedresponse.Data>().toList(
      growable: true);
  List<Feedresponse.Data>? moduled = [].cast<Feedresponse.Data>().toList(
      growable: true);
  List<Feedresponse.Data>? databean = [].cast<Feedresponse.Data>().toList(
      growable: true);
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country = prefs.getString("country");
      userid = prefs.getString("userid");
    });
    if(widget.feeddata!=null){
      setState(() {
        databean=widget.feeddata;
      });

    }else {
      getFeed(userid.toString(), "0", "",widget.seldomain!.isNotEmpty ?widget.seldomain!:"",widget.themes!.isNotEmpty?widget.themes!:"");
    }


  }

  getFeed(String userid, String feedPageId, String feedTypeId,
      String domainId, String themeId) async {
     // showLoaderDialog(context);
      http.Response response =
          await http.post(Uri.parse(StringConstants.BASE_URL + "feed"), body: {
        'user_id': userid.toString(),
        'feed_page_id': feedPageId.toString(),
        'feed_type_id': feedTypeId.toString(),
        'domain_id': domainId.toString(),
        'theme_id': themeId.toString()
      });
    var jsonResponse = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
         // Navigator.pop(context);
        data = response.body;
        if (jsonResponse['status'] == 200) {
          //final responseJson = json.decode(response.body);//store response as string
          setState(() {
            feeddata = jsonDecode(
                data!)['data']; //get all the data from json string superheros
            print(feeddata.length);
            onsuccessfeed(Feedresponse.getFeedResponseFromJson(data));
          });

          var venam = jsonDecode(data!)['data'];
          print(venam);
          print(jsonDecode(data!)['last_id']);
          //last_id
          print(jsonDecode(data!)['data'][0]['id']);
          print(jsonDecode(data!)['data'][0]['type']);
          print(jsonDecode(data!)['data'][0]['tags']);
          print(jsonDecode(data!)['data'][0]['title']);
          print(jsonDecode(data!)['data'][0]['description']);
          print(jsonDecode(data!)['data'][0]['external_link']);
          print(jsonDecode(data!)['data'][0]['video_link']);
          print(jsonDecode(data!)['data'][0]['placeholder_image']);
          print(jsonDecode(data!)['data'][0]['savepost']);
          print(jsonDecode(data!)['data'][0]['is_saved']);
          print(jsonDecode(data!)['data'][0]['share']);
          print(jsonDecode(data!)['data'][0]['media_type']);
          print(jsonDecode(data!)['data'][0]['media']);
          print(jsonDecode(data!)['data'][0]['media_type']);
          print(jsonDecode(data!)['data'][0]['media_type']);
        }else{
          snackBar = SnackBar(
            content: Text(
                jsonResponse['message']),
          );
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar);
        }
      }else {
         // Navigator.pop(context);
        print(response.statusCode);
      }

  }


  onsuccessfeed(Feedresponse.GetFeedResponse feedResponse) {
    if(feedResponse!=null){
      if(feedResponse.data!=null) {
        if (feedResponse.data!.length > 0) {
          rlshow=true;
          setState(() {
            feed_page_id =
            feedResponse.data![feedResponse.data!.length - 1].id!;
            databean = feedResponse.data;
          });
        }else{
          rlshow=false;
          snackBar = const SnackBar(
            content: Text(
                "There is no more feed"),
          );
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar);
        }
      }


    }

  }
  loadmoreapi(String userid, String feed_page_id, String feed_type_id,
      String domain_id, String theme_id) async {
    // showLoaderDialog(context);
    http.Response response =
    await http.post(Uri.parse(StringConstants.BASE_URL + "feed"), body: {
      'user_id': userid.toString(),
      'feed_page_id': feed_page_id.toString(),
      'feed_type_id': feed_type_id.toString(),
      'domain_id': domain_id.toString(),
      'theme_id': theme_id.toString()
    });
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      // Navigator.pop(context);
      data = response.body;
      if (jsonResponse['status'] == 200) {
        //final responseJson = json.decode(response.body);//store response as string
        setState(() {
          feeddata = jsonDecode(
              data!)['data']; //get all the data from json string superheros
          print(feeddata.length);
          onloadsuccess(Feedresponse.getFeedResponseFromJson(data));
        });

        var venam = jsonDecode(data!)['data'];
        print(venam);
        print(jsonDecode(data!)['last_id']);
        //last_id
        print(jsonDecode(data!)['data'][0]['id']);
        print(jsonDecode(data!)['data'][0]['type']);
        print(jsonDecode(data!)['data'][0]['tags']);
        print(jsonDecode(data!)['data'][0]['title']);
        print(jsonDecode(data!)['data'][0]['description']);
        print(jsonDecode(data!)['data'][0]['external_link']);
        print(jsonDecode(data!)['data'][0]['video_link']);
        print(jsonDecode(data!)['data'][0]['placeholder_image']);
        print(jsonDecode(data!)['data'][0]['savepost']);
        print(jsonDecode(data!)['data'][0]['is_saved']);
        print(jsonDecode(data!)['data'][0]['share']);
        print(jsonDecode(data!)['data'][0]['media_type']);
        print(jsonDecode(data!)['data'][0]['media']);
        print(jsonDecode(data!)['data'][0]['media_type']);
        print(jsonDecode(data!)['data'][0]['media_type']);
      }else{
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    }else {
      // Navigator.pop(context);
      if (kDebugMode) {
        print(response.statusCode);
      }
    }

  }
  onloadsuccess(Feedresponse.GetFeedResponse obj){
    if(obj!=null){
      if(obj.data!=null){
        if(obj.data!.length>0){
          rlshow=true;
          if(obj.lastId.toString()!="") {

            setState(() {
            feed_page_id= obj.data![obj.data!.length-1].id!;
          });
          }

          updateData(obj.data!);
        }else{
          rlshow=false;
          snackBar = const SnackBar(
            content: Text(
               "There is no more feed"),
          );
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar);
        }
      }
    }

  }
  gettagfilter(String userid ,String searchkey,String type) async {

      http.Response response = await http.get(
          Uri.parse(StringConstants.BASE_URL + "tagfilter?searchkey=$searchkey&type=$type&user_id=$userid")
      );
       // showLoaderDialog(context);
      var jsonResponse = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        data = response.body;
         // Navigator.pop(context);
        if (jsonResponse['status'] == 200) {
          setState(() {
            tagdata = jsonDecode(
                data!)['data']; //get all the data from json string superheros
            print(tagdata.length);
          });
          onsuccess(Feedresponse.getFeedResponseFromJson(data).data,searchkey);
          var venam = jsonDecode(data!)['data'];
          print(venam);
        } else {
          onsuccess(null,"");
          snackBar = SnackBar(
            content: Text(
                jsonResponse['message']),
          );
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar);
        }
      } else {
         // Navigator.pop(context);
        // onsuccess(null);
        if (kDebugMode) {
          print(response.statusCode);
        }
      }

  }
  onsuccess(List<Feedresponse.Data>? list, String searchkey){
   if(list!=null) {
     if (list.length > 0) {
       rlshow=true;
       setState(() {
         feed_page_id = list[list.length - 1].id!;
         tagfilterd = list;
       });
       Navigator.of(context).pushReplacement(
           MaterialPageRoute(builder: (BuildContext context) => TagFeed(tags: tagfilterd,seachkey:searchkey, feeddata: feeddata,)));
     }else{
       rlshow=false;
       snackBar = const SnackBar(
         content: Text(
             "There is no more feed"),
       );
       ScaffoldMessenger.of(context)
           .showSnackBar(snackBar);
     }
   }

    print(databean.toString());
  }
  getmodule(String userid ,String moduleId,String type) async {

    http.Response response = await http.post(
        Uri.parse(StringConstants.BASE_URL + "module"),body: {
      'module_id': moduleId.toString(),
      'user_id': userid.toString(),
      'type':type.toString()
    }
    );
    // showLoaderDialog(context);
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      data = response.body;
      // Navigator.pop(context);
      if (jsonResponse['status'] == 200) {
        setState(() {
          moduledata = jsonDecode(
              data!)['data']; //get all the data from json string superheros
          print(moduledata.length);
        });
        setmodule(Feedresponse.getFeedResponseFromJson(data).data,type);
        var venam = jsonDecode(data!)['data'];
        print(venam);
      } else {
        setmodule(null,"");
        snackBar = SnackBar(
          content: Text(
              jsonResponse['message']),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar);
      }
    } else {
      // Navigator.pop(context);
      // onsuccess(null);
      if (kDebugMode) {
        print(response.statusCode);
      }
    }

  }
  setmodule(List<Feedresponse.Data>? list, String type){
  if(data!=null){
    if(data.length>0) {
      setState(() {
        feed_page_id = list![list.length - 1].id!;
        moduled = list;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => CallModules( module: moduled, feeddata: databean,type:type)));
    }
  }
  }
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      content:
          Container(
            height: 80,width: 80,
              child: const Center(child: CircularProgressIndicator())),



    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

//0 unsave 1 save
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
  // Event buildEvent(String? title,String? description) {
  //   return Event(
  //     title: title!,
  //     description: description!,
  //     location: 'Cultre App',
  //     startDate: DateTime.now(),
  //     endDate: DateTime.now().add(Duration(minutes: 30)),
  //     allDay: false,
  //     iosParams: IOSParams(
  //       reminder: Duration(minutes: 40),
  //     ),
  //
  //   );
  // }
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
        MaterialPageRoute(builder: (BuildContext context) => HomePage()));
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
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  alignment: Alignment.centerLeft,

                  padding: const EdgeInsets.all(5),
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
                                  builder: (context) =>  HomePage()));

                        },
                        child:  Image.asset("assets/images/home_1.png",height: 40,width: 40,),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
            Container(
              color: Colors.white,
              child: ListBody(children: [
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: const Text("WHAT'S NEW",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: "Nunito"))),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text(username==null?"":username,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: "Nunito"))),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.search),
                    title: TextFormField(
                      controller: controller,
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: onSearchTextChanged,
                      decoration: const InputDecoration(
                          hintText: 'Search', border: InputBorder.none),
                    ),
                    trailing: controller.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.cancel),
                            onPressed: () {
                              controller.clear();
                              onSearchTextChanged('');
                            },
                          )
                        : IconButton(
                      icon: const Icon(Icons.cancel,color: Colors.white,),
                      onPressed: () {
                        controller.clear();
                        onSearchTextChanged('');
                      },
                    ),
                  ),
                ),
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FilterPage()));
                      },
                      child: Card(
                        child: Container(
                          width: 150,
                          child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("SET FILTER",
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontFamily: "Nunito")),
                              Image.asset("assets/images/right_arrow.png",
                                  height: 20, width: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                   GestureDetector(
                     onTap: (){
                       Navigator.pushReplacement(
                           context,
                           MaterialPageRoute(
                               builder: (context) => SavedPost()));
                     },
                      child: Card(
                        child: Container(
                          width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("SAVED POST",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontFamily: "Nunito")),
                              Image.asset("assets/images/right_arrow.png",
                                  height: 20, width: 20),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

                databean==null? Center(
                  child: Container(

                  ),
                )
                    :  Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: ListView.builder(
                            physics: const ClampingScrollPhysics(
                                parent: const BouncingScrollPhysics()),
                            shrinkWrap: true,
                            itemCount: databean!.length,
                            itemBuilder: (BuildContext context, int index) {
                              var ischecked=databean![index].isSaved;
                              var check= ischecked==1?true:false;
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
                                    if(databean![index].mediaType
                                    .toString().isNotEmpty)
                                    Container(
                                      height: 300,
                                      child: PageView.builder(
                                          itemCount: databean![index].media!
                                              .length,
                                          pageSnapping: true,
                                          controller: _pageController,
                                          onPageChanged: (page) {
                                            setState(() {
                                              activePage = page;
                                            });
                                          },
                                          itemBuilder: (context, pagePosition) {
                                            return GestureDetector(
                                              onTap:(){
                                                Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(builder: (BuildContext context) =>
                                                        ImageviewFeed(gallery: databean![index].media!, index: pagePosition , contents: widget.contents, themes: widget.themes,
                                                          seldomain: widget.seldomain, image:databean![index].media![pagePosition], typef: 1, feeddata: databean,)));
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            databean![index].media!

                                                                [pagePosition]),
                                                        fit: BoxFit.contain)),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      height: 50,
                                                      padding:EdgeInsets.all(8),
                                                      alignment: Alignment.topLeft,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          GestureDetector(
                                                            onTap:(){
                                                              if(databean![index].type=="Modules") {
                                                                getmodule(userid
                                                                    .toString(),
                                                                    databean![index]
                                                                        .id
                                                                        .toString(),
                                                                    "2");
                                                              }else if(databean![index].type=="Collections"){
                                                                getmodule(userid
                                                                    .toString(),
                                                                    databean![index]
                                                                        .id
                                                                        .toString(),
                                                                    "3");
                                                              }
                                                             },
                                                            child: Container(
                                                              margin: EdgeInsets.only(left: 5,right: 5),
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(20)
                                                              ),
                                                              padding:  EdgeInsets.all(4),height: 35, width: 35,
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
                                                              Share.share("${databean![index].title! +"\n"+
                                                                  databean![index].description! +"\n"+ databean![index].media!.toString()}", subject: 'share');

                                                            },
                                                            child: Container(height: 35, width: 35,
                                                              child: Image.asset("assets/images/share_feed.png",fit: BoxFit.cover,
                                                              ),),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets.all(10),
                                                      alignment:
                                                          Alignment.bottomCenter,
                                                      height: 40,
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: indicators(
                                                              databean![index].media!

                                                                  .length,
                                                              activePage)),
                                                    ),
                                                  ],
                                                ),
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
                                              databean![index].description!
                                              ,
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
                                          Container(
                                            height: 32,

                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                                physics: const ClampingScrollPhysics(
                                                    parent:
                                                        BouncingScrollPhysics()),
                                                shrinkWrap: true,
                                                itemCount:
                                                databean![index].tags!

                                                        .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index1) {

                                                  return GestureDetector(
                                                    onTap: (){


                                                      gettagfilter(userid.toString(),databean![index].tags!
                                                      [index1].toString(), "0");
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
                                                        padding: const EdgeInsets.all(4),
                                                        child: Center(
                                                          child: Text(databean![index].tags!
                                                              [index1],style: const TextStyle(color: Colors.white),textAlign: TextAlign.center,),
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
                                                        onTap: () {
                                                          setState(() {
                                                            check=!check;
                                                            check==true?ischecked=1:ischecked=0;
                                                          });
                                                          check=!check;
                                                          check==true?ischecked=1:ischecked=0;
                                                          savepost(userid.toString(), databean![index].id.toString(),
                                                              ischecked==1?0:1,index );
                                                        },
                                                        child: Container(
                                                            child: ischecked != 1
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
                                                            databean![index].savepost
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: databean![index].isSaved!=
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
                                                Container(
                                                  width: 60,
                                                  child: Row(
                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            log("cal click");
                                                            // buildEvent( databean![index].title!, databean![index].description!);
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
                if(feeddata!=null)
                  Visibility(child:showmore(context),visible: rlshow,replacement: const SizedBox.shrink(),)

              ]),
            ),
          ]),
        ),
      ),
    );
  }
  Widget showmore(BuildContext context){

    return
      Column(
        children: [
          if(feed_page_id!=databean![0].id)
          GestureDetector(
          onTap: (){
            loadmoreapi(userid.toString(), feed_page_id.toString(), "", "", "");
          },
          child: Container(
            child: const Center(child: Text("Show More",
              style: TextStyle(color: Colors.black,fontSize: 18),textAlign: TextAlign.center,)),
          ),
    ),
    if(feed_page_id==databean![0].id)
    Container()
        ],
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

  onSearchTextChanged(String text) {
    tagdata=null;
    feeddata=null;
    if (text.isNotEmpty) {


      // showLoaderDialog(context);
      gettagfilter(userid.toString(), text,"1");
    } else {

      // showLoaderDialog(context);
      getFeed(userid.toString(), "0", "", "", "");
    }
    print(text);
    log(text);

    setState(() {});
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

import 'dart:convert';
import 'dart:developer';

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../colors/colors.dart';
import '../../../utils/StringConstants.dart';

import 'package:CultreApp/ui/homepage/homepage.dart';

import '../../modal/allexprience/GetAllExperience.dart';
import '../feed/callmodules/callmodules.dart';
import '../feed/imageview.dart';
import '../feed/tagfeed/tagfeed.dart';
import '../rightdrawer/right_drawer.dart';
import '../shopproduct/shopproducts_page.dart';
import 'dart:convert' as convert;
import 'package:CultreApp/modal/feedresponse/GetFeedResponse.dart' as Feedresponse;
class Shopactivity extends StatefulWidget{
int type=0;
  Shopactivity({Key? key,required this.type}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<Shopactivity> with ChangeNotifier{
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  PageController _pageController = PageController();
  var data;
  var username;
  var email;
  var country;
  var profilepic;
  var userid;
  var productdata;
  var feeddata;
  var expdata;
  List<Data>? experdata;
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
      country =prefs.getString("country");
      userid= prefs.getString("userid");
    });
    if(widget.type==1) {
      getproduct("", "");
    }else if(widget.type==2){
      getExperience(userid.toString(), "") ;
    }else if(widget.type==3){
      getFeed(userid.toString(), "0", "","","");
    }

  }
  getproduct(String userid ,String searchkey) async {
    try {
      http.Response response = await http.get(
          Uri.parse(StringConstants.BASE_URL+"get_all_products")
      );

      if (response.statusCode == 200) {
        data = response.body; //store response as string
        setState(() {
          productdata = jsonDecode(
              data!)['data']; //get all the data from json string superheros
          print(productdata.length); // just printed length of data
        });

        var venam = jsonDecode(data!)['data'];
        print(venam);
      } else {
        print(response.statusCode);
      }
    } catch (e) {

      log(e.toString());
    }
  }
  onsuccess(){

  }





  getExperience(String userid ,String searchkey) async {
    if (searchkey == null) {
      http.Response response = await http.get(
          Uri.parse(StringConstants.BASE_URL + "exp")
      );

      var jsonResponse = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        data = response.body;

        if (jsonResponse['status'] == 200) {
          setState(() {
            expdata = jsonDecode(
                data!)['data']; //get all the data from json string superheros
            print(expdata.length);
          });
          onsuccessexp(getAllExperienceFromJson(data).data);
          var venam = jsonDecode(data!)['data'];
          print(venam);
        } else {
          onsuccessexp(null);
          snackBar = SnackBar(
            content: Text(
                jsonResponse['message']),
          );
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar);
        }
      } else {

        // onsuccess(null);
        print(response.statusCode);
      }
    } else {
      http.Response response = await http.get(
          Uri.parse(StringConstants.BASE_URL + "exp?search=" + searchkey)
      );

      var jsonResponse = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        data = response.body;

        if (jsonResponse['status'] == 200) {
          setState(() {
            expdata = jsonDecode(
                data!)['data']; //get all the data from json string superheros
            print(expdata.length);
          });
          onsuccessexp(getAllExperienceFromJson(data).data);
          var venam = jsonDecode(data!)['data'];
          print(venam);
        } else {
          onsuccessexp(null);
          snackBar = SnackBar(
            content: Text(
                jsonResponse['message']),
          );
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar);
        }
      } else {

        // onsuccess(null);
        print(response.statusCode);
      }
    }
  }
  onsuccessexp(List<Data>? list){

    setState(() {
      experdata=list ;
    });
    print(experdata.toString());
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
        onsuccesstag(Feedresponse.getFeedResponseFromJson(data).data,searchkey);
        var venam = jsonDecode(data!)['data'];
        print(venam);
      } else {
        onsuccesstag(null,"");
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
  onsuccesstag(List<Feedresponse.Data>? list, String searchkey){
    if(list!=null) {
      if (list.length > 0) {
        rlshow=true;
        setState(() {
          feed_page_id = list[list.length - 1].id!;
          tagfilterd = list;
        });
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => TagFeed(tags: tagfilterd,seachkey:searchkey, feeddata: databean,)));
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
  Event buildEvent({Recurrence? recurrence,String? title, String? desc}) {
    return Event(
      title: title!,
      description: desc!,
      location: 'Cultre App',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(minutes: 30)),
      allDay: false,
      iosParams: IOSParams(
        reminder: Duration(minutes: 40),
      ),
      // androidParams: AndroidParams(
      //   // emailInvites: ["test@example.com"],
      // ),
      recurrence: recurrence,
    );
  }
  // showLoaderDialog(BuildContext context) {
  //   AlertDialog alert = AlertDialog(
  //     content: new Row(
  //       children: [
  //         CircularProgressIndicator(),
  //         Container(
  //             margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
  //       ],),
  //   );
  //   showDialog(barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
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
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ShopPage()));
    // Do some stuff.
    return true;
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
            image: AssetImage("assets/images/login_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child:Container( color: Colors.white.withAlpha(100),
          margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Stack(
              children: [

                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    color: Colors.white,
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
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
                                          builder: (context) =>  HomePage()));
                                },
                                child:  Image.asset("assets/images/home_1.png",height: 40,width: 40,),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 20, 10),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 5.0),
                          child: GestureDetector(
                            onTap: () {
                              _scaffoldKey.currentState!.openEndDrawer();
                            },
                            child: Image.asset(
                                "assets/images/side_menu_2.png", height: 40,
                                width: 40),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if(widget.type==1)
              product(context),
                if(widget.type==2)
                experience(context),
                  if(widget.type==3)
                  feed(context)
              ]
          ),
        ),
      ),
    );
  }
Widget product(BuildContext context){
    return    Container(
      alignment: Alignment(0,100),
      // height: MediaQuery.of(context).size.height-120,
      margin: const EdgeInsets.fromLTRB(20, 90, 20, 10),
      child: ListView(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: const Text("SHOP",style: TextStyle(fontSize: 18,color:Colors.black,fontFamily: "Nunito"))),
            Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child:  Text("PRODUCT",style: TextStyle(fontSize: 18,color: Colors.black,fontFamily: "Nunito"))),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                  "Scroll down see all updates, search by keywords, or filter update by type.",
                  style: TextStyle(fontSize: 14,
                      color: ColorConstants.txt)
              ),
            ),
            productdata==null?const Center(
              child: CircularProgressIndicator(),
            )
                : Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: ListView.builder(
                  physics: ClampingScrollPhysics(parent: BouncingScrollPhysics()),
                  shrinkWrap: true,
                  itemCount: jsonDecode(data!)['data'].length,
                  itemBuilder: (BuildContext context, int index) {
                    return
                      Card(
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
                            Container(
                              height: 300,
                              color: ColorConstants.lightgrey200,
                              child: Image.network(jsonDecode(data!)['data'][index]['images'][0],fit: BoxFit.fill,),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: ListBody(
                                children: [

                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Text(jsonDecode(data!)['data'][index]['name'],style: TextStyle(fontSize: 16,color: Colors.black,fontFamily: "Nunito")),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Text(jsonDecode(data!)['data'][index]['description'],style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: "Nunito")),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(jsonDecode(data!)['data'][index]['price'],style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: "Nunito")),
                                        GestureDetector(
                                            onTap: (){
                                              Share.share(jsonDecode(data!)['data'][index]['link'], subject: 'Share link');
                                            },
                                            child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color:  Colors.orange,
                                                  borderRadius: BorderRadius.circular(20),
                                                ),

                                                child: Text("PURCHASE",style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: "Nunito")))),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            )
                          ],
                        ),
                      );
                  }),
            ),
          ]
      ),
    );

}

Widget experience(BuildContext context){
    return  Container(
      alignment: Alignment(0,100),
      // height: MediaQuery.of(context).size.height-120,
      margin: const EdgeInsets.fromLTRB(20, 90, 20, 10),
      child: ListView(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: const Text("EXPLORE",style: TextStyle(fontSize: 18,color: Colors.black,fontFamily: "Nunito"))),
            Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child:  Text("EXPERIENCES",style: TextStyle(fontSize: 18,color: Colors.black,fontFamily: "Nunito"))),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                  "Scroll down see all updates, search by keywords, or filter update by type.",
                  style: TextStyle(fontSize: 14,
                      color: ColorConstants.txt)
              ),
            ),

            experdata==null? Center(
              child: Container(

              ),
            )
                : Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: ListView.builder(
                  physics: ClampingScrollPhysics(parent: BouncingScrollPhysics()),
                  shrinkWrap: true,
                  itemCount: jsonDecode(data!)['data'].length,
                  itemBuilder: (BuildContext context, int index) {
                    return
                      Card(
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
                            Container(
                              height: 300,
                              color: ColorConstants.lightgrey200,
                              child: Image.network(experdata![index].images![0].toString(),fit: BoxFit.fill,),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: ListBody(
                                children: [

                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Text(experdata![index].name.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontFamily: "Nunito")),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Text(experdata![index].description.toString(),style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: "Nunito")),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(experdata![index].price.toString(),style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: "Nunito")),
                                        GestureDetector(
                                            onTap: (){
                                              Share.share(experdata![index].link.toString(), subject: 'Share link');
                                            },
                                            child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color:  Colors.orange,
                                                  borderRadius: BorderRadius.circular(20),
                                                ),child: Text("REGISTER",style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: "Nunito")))),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            )
                          ],
                        ),
                      );
                  }),
            ),
          ]
      ),
    );
}
 Widget feed(BuildContext context){
    return  databean!.isEmpty ? Container(
      height: 300,
      child: const Center(
        child: CircularProgressIndicator(),
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
                      child: Stack(
                        children: [
                          PageView.builder(
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
                                            ImageviewFeed(gallery: databean![index].media!, index: pagePosition , contents: "", themes: "",
                                              seldomain: "", image:databean![index].media![pagePosition], typef: 1, feeddata: databean,)));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                databean![index].media!

                                                [pagePosition]),
                                            fit: BoxFit.cover)),

                                  ),
                                );
                              }),
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
                                    padding:  EdgeInsets.all(3),height: 30, width: 30,
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
                                  child: Container(height: 30, width: 30,
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
                                      databean![index].media!

                                          .length,
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
                                  fontFamily: "Nunito",fontStyle: FontStyle.normal)),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(
                              0, 10, 0, 10),
                          child: ReadMoreText(
                            databean![index].description!
                            ,
                            trimLines: 5,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(fontSize: 14,color:Colors.black,fontStyle: FontStyle.normal,),
                            colorClickableText: Colors.black,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Read more',
                            trimExpandedText: 'Read less',
                            lessStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                                fontFamily: "Nunito",fontStyle: FontStyle.normal),
                            moreStyle:const TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                                fontFamily: "Nunito",fontStyle: FontStyle.normal),
                          ),
                        ),
                        Container(
                          height: 42,

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
                                      padding: const EdgeInsets.all(8),
                                      child: Center(
                                        child: Text(databean![index].tags!
                                        [index1],style: const TextStyle(color: Colors.white,fontStyle: FontStyle.normal),textAlign: TextAlign.center,),
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
                                            height: 25,
                                            width: 25,
                                            color: Colors.grey,
                                          )
                                              : Image.asset(
                                            "assets/images/folder.png",
                                            height: 25,
                                            width: 25,
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
                                          Add2Calendar.addEvent2Cal(
                                            buildEvent(title:databean![index].title!,desc:  databean![index].description! ),
                                          );
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
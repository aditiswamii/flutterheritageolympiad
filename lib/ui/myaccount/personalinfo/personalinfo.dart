
import 'dart:convert';
import 'dart:developer';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:CultreApp/colors/colors.dart';

import 'package:CultreApp/modal/getprofileresponse/GetProfileResponse.dart';

import 'package:CultreApp/ui/myaccount/myaccount_page.dart';
import 'package:CultreApp/ui/rightdrawer/right_drawer.dart';
import 'package:CultreApp/ui/homepage/homepage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import '../../../modal/getcitylist/GetCityResponse.dart';
import '../../../modal/getcountry/GetCountryList.dart';
import '../../../modal/getstate/GetStateResponse.dart';
import '../../../utils/StringConstants.dart';


class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  _PersonalinfoState createState() => _PersonalinfoState();
}

class _PersonalinfoState extends State<PersonalInfoScreen> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  Color textcolor = ColorConstants.txt;
  Color textcolor1 = ColorConstants.txt;
  var selected = '';
   File? _image;
  final ImagePicker _picker = ImagePicker();
  var data;
  var datacoun;
  var datastate;
  var statelength;
  var countlength;
  var snackbar;
  var countryid;
  var countryname;
  var stateid;
  var statename;
  var citydata;
  var citylength;
  var cityid;
  var cityname;
  var gendername;
  var dobdate;
  var subletter;
  var username;
  var email;
  var country;
  String? profilepic="";
  var userid;
  var snackBar;
  var prodata;
  var dob;

  var firstname;
  var lastname;

  var mobileno;
  GetProfileResponse? profileresdata;
  userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username");
      country =prefs.getString("country");
      userid= prefs.getString("userid");
    });
    getCountry(GetCountryList);
    getProfile(userid.toString());
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
  final List<String> genderlist = <String>['Male', 'Female'];
  String date = "";
  DateTime selectedDate = DateTime.now();
  bool valuenews = false;
  void getCity(GetCityResponse, var statid) async {
    http.Response response =
    await http.get(Uri.parse("http://3.108.183.42/api/city/$statid"));
    if (response.statusCode == 200) {
      citydata = response.body;
      var jsonResponse =
      convert.jsonDecode(response.body); //store response as string
      setState(() {
        citydata = response.body;
        citylength = getCityResponseFromJson(citydata!);
        jsonDecode(citydata!)['cities'];
      });
      var venam = jsonDecode(citydata!)['cities'].toString();
      var venamid = jsonDecode(citydata!)['cities'][4]['id'].toString();
      print(venam);
      print(citydata.length);
      print(getCityResponseFromJson(citydata!).cities.toString());
      print(venamid);
    } else {
      print(response.statusCode);
    }
  }

  void getCountry(GetCountryList) async {
    http.Response response =
    await http.get(Uri.parse(StringConstants.BASE_URL+'country'));
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      datacoun = response.body;
      if (jsonResponse['status'] == 200) {
        setState(() {
          datacoun = response.body;
          countlength = getCountryListFromJson(
              datacoun!); //get all the data from json string superheros
          jsonDecode(datacoun!)['countries'];
        });
        //getState(GetStateResponse);
        var venam = jsonDecode(datacoun!)['countries'].toString();
        var venamid = jsonDecode(datacoun!)['countries'][4]['id'].toString();
        print(venam);

        print(getCountryListFromJson(datacoun!).countries.toString());
        print(venamid);
      }else{

      }
    }else {
      print(response.statusCode);
    }
  }

  void getState(GetStateResponse, var couid) async {
    http.Response response =
    await http.get(Uri.parse('http://3.108.183.42/api/state/$couid'));
    if (response.statusCode == 200) {
      datastate = response.body; //store response as string
      setState(() {
        datastate = response.body;
        statelength = getStateResponseFromJson(
            datastate!); //get all the data from json string superheros
        jsonDecode(datastate!)['states'];
      });
      var venam = jsonDecode(datastate!)['states'].toString();
      var venamid = jsonDecode(datastate!)['states'][4]['id'].toString();
      print(venam);
      print(datastate.length);
      print(getStateResponseFromJson(datastate!).states.toString());
      print(venamid);
    } else {
      print(response.statusCode);
    }
  }
  getProfile(String userid) async {
      http.Response response =
      await http.get(
          Uri.parse(StringConstants.BASE_URL + "get-profile?user_id=$userid"));
      var jsonResponse = convert.jsonDecode(response.body);
      if (response.statusCode == 200) {
        data = response.body;
        if (jsonResponse['status'] == 200) {
          //final responseJson = json.decode(response.body);//store response as string
          setState(() {
            prodata = jsonDecode(
                data!)['data']; //get all the data from json string superheros
            print(prodata.length);
          });
          onsuccess(getProfileResponseFromJson(data!));
          var venam = jsonDecode(data!)['data'];
          print(venam);
        }else{
          log(jsonResponse['message']);
        }
      }else {
        print(response.statusCode);
      }

  }
  onsuccess(GetProfileResponse? getprofileresponse) {
    if (getprofileresponse != null) {
      if (getprofileresponse.data != null) {
        setState(() {
          profileresdata = getprofileresponse;
          firstname = profileresdata!.data!.firstName![0].toUpperCase() +
              profileresdata!.data!.firstName!.substring(1);
          lastname = profileresdata!.data!.lastName!.toString();
          dobdate = profileresdata!.data!.dob!.toString();
          mobileno = profileresdata!.data!.mobile!.toString();
          profilepic = profileresdata!.data!.image!.toString();
          gendername = profileresdata!.data!.gender!.toString();
          cityid = profileresdata!.data!.cityId!.toString();
          cityname = profileresdata!.data!.city!.toString();
          stateid = profileresdata!.data!.stateId!.toString();
          statename = profileresdata!.data!.state!.toString();
          countryid = profileresdata!.data!.countryId!.toString();
          countryname = profileresdata!.data!.country!.toString();
        });
      }
    }
  }


  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime(selectedDate.year - 1),
      firstDate: DateTime(selectedDate.year-99),
      lastDate: DateTime(selectedDate.year-1),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }
  uploadFile(String userid,String mobile,String firstName,String dob,String stateId,String cityId,
  String gender,String lastName, File image) async {

    var postUri = Uri.parse(StringConstants.BASE_URL+'update-profile');
    var request = http.MultipartRequest("POST", postUri);
    request.fields['user_id'] = userid.toString();
    request.fields['mobile'] =  mobile.toString();
    request.fields['first_name'] = firstName.toString();
    request.fields['dob'] = dob.toString();
    request.fields['state_id'] = stateId.toString();
    request.fields['city_id'] = cityId.toString();
    request.fields['gender'] = gender.toString();
    request.fields['last_name'] = lastName.toString();
    print(request.toString());
    print(_image!.path);
    request.files.add(await http.MultipartFile.fromPath(
        'image',
        _image!.path));
    request.send().then((response) {
 log('userid : '+userid.toString());
 log('mobile : '+mobile.toString());
 log('first_name : '+firstName.toString());
 log('dob : '+dob.toString());
 log('state_id : '+stateId.toString());
 log('city_id : '+cityId.toString());
 log('gender : '+gender.toString());
 log('last_name : '+lastName.toString());
 log('image : '+image.toString());
      //print("rrrrr=>"+response.statusCode.toString());

      if (response.statusCode == 200) {
        // Navigator.pop(context);
        // showLoaderDialog(context);
        getProfile(userid.toString());
        //store response as string
        onupdate();
        print("Uploaded!");

      }else{
        // Navigator.pop(context);
        print("uploadfile response:"+response.statusCode.toString());
      }
    });
  }
  profileupdateapi(String userid,String mobile,String firstName,String dob,String stateId,String cityId,
      String gender,String lastName) async {
    http.Response response = await http
        .post(Uri.parse(StringConstants.BASE_URL+'update-profile'),
        body: {
          'user_id' : userid.toString(),
          'mobile': mobile.toString(),
          'first_name': firstName.toString(),
          'dob': dob.toString(),
          'state_id': stateId.toString(),
          'city_id': cityId.toString(),
          'gender': gender.toString(),
          'last_name': lastName.toString()
        });
    log('userid : '+userid.toString());
    log('mobile : '+mobile.toString());
    log('first_name : '+firstName.toString());
    log('dob : '+dob.toString());
    log('state_id : '+stateId.toString());
    log('city_id : '+cityId.toString());
    log('gender : '+gender.toString());
    log('last_name : '+lastName.toString());
    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      log(jsonResponse.toString());
      // Navigator.pop(context);
      data = response.body;
      if(jsonResponse['status']==200){



        getProfile(userid.toString());
        //store response as string
        onupdate();
      }else{
        snackBar = SnackBar(
          content: Text(jsonResponse['message']),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

    } else {
      // Navigator.pop(context);
      print("profileupdate:"+response.statusCode.toString());
    }
  }
  onupdate(){
   successdialog(context, "You have successfully updated your profile");
  }
  validateName(String value) {
    if (value.length > 3) {
      return true;
    } else {
      return false;
    }
  }

  validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length == 10) {
      return true;
    }
    else {
      return false;
    }
  }
  successdialog(BuildContext context, String text) {
    AlertDialog alert = AlertDialog(
      backgroundColor: ColorConstants.verdigris,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      content: Container(
          child: Text(
            "${text}",
            style: const TextStyle(color: Colors.white, fontSize: 18),
            textAlign: TextAlign.center,
          )),

    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        Future.delayed(
          const Duration(seconds: 2),
              () {
            Navigator.of(context).pop(true);
          },
        );
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
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => const MyAccountPage()));
    // Do some stuff.
    return true;
  }

  Future getImagefromcamera() async {
    var image = await _picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(image!.path);
    });
    Navigator.of(context).pop();
  }

  Future getImagefromGallery() async {
    var image = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image!.path);
    });
    Navigator.of(context).pop();
  }
  Future<Future> _refreshdata(BuildContext context) async {

    return getProfile(userid.toString());
  }
  @override
  Widget build(BuildContext context) {
    bool click = false;
    bool click1 = false;
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      key: _scaffoldKey,
     // resizeToAvoidBottomInset: false,
      endDrawerEnableOpenDragGesture: true,
      endDrawer: const MySideMenuDrawer(),
      body:RefreshIndicator(
      color: Colors.transparent,
      onRefresh: () => _refreshdata(context),
    child:Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/debackground.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.white.withAlpha(200),
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Stack(
            children: [
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
                          child:  Image.asset("assets/images/side_menu_2.png",height: 40,width: 40),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: const Alignment(0,100),
                // height: MediaQuery.of(context).size.height-120,
                margin: const EdgeInsets.fromLTRB(0, 90, 0, 10),
                child: ListView(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.fromLTRB(0, 40, 0, 10),
                        child: const Text("PERSONAL INFORMATION",
                            style: TextStyle(
                                fontSize: 24, color: ColorConstants.txt))),


            // prodata==null?Container():
            profileresdata==null?Container(): ListBody(
                children: [

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: (){
                AlertDialog errorDialog = AlertDialog(
                  insetPadding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  titlePadding:const EdgeInsets.fromLTRB(10, 20, 10, 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20.0)), //this right here
                    title: Container(
                      height: 100,
                      width: 100,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[

                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: ColorConstants.red,
                                  onPrimary: Colors.white,
                                  elevation: 3,
                                  shape: const CircleBorder(
                                  ),
                                  //alignment: Alignment.center,
                                  // shape: RoundedRectangleBorder(
                                  //     borderRadius: BorderRadius.circular(20.0)),
                                  fixedSize: const Size(50, 50),
                                  //////// HERE
                                ),
                                onPressed: getImagefromcamera,

                                child: const Icon(Icons.add_a_photo,size: 22,color: Colors.white,),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: ColorConstants.red,
                                  onPrimary: Colors.white,
                                  elevation: 3,
                                  //alignment: Alignment.center,
                                  shape: const CircleBorder(
                                  ),
                                  fixedSize: const Size(50, 50),
                                  //////// HERE
                                ),
                                onPressed:
                                getImagefromGallery,
                                child: const Icon(Icons.broken_image_outlined,size: 22,color:Colors.white,),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                const Text("Pick Image\nfrom camera",style: TextStyle(fontSize: 12)),
                                const Text("Pick Image\nform gallery",style: TextStyle(fontSize: 12),),
                              ],
                            ),
                          ),
                        ],
                      ),)
                );
                showDialog(
                    context: context,
                    builder: (BuildContext context) => errorDialog);
                  },
                  child: Container(
                width: 100,
                height: 100.0,
                child:profilepic!.isEmpty?CircleAvatar(
                  radius: 30.0,
                  child: Image.asset("assets/images/placeholder.png",fit: BoxFit.cover,),
                  backgroundImage:const AssetImage("assets/images/placeholder.png"),
                  backgroundColor: Colors.transparent,
                ): CircleAvatar(
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: _image ==null ?  Image.network(profilepic!,height: 100,width: 100,fit: BoxFit.cover,):Image.file(_image!,height: 100,width: 100,fit: BoxFit.cover,),
                  ),
                ),
                  ),
                ),
              ),
                Container(
                  height: 60,
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: TextFormField(
                initialValue: firstname,
                onChanged: (value){
                  setState(() {
                    firstname=value;

                  });
                  print(firstname);
                },
                obscureText: false,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor:  Colors.black12,
                  border: InputBorder.none,
                  // labelText: 'Username or Email ID',
                  hintText: 'firstname',
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter
                ],
                  ),
                ),
                Container(
                  height: 60,
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: TextFormField(
                initialValue: lastname,
                onChanged: (value){
                  setState(() {
                    lastname=value;

                  });
                  print(lastname);
                },
                obscureText: false,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor:  Colors.black12,
                  border: InputBorder.none,
                  // labelText: 'Username or Email ID',
                  hintText: 'lastname',
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter
                ],
                  ),
                ),
                Container(
                  height: 60,
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: TextFormField(
                initialValue: mobileno,
                onChanged: (value){
                  setState(() {
                    mobileno=value;

                  });
                  print(mobileno);
                },
                obscureText: false,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor:  Colors.black12,
                  border: InputBorder.none,
                  // labelText: 'Username or Email ID',
                  hintText: 'mobile no',
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter
                ],
                  ),
                ),
                  Container(  margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  height: 50,
                  alignment: Alignment.centerLeft,
                  //color: Colors.white,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(5)),
                  // margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),

                  child: GestureDetector(
                    onTap: () {
                      AlertDialog errorDialog = AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        contentPadding: const EdgeInsets.all(5), //this right here
                        title: SingleChildScrollView(
                          // height: 300,
                          // width: 100,
                          // alignment: Alignment.center,
                          child: Container(
                            height: MediaQuery.of(context).size.height-200,
                            width: MediaQuery.of(context).size.width-20,

                            child: ListView.builder(
                                physics: const ClampingScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                shrinkWrap: true,
                                itemCount:
                                jsonDecode(datacoun!)[
                                'countries'].length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      Container(
                                        //height: 50,
                                        padding: const EdgeInsets.all(8),
                                        margin: const EdgeInsets.all(4),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              countryname = jsonDecode(datacoun!)[
                                              'countries'][index]['name']
                                                  .toString();
                                              countryid = jsonDecode(datacoun!)[
                                              'countries'][index]['id']
                                                  .toString();
                                              getState(
                                                  GetStateResponse, countryid);
                                              print(countryid);
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: Text(
                                            jsonDecode(datacoun!)['countries']
                                            [index]['name'],
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: ColorConstants.txt),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ),
                      );
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => errorDialog);
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: countryname == null
                                ? const Text("Select Country",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14))
                                : Text(countryname.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14)),
                          ),
                          const Icon(
                            Icons.arrow_drop_down_outlined,
                            size: 22,
                          )
                        ],
                      ),
                    ),
                  )),
                  Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  height: 50,
                  alignment: Alignment.centerLeft,
                  //color: Colors.white,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(5)),
                  // margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),

                  child: GestureDetector(
                    onTap: () {
                      AlertDialog errorDialog = AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        contentPadding: const EdgeInsets.all(5), //this right here
                        title: SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.of(context).size.height-200,
                            width: MediaQuery.of(context).size.width-20,

                            child: ListView.builder(
                                physics: const ClampingScrollPhysics(
                                    parent: const BouncingScrollPhysics()),
                                shrinkWrap: true,
                                itemCount:
                                jsonDecode(datastate!)['states'].length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      Container(
                                        //height: 50,
                                        padding: const EdgeInsets.all(8),
                                        margin: const EdgeInsets.all(4),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              statename =
                                                  jsonDecode(datastate!)['states']
                                                  [index]['name']
                                                      .toString();
                                              stateid =
                                                  jsonDecode(datastate!)['states']
                                                  [index]['id']
                                                      .toString();
                                              getCity(GetCityResponse, stateid);
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: Text(
                                            jsonDecode(datastate!)['states']
                                            [index]['name'],
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: ColorConstants.txt),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ),
                      );
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => errorDialog);
                    },
                    child: Container( margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: statename == null
                                ? const Text("Select State",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14))
                                : Text(statename.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14)),
                          ),
                          const Icon(
                            Icons.arrow_drop_down_outlined,
                            size: 22,
                          )
                        ],
                      ),
                    ),
                  )),
                  Container(margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  height: 50,
                  alignment: Alignment.centerLeft,
                  //color: Colors.white,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(5)),
                  // margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),

                  child: GestureDetector(
                    onTap: () {
                      AlertDialog errorDialog = AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        contentPadding: const EdgeInsets.all(5), //this right here
                        title: SingleChildScrollView(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height-200,
                            width: MediaQuery.of(context).size.width-20,

                            child: ListView.builder(
                                physics: const ClampingScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                shrinkWrap: true,
                                itemCount: jsonDecode(citydata!)['cities'].length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      Container(
                                        //height: 50,
                                        padding: const EdgeInsets.all(8),
                                        margin: const EdgeInsets.all(4),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              cityname =
                                                  jsonDecode(citydata!)['cities']
                                                  [index]['name']
                                                      .toString();
                                              cityid =
                                                  jsonDecode(citydata!)['cities']
                                                  [index]['id']
                                                      .toString();

                                              Navigator.pop(context);
                                            });
                                          },
                                          child: Text(
                                            jsonDecode(citydata!)['cities'][index]
                                            ['name'],
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: ColorConstants.txt),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ),
                      );
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => errorDialog);
                    },
                    child: Container(margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: cityname == null
                                ? const Text("Select City",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14))
                                : Text(cityname.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14)),
                          ),
                          const Icon(
                            Icons.arrow_drop_down_outlined,
                            size: 22,
                          )
                        ],
                      ),
                    ),
                  )),
                  Container(margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                height: 50,
                alignment: Alignment.centerLeft,
                //color: Colors.white,
                decoration: BoxDecoration(
                    color: Colors.black12, borderRadius: BorderRadius.circular(5)),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        dobdate ="${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                        dob="${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                        //"${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";

                      });
                      _selectDate(context);
                    },
                    child: dobdate == null
                        ? Container(margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: const Text("Select DOB",
                          style: TextStyle(
                              color: Colors.black, fontSize: 14)),
                        )
                        : Container(margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text("${dobdate}",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14)),
                        )),
                // margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  ),
                  Container(
                  height: 60,
                  alignment: Alignment.centerLeft,
                  //color: Colors.white,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(5)),
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: GestureDetector(
                    onTap: () {
                      AlertDialog errorDialog = AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(20.0)), //this right here
                        title: Container(
                          height: 100,
                          width: 100,
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          child: ListView.builder(
                              physics: const ClampingScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              shrinkWrap: true,
                              itemCount: genderlist.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Container(
                                      //height: 50,
                                      padding: const EdgeInsets.all(4),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            gendername = '${genderlist[index]}';
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Text(
                                          '${genderlist[index]}',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: ColorConstants.txt),
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.black12,
                                    )
                                  ],
                                );
                              }),
                        ),
                      );
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => errorDialog);
                    },
                    child: Container(margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: gendername == null
                                ? const Text("Select Gender",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14))
                                : Text("${gendername}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14)),
                          ),
                          const Icon(
                            Icons.arrow_drop_down_outlined,
                            size: 22,
                          )
                        ],
                      ),
                    ),
                  )),

                Center(
                  child: Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ColorConstants.verdigris,
                    onPrimary: Colors.white,
                    elevation: 3,
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    fixedSize: const Size(120, 30),
                    //////// HERE
                  ),
                  onPressed: () {
                    log(dob.toString());
                    log(dobdate.toString());
                    String strDigits(int n) => n.toString().padLeft(2, '0');
                    log("${selectedDate.year}-${selectedDate.month}-${selectedDate.day}");
                    // if(dob==null)
                    //   {
                    //     var newdate= DateTime.parse(dobdate);
                    //     final DateFormat formatter = DateFormat('dd-mm-yyyy');
                    //     final String formatted = formatter.format(newdate);
                    //
                    //    setState(() {
                    //      dob="$formatted";
                    //    });
                    //   }
                    // log(dob.toString());
                    // Navigator.of(context).pop();
                    if (validateMobile(mobileno.toString())) {
                      if (validateName(firstname)) {
                        if (_image != null) {
                         // showLoaderDialog(context);
                          uploadFile(
                              userid.toString(),
                              mobileno.toString(),
                              firstname.toString(),
                              dobdate.toString(),
                              stateid.toString(),
                              cityid.toString(),
                              gendername.toString(),
                              lastname.toString(),
                              _image!);
                        } else {
                         // showLoaderDialog(context);
                          profileupdateapi(
                              userid.toString(),
                              mobileno.toString(),
                              firstname.toString(),
                              dobdate.toString(),
                              stateid.toString(),
                              cityid.toString(),
                              gendername.toString(),
                              lastname.toString());
                        }
                      }else{
                        const snackBar =
                        SnackBar(
                          content: Text(
                              'Name Must be more than 2 character'),
                        );
                        ScaffoldMessenger
                            .of(context)
                            .showSnackBar(
                            snackBar);
                      }
                    }else{
                      const snackBar =
                      SnackBar(
                        content: Text(
                            'Mobile number must be of 10 digits'),
                      );
                      ScaffoldMessenger
                          .of(context)
                          .showSnackBar(
                          snackBar);
                    }
                  },
                  child: const Text(
                    "UPDATE",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),

    ),

                ),

              ]),
                  ],
                ),
                ),
            ],
          ),
        ),
      ),
      )
    );
  }
}

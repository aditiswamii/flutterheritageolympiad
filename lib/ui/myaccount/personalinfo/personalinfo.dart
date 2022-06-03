
import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/modal/getprivacy/GetPrivacyResponse.dart';
import 'package:flutterheritageolympiad/modal/getprofileresponse/GetProfileResponse.dart';
import 'package:flutterheritageolympiad/ui/myaccount/invitecontact/invitecontactlink/invitecontact_link.dart';
import 'package:flutterheritageolympiad/ui/myaccount/myaccount_page.dart';
import 'package:flutterheritageolympiad/ui/rightdrawer/right_drawer.dart';
import 'package:flutterheritageolympiad/ui/homepage/homepage.dart';
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
  var profilepic;
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

    getProfile(userid.toString());
  }
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
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
    await http.get(Uri.parse('http://3.108.183.42/api/country'));
    if (response.statusCode == 200) {
      datacoun = response.body; //store response as string
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
    } else {
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

      if (response.statusCode == 200) {
        data = response.body;
        //final responseJson = json.decode(response.body);//store response as string
        setState(() {
          data = response.body;
          prodata = jsonDecode(
              data!)['data']; //get all the data from json string superheros
          print(prodata.length);
          getCountry(GetCountryList);
          onsuccess(getProfileResponseFromJson(data!));
        });

        var venam = jsonDecode(data!)['data'];
        print(venam);
      } else {
        print(response.statusCode);
      }

  }
  onsuccess(GetProfileResponse? getprofileresponse){
    if(getprofileresponse!.data!=null){
      setState(() {
        profileresdata=getprofileresponse;
        firstname="${profileresdata!.data!.firstName![0].toUpperCase() + profileresdata!.data!.firstName!.substring(1)}";
        lastname=profileresdata!.data!.lastName!.toString();
        dobdate=profileresdata!.data!.dob!.toString();
        mobileno=profileresdata!.data!.mobile!.toString();
        profilepic=profileresdata!.data!.image!.toString();
        gendername=profileresdata!.data!.gender!.toString();
        cityid=profileresdata!.data!.cityId!.toString();
        cityname=profileresdata!.data!.city!.toString();
        stateid=profileresdata!.data!.stateId!.toString();
        statename=profileresdata!.data!.state!.toString();
        countryid=profileresdata!.data!.countryId!.toString();
        countryname=profileresdata!.data!.country!.toString();
      });


    }
  }


  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime(selectedDate.year - 1),
      firstDate: DateTime(selectedDate.year-99),
      lastDate: DateTime(selectedDate.year-1),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }
  uploadFile(String userid,String mobile,String first_name,String dob,String state_id,String city_id,
  String gender,String last_name, File image) async {

    var postUri = Uri.parse(StringConstants.BASE_URL+'update-profile');
    var request = http.MultipartRequest("POST", postUri);
    request.fields['user_id'] = userid.toString();
    request.fields['mobile'] =  mobile.toString();
    request.fields['first_name'] = first_name.toString();
    request.fields['dob'] = dob.toString();
    request.fields['state_id'] = state_id.toString();
    request.fields['city_id'] = city_id.toString();
    request.fields['gender'] = gender.toString();
    request.fields['last_name'] = last_name.toString();
    print(request.toString());
    print(_image!.path);
    request.files.add(await http.MultipartFile.fromPath(
        'image',
        _image!.path));
    request.send().then((response) {

      //print("rrrrr=>"+response.statusCode.toString());

      if (response.statusCode == 200) {
        Navigator.pop(context);
        showLoaderDialog(context);
        getProfile(userid.toString());
        //store response as string
        onupdate();
        print("Uploaded!");

      }else{
        Navigator.pop(context);
        print("uploadfile response:"+response.statusCode.toString());
      }
    });
  }
  profileupdateapi(String userid,String mobile,String first_name,String dob,String state_id,String city_id,
      String gender,String last_name) async {
    http.Response response = await http
        .post(Uri.parse(StringConstants.BASE_URL+'update-profile'),
        body: {
          'user_id' : userid.toString(),
          'mobile': mobile.toString(),
          'first_name': first_name.toString(),
          'dob': dob.toString(),
          'state_id': state_id.toString(),
          'city_id': city_id.toString(),
          'gender': gender.toString(),
          'last_name': last_name.toString(),


        });

    var jsonResponse = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
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
      Navigator.pop(context);
      print("profileupdate:"+response.statusCode.toString());
    }
  }
  onupdate(){

  }
  validateName(String value) {
    if (value.length > 3)
      return true;
    else
      return false;
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
        MaterialPageRoute(builder: (BuildContext context) => MyAccountPage()));
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
      endDrawer: MySideMenuDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/debackground.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.white.withAlpha(200),
          margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
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
                                      builder: (context) =>  HomePage()));
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
                      margin: const EdgeInsets.fromLTRB(0, 40, 0, 10),
                      child: const Text("PERSONAL INFORMATION",
                          style: TextStyle(
                              fontSize: 24, color: ColorConstants.txt))),

              prodata==null?Container():  ListBody(
                  children: [

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: (){
                      AlertDialog errorDialog = AlertDialog(
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
                                      FloatingActionButton(
                                        onPressed: getImagefromcamera,
                                        tooltip: "Pick Image form gallery",
                                        child: Icon(Icons.add_a_photo),
                                      ),
                                      FloatingActionButton(
                                        onPressed: getImagefromGallery,
                                        tooltip: "Pick Image from camera",
                                        child: Icon(Icons.broken_image_outlined),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text("Pick Image\nfrom camera",style: TextStyle(fontSize: 12)),
                                      Text("Pick Image\nform gallery",style: TextStyle(fontSize: 12),),
                                    ],
                                  ),
                                ],
                              ),)
                      );
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => errorDialog);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100.0,
                      child:CircleAvatar(
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: _image ==null ?  Image.network(profilepic,height: 100,width: 100,fit: BoxFit.cover,):Image.file(_image!,height: 100,width: 100,fit: BoxFit.cover,),
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
                    Container(  margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
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
                              contentPadding: EdgeInsets.all(5), //this right here
                              title: SingleChildScrollView(
                                // height: 300,
                                // width: 100,
                                // alignment: Alignment.center,
                                child: Container(
                                  height: 500,
                                  child: ListView.builder(
                                      physics: ClampingScrollPhysics(
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
                                              padding: EdgeInsets.all(8),
                                              margin: EdgeInsets.all(4),
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
                                                  style: TextStyle(
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
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: countryname == null
                                      ? Text("Select Country",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14))
                                      : Text(countryname.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14)),
                                ),
                                Icon(
                                  Icons.arrow_drop_down_outlined,
                                  size: 22,
                                )
                              ],
                            ),
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
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
                              contentPadding: EdgeInsets.all(5), //this right here
                              title: SingleChildScrollView(
                                child: Container(
                                  height: 300,
                                  child: ListView.builder(
                                      physics: ClampingScrollPhysics(
                                          parent: BouncingScrollPhysics()),
                                      shrinkWrap: true,
                                      itemCount:
                                      jsonDecode(datastate!)['states'].length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            Container(
                                              //height: 50,
                                              padding: EdgeInsets.all(8),
                                              margin: EdgeInsets.all(4),
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
                                                  style: TextStyle(
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
                          child: Container( margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: statename == null
                                      ? Text("Select State",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14))
                                      : Text(statename.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14)),
                                ),
                                Icon(
                                  Icons.arrow_drop_down_outlined,
                                  size: 22,
                                )
                              ],
                            ),
                          ),
                        )),
                    Container(margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
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
                              contentPadding: EdgeInsets.all(5), //this right here
                              title: SingleChildScrollView(
                                child: Container(
                                  height: 300,
                                  child: ListView.builder(
                                      physics: ClampingScrollPhysics(
                                          parent: BouncingScrollPhysics()),
                                      shrinkWrap: true,
                                      itemCount: jsonDecode(citydata!)['cities'].length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            Container(
                                              //height: 50,
                                              padding: EdgeInsets.all(8),
                                              margin: EdgeInsets.all(4),
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
                                                  style: TextStyle(
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
                          child: Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: cityname == null
                                      ? Text("Select City",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14))
                                      : Text(cityname.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14)),
                                ),
                                Icon(
                                  Icons.arrow_drop_down_outlined,
                                  size: 22,
                                )
                              ],
                            ),
                          ),
                        )),
                    Container(margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
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
                              ? Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Text("Select DOB",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14)),
                              )
                              : Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Text("${dobdate}",
                                style: TextStyle(
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
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: GestureDetector(
                          onTap: () {
                            AlertDialog errorDialog = AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(20.0)), //this right here
                              title: Container(
                                height: 100,
                                width: 100,
                                padding: EdgeInsets.all(8),
                                alignment: Alignment.center,
                                child: ListView.builder(
                                    physics: ClampingScrollPhysics(
                                        parent: BouncingScrollPhysics()),
                                    shrinkWrap: true,
                                    itemCount: genderlist.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          Container(
                                            //height: 50,
                                            padding: EdgeInsets.all(4),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  gendername = '${genderlist[index]}';
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: Text(
                                                '${genderlist[index]}',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: ColorConstants.txt),
                                              ),
                                            ),
                                          ),
                                          Divider(
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
                          child: Container(margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: gendername == null
                                      ? Text("Select Gender",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14))
                                      : Text("${gendername}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14)),
                                ),
                                Icon(
                                  Icons.arrow_drop_down_outlined,
                                  size: 22,
                                )
                              ],
                            ),
                          ),
                        )),

                  Center(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                          // Navigator.of(context).pop();
                          if (validateMobile(mobileno.toString())) {
                            if (validateName(firstname)) {
                              if (_image != null) {
                                showLoaderDialog(context);
                                uploadFile(
                                    userid.toString(),
                                    mobileno.toString(),
                                    firstname.toString(),
                                    dob.toString(),
                                    stateid.toString(),
                                    cityid.toString(),
                                    gendername.toString(),
                                    lastname.toString(),
                                    _image!);
                              } else {
                                showLoaderDialog(context);
                                profileupdateapi(
                                    userid.toString(),
                                    mobileno.toString(),
                                    firstname.toString(),
                                    dob.toString(),
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
            )

          ),
        ),
      ),
    );
  }
}

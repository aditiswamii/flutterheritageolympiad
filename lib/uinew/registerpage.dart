import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/modal/getcitylist/GetCityResponse.dart';
import 'package:flutterheritageolympiad/modal/getstate/GetStateResponse.dart';
import 'package:flutterheritageolympiad/ui/alldone/alldone.dart';
import 'package:flutterheritageolympiad/ui/almostthere/almostthere_presenter.dart';
import 'package:flutterheritageolympiad/ui/almostthere/almostthere_viewmodal.dart';
import 'package:flutterheritageolympiad/ui/signup/signup_page.dart';
import 'package:flutterheritageolympiad/ui/welcomeback/welcomeback_page.dart';
import 'package:flutterheritageolympiad/uinew/loginpage.dart';
import 'package:flutterheritageolympiad/uinew/signuppage.dart';
import 'package:flutterheritageolympiad/utils/apppreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modal/getcountry/GetCountryList.dart';
import '../modal/getregisterresponse/GetRegisterResponse.dart';
import '../utils/StringConstants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: RegisterPage(),
//   ));
// }

class RegisterPage extends StatefulWidget {
  var userid;
  RegisterPage({Key? key,required this.userid}) : super(key: key);


  @override
  _State createState() => _State();
}

class _State extends State<RegisterPage> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController newsletter = TextEditingController();
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
        citylength = getCityResponseFromJson(citydata!);
        // just printed length of data
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
        countlength = getCountryListFromJson(
            datacoun!); //get all the data from json string superheros
        // just printed length of data
      });
      //getState(GetStateResponse);
      var venam = jsonDecode(datacoun!)['countries'].toString();
      var venamid = jsonDecode(datacoun!)['countries'][4]['id'].toString();
      print(venam);
      print(countlength.length);
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
        statelength = getStateResponseFromJson(
            datastate!); //get all the data from json string superheros
        // just printed length of data
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

  void registerapi(
      String firstname,
      String dob,
      String mobile,
      String lastname,
      String stateid,
      String cityid,
      String gender,
      String newsletter,
      String userid) async {
    http.Response response = await http
        .post(Uri.parse(StringConstants.BASE_URL + 'register'), body: {
      'first_name': firstname,
      'dob': dob,
      'mobile': mobile,
      'last_name': lastname,
      'state_id': stateid,
      'city_id': cityid,
      'gender': gender,
      'newsletter': newsletter,
      'user_id': userid,
    });
    if (response.statusCode == 200) {
      data = response.body;
        print(jsonDecode(data!)['success'].toString());
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        String registerdata =
            jsonEncode(getRegisterResponseFromJson(data!).data);
        prefs.setString('registerdata', registerdata);
        prefs.setString('issocial',
            getRegisterResponseFromJson(data!).data!.isSocial.toString());
        prefs.setString("username",getRegisterResponseFromJson(data!).data!.name.toString() );
      prefs.setString("profileComplete",getRegisterResponseFromJson(data!).data!.profileComplete.toString() );
      prefs.setString("userid",getRegisterResponseFromJson(data!).data!.id.toString() );
      prefs.setString("profileImage",getRegisterResponseFromJson(data!).data!.profileImage.toString() );
      prefs.setString("gender",getRegisterResponseFromJson(data!).data!.gender.toString() );
      prefs.setString("lastName",getRegisterResponseFromJson(data!).data!.lastName.toString() );
      prefs.setString("stateId",getRegisterResponseFromJson(data!).data!.stateId.toString() );
      prefs.setString("age",getRegisterResponseFromJson(data!).data!.age.toString() );
      prefs.setString("country",getRegisterResponseFromJson(data!).data!.country.toString() );
        onsuccess(getRegisterResponseFromJson(data!).data);

    } else {
      print(response.statusCode);
    }
  }

  onsuccess(Data? data) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => WelcomePage()));
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime(selectedDate.year - 1),
      firstDate: DateTime(1950),
      lastDate: DateTime(selectedDate.year),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }

  @override
  void initState() {
    getCountry(GetCountryList);
    super.initState();

    BackButtonInterceptor.remove(myInterceptor);

    //autoLogIn();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => Stepone()));
    // Do some stuff.
    return true;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: ListView(children: [
            Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.fromLTRB(0, 70, 0, 10),
                child: const Text("ALMOST THERE...",
                    style: TextStyle(
                        fontSize: 24, color: ColorConstants.txt))),
            Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                alignment: Alignment.centerLeft,
                child: Text("First Name*",
                    style: TextStyle(
                        color: ColorConstants.txt, fontSize: 16.0))),
            Container(
              // height: 60,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: TextFormField(
                controller: firstnameController,
                obscureText: false,
                maxLength: 50,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelStyle: TextStyle(textBaseline: TextBaseline.alphabetic),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorConstants.txt, width: 1.0),
                  ),
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                alignment: Alignment.centerLeft,
                child: Text('Last Name*',
                    style: TextStyle(
                        color: ColorConstants.txt, fontSize: 16.0))),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: TextField(
                controller: lastnameController,
                obscureText: false,
                maxLength: 50,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelStyle: TextStyle(textBaseline: TextBaseline.alphabetic),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorConstants.txt, width: 1.0),
                  ),
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.singleLineFormatter
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                alignment: Alignment.centerLeft,
                child: Text("Country*",
                    style: TextStyle(
                        color: ColorConstants.txt, fontSize: 16.0))),
            Container(
                height: 50,
                alignment: Alignment.centerLeft,
                //color: Colors.white,
                decoration: BoxDecoration(
                    color: Colors.white,
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
                                  jsonDecode(datacoun!)['countries'].length,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: countryname == null
                            ? Text("Select Country",
                                style: TextStyle(
                                    color: ColorConstants.txt,
                                    fontSize: 14))
                            : Text(countryname.toString(),
                                style: TextStyle(
                                    color: ColorConstants.txt,
                                    fontSize: 14)),
                      ),
                      Icon(
                        Icons.arrow_drop_down_outlined,
                        size: 22,
                      )
                    ],
                  ),
                )),
            Divider(
              color: ColorConstants.txt,
              height: 1,
              thickness: 1,
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                alignment: Alignment.centerLeft,
                child: Text("State/Province*",
                    style: TextStyle(
                        color: ColorConstants.txt, fontSize: 16.0))),
            Container(
                height: 50,
                alignment: Alignment.centerLeft,
                //color: Colors.white,
                decoration: BoxDecoration(
                    color: Colors.white,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: statename == null
                            ? Text("Select State",
                                style: TextStyle(
                                    color: ColorConstants.txt,
                                    fontSize: 14))
                            : Text(statename.toString(),
                                style: TextStyle(
                                    color: ColorConstants.txt,
                                    fontSize: 14)),
                      ),
                      Icon(
                        Icons.arrow_drop_down_outlined,
                        size: 22,
                      )
                    ],
                  ),
                )),
            Divider(
              color: ColorConstants.txt,
              height: 1,
              thickness: 1,
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                alignment: Alignment.centerLeft,
                child: Text('City',
                    style: TextStyle(
                        color: ColorConstants.txt, fontSize: 16.0))),
            Container(
                height: 50,
                alignment: Alignment.centerLeft,
                //color: Colors.white,
                decoration: BoxDecoration(
                    color: Colors.white,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: cityname == null
                            ? Text("Select City",
                                style: TextStyle(
                                    color: ColorConstants.txt,
                                    fontSize: 14))
                            : Text(cityname.toString(),
                                style: TextStyle(
                                    color: ColorConstants.txt,
                                    fontSize: 14)),
                      ),
                      Icon(
                        Icons.arrow_drop_down_outlined,
                        size: 22,
                      )
                    ],
                  ),
                )),
            Divider(
              color: ColorConstants.txt,
              height: 1,
              thickness: 1,
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Text('Date of Birth*(DD/MM/YYYY)',
                    style: TextStyle(
                        color: ColorConstants.txt, fontSize: 16.0))),
            Container(
              height: 50,
              alignment: Alignment.centerLeft,
              //color: Colors.white,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      dobdate =
                          "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";
                    });
                    _selectDate(context);
                  },
                  child: dobdate == null
                      ? Text("Select DOB",
                          style: TextStyle(
                              color: ColorConstants.txt, fontSize: 14))
                      : Text("${dobdate}",
                          style: TextStyle(
                              color: ColorConstants.txt, fontSize: 14))),
              // margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            ),
            Divider(
              color: ColorConstants.txt,
              height: 1,
              thickness: 1,
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                alignment: Alignment.centerLeft,
                child: Text("Gender",
                    style: TextStyle(
                        color: ColorConstants.txt, fontSize: 16.0))),
            Container(
                height: 60,
                alignment: Alignment.centerLeft,
                //color: Colors.white,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: gendername == null
                            ? Text("Select Gender",
                                style: TextStyle(
                                    color: ColorConstants.txt,
                                    fontSize: 14))
                            : Text("${gendername}",
                                style: TextStyle(
                                    color: ColorConstants.txt,
                                    fontSize: 14)),
                      ),
                      Icon(
                        Icons.arrow_drop_down_outlined,
                        size: 22,
                      )
                    ],
                  ),
                )),
            Divider(
              color: ColorConstants.txt,
              height: 1,
              thickness: 1,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Subscribe me to the monthly newsletter?",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                    Checkbox(
                      value: valuenews,
                      onChanged: (value) {
                        setState(() {
                          valuenews = value!;
                        });
                      },
                    )
                  ]),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.white,
                        elevation: 3,
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        fixedSize: const Size(100, 50),
                        //////// HERE
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupPage()));
                      },
                      child: const Text(
                        "BACK",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.white,
                        elevation: 3,
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        fixedSize: const Size(100, 50),
                        //////// HERE
                      ),
                      onPressed: () {
                        if (valuenews == true) {
                          subletter = "1";
                        } else {
                          subletter = "0";
                        }
                        if (firstnameController.text.isNotEmpty) {
                          if (lastnameController.text.isNotEmpty) {
                            if (dobdate != null) {
                              if (cityid != null) {
                                if (stateid != null) {
                                  if (countryid != null) {
                                    registerapi(
                                        firstnameController.text.toString(),
                                        dobdate.toString(),
                                        "",
                                        lastnameController.text.toString(),
                                        stateid,
                                        cityid,
                                        gendername.toString(),
                                        subletter,
                                        widget.userid.toString());
                                    // _presenter.register(
                                    //     firstnameController.text.toString(),
                                    //     dobController.text.toString(),
                                    //     "",//mobile
                                    //     lastnameController.text.toString(),
                                    //     stateController.text.toString(),
                                    //     cityController.text.toString(),
                                    //     gender.text.toString(),
                                    //     newsletter.text.toString(),
                                    //     ""//userid
                                    // );
                                  } else {
                                    const snackBar = SnackBar(
                                      content: Text('Please Select Country'),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                } else {
                                  const snackBar = SnackBar(
                                    content: Text('Please Select State'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              } else {
                                const snackBar = SnackBar(
                                  content: Text('Please Select City'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            } else {
                              const snackBar = SnackBar(
                                content: Text('Please Select DOB'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          } else {
                            const snackBar = SnackBar(
                              content: Text('Please fill lastname'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                          // AppPreference().preference.
                        } else {
                          const snackBar = SnackBar(
                            content: Text('Please fill firstname'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: const Text(
                        "NEXT",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}

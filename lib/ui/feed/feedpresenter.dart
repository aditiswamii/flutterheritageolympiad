//
//
// import 'dart:convert';
// import 'dart:developer';
//
//
// import 'package:flutter/material.dart';
// import 'package:flutterheritageolympiad/ui/feed/feedview.dart';
// import 'package:flutterheritageolympiad/utils/stringconstants.dart';
// import 'package:http/http.dart';
// import 'dart:convert' as convert;
// import 'package:http/http.dart' as http;
//
// import '../../modal/feedtagfilter/GetTagFilterResponse.dart';
//
// class FeedPresenter {
//   FeedView _view;
//   FeedPresenter(this._view);
//   var snackBar;
//   var data;
//
//   getFeed(BuildContext context,String userid, String feed_page_id, String feed_type_id,
//       String domain_id, String theme_id) async {
//     // showLoaderDialog(context);
//     http.Response response =
//     await http.post(Uri.parse(StringConstants.BASE_URL + "feed"), body: {
//       'user_id': userid.toString(),
//       'feed_page_id': feed_page_id.toString(),
//       'feed_type_id': feed_type_id.toString(),
//       'domain_id': domain_id.toString(),
//       'theme_id': theme_id.toString()
//     });
//     var jsonResponse = convert.jsonDecode(response.body);
//     if (response.statusCode == 200) {
//       // Navigator.pop(context);
//       data = response.body;
//       if (jsonResponse['status'] == 200) {
//         //final responseJson = json.decode(response.body);//store response as string
//        var feeddataa=jsonResponse['data'];
//
//
//       _view.feedData(feeddataa);
//
//         var venam = jsonDecode(data!)['data'];
//         print(venam);
//         print(jsonDecode(data!)['last_id']);
//         //last_id
//         print(jsonDecode(data!)['data'][0]['id']);
//         print(jsonDecode(data!)['data'][0]['type']);
//         print(jsonDecode(data!)['data'][0]['tags']);
//         print(jsonDecode(data!)['data'][0]['title']);
//         print(jsonDecode(data!)['data'][0]['description']);
//         print(jsonDecode(data!)['data'][0]['external_link']);
//         print(jsonDecode(data!)['data'][0]['video_link']);
//         print(jsonDecode(data!)['data'][0]['placeholder_image']);
//         print(jsonDecode(data!)['data'][0]['savepost']);
//         print(jsonDecode(data!)['data'][0]['is_saved']);
//         print(jsonDecode(data!)['data'][0]['share']);
//         print(jsonDecode(data!)['data'][0]['media_type']);
//         print(jsonDecode(data!)['data'][0]['media']);
//         print(jsonDecode(data!)['data'][0]['media_type']);
//         print(jsonDecode(data!)['data'][0]['media_type']);
//       }else{
//         snackBar = SnackBar(
//           content: Text(
//               jsonResponse['message']),
//         );
//         ScaffoldMessenger.of(context)
//             .showSnackBar(snackBar);
//       }
//     }else {
//       // Navigator.pop(context);
//       print(response.statusCode);
//     }
//
//   }
//   gettagfilter(BuildContext context,String userid ,String searchkey,String type) async {
//
//     http.Response response = await http.get(
//         Uri.parse(StringConstants.BASE_URL + "tagfilter?searchkey=$searchkey&type=$type&user_id=$userid")
//     );
//     // showLoaderDialog(context);
//     var jsonResponse = convert.jsonDecode(response.body);
//     if (response.statusCode == 200) {
//       data = response.body;
//       // Navigator.pop(context);
//       if (jsonResponse['status'] == 200) {
//
//         var  tagdata = jsonDecode(
//               data!)['data']; //get all the data from json string superheros
//           print(tagdata.length);
//
//         _view.onsuccess(getTagFilterResponseFromJson(data).data);
//         var venam = jsonDecode(data!)['data'];
//         print(venam);
//       } else {
//         _view.onsuccess(null);
//         snackBar = SnackBar(
//           content: Text(
//               jsonResponse['message']),
//         );
//         ScaffoldMessenger.of(context)
//             .showSnackBar(snackBar);
//       }
//     } else {
//       // Navigator.pop(context);
//       // onsuccess(null);
//       print(response.statusCode);
//     }
//
//   }
//
//   savepost(BuildContext context,String userid ,String feed_id,String type) async {
//
//     http.Response response = await http.post(
//         Uri.parse(StringConstants.BASE_URL + "savefeed"),body: {
//       'user_id':userid.toString(),
//       'feed_id':feed_id.toString(),
//       'type':type.toString()
//     }
//     );
//     // showLoaderDialog(context);
//     var jsonResponse = convert.jsonDecode(response.body);
//     if (response.statusCode == 200) {
//       data = response.body;
//       // Navigator.pop(context);
//       if (jsonResponse['status'] == 200) {
//
//         snackBar = SnackBar(
//           content: Text(
//               jsonResponse['message']),
//         );
//         ScaffoldMessenger.of(context)
//             .showSnackBar(snackBar);
//       } else {
//
//         snackBar = SnackBar(
//           content: Text(
//               jsonResponse['message']),
//         );
//         ScaffoldMessenger.of(context)
//             .showSnackBar(snackBar);
//       }
//     } else {
//
//       print(response.statusCode);
//     }
//
//   }
//
// }
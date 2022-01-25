import 'package:flutter/material.dart';


import 'mvpexample_model.dart';
import 'mvpexample_view.dart';


class MVPExampleMain extends StatefulWidget {
  @override
  _MVPExampleMainState createState() => _MVPExampleMainState();
}

class _MVPExampleMainState extends State<MVPExampleMain> implements MVPExampleView {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  @override
  void showContactList(List<MVPExampleModel> items) {
    // TODO: implement showContactList
  }

  @override
  void showError() {
    // TODO: implement showError
  }
  // TextEditingController controller = TextEditingController();
  //
  // DuelRejectPresenter _presenter;
  //
  // List<DuelRejectModel> _contacts;
  //
  // List<DuelRejectModel> _searchResult = [];
  //
  // bool _isLoading;

  // _DuelRejectDialogState() {
  //   _presenter = DuelRejectPresenter(this);
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _isLoading = true;
  //   _presenter.loadContacts();
  // }
  //
  // @override
  // void showContactList(List<DuelRejectModel> items) {
  //   setState(() {
  //     _contacts = items;
  //     _isLoading = false;
  //   });
  // }
  //
  // @override
  // void showError() {
  //   // TODO: implement showError
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("Payments"),
  //       elevation: 0.0,
  //     ),
  //     body: Column(
  //       children: <Widget>[
  //         Container(
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Container(
  //               height: 40,
  //               padding: EdgeInsets.only(left: 8, right: 8),
  //               decoration: BoxDecoration(
  //                   color: Color.fromRGBO(231, 233, 235, 1),
  //                   borderRadius: BorderRadius.circular(10)),
  //               child: Row(
  //                 children: <Widget>[
  //                   Icon(
  //                     Icons.search,
  //                     color: Colors.grey,
  //                   ),
  //                   SizedBox(
  //                     width: 15,
  //                   ),
  //                   Expanded(
  //                     child: TextField(
  //                       controller: controller,
  //                       decoration: InputDecoration(
  //                           hintText: 'Search', border: InputBorder.none),
  //                       onChanged: onSearchTextChanged,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: 5,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //             child: _isLoading == true
  //                 ? Container(
  //               child: Center(
  //                   child: Padding(
  //                       padding: const EdgeInsets.only(
  //                           left: 16.0, right: 16.0),
  //                       child: CircularProgressIndicator())),
  //             )
  //                 : ListView(
  //                 padding: EdgeInsets.symmetric(vertical: 8.0),
  //                 children: _buildContactList(context)))
  //       ],
  //     ),
  //   );
  // }
  //
  // List<ContactListItem> _buildContactList(BuildContext context) {
  //   return (_searchResult.length != 0 || controller.text.isNotEmpty)
  //       ? _searchResult
  //       .map((contact) => ContactListItem(
  //       contact: contact,
  //       onTap: () {
  //         Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => PaymentDetail()));
  //       }))
  //       .toList()
  //       : _contacts
  //       .map((contact) => ContactListItem(
  //       contact: contact,
  //       onTap: () {
  //         Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => PaymentDetail()));
  //       }))
  //       .toList();
  // }
  //
  // onSearchTextChanged(String text) async {
  //   _searchResult.clear();
  //   if (text.isEmpty) {
  //     setState(() {});
  //     return;
  //   }
  //
  //   _contacts.forEach((contact) {
  //     if (contact.fullName.contains(text) || contact.phone.contains(text))
  //       _searchResult.add(contact);
  //   });
  //
  //   setState(() {});
  // }
}
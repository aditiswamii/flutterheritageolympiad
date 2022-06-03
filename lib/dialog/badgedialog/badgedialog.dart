
import 'package:flutter/material.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';

// ignore: must_be_immutable
class BadgeDialog extends StatefulWidget {
  String? title;
  String? image;
  String? description;
  BadgeDialog(
      {Key? key, required this.title, required this.image, required this.description})
      : super(key: key);

  @override
  _BadgeDialogState createState() => _BadgeDialogState();
}

class _BadgeDialogState extends State<BadgeDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          // height:250,
          // width: 250,
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const Text(
                      'You won a badge!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: ColorConstants.txt, fontSize: 24),
                    )),

                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: 150,
                  width: 150,
                  child: widget.image != ""
                      ? Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: 80,
                      width: 80,
                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage("${widget.image}"),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  )
                      : Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: 80,
                      width: 80,
                      child: const CircleAvatar(
                        radius: 30.0,
                        backgroundImage:
                        AssetImage("assets/images/placeholder.png"),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),

                Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(color: Colors.white),
                    child:  Text(
                      '${widget.title}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: ColorConstants.txt, fontSize: 18),
                    )),
                Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(color: Colors.white),
                    child:  Text(
                      "${widget.description}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: ColorConstants.txt, fontSize: 13),
                    )),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerRight,
                  child: TextButton(onPressed: () {
                    Navigator.pop(context);
                  },
                    child: const Text("CLOSE",style: TextStyle(color: Colors.red),),),
                )
              ],
            )));
  }
}

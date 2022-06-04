
import 'package:flutter/material.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';


class CongratsDialog extends StatefulWidget {
  String? title;
  String? image;
  int? rank;
  CongratsDialog(
      {Key? key, required this.title, required this.image, required this.rank})
      : super(key: key);

  @override
  _CongratsDialogState createState() => _CongratsDialogState();
}

class _CongratsDialogState extends State<CongratsDialog> {
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
                    child: Text(
                      '${widget.title}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: ColorConstants.txt, fontSize: 24),
                    )),

                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: widget.rank==1?const AssetImage("assets/images/artwork1.png"):
                    widget.rank==2?const AssetImage("assets/images/artwork2.png"):widget.rank==3?const AssetImage("assets/images/artwork3.png"):const AssetImage("assets/images/artwork1.png"))
                  ),
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
                    child: const Text(
                      'Congratulations!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ColorConstants.txt, fontSize: 18),
                    )),
                Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const Text(
                      "Keep it up!",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ColorConstants.txt, fontSize: 13),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterheritageolympiad/colors/colors.dart';
import 'package:flutterheritageolympiad/dialog/cancelplansuccess/cancelplan_successdialog.dart';
import 'package:flutterheritageolympiad/ui/payment/payment_screen.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DialogCancelPlan(),
  ));
}
class DialogCancelPlan extends StatefulWidget{
  const DialogCancelPlan({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<DialogCancelPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          // height:250,
          // width: 250,
            alignment: Alignment.center,
            //margin: EdgeInsets.fromLTRB(0,10,0,10),
           // padding: EdgeInsets.all(10),
            child:Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    margin:EdgeInsets.only(bottom: 10),

                    child: Text('Are you sure you want to cancel the plan?',textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.Omnes_font,fontSize:16 ),)
                ),

                Container(
                    alignment: Alignment.center,
                    margin:EdgeInsets.only(bottom: 10),
                    child: Text('Some Conditions here about the refund and reinstatement of the plan.',textAlign: TextAlign.center,style: TextStyle(color: ColorConstants.Omnes_font,fontSize:16 ),)
                ),
                Container(
                  alignment: FractionalOffset.bottomCenter,
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: ColorConstants.red,
                          onPrimary: Colors.white,
                          elevation: 3,
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          fixedSize: const Size(100, 40),
                          //////// HERE
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentScreen()));
                        },
                        child: const Text(
                          "GO BACK",
                          style: TextStyle(
                              color: ColorConstants.to_the_shop, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: ColorConstants.verdigris,
                          onPrimary: Colors.white,
                          elevation: 3,
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          fixedSize: const Size(100, 40),
                          //////// HERE
                        ),
                        onPressed: () {
                          AlertDialog errorDialog = AlertDialog(
                            backgroundColor: ColorConstants.verdigris,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(
                                      20.0)), //this right here
                              title:
                              Container(
                                  height: 150,
                                  width: 150,
                                  alignment: Alignment.center,
                                  child: DialogCancelPlanSuccess()));
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                              errorDialog);
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => PaymentScreen()));
                        },
                        child: const Text(
                          "CANCEL",
                          style: TextStyle(
                              color: ColorConstants.to_the_shop, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
        )
    );
  }
}

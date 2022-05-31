//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
//
// Class ValueNotifier<T> extends ChangeNotifier implements ValueListenable<T>{
//   ValueNotifier(this.value);
//
//   @override
//  T get value => _value;
//   set value(T newValue){
//     if(T==newValue){
//       return;
//       _value=newValue;
//       notifyListeners();
//     }
//   }
// }
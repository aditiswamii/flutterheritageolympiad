



// class PaymentApiService {
//   Future<PaymentModel> getPaymentDetail(String url, {Map<String, dynamic> queryParameters}) async {
//     final DocumentReference document =   Firestore.instance.collection("payments").document(url);
//     await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
//       var data = snapshot.data;
//       var model =  new PaymentModel.fromMap(data);
//       return model;
//     });
//   }
// }
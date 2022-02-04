import 'package:flutter/material.dart';
import 'package:flutterheritageolympiad/ui/shopproduct/product/products_presenter.dart';
import 'package:flutterheritageolympiad/ui/shopproduct/product/products_viewmodal.dart';

void main() {

  runApp(const MaterialApp(

    debugShowCheckedModeBanner: false,
    home: ProductList(),
  ));
}

class ProductList extends StatefulWidget{

  const ProductList({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<ProductList> implements ProductsView{
  late ProductsPresenter  _presenter;
  @override
  void initState() {
    super.initState();
    _presenter = ProductsPresenter(this);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:FutureBuilder<Object>(
              builder: (context, snapshot) {
                return
                    _presenter.getproduct("", "") ;
              }
            )
        ),
    );
  }

  @override
  void onSuccess(List jsonResponse) {
    ListView _jobsListView(data) {
      return ListView.builder(
        shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return (data[index].position);
          });
    }
  }


}
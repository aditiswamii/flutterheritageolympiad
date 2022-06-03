import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutterheritageolympiad/ui/feed/feed.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';


class ImageviewFeed extends StatefulWidget{
  List<String> gallery;
  String image;
  int index;
  var contents;
  var themes;
  var seldomain;
  ImageviewFeed({Key? key,required this.gallery
    ,required this.image,required this.index,required this.seldomain,required this.contents,required this.themes
  }) : super(key: key);

  @override
  _State createState() => _State();
}


class _State extends State<ImageviewFeed> {
  int firstpage=0;
  BuildContext? context1;
  @override
  void initState() {
    super.initState();
    context1;
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) =>FeedPage(contents: widget.contents, themes: widget.themes, seldomain: widget.seldomain,)));

    // Do some stuff.
    return true;
  }
  @override
  Widget build(BuildContext context) {
    firstpage = widget.index;
    PageController _pageController = PageController(initialPage: firstpage);
    return Scaffold(

        body:Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          child: Column(
            children: [
              Center(
                child: Container(
                  height:MediaQuery.of(context).size.height-50,
                  //  height: 200,
                    child: PhotoViewGallery.builder(
                      backgroundDecoration: BoxDecoration(
                          color: Colors.black
                      ),
                      scrollPhysics: const BouncingScrollPhysics(),
                      pageController: _pageController,
                      builder: (BuildContext context, int index) {
                        String myImg =widget.gallery[index];
                        return PhotoViewGalleryPageOptions(
                          imageProvider: NetworkImage(myImg),
                          initialScale: PhotoViewComputedScale.contained * 0.8,
                          // heroAttributes: PhotoViewHeroAttributes(tag: pics[index].id),
                        );
                      },
                      itemCount:widget.gallery.length,
                      onPageChanged: (int index) {
                        setState(() {
                          firstpage = index;
                        });
                      },
                    )
                ),
              ),
              Container(
                height: 50,
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>FeedPage(contents: widget.contents, themes: widget.themes, seldomain: widget.seldomain,)));



                  },
                  child: Image.asset("assets/images/left_arrow.png",height: 40,width: 40),
                ),
              ),
            ],
          ),
        )
    );
  }
}
//Container(
//                  height: 150,
//                  child: PhotoViewGallery.builder(
//                    backgroundDecoration: BoxDecoration(
//                        color: Colors.white
//                    ),
//                    scrollPhysics: const BouncingScrollPhysics(),
//                    builder: (BuildContext context, int index) {
//                      return PhotoViewGalleryPageOptions(
//                        imageProvider: NetworkImage(pics[index]),
//                        initialScale: PhotoViewComputedScale.contained * 0.8,
//                        // heroAttributes: PhotoViewHeroAttributes(tag: pics[index].id),
//                      );
//                    },
//                    itemCount: pics.length,
//
//                  )
//              )
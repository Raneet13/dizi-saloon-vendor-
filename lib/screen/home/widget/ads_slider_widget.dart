import 'package:carousel_slider/carousel_slider.dart';
import 'package:dizisalon_vender/data/app_url.dart';
import 'package:dizisalon_vender/size_config.dart' show SizeConfig;
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../../model/home_model.dart';

class AdsSliderWidget extends StatefulWidget {
   List<AddDtl>? bannerDtl;
   AdsSliderWidget({this.bannerDtl, super.key});

  @override
  State<AdsSliderWidget> createState() => _AdsSliderWidgetState();
}

class _AdsSliderWidgetState extends State<AdsSliderWidget> {
  //    List<BannerDtl>? banner;
  int itemInde =0;
  @override
  Widget build(BuildContext context) {
    // print(widget.bannerDtl?[0].toJson());
    return Column(
      children: [
       widget.bannerDtl?.length==0?SizedBox(): CarouselSlider.builder(
          
          itemCount:widget.bannerDtl?.length,
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
        AnimatedContainer(
          height: double.infinity,
          width: double.infinity,
          duration: Duration(milliseconds:0),
                margin: EdgeInsets.only(
                  left:itemInde==itemIndex? 0:16,
        right:  itemInde==itemIndex? 0:16, // show margin only if not selected
      ),
          decoration: BoxDecoration(
        //       // color: Colors.grey[300],
               borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                onError: (error,stacktress){
                  // return AssetImage("assets/image/no_image.png",);
                },
                // image: AssetImage("assets/image/no_image.png",),
                
                image: NetworkImage("${AppUrl.imageApi}${widget.bannerDtl?[itemIndex].image??""}"),
                fit: BoxFit.cover,
              )
              ),
//         clipBehavior: Clip.hardEdge,
//         child: FadeInImage.assetNetwork(
//   placeholder: 'assets/image/no_image.png',
//   image: "${AppUrl.imageApi}${widget.bannerDtl?[itemIndex].image ?? ""}",
//   fit: BoxFit.cover,
//   imageErrorBuilder: (context, error, stackTrace) {
//     return Image.asset('assets/image/no_image.png', fit: BoxFit.cover);
//   },
// ),
        ),
         options: CarouselOptions(
         height: SizeConfig.blockHeight * 20,
          
          aspectRatio:1,// 16/9,
          viewportFraction:1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          
          // autoPlayAnimationDuration: Duration(milliseconds: 800),
           autoPlayCurve: Curves.linear, // optional, smoother change if needed
  enlargeCenterPage: false,
          enlargeFactor: 1,
          onPageChanged: (index,_){
            setState(() {
              itemInde=index;
            });
          },
          scrollDirection: Axis.horizontal,
           )
        ),
        SizedBox(
          height: 20,
           child: DotsIndicator(
                 dotsCount: widget.bannerDtl!.length ,//,
                 position:itemInde.toDouble(),
                 decorator: DotsDecorator(
                   size: const Size.square(9.0),
                   activeSize: const Size(18.0, 9.0),
                   activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                 ),
               ),
         ),
      ],
    );
  }
}
//  
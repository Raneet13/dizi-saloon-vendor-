import 'package:carousel_slider/carousel_slider.dart';
import 'package:dizisalon_vender/data/app_url.dart';
import 'package:dizisalon_vender/size_config.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../model/home_model.dart';

class HomeSlider extends StatefulWidget {
   List<AddDtl>? bannerDtl;
   bool dotFalse;
   HomeSlider({this.bannerDtl, super.key,this.dotFalse=false});

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  //    List<BannerDtl>? banner;
  int itemInde =0;
  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
       widget.bannerDtl?.length==0?SizedBox(): CarouselSlider.builder(
          
          itemCount:widget.bannerDtl?.length,
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
        AnimatedContainer(
          height: double.infinity,
          width: double.infinity,
          // margin:  EdgeInsets.symmetric(horizontal: 8),
          //  margin: const EdgeInsets.symmetric(horizontal: 8.0), 
          // padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
          // //     // color: Colors.grey[300],
               borderRadius: BorderRadius.circular(10),
          //     image: DecorationImage(
          //       onError: (error,stacktress){
          //         // return const Icon(Icons.error);
          //       },
          //       image: NetworkImage("${AppUrl.imageApi}${widget.bannerDtl?[itemIndex].image??""}"),
          //       fit: BoxFit.fill,
          //     )
              ),
              clipBehavior: Clip.hardEdge,
              duration: Duration(milliseconds:0),
                margin: EdgeInsets.only(
                  left:itemInde==itemIndex? 0:16,
        right:  itemInde==itemIndex? 0:16, // show margin only if not selected
      ),
              child: FadeInImage.assetNetwork(
  placeholder: 'assets/image/no_image.png',
  image: "${AppUrl.imageApi}${widget.bannerDtl?[itemIndex].image??""}",
  fit: BoxFit.cover,
  imageErrorBuilder: (context, error, stackTrace) {
    return Image.asset('assets/image/no_image.png', fit: BoxFit.fill);
  },
),
        ),
         options: CarouselOptions(
          height: 150.h,
          
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
       widget.dotFalse?SizedBox(): SizedBox(
          height: 20,
           child: DotsIndicator(
                 dotsCount: widget.bannerDtl!.length,
                 position:itemInde.toDouble(),
                 decorator: DotsDecorator(
                   size:  Size.square(9.0.r),
                   activeSize:  Size(17.0.w, 8.0.h),
                   activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                 ),
               ),
         ),
      ],
    );
  }
}
//  
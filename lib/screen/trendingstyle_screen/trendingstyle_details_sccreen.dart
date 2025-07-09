import 'package:dizisalon_vender/data/app_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/trendingstyle_model.dart';
import '../../view_model/home_viewmodel.dart';
import '../loading_screen/loading_screen.dart';

class TrendingstyleDetailsSccreen extends StatefulWidget {
  String? data;
 TrendingstyleDetailsSccreen({required this.data, super.key});

  @override
  State<TrendingstyleDetailsSccreen> createState() => _TrendingstyleDetailsSccreenState();
}

class _TrendingstyleDetailsSccreenState extends State<TrendingstyleDetailsSccreen> {
    final home = Get.find<HomeViewmodel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        home.trendingstyleDetails(widget.data??"");
    });
  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Obx(
        ()=>home.isLoading.value?SizedBox(): Text(
                  "${home.trendingStyleDetails.value.data?.bannerTitle??""}",
                  style:  GoogleFonts.montserrat(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
      ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 12,right: 12),
          child: Obx(
      ()=>home.isLoading.value?JumpingDotsScreen(): Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              // SizedBox(height: 20),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //   '${home.trendingStyleDetails.value.data?.bannerTitle??""}',
              //   style: TextStyle(
              //     fontSize: 28,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.black,
              //   ),
              // ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 8),
                child: Image.network("${AppUrl.imageApi}${home.trendingStyleDetails.value.data?.image??""}",fit: BoxFit.cover,errorBuilder: (context, error, stackTrace) {
                                        return Image.asset("assets/image/no_image.png",fit: BoxFit.cover,);
                                      },),
              ),
              // SizedBox(height: 20,),
              // Text(
              //   '${home.trendingStyleDetails.value.data?.description??""}',
              //   style: TextStyle(
              //     fontSize: 16,
              //     height: 1.5,
              //     color: Colors.black87,
              //   ),
              //   textAlign: TextAlign.justify,
              // ),
              Html(
          data: home.trendingStyleDetails.value.data?.description??"",
          style: {
             "*": Style(
                                                    margin: Margins.zero,
                                                    padding: HtmlPaddings.zero,
                                                    fontFamily: GoogleFonts.montserrat().fontFamily,
                                                  ),
            "h1": Style(
              fontSize: FontSize(28.sp),
              fontWeight: FontWeight.bold,
              color: Colors.teal,
              textAlign: TextAlign.center,
              fontFamily: GoogleFonts.montserrat().fontFamily,
            ),
            "h3": Style(
              fontSize: FontSize(20.sp),
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            "p": Style(
              fontSize: FontSize(16.sp),
              color: Colors.black,
              fontFamily: GoogleFonts.montserrat(fontSize: 14.sp).fontFamily,
              // lineHeight: LineHeight(2.sp),
            ),
            "ul": Style(
              margin: Margins.symmetric(vertical: 10.sp),
              padding: HtmlPaddings(left: HtmlPadding(20)),
              fontFamily: GoogleFonts.montserrat().fontFamily,
              // margin: EdgeInsets.symmetric(vertical: 10),
              // padding: EdgeInsets.only(left: 20),
            ),
            "li": Style(
              fontSize: FontSize(16.sp),
              color: Colors.black,
              fontFamily: GoogleFonts.montserrat().fontFamily,
            ),
            "span": Style(
              fontSize: FontSize(16.sp),
              color: Colors.black,
              fontFamily: GoogleFonts.montserrat().fontFamily,
            ),
            "strong": Style(
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.montserrat().fontFamily,
            ),
            "em": Style(
              fontStyle: FontStyle.italic,
              fontFamily: GoogleFonts.montserrat().fontFamily,
            ),
          },
        ),
              SizedBox(height: 30),
              
            ],
          ),
        ),
      ),
    );
  }
}
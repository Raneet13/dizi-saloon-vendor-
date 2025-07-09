import 'package:dizisalon_vender/data/app_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/latestarticle_model.dart';
import '../../view_model/home_viewmodel.dart';
import '../loading_screen/loading_screen.dart';
class ArticleDetailsSccreen extends StatefulWidget {
  String data;
 ArticleDetailsSccreen({required this.data, super.key});

  @override
  State<ArticleDetailsSccreen> createState() => _ArticleDetailsSccreenState();
}

class _ArticleDetailsSccreenState extends State<ArticleDetailsSccreen> {
      final home = Get.find<HomeViewmodel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        home.latestArticleDetails(blogId:  widget.data);
    });
  
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
          appBar: AppBar(
        title: Text(
                  '${home.latestArticleDetailsmodel.value.data?.title??""} ',
                  style: GoogleFonts.montserrat(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(left: 12,right: 12),
            child: Obx(
        ()=> home.isLoading.value?JumpingDotsScreen():  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //  Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(
                //   '${home.latestArticleDetailsmodel.value.data?.title??""}',
                //   style: TextStyle(
                //     fontSize: 28,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.black,
                //   ),
                // ),
                // ),
                // SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:  8.0,horizontal: 0),
                  child: Image.network("${AppUrl.imageApi}${home.latestArticleDetailsmodel.value.data?.image??""}",fit: BoxFit.cover,errorBuilder: (context, error, stackTrace) {
                                          return const Icon(Icons.error);
                                        },),
                ),
                // SizedBox(height: 20,),
                
                Html(
          data: home.latestArticleDetailsmodel.value.data?.message??"",
          style: {
             "*": Style(
                                                    margin: Margins.zero,
                                                    padding: HtmlPaddings.zero,
                                                    fontFamily: GoogleFonts.montserrat().fontFamily,
                                                  ),
            "h1": Style(
              fontSize: FontSize(28),
              fontWeight: FontWeight.bold,
              color: Colors.teal,
              textAlign: TextAlign.center,
             fontFamily: GoogleFonts.montserrat().fontFamily,
            ),
            "h3": Style(
              fontSize: FontSize(20),
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontFamily: GoogleFonts.montserrat().fontFamily,
            ),
            "p": Style(
              fontSize: FontSize(16),
              color: Colors.black,
              fontFamily: GoogleFonts.montserrat().fontFamily,
              lineHeight: LineHeight(1.5),
            ),
            "ul": Style(
              margin: Margins.symmetric(vertical: 10),
              padding: HtmlPaddings(left: HtmlPadding(20)),
              fontFamily: GoogleFonts.montserrat().fontFamily,
              // margin: EdgeInsets.symmetric(vertical: 10),
              // padding: EdgeInsets.only(left: 20),
            ),
            "li": Style(
              fontSize: FontSize(16),
              color: Colors.black,
              fontFamily: GoogleFonts.montserrat().fontFamily,
            ),
            "span": Style(
              fontSize: FontSize(16),
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
      ),
    );
  }
}
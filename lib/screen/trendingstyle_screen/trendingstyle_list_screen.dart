import 'package:dizisalon_vender/data/app_url.dart';
import 'package:dizisalon_vender/screen/article_screen/article_details_sccreen.dart';
import 'package:dizisalon_vender/screen/trendingstyle_screen/trendingstyle_details_sccreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../view_model/home_viewmodel.dart';
import '../loading_screen/loading_screen.dart';

class TrendingStylesScreen extends StatefulWidget {
  const TrendingStylesScreen({super.key});

  @override
  State<TrendingStylesScreen> createState() => _TrendingStylesScreenState();
}

class _TrendingStylesScreenState extends State<TrendingStylesScreen> {
    final home = Get.find<HomeViewmodel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        home.trendingstyle();
    });
  
  }
  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // title: const Text("Trending Style"),
        actions: [
 Image.asset("assets/image/splash_logo.png",height: 32.h,fit: BoxFit.cover,),
 SizedBox(width: 16.w,)
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:  EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const SizedBox(height: 24),

              // Search Bar
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        onChanged: (value){
                          home.searchtrendingstyle(search: value);
                        },
                        decoration: const InputDecoration.collapsed(
                            hintText: 'Search for Styles'),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

               Text(
                'Trending Styles',
                style:  GoogleFonts.montserrat(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 16),

              // List of Styles
              Obx(

                ()=>home.isLoading.value?JumpingDotsScreen():home.trendingStyleSearch.value.isNotEmpty?
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: home.trendingStyleSearch.value.length??0,
                  itemBuilder: (context, index) {
                    // final style = styles[index];
                    return InkWell(
                      onTap: (){
                        // print(home.trendingStylemodel.value.data?.trendingStyle?[index].bannerId??"");
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>TrendingstyleDetailsSccreen(data: home.trendingStyleSearch.value[index].bannerId??"",)));
                        
                      },
                      child: Container(
                        //  height: 104.h,
                                // width: 70.w,
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                "${AppUrl.imageApi}${home.trendingStyleSearch.value[index].image??""}",
                                height: 82.h,
                                width: 82.h,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                    return Image.asset("assets/image/no_image.png",fit: BoxFit.cover,);
                                  },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    home.trendingStyleSearch.value[index].bannerTitle??"",
                                    style:   GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp),
                                  ),
                                  // const SizedBox(height: 4),
                                  SizedBox(
                                    // height: 40.h,
                                    width: double.infinity,
                                    child: Html(
                                              data: home.trendingStyleSearch.value[index].description??"",
                                               shrinkWrap: true,
                                              style: {
                                                  "*": Style(
                                                    margin: Margins.zero,
                                                    padding: HtmlPaddings.zero,
                                                    fontFamily: GoogleFonts.montserrat().fontFamily,
                                                  ),
                                                    "html": Style(
                                                      margin: Margins.zero,
                                                      padding: HtmlPaddings.zero,
                                                      fontFamily: GoogleFonts.montserrat().fontFamily,
                                                    ),
                                                    "body": Style(
                                                      // maxLines: 2,
                                                      margin: Margins.zero,
                                                      padding: HtmlPaddings.zero,
                                                      fontFamily: GoogleFonts.montserrat(fontSize: 14.sp).fontFamily,
                                                    ),
                                                  "h1": Style(
                                                    
                                                      fontSize: FontSize(16.sp),
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.teal,
                                                      textAlign: TextAlign.center,
                                                      // fontFamily: 'Arial',
                                                      margin: Margins.zero,       // Remove default margin
                                                      padding: HtmlPaddings.zero, // Remove default padding
                                                      fontFamily: GoogleFonts.montserrat().fontFamily,
                                                    ),
                                                    "h3": Style(
                                                      fontSize: FontSize(15.sp),
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.black87,
                                                      margin: Margins.zero,
                                                      padding: HtmlPaddings.zero,
                                                      fontFamily: GoogleFonts.montserrat().fontFamily,
                                                    ),
                                                    "p": Style(
                                                      maxLines: 2,
                                                      textOverflow: TextOverflow.ellipsis,
                                                      fontSize: FontSize(14.sp),
                                                      color: Colors.black,
                                                      // fontFamily: 'Roboto',
                                                      // lineHeight: LineHeight(1.5),
                                                      margin: Margins.zero,
                                                      padding: HtmlPaddings.zero,
                                                      fontFamily: GoogleFonts.montserrat(fontSize: 14.sp).fontFamily,
                                                    ),
                                                    "ul": Style(
                                                      margin: Margins.symmetric(vertical: 0), // Adjust margin as needed
                                                      padding: HtmlPaddings(left: HtmlPadding(20)),
                                                      fontFamily: GoogleFonts.montserrat().fontFamily,
                                                    ),
                                                    "li": Style(
                                                      fontSize: FontSize(16),
                                                      color: Colors.black,
                                                      // fontFamily: 'Roboto',
                                                      margin: Margins.zero,
                                                      padding: HtmlPaddings.zero,
                                                      fontFamily: GoogleFonts.montserrat().fontFamily,
                                                    ),
                                                    "span": Style(
                                                      fontSize: FontSize(16),
                                                      color: Colors.black,
                                                      margin: Margins.zero,
                                                      padding: HtmlPaddings.zero,
                                                      fontFamily: GoogleFonts.montserrat().fontFamily,
                                                    ),
                                                    "strong": Style(
                                                      fontWeight: FontWeight.bold,
                                                      margin: Margins.zero,
                                                      padding: HtmlPaddings.zero,
                                                      fontFamily: GoogleFonts.montserrat().fontFamily,
                                                    ),
                                                    "em": Style(
                                                      fontStyle: FontStyle.italic,
                                                      margin: Margins.zero,
                                                      padding: HtmlPaddings.zero,
                                                      fontFamily: GoogleFonts.montserrat().fontFamily,
                                                    ),
                                              },
                                            ),
                                  ),
                                  
                                  // Text(
                                  //   home.trendingStyleSearch.value[index].description??"",
                                  //   style: const TextStyle(fontSize: 13),
                                  //   maxLines: 2,
                                  //   overflow: TextOverflow.ellipsis,
                                  // ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${DateFormat('hh:MM a').format(DateTime.parse(home.trendingStyleSearch.value[index].createdDate??"")) } | ${DateFormat('dd MMM, yyyy').format(DateTime.parse(home.trendingStyleSearch.value[index].createdDate??""))}',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12.sp, color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ):
               ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: home.trendingStylemodel.value.data?.trendingStyle?.length??0,
                  itemBuilder: (context, index) {
                    // final style = styles[index];
                    return InkWell(
                      onTap: (){
                        // print(home.trendingStylemodel.value.data?.trendingStyle?[index].bannerId??"");
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>TrendingstyleDetailsSccreen(data: home.trendingStylemodel.value.data?.trendingStyle?[index].bannerId??"",)));
                        
                      },
                      child: Container(
                        //  height: 104.h,
                                // width: 70.w,
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                "${AppUrl.imageApi}${home.trendingStylemodel.value.data?.trendingStyle?[index].image??""}",
                                height: 82.h,
                                width: 82.h,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                    return Image.asset("assets/image/no_image.png",fit: BoxFit.cover,);
                                  },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    home.trendingStylemodel.value.data?.trendingStyle?[index].bannerTitle??"",
                                    style:   GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp),
                                  ),
                                  // const SizedBox(height: 4),
                                  SizedBox(
                                    // height: 40.h,
                                    width: double.infinity,
                                    child: Html(
                                              data: home.trendingStylemodel.value.data?.trendingStyle?[index].description??"",
                                               shrinkWrap: true,
                                              style: {
                                                  "*": Style(
                                                    margin: Margins.zero,
                                                    padding: HtmlPaddings.zero,
                                                    fontFamily: GoogleFonts.montserrat().fontFamily,
                                                  ),
                                                    "html": Style(
                                                      margin: Margins.zero,
                                                      padding: HtmlPaddings.zero,
                                                      fontFamily: GoogleFonts.montserrat().fontFamily,
                                                    ),
                                                    "body": Style(
                                                      // maxLines: 2,
                                                      margin: Margins.zero,
                                                      padding: HtmlPaddings.zero,
                                                      fontFamily: GoogleFonts.montserrat(fontSize: 14.sp).fontFamily,
                                                    ),
                                                  "h1": Style(
                                                    
                                                      fontSize: FontSize(16.sp),
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.teal,
                                                      textAlign: TextAlign.center,
                                                      // fontFamily: 'Arial',
                                                      margin: Margins.zero,       // Remove default margin
                                                      padding: HtmlPaddings.zero, // Remove default padding
                                                      fontFamily: GoogleFonts.montserrat().fontFamily,
                                                    ),
                                                    "h3": Style(
                                                      fontSize: FontSize(15.sp),
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.black87,
                                                      margin: Margins.zero,
                                                      padding: HtmlPaddings.zero,
                                                      fontFamily: GoogleFonts.montserrat().fontFamily,
                                                    ),
                                                    "p": Style(
                                                      maxLines: 2,
                                                      textOverflow: TextOverflow.ellipsis,
                                                      fontSize: FontSize(14.sp),
                                                      color: Colors.black,
                                                      // fontFamily: 'Roboto',
                                                      // lineHeight: LineHeight(1.5),
                                                      margin: Margins.zero,
                                                      padding: HtmlPaddings.zero,
                                                      fontFamily: GoogleFonts.montserrat(fontSize: 14.sp).fontFamily,
                                                    ),
                                                    "ul": Style(
                                                      margin: Margins.symmetric(vertical: 0), // Adjust margin as needed
                                                      padding: HtmlPaddings(left: HtmlPadding(20)),
                                                      fontFamily: GoogleFonts.montserrat().fontFamily,
                                                    ),
                                                    "li": Style(
                                                      fontSize: FontSize(16),
                                                      color: Colors.black,
                                                      // fontFamily: 'Roboto',
                                                      margin: Margins.zero,
                                                      padding: HtmlPaddings.zero,
                                                      fontFamily: GoogleFonts.montserrat().fontFamily,
                                                    ),
                                                    "span": Style(
                                                      fontSize: FontSize(16),
                                                      color: Colors.black,
                                                      margin: Margins.zero,
                                                      padding: HtmlPaddings.zero,
                                                      fontFamily: GoogleFonts.montserrat().fontFamily,
                                                    ),
                                                    "strong": Style(
                                                      fontWeight: FontWeight.bold,
                                                      margin: Margins.zero,
                                                      padding: HtmlPaddings.zero,
                                                      fontFamily: GoogleFonts.montserrat().fontFamily,
                                                    ),
                                                    "em": Style(
                                                      fontStyle: FontStyle.italic,
                                                      margin: Margins.zero,
                                                      padding: HtmlPaddings.zero,
                                                      fontFamily: GoogleFonts.montserrat().fontFamily,
                                                    ),
                                              },
                                            ),
                                  ),
                                  
                                  // Text(
                                  //   home.trendingStylemodel.value.data?.trendingStyle?[index].description??"",
                                  //   style: const TextStyle(fontSize: 13),
                                  //   maxLines: 2,
                                  //   overflow: TextOverflow.ellipsis,
                                  // ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${DateFormat('hh:MM a').format(DateTime.parse(home.trendingStylemodel.value.data?.trendingStyle?[index].createdDate??"")) } | ${DateFormat('dd MMM, yyyy').format(DateTime.parse(home.trendingStylemodel.value.data?.trendingStyle?[index].createdDate??""))}',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12.sp, color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

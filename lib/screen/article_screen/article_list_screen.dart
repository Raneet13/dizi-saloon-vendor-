import 'package:dizisalon_vender/data/app_url.dart';
import 'package:dizisalon_vender/screen/article_screen/article_details_sccreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../view_model/home_viewmodel.dart';
import '../loading_screen/loading_screen.dart';

class ArticleListScreen extends StatefulWidget {
  const ArticleListScreen({super.key});

  @override
  State<ArticleListScreen> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
    final home = Get.find<HomeViewmodel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
          home.latestArticle();
    });

  }
  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // title: const Text("Latest Article"),
        actions: [
 Image.asset("assets/image/splash_logo.png",height: 32.h,fit: BoxFit.cover,),
 SizedBox(width: 16.w,)
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                        onChanged: (val){
                          home.searchblogtyle(search: val);
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
                'Latest Articles',
                style: GoogleFonts.montserrat(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 16),

              // List of Styles
              Obx(

                ()=>home.isLoading.value?JumpingDotsScreen():
                home.latestblogSearch.value.isNotEmpty?
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: home.latestblogSearch.value.length??0,
                  itemBuilder: (context, index) {
                    // final style = styles[index];
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticleDetailsSccreen(data: home.latestblogSearch.value[index].blogId??"",)));
                        
                      },
                      child: Container(
                        // height: 104.h,
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
                                "${AppUrl.imageApi}${home.latestblogSearch.value[index].image??""}",
                                height: 82.h,
                              width: 82.h,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    home.latestblogSearch.value[index].name??"",
                                    style:  GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  // const SizedBox(height: 4),
                                  SizedBox(
                                    // height: 40.h,
                                    child: Html(
                                              data: home.latestblogSearch.value[index].message??"",
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
                                                      fontFamily: GoogleFonts.montserrat().fontFamily,
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
                                                      // fontSize: FontSize(1.sp),
                                                      color: Colors.black,
                                                      // fontFamily: 'Roboto',
                                                      // lineHeight: LineHeight(1.5),
                                                      margin: Margins.zero,
                                                      padding: HtmlPaddings.zero,
                                                      fontFamily: GoogleFonts.montserrat(fontSize: 12.sp).fontFamily,
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
                                  //   home.latestblogSearch.value[index].message??"",
                                  //   style: const TextStyle(fontSize: 13),
                                  //   maxLines: 2,
                                  //   overflow: TextOverflow.ellipsis,
                                  // ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${DateFormat('hh:MM a').format(DateTime.parse(home.latestblogSearch.value[index].createdAt??"")) } | ${DateFormat('dd MMM, yyyy').format(DateTime.parse(home.latestblogSearch.value[index].createdAt??""))}',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12, color: Colors.grey[600]),
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
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: home.latestArticlemodel.value.data?.latestArticles?.length??0,
                  itemBuilder: (context, index) {
                    // final style = styles[index];
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticleDetailsSccreen(data: home.latestArticlemodel.value.data?.latestArticles?[index].blogId??"",)));
                        
                      },
                      child: Container(
                        // height: 104.h,
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
                                "${AppUrl.imageApi}${home.latestArticlemodel.value.data?.latestArticles?[index].image??""}",
                                height: 82.h,
                              width: 82.h,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    home.latestArticlemodel.value.data?.latestArticles?[index].name??"",
                                    style:  GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  // const SizedBox(height: 4),
                                  SizedBox(
                                    // height: 40.h,
                                    child: Html(
                                              data: home.latestArticlemodel.value.data?.latestArticles?[index].message??"",
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
                                                      fontFamily: GoogleFonts.montserrat().fontFamily,
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
                                                      // fontSize: FontSize(1.sp),
                                                      color: Colors.black,
                                                      // fontFamily: 'Roboto',
                                                      // lineHeight: LineHeight(1.5),
                                                      margin: Margins.zero,
                                                      padding: HtmlPaddings.zero,
                                                      fontFamily: GoogleFonts.montserrat(fontSize: 12.sp).fontFamily,
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
                                  //   home.latestArticlemodel.value.data?.latestArticles?[index].message??"",
                                  //   style: const TextStyle(fontSize: 13),
                                  //   maxLines: 2,
                                  //   overflow: TextOverflow.ellipsis,
                                  // ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${DateFormat('hh:MM a').format(DateTime.parse(home.latestArticlemodel.value.data?.latestArticles?[index].createdAt??"")) } | ${DateFormat('dd MMM, yyyy').format(DateTime.parse(home.latestArticlemodel.value.data?.latestArticles?[index].createdAt??""))}',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12, color: Colors.grey[600]),
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

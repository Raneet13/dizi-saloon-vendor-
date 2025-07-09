import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/cms_model.dart';

class DetialsOfDocument extends StatelessWidget {
     BarbarKyc? details;
   DetialsOfDocument({required this.details, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${details?.pageName??""}",style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 12,right: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text("${details?.details??""}"),
            Html(
          data: details?.details??"",
          style: {
            "*":Style(
              margin: Margins.zero,
                                                    padding: HtmlPaddings.zero,
                                                    fontFamily: GoogleFonts.montserrat().fontFamily,
            ),
            "h1": Style(
              fontSize: FontSize(28),
              fontWeight: FontWeight.bold,
              color: Colors.teal,
              textAlign: TextAlign.center,
              fontStyle: GoogleFonts.montserrat().fontStyle,
            ),
            "h3": Style(
              fontSize: FontSize(20.sp),
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontStyle: GoogleFonts.montserrat().fontStyle,
            ),
            "p": Style(
              fontSize: FontSize(14.sp),
              color: Colors.black,
              // fontFamily: 'Roboto',
              fontStyle: GoogleFonts.montserrat().fontStyle,
              
              // lineHeight: LineHeight(1.5),
            ),
            "ul": Style(
              margin: Margins.symmetric(vertical: 10),
              padding: HtmlPaddings(left: HtmlPadding(20))
              // margin: EdgeInsets.symmetric(vertical: 10),
              // padding: EdgeInsets.only(left: 20),
            ),
            "li": Style(
              fontSize: FontSize(16),
              color: Colors.black,
              fontStyle: GoogleFonts.montserrat().fontStyle,
            ),
            "span": Style(
              fontSize: FontSize(16),
              color: Colors.black,
              fontStyle: GoogleFonts.montserrat().fontStyle,
            ),
            "strong": Style(
              fontWeight: FontWeight.bold,
              fontStyle: GoogleFonts.montserrat().fontStyle,
            ),
            "em": Style(
              // fontStyle: FontStyle.italic,
              fontStyle: GoogleFonts.montserrat().fontStyle,
            ),
          },
        ),
     
          ],
        ),
      ),
    );
  }
}
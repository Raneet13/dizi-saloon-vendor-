import 'package:dizisalon_vender/size_config.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/app_url.dart';
import '../../../model/home_model.dart';
import '../../article_screen/article_details_sccreen.dart';
import '../../article_screen/article_list_screen.dart';
import '../../trendingstyle_screen/trendingstyle_details_sccreen.dart';
import '../../trendingstyle_screen/trendingstyle_list_screen.dart';

class showListwidget extends StatefulWidget {
  final String title;
  final List<AddDtl>? item;
  final BuildContext contextFromParent;
  final String page;

  const showListwidget({
    required this.title,
    required this.item,
    required this.contextFromParent,
    required this.page,
    Key? key,
  }) : super(key: key);

  @override
  State<showListwidget> createState() => _ShowListWidgetState();
}

class _ShowListWidgetState extends State<showListwidget> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;
  final double _itemWidth =  1.sw; // 150 width + 8px margin left & right

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      int newIndex = (offset / _itemWidth).round();

      if (_currentIndex != newIndex) {
        setState(() {
          _currentIndex = newIndex;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 8.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style:  GoogleFonts.montserrat(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              TextButton(
                style:TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap
                ),
                onPressed: () {
                  // if (widget.page == "trending") {
                    Navigator.push(
                      widget.contextFromParent,
                      MaterialPageRoute(builder: (context) => TrendingStylesScreen()),
                    );
                  // } else {
                  //   Navigator.push(
                  //     widget.contextFromParent,
                  //     MaterialPageRoute(builder: (context) => ArticleListScreen()),
                  //   );
                  // }
                },
                child:  Text("Show More", style:  GoogleFonts.montserrat(color: const Color(0xFF002B5B),fontSize: 14.sp,fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 145.h,
          width: double.infinity,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: widget.item?.length ?? 0,
            padding: const EdgeInsets.only(left: 16),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return  InkWell(
                        onTap: (){
                      //  print(widget.item?[index].bannerId??"");
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>TrendingstyleDetailsSccreen(data: widget.item?[index].bannerId??"",)));
                  
                         
                          
                        },
                child: Container(
                  margin:  EdgeInsets.only(right: 8.r),
                  // height:  SizeConfig.blockHeight * 14,
                  width:  140.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12.r),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("${AppUrl.imageApi}${widget.item?[index].image ?? ""}"),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Center(
          child:widget.item==null?SizedBox(): DotsIndicator(
            dotsCount:(widget.item!.length / 3).ceil(),//widget.item!.length%3==0?(widget.item!.length / 3).ceil(): (widget.item!.length-1 / 2).ceil(),
            position: _currentIndex.toDouble(),
            decorator: DotsDecorator(
              size:  Size.square(9.0.r),
              activeSize:  Size(16.0.w, 6.0.h),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

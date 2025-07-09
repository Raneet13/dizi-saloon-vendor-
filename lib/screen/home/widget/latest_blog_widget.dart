import 'package:dizisalon_vender/size_config.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/app_url.dart';
import '../../../model/home_model.dart';
import '../../article_screen/article_details_sccreen.dart';
import '../../article_screen/article_list_screen.dart';
import '../../trendingstyle_screen/trendingstyle_list_screen.dart';

class LatestBlogWidget extends StatefulWidget {
  final String title;
  final List<BlogDtl>? item;
  final BuildContext contextFromParent;
  final String page;

  const LatestBlogWidget({
    required this.title,
    required this.item,
    required this.contextFromParent,
    required this.page,
    Key? key,
  }) : super(key: key);

  @override
  State<LatestBlogWidget> createState() => _LatestBlogWidgetState();
}

class _LatestBlogWidgetState extends State<LatestBlogWidget> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;
  final double _itemWidth = 1.sw; // 150 width + 8px margin left & right

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
                style:  GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextButton(
                style:TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap
                ),
                onPressed: () {
                  // if (widget.page == "trending") {
                  //   Navigator.push(
                  //     widget.contextFromParent,
                  //     MaterialPageRoute(builder: (context) => TrendingStylesScreen()),
                  //   );
                  // } else {
                    Navigator.push(
                      widget.contextFromParent,
                      MaterialPageRoute(builder: (context) => ArticleListScreen()),
                    );
                  // }
                },
                child:  Text("Show More", style:  GoogleFonts.montserrat(color: const Color(0xFF002B5B),fontSize: 14.sp,fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100.h,
          // width: double.infinity,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: widget.item?.length ?? 0,
            padding: const EdgeInsets.only(left: 16),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                        onTap: (){
                       
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticleDetailsSccreen(data: widget.item?[index].blogId??"",)));
                  
                         
                          
                        },
                child: Container(
                  margin:  EdgeInsets.only(right: 8.r),
                  // height: SizeConfig.blockHeight * 0,
                  width:100.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
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
            dotsCount:(widget.item!.length / 4).ceil(), //widget.item!.length%2==0?(widget.item!.length / 2).ceil(): (widget.item!.length-1 / 2).ceil(),
            position: _currentIndex.toDouble(),
            decorator: DotsDecorator(
              size:  Size.square(9.0.r),
              activeSize:  Size(10.0.w, 8.0.h),
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

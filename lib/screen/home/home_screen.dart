import 'package:dizisalon_vender/data/app_url.dart';
import 'package:dizisalon_vender/screen/home/widget/ads_slider_widget.dart';
import 'package:dizisalon_vender/screen/home/widget/latest_blog_widget.dart';
import 'package:dizisalon_vender/screen/home/widget/trending_blog_widget.dart';
import 'package:dizisalon_vender/screen/home/widget/your_salon_widget.dart';
import 'package:dizisalon_vender/size_config.dart';
import 'package:dizisalon_vender/view_model/home_viewmodel.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/home_model.dart';
import '../article_screen/article_list_screen.dart';
import '../loading_screen/loading_screen.dart';
import '../notification/notification_sccreen.dart';
import '../profile/profile_details_screen.dart';
import '../trendingstyle_screen/trendingstyle_list_screen.dart';
import 'widget/home_slider.dart';
import 'widget/kyc_submit_widget.dart';
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //  HomeScreen({super.key}) : super();
  final home = Get.find<HomeViewmodel>();
   
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
   WidgetsBinding.instance.addPostFrameCallback((_) {
      home..home()
      ..
    cmsArticle();
    });
  }

  @override
  Widget build(BuildContext context) {
      SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   actions: [
      //     Image.asset("assets/image/splash_logo.png")
      //   ],
      // ),
      body: NestedScrollView(
         headerSliverBuilder: (context, innerBoxIsScrolled) {
    return [
      SliverAppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          children: [
             Obx(()=> home.isLoading.value?SizedBox(height: 20,width: 20, child: Center(child: CircularProgressIndicator(),)):   InkWell(
              onTap: (){
                 Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  ProfileDetailScreen(),
                              ),
                            );
              },
               child: CircleAvatar(
                radius: 16.r,
                            backgroundImage:home.homemodel.value.messages?.data?.loginUser?.logoImage==null?AssetImage("assets/image/userimage.png"):  NetworkImage('${AppUrl.imageApi}${home.homemodel.value.messages?.data?.loginUser?.logoImage??""}'), // Replace with actual image
                          ),
             )),
                        // SizedBox(width: 20,),
                        IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
                        }, icon: Icon(Icons.notifications_outlined,size: 24.sp,color: Colors.grey,))
                        
          ],
        ),
        floating: true,
        snap: false,

        // expandedHeight: 50,
        // flexibleSpace: FlexibleSpaceBar(
        //   background: Image.network(
        //     'https://picsum.photos/1200/800',
        //     fit: BoxFit.cover,
        //   ),
        // ),
        actions: [
          Image.asset("assets/image/splash_logo.png",height: 28.h,fit: BoxFit.cover,),
          SizedBox(width: 16,)
        ],
      ),
    ];
  },
        body: SingleChildScrollView(
          // child: JumpingDotsScreen(),
          child: Obx(
            ()=>home.isLoading.value?JumpingDotsScreen(): Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 16.0.r),
                  child:Text.rich(
                              TextSpan(
                                text: "Hi,",
                                style: GoogleFonts.montserrat(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: home.homemodel.value.messages?.data?.loginUser?.fullName??"",
                                    style: GoogleFonts.montserrat(fontSize: 18, color: Colors.grey.shade600,fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                  )
                  //  Text(
                  //               "${home.homemodel.value.messages?.data?.loginUser?.fullName??""}",
                  //               style: GoogleFonts.openSans(fontSize: 18, color: Colors.grey),
                  //             ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16,top: 4),
                  child: HomeSlider(bannerDtl: home.homemodel.value.messages?.data?.bannerDtl??[],)
                   ),
               home.homemodel.value.messages?.data?.reciveOrder !=true? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Let's do KYC and List your Salon",
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ):Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Your Salon",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
               home.homemodel.value.messages?.data?.reciveOrder !=true? Padding(
                  padding: const EdgeInsets.symmetric(horizontal:  16.0,vertical: 4),
                  child: KYCWidget(saalon: home.homemodel.value.messages?.data?.loginUser,)
                  ):
                   Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SalonDetailsCard()
                  ),
                  showListwidget(title: "Trending Style’s", item: home.homemodel.value.messages?.data?.trendingStyle,contextFromParent: context,page:  "trending"),
                   LatestBlogWidget(title:"Latest Articles",item:home.homemodel.value.messages?.data?.blogDtl,contextFromParent:context,page:"latest"),
                   Padding(
                     padding: const EdgeInsets.only(left:  16.0),
                     child: Text("Ads",  style:  GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                   ),
                     Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AdsSliderWidget(bannerDtl: home.homemodel.value.messages?.data?.addDtl??[],)
                   ),
              ],
            ),
          ),
        
        ),
      ),
    );
  }
}
 
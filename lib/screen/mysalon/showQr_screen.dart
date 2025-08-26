import 'package:dizisalon_vender/view_model/salon_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../model/cms_model.dart';

class ShowqrScreen extends StatefulWidget {
  String orderId;
  String customerName;
  bool singleback;

  ShowqrScreen({required this.orderId,required this.customerName,required this.singleback, super.key});
  @override
  State<ShowqrScreen> createState() => _ShowqrScreenState();
}

class _ShowqrScreenState extends State<ShowqrScreen> {
  //    String? details;
   final salon = Get.find<SalonViewmodel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      salon.generateQr(orderId: widget.orderId,customerName: widget.customerName);
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<SalonViewmodel>().allOrderList();
       if(widget.singleback){
        Navigator.pop(context);
       }else{
        Navigator.pop(context);
        Navigator.pop(context);
       }
        
        return false; 
      },
      
      child: Scaffold(
        appBar: AppBar(
          title: Text("QR Code"),
          leading: InkWell(
            onTap: (){
              Get.find<SalonViewmodel>().allOrderList();
                     if(widget.singleback){
                    Navigator.pop(context);
                  }else{
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
            },
            child: Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 12,right: 12),
          child: Obx(
            ()=> Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text("${details?.details??""}"),
                Html(
              data: salon.qrhtml.value,
              style: {
                "h1": Style(
                  fontSize: FontSize(28),
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                  textAlign: TextAlign.center,
                  fontFamily: 'Arial',
                ),
                "h3": Style(
                  fontSize: FontSize(20),
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                "p": Style(
                  fontSize: FontSize(16),
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  lineHeight: LineHeight(1.5),
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
                  fontFamily: 'Roboto',
                ),
                "span": Style(
                  fontSize: FontSize(16),
                  color: Colors.black,
                ),
                "strong": Style(
                  fontWeight: FontWeight.bold,
                ),
                "em": Style(
                  fontStyle: FontStyle.italic,
                ),
                
              },
              
            ),
                 
              ],
            ),
          ),
        ),
      
      ),
    );
  }
}
import 'package:dizisalon_vender/screen/order/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view_model/salon_viewmodel.dart';
import '../loading_screen/loading_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
    final salon = Get.find<SalonViewmodel>();
  //  final home = Get.find<HomeViewmodel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    salon.allOrderList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Order List"),
        automaticallyImplyLeading: false
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Obx(
          ()=>salon.isLoading.value?JumpingDotsScreen(): RefreshIndicator(
            onRefresh: ()async{
              salon.allOrderList();
            },
            child: ListView(
              
              children: [
               
                SizedBox(height: 16),
                Expanded(
                  child: salon.allOrderlist.value.messages?.appointments?.orderList?.length==0?Center(child: Text("No Booking"),):
                  salon.allOrderlist.value.messages?.appointments?.orderList?.length==0?Center(child: Text("No Booking"),):
                   ListView.builder(
                    shrinkWrap: true,
                    itemCount: salon.allOrderlist.value.messages?.appointments?.orderList?.length??0,
                    itemBuilder: (context, index) {
                      var orderItem = salon.allOrderlist.value.messages?.appointments?.orderList?[index];
                     return BookingItem(
                      orderItem: orderItem,
                              // indicatorColor: Colors.green,
                            );
                      },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

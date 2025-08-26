import 'package:dizisalon_vender/view_model/salon_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../model/all_review_model.dart';

class FeedbackScreen extends StatefulWidget {
   FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
final review = Get.find<SalonViewmodel>();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
     review.allreviewList();
  });
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Feedback',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        ()=>review.centerallReview.value.messages==null?Center(child: CircularProgressIndicator(),): Padding(
          padding: const EdgeInsets.all(16.0),
          child:review.centerallReview.value.messages?.reviews?.length==0?Center(child:Text("No Reviews"),): GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              // childAspectRatio: 3 / 4.5,
            ),
            itemCount: review.centerallReview.value.messages?.reviews?.length, // Number of feedback cards
            itemBuilder: (context, index) {
              return FeedbackCard(reviewDetails: review.centerallReview.value.messages?.reviews?[index],);
            },
          ),
        ),
      ),
    );
  }
}

class FeedbackCard extends StatelessWidget {
  Review? reviewDetails;
   FeedbackCard({required this.reviewDetails, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile picture
            // CircleAvatar(
            //   radius: 30,
            //   backgroundImage: AssetImage('assets/images/user_placeholder.png'),
            // ),
            // const SizedBox(height: 8),
            // Name
             Text(
              "${reviewDetails?.senderName??""}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            // Star rating
            RatingBarIndicator(
    rating:double.parse(reviewDetails?.rating??"0") ,
    itemBuilder: (context, index) => Icon(
         Icons.star,
         color: Colors.amber,
    ),
    itemCount: 5,
    itemSize: 15.0,
    direction: Axis.horizontal,
),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: const [
            //     Icon(Icons.star, color: Colors.amber, size: 18),
            //     Icon(Icons.star, color: Colors.amber, size: 18),
            //     Icon(Icons.star, color: Colors.amber, size: 18),
            //     Icon(Icons.star_border, color: Colors.amber, size: 18),
            //     Icon(Icons.star_border, color: Colors.amber, size: 18),
            //   ],
            // ),
            const SizedBox(height: 8),
            // Feedback text
             Text(
              "${reviewDetails?.review??""}",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            // const Spacer(),
            // // Reply button
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Handle reply button press
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.blue.shade900,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //     ),
            //     child: const Text("Reply"),
            //   ),
            // ),
          
          ],
        ),
      ),
    );
  }
}
import 'package:dizisalon_vender/static/app_color.dart';
import 'package:flutter/material.dart';

Widget customElevatedButton(
    {required BuildContext context,
    required String buttonname,
    Function()? onpressed}) {
  return Container(
      height: 48,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colo.primaryColor,
        // gradient: LinearGradient(
        //   colors: [
        //     // Color(0xFFE6D0AE),
        //     Colo.primaryColor,
        //     Colo.white,
        //     // Color(0xFFD1AE7E)
        //     // A secondary color for the gradient
        //   ],
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   // stops: [0.5, 1.0],
        // ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: onpressed,
        child: Text("${buttonname ?? ""}",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),),
      ));
}

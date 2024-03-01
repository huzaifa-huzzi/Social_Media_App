import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:tech_media/res/color.dart';



class RoundButton extends StatelessWidget {
 final  String title;
  bool loading ;
  final VoidCallback ontap;
   RoundButton({super.key,required this.title,required this.ontap,this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50,
        width: 350,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: loading ?const LoadingIndicator(indicatorType:Indicator.ballClipRotate,colors: [Colors.white],) :  Center(child: Text(title,style: TextStyle(fontSize: 22,color: AppColors.whiteColor,fontWeight: FontWeight.w500),),),
      ),
    );
  }
}

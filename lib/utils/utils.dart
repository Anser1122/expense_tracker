import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../colors.dart';

class Utils{

  String fontFamily = 'Poppins';


  gradientDecoration()
  {
    return  const BoxDecoration(
        gradient:  LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:[
              AppColors.purpleGradient,
              AppColors.pinkGradient,
            ])
    );
  }
  blurGradientDecoration()
  {
    return const BoxDecoration(
        gradient:  LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:[
              AppColors.blurPurpleGradient,
              AppColors.blurPinkGradient,
            ])
    );
  }
  darkBlurGradientDecoration()
  {
    return const BoxDecoration(
        gradient:  LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:[
              AppColors.blurDarkPurpleGradient,
              AppColors.blurPinkGradient,
            ])
    );
  }

  poppinsSemiBoldText(text, size, color, textAlign) {
    return Text(
      text,
      textAlign: textAlign,

      style: TextStyle(color: color,
          fontFamily: fontFamily,
          fontSize: size, fontWeight: FontWeight.w700),
    );
  }

  poppinsRegularText(text, size, color, textAlign,{maxlines}) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxlines,
      style: TextStyle(color: color, fontSize: size,
          fontFamily:fontFamily,fontWeight: FontWeight.normal),
    );
  }


  poppinsBoldText(text, size, color, textAlign) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(color: color, fontSize: size, fontFamily: fontFamily,  fontWeight: FontWeight.w900),
    );
  }

  poppinsMediumText(text, size, color, textAlign,{maxlines}) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines:maxlines ,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: color, fontSize: size,  fontFamily: fontFamily,fontWeight: FontWeight.w500),
    );
  }

  textFieldWithoutIconWithoutBorder(controller, hint, hintColor,inputType,{maxlines}) {
    return Container(
      height: 55,
      child:
      TextFormField(
        keyboardType: inputType,
        textCapitalization: TextCapitalization.sentences,
        controller: controller,
        decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: 14,color: hintColor,fontFamily: fontFamily,fontWeight: FontWeight.normal),
            hintText: hint,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            contentPadding: EdgeInsets.only(left: 8,right: 8)
        ),
      ),
    );
  }

  textFieldWithoutIconWithoutBorderSuffix(controller, hint, hintColor,inputType,icon,suffixIcon,onTap,obsecureText) {
    return Container(
      height: 55,
      child:
      TextFormField(
        keyboardType: inputType,
        controller: controller,
        obscureText: obsecureText,
        decoration: InputDecoration(
          // prefixIcon:  Icon(icon,size: 23,),
            suffixIcon: InkWell(
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.only(left: 15,right: 15,top: 27,bottom: 8),
                child: SvgPicture.asset(suffixIcon,height: 30,width: 30,
                ),
              ),
            ),
            hintStyle: TextStyle(fontSize: 14,color: hintColor,fontFamily: fontFamily,fontWeight: FontWeight.normal),
            hintText: hint,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            contentPadding: EdgeInsets.only(top: 20,left: 8)
        ),
      ),
    );
  }
  orangePinkGradientDecoration( radious)
  {
    return  BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radious)),
        gradient:  const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors:[
              AppColors.pinkGradientWithOrange,
              AppColors.orangeGradient,
            ])
    );
  }

  rectangleBoxForServices(radious,color)
  {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radious),
      color: color,
    );
  }

  rectangleBoxWithoutElevation(radious,color)
  {
    return BoxDecoration(
      border: Border(
        //top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
        bottom: BorderSide(width: 1.0, color: Colors.grey),
      ),
      color: Colors.white,
    );
  }

  showLoadingDialog()
  {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(backgroundColor: AppColors.pinkGradient,color:AppColors.purpleGradient,),
      ),
      barrierDismissible: false,
      useSafeArea: true,
    );
  }
  snackBar(String message)
  {
    Get.snackbar('Alert', message,duration: Duration(milliseconds: 3000)
        ,backgroundColor: AppColors.pinkGradient,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        icon: Icon(Icons.notification_important_outlined,color: Colors.white,));
  }



}
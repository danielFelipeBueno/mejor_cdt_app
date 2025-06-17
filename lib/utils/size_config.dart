import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:io';
class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static double? aspectRatio;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    aspectRatio = _mediaQueryData!.size.aspectRatio;
    orientation = _mediaQueryData!.orientation;
  }
}

double getProportionateScreenHeight(double inputHeight) {
  double? screenHeight = SizeConfig.screenHeight;
  return (inputHeight / 812.0) * screenHeight!;
}

double getProportionateScreenWidth(double inputWidth) {
  double? screenWidth = SizeConfig.screenWidth;
  return (inputWidth / 375.0) * screenWidth!;
}

double getCustomWidthSize(double size) {
  double? screenWidth = SizeConfig.screenWidth;
  return screenWidth! * size;
}

double getCustomHeightSize(double size) {
  double? screenHeight = SizeConfig.screenHeight;
  return screenHeight! * size;
}

double getTotalHeight(double size){
  double? screenHeight = SizeConfig.screenHeight;
  return screenHeight!*size;
}

double getAvailableHeight(double size){
  double deadZone = Platform.isAndroid
  ?0.97:getAspectRatio() > 0.5?0.97:0.89;
  double? screenHeight = SizeConfig.screenHeight;
  return (screenHeight!*deadZone) * size;
}

bool isMoreSquare()=>Platform.isIOS&&getAspectRatio()>0.5?true:false;


double getPaddingBottom(){
  return SizeConfig._mediaQueryData!.padding.bottom;
}

double getDiagonal(){
  return math.sqrt(math.pow(SizeConfig.screenWidth!, 2) +math.pow(SizeConfig.screenHeight!, 2));
}

double getAspectRatio(){
  return SizeConfig.aspectRatio!;
}

double getRelationScreen(){
  return SizeConfig.screenHeight!/SizeConfig.screenWidth!;
}
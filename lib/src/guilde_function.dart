import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'guide_model.dart';
import 'guide_page.dart';

///是否输出日志
///显示新手蒙版引导页面
///[context]当前上下文对象
///[globalKeyPointList] 需要引导的位置信息  List，GlobalKey widget 位置主键标识
///[TipsPointList] 需要引导的位置信息  List，
///   TipsPoint 中 x,y 指定指引位置 从0-1 ，手机屏幕左上角开始为（0，0）位置，右下角为(1,1)
///   TipsPoint tipsMessage 为引导框内显示的文字
/// [pointX][pointY]用来设定单点指引，当 [TipsPointList] 为 null 的时候起作用
/// [tipsTextColor] 气泡提示框的内容文字颜色
/// [clickCallback] 点击下一步的回调事件 参数 isEnd 为true 时表示最后一页指引
///

void showBeginnerGuidance(BuildContext context,
    {List<TipsPoint> tipsPointList,
    List<GlobalKeyPoint> globalKeyPointList,
    Function(bool isEnd) clickCallback}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,
      useRootNavigator: false,
      barrierColor: Color(0x00000000),
      builder: (BuildContext context) {
        return GuideSplashPage(
            globalKeyPointList: globalKeyPointList,
            tipsPointList: tipsPointList,
            clickCallback: clickCallback);
      });
}

void closeBeginnerGuidance(BuildContext context){
  Navigator.of(context).pop();
}
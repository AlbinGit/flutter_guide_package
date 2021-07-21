import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TipsAlign {
  topLeft,
  topCenter,
  topRight,
  centerLeft,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}

class TipsPoint {
  ///引导Widget坐标起始点x,y
  double x;
  double y;

  ///引导Widget宽高
  double eWidth;
  double eHeight;

  ///提示框位置
  TipsAlign tipsAlign;

  ///提示框宽度
  double tipsWidth;

  /// 边界安全距离
  double tipsSafePadding;

  /// 提示框背景颜色
  Color tipsBackGroundColor;

  ///引导框内显示的文字
  String tipsText;

  /// 提示文案颜色
  Color tipsTextColor;

  /// 提示文案字号
  double tipsTextSize;

  ///下一步文案
  String nextText;

  ///下一步文字大小
  double nextTextSize;

  ///下一步文字颜色
  Color nextTextColor;

  TipsPoint(this.x, this.y,
      {this.eWidth = 0,
      this.eHeight = 0,
      this.tipsAlign = TipsAlign.bottomRight,
      this.tipsWidth = 229,
      this.tipsSafePadding = 5,
      this.tipsBackGroundColor = const Color(0xb2000000),
      this.tipsText = "--",
      this.tipsTextColor = Colors.white,
      this.tipsTextSize = 14.0,
      this.nextText = "我知道了",
      this.nextTextSize = 14.0,
      this.nextTextColor = Colors.red});
}

class GlobalKeyPoint {
  ///widget 对应key 程序自动判断
  GlobalKey key;

  ///提示框位置
  TipsAlign tipsAlign;

  ///提示框宽度
  double tipsWidth;

  /// 边界安全距离
  double tipsSafePadding;

  /// 提示框背景颜色
  Color tipsBackGroundColor;

  ///引导框内显示的文字
  String tipsText;

  /// 提示文案颜色
  Color tipsTextColor;

  /// 提示文案字号
  double tipsTextSize;

  ///下一步文案
  String nextText;

  ///下一步文字大小
  double nextTextSize;

  ///下一步文字颜色
  Color nextTextColor;

  GlobalKeyPoint(this.key,
      {this.tipsAlign = TipsAlign.bottomRight,
      this.tipsWidth = 229,
      this.tipsSafePadding = 5,
      this.tipsBackGroundColor = const Color(0xb2000000),
      this.tipsText = "--",
      this.tipsTextColor = Colors.white,
      this.tipsTextSize = 14.0,
      this.nextText = "我知道了",
      this.nextTextSize = 14.0,
      this.nextTextColor = Colors.red});
}

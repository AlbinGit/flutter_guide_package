import 'package:flutter/material.dart';
import 'dart:async';

import 'guide_logs.dart';
import 'guide_model.dart';
import 'guide_painter.dart';

class GuideSplashPage extends StatefulWidget {
  ///需要引导的位置信息  List，GlobalKey widget 位置主键标识
  ///还是要转换成 List<TipsPoint>
  List<GlobalKeyPoint> globalKeyPointList;
  List<TipsPoint> tipsPointList;
  Function(bool isEnd) clickCallback;

  GuideSplashPage(
      {Key key,
      this.globalKeyPointList,
      this.tipsPointList,
      this.clickCallback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GuidePageState();
  }
}

class _GuidePageState extends State<GuideSplashPage> {
  ///当前可点击的下一步
  Rect nextRect;
  int currentPointIndex = 0;

  @override
  void initState() {
    super.initState();

    // 监听widget渲染完成
    // WidgetsBinding.instance.addPostFrameCallback((duration) {
    //   ///页面初始化完成后再构建数据
    //   controllerInitData();
    // });
  }

  void controllerInitData() {
    if ((widget.globalKeyPointList == null ||
            widget.globalKeyPointList.length == 0) &&
        (widget.tipsPointList == null || widget.tipsPointList.length == 0)) {
      widget.tipsPointList = [];
      widget.tipsPointList.add(TipsPoint(0, 0, tipsText: '--'));
    } else if (widget.globalKeyPointList != null &&
        widget.globalKeyPointList.length > 0) {
      widget.tipsPointList = [];

      ///获取当前屏幕的宽与高
      double screenWidth2 = MediaQuery.of(context).size.width;
      double screenHeight2 = MediaQuery.of(context).size.height;

      ///转换数据
      ///将 GlobalKeyPoint数据转为 TipsPoint 类型数据
      for (GlobalKeyPoint pointBean in widget.globalKeyPointList) {
        if (pointBean.key != null && pointBean.key.currentContext != null) {
          //获取position
          RenderBox renderBox = pointBean.key.currentContext.findRenderObject();

          ///获取 Offset
          Offset offset1 = renderBox.localToGlobal(Offset.zero);

          ///获取 Size
          //获取size
          Size size1 = renderBox.size;

          ///构建使用数据结构
          ///计算比例
          TipsPoint tipsPoint = TipsPoint(offset1.dx, offset1.dy,
              eWidth: size1.width,
              eHeight: size1.height,
              tipsAlign: pointBean.tipsAlign,
              tipsWidth: pointBean.tipsWidth,
              tipsGap: pointBean.tipsGap,
              tipsSafePadding: pointBean.tipsSafePadding,
              tipsBackGroundColor: pointBean.tipsBackGroundColor,
              tipsText: pointBean.tipsText,
              tipsTextColor: pointBean.tipsTextColor,
              tipsTextSize: pointBean.tipsTextSize,
              nextText: pointBean.nextText,
              nextTextSize: pointBean.nextTextSize,
              nextTextColor: pointBean.nextTextColor);
          widget.tipsPointList.add(tipsPoint);
          GuideLogs.e(
              "获取到的位置信息 dx ${offset1.dx}  dy  ${offset1.dy}  screenWidht $screenWidth2  screenHeight $screenHeight2 eWidth${size1.width} eHeight${size1.height}");
        } else {
          GuideLogs.e("空数据 ");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    controllerInitData();
    double padding = (MediaQuery.of(context).size.width / 9);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    ///在Flutter中通过WillPopScope来实现返回按钮拦截
    return GestureDetector(
      onTapUp: (TapUpDetails detail) {
        GuideLogs.e('onTapUp');
        onTap(context, detail);
      },
      child: Stack(
        children: <Widget>[
          buildCustomPainter(),
        ],
      ),
    );
  }

  ///用户计算下一步的点击事件
  void onTap(BuildContext context, TapUpDetails detail) {
    if (widget.tipsPointList == null) {
      Navigator.of(context).pop();
    }

    Offset globalPosition = detail.globalPosition;
    GuideLogs.e("onTapUp 点击了 ${globalPosition.dx}  ${globalPosition.dy}");
    if (nextRect != null) {
      ///获取当前 下一步的区域
      double left = nextRect.left;
      double right = nextRect.right;
      double bottom = nextRect.bottom;
      double top = nextRect.top;

      ///获取当前屏幕上手指点击的位置
      double dx = globalPosition.dx;
      double dy = globalPosition.dy;

      if (dx > left && dx < right && dy > top && dy < bottom) {
        if (currentPointIndex < widget.tipsPointList.length - 1) {
          ///如果当前不是最后一页面，那么取出下一页的内容信息
          setState(() {
            currentPointIndex++;
          });

          ///蒙版中点击下一步的回调事件
          if (widget.clickCallback != null) {
            widget.clickCallback(false);
          }
        } else {
          ///如果是最后一页退出蒙版引导
          if (widget.clickCallback != null) {
            widget.clickCallback(true);
          }
          Navigator.of(context).pop();
        }
      }
    }
  }

  ///记录下一步按钮位置的回调
  void liserClickCallback(Rect rect) {
    this.nextRect = rect;
  }

  Widget buildCustomPainter() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    if (widget.tipsPointList == null || widget.tipsPointList.length == 0) {
      return Container(
        height: height,
        width: width,
        color: Color(0x000000),
      );
    }

    ///获取当前指引信息
    TipsPoint tipsPoint = widget.tipsPointList[currentPointIndex];

    ///画布由CustomPaint小部件创建并提供
    return CustomPaint(
      size: Size(width, height),

      ///这是CustomPainter类的一个实例，它在画布上绘制绘画的第一层
      painter: MyCustomPainter(
        tipsPoint.x,
        tipsPoint.y,
        tipsPoint.tipsText,
        pointWidth: tipsPoint.eWidth,
        pointHeight: tipsPoint.eHeight,
        tipsTextColor: tipsPoint.tipsTextColor,
        tipsBackgroundColor: tipsPoint.tipsBackGroundColor,
        tipsTextSize: tipsPoint.tipsTextSize,
        nextTextTip: tipsPoint.nextText,
        nextTextColor: tipsPoint.nextTextColor,
        nextTextSize: tipsPoint.nextTextSize,
        tipsAlign: tipsPoint.tipsAlign,
        tipsWidth: tipsPoint.tipsWidth,
        tipsSafePadding: tipsPoint.tipsSafePadding,
        tipsGap: tipsPoint.tipsGap,
        clickLiser: liserClickCallback,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

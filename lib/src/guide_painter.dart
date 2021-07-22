import 'dart:ui' as ui; //这里用as取个别名，有库名冲突
import 'package:flutter/material.dart';

import 'guide_model.dart';

class MyCustomPainter extends CustomPainter {
  double pointX = 0;
  double pointY = 0;

  double pointWidth = 0;
  double pointHeight = 0;

  ///提示文字颜色
  Color tipsTextColor;

  ///提示文字背景颜色
  Color tipsBackgroundColor;

  ///提示文字内容
  String textTip;

  ///提示文字大小
  double tipsTextSize;

  ///提示框位置
  TipsAlign tipsAlign;

  ///下一步文字颜色
  Color nextTextColor;

  ///下一步背景颜色
  Color nextBackgroundColor;

  ///下一步文字
  String nextTextTip;

  ///下一步文字大小
  double nextTextSize;

  ///提示框宽度
  double tipsWidth;

  /// 边界安全距离
  double tipsSafePadding;

  /// 三角距离Widget间隔
  double tipsGap;
  ///点击区域回调
  Function(Rect rect) clickLiser;

  MyCustomPainter(this.pointX, this.pointY, this.textTip,
      {
        this.pointWidth,
        this.pointHeight,
        this.tipsTextColor,
        this.tipsBackgroundColor,
        this.tipsTextSize,
        this.tipsAlign,
        this.nextTextColor,
        this.nextBackgroundColor,
        this.nextTextTip,
        this.nextTextSize,
        this.tipsWidth,
        this.tipsSafePadding,
        this.tipsGap,
        this.clickLiser,
      });

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    canvas.save();

    //屏幕宽
    double width = size.width;
    //屏幕高
    double height = size.height;

    double gap = tipsGap;//三角距离Widget间隔
    TipsPoint a = TipsPoint(pointX, pointY);
    TipsPoint starPoint;
    TipsPoint centerPoint;
    double triangleLengh = 7;//三角高，底边是高的2倍
    double pading = 15;
    double safePading = tipsSafePadding;
    double tipsHeight = 0;//提示框高度
    if (tipsAlign == TipsAlign.topLeft) {
      starPoint = TipsPoint(a.x+pointWidth/2.0, a.y-gap);
      double centerPointX = starPoint.x+pading+triangleLengh-tipsWidth/2.0;
      if((centerPointX - safePading) < tipsWidth/2.0) {
        tipsWidth = (centerPointX - safePading)+ tipsWidth/2.0;
        centerPointX = starPoint.x+pading+triangleLengh-tipsWidth/2.0;
      }
      tipsHeight = getRectHeight(canvas, pading);
      centerPoint = TipsPoint(centerPointX, starPoint.y-triangleLengh-tipsHeight/2.0);
    }
    else if (tipsAlign == TipsAlign.topCenter) {
      starPoint = TipsPoint(a.x+pointWidth/2.0, a.y-gap);
      double centerPointX = starPoint.x;
      if((centerPointX - safePading) < tipsWidth/2.0) {
        tipsWidth = (centerPointX - safePading) * 2.0;
      }
      tipsHeight = getRectHeight(canvas, pading);
      centerPoint = TipsPoint(centerPointX, starPoint.y-triangleLengh-tipsHeight/2.0);
    }
    else if (tipsAlign == TipsAlign.topRight) {
      starPoint = TipsPoint(a.x+pointWidth/2.0, a.y-gap);
      double centerPointX = starPoint.x-pading-triangleLengh+tipsWidth/2.0;
      if((width - centerPointX - safePading) < tipsWidth/2.0) {
        tipsWidth = (width - centerPointX - safePading) + tipsWidth/2.0;
        centerPointX = starPoint.x-pading-triangleLengh+tipsWidth/2.0;
      }
      tipsHeight = getRectHeight(canvas, pading);
      centerPoint = TipsPoint(centerPointX, starPoint.y-triangleLengh-tipsHeight/2.0);
    }
    else if (tipsAlign == TipsAlign.centerLeft) {
      starPoint = TipsPoint(a.x-gap, a.y+pointHeight/2.0);
      double centerPointX = starPoint.x-triangleLengh-tipsWidth/2.0;
      if((centerPointX - safePading) < tipsWidth/2.0) {
        tipsWidth = (centerPointX - safePading) + tipsWidth/2.0;
        centerPointX = starPoint.x-triangleLengh-tipsWidth/2.0;
      }
      tipsHeight = getRectHeight(canvas, pading);
      centerPoint = TipsPoint(centerPointX, starPoint.y-triangleLengh-pading+tipsHeight/2.0);
    }
    else if (tipsAlign == TipsAlign.centerRight) {
      starPoint = TipsPoint(a.x+pointWidth+gap, a.y+pointHeight/2.0);
      double centerPointX = starPoint.x+triangleLengh+tipsWidth/2.0;
      if((width - centerPointX - safePading) < tipsWidth/2.0) {
        tipsWidth = (width - centerPointX - safePading) + tipsWidth/2.0;
        centerPointX = starPoint.x+triangleLengh+tipsWidth/2.0;
      }
      tipsHeight = getRectHeight(canvas, pading);
      centerPoint = TipsPoint(centerPointX, starPoint.y-triangleLengh-pading+tipsHeight/2.0);
    }
    else if (tipsAlign == TipsAlign.bottomLeft) {
      starPoint = TipsPoint(a.x+pointWidth/2.0, a.y+pointHeight+gap);
      double centerPointX = starPoint.x+pading+triangleLengh-tipsWidth/2.0;
      if((centerPointX - safePading) < tipsWidth/2.0) {
        tipsWidth = (centerPointX - safePading) + tipsWidth/2.0;
        centerPointX = starPoint.x+pading+triangleLengh-tipsWidth/2.0;
      }
      tipsHeight = getRectHeight(canvas, pading);
      centerPoint = TipsPoint(centerPointX, starPoint.y+triangleLengh+tipsHeight/2.0);
    }
    else if (tipsAlign == TipsAlign.bottomCenter) {
      starPoint = TipsPoint(a.x+pointWidth/2.0, a.y+pointHeight+gap);
      double centerPointX = starPoint.x;
      if((centerPointX - safePading) < tipsWidth/2.0) {
        tipsWidth = (centerPointX - safePading) * 2.0;
      }
      tipsHeight = getRectHeight(canvas, pading);
      centerPoint = TipsPoint(centerPointX, starPoint.y+triangleLengh+tipsHeight/2.0);
    }
    else if(tipsAlign == TipsAlign.bottomRight) {
      starPoint = TipsPoint(a.x+pointWidth/2.0, a.y+pointHeight+gap);
      double centerPointX = starPoint.x-pading-triangleLengh+tipsWidth/2.0;
      if((width - centerPointX - safePading) < tipsWidth/2.0) {
        tipsWidth = (width - centerPointX - safePading) + tipsWidth/2.0;
        centerPointX = starPoint.x-pading-triangleLengh+tipsWidth/2.0;
      }
      tipsHeight = getRectHeight(canvas, pading);
      centerPoint = TipsPoint(centerPointX, starPoint.y+triangleLengh+tipsHeight/2.0);
    }
    ///绘制三角形
    drawTriangle(canvas, starPoint, tipsAlign, triangleLengh);
    ///绘制提示框
    drawRectangle(canvas, centerPoint, tipsWidth, tipsHeight);

    ///绘制提示文本
    Offset tipsOrigin = Offset(centerPoint.x-tipsWidth/2.0+pading,centerPoint.y-tipsHeight/2.0+pading);
    Size tipsSize;
    drawTextFunction(tipsWidth - pading*2, tipsOrigin, canvas, textTip,textColor: tipsTextColor, textSize: tipsTextSize, drawedCallback: (Size size){
      tipsSize = size;
    });

    ///绘制下一步文本
    Offset nextOrigin = Offset(tipsOrigin.dx,tipsOrigin.dy+tipsSize.height+pading);
    drawTextFunction(tipsWidth - pading*2, nextOrigin, canvas, nextTextTip, textColor: nextTextColor, textSize: nextTextSize, textAlign: TextAlign.right, drawedCallback: (Size size){
      ///点击区域位置记录
      if (clickLiser != null) {
        clickLiser(Rect.fromLTWH(nextOrigin.dx, nextOrigin.dy, size.width, size.height));
      }
    });

    canvas.restore();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void drawTriangle(Canvas canvas, TipsPoint starPoint, TipsAlign curverAlign, double triangleLengh) {
    var paint = Paint();
    paint.color = tipsBackgroundColor;
    var path = Path();
    TipsPoint a1;
    TipsPoint a2;
    TipsPoint b1;
    TipsPoint b2;
    if(curverAlign == TipsAlign.topLeft || curverAlign == TipsAlign.topCenter || curverAlign == TipsAlign.topRight) {
      a1 = TipsPoint(starPoint.x - 1, starPoint.y - 1);
      a2 = TipsPoint(starPoint.x + 1, starPoint.y - 1);
      b1 = TipsPoint(starPoint.x + triangleLengh, starPoint.y - triangleLengh);
      b2 = TipsPoint(starPoint.x - triangleLengh, starPoint.y - triangleLengh);
    }
    else if (tipsAlign == TipsAlign.centerLeft) {
      a1 = TipsPoint(starPoint.x - 1, starPoint.y + 1);
      a2 = TipsPoint(starPoint.x - 1, starPoint.y - 1);
      b1 = TipsPoint(starPoint.x - triangleLengh, starPoint.y - triangleLengh);
      b2 = TipsPoint(starPoint.x - triangleLengh, starPoint.y + triangleLengh);
    }
    else if (tipsAlign == TipsAlign.centerRight) {
      a1 = TipsPoint(starPoint.x + 1, starPoint.y + 1);
      a2 = TipsPoint(starPoint.x + 1, starPoint.y - 1);
      b1 = TipsPoint(starPoint.x + triangleLengh, starPoint.y - triangleLengh);
      b2 = TipsPoint(starPoint.x + triangleLengh, starPoint.y + triangleLengh);
    }
    else if(curverAlign == TipsAlign.bottomLeft || curverAlign == TipsAlign.bottomCenter || curverAlign == TipsAlign.bottomRight) {
      a1 = TipsPoint(starPoint.x - 1, starPoint.y + 1);
      a2 = TipsPoint(starPoint.x + 1, starPoint.y + 1);
      b1 = TipsPoint(starPoint.x + triangleLengh, starPoint.y + triangleLengh);
      b2 = TipsPoint(starPoint.x - triangleLengh, starPoint.y + triangleLengh);
    }
    ///a1点
    path.moveTo(a1.x, a1.y);
    path.arcToPoint(Offset(a2.x, a2.y),radius: Radius.circular(2));
    /// 绘制到 a2点
    path.lineTo(b1.x, b1.y);
    path.lineTo(b2.x, b2.y);
    ///绘制 Path
    canvas.drawPath(path, paint);
  }

  void drawRectangle(Canvas canvas, TipsPoint centerPoint, double width, double height) {
    var paint = Paint();
    paint.color = tipsBackgroundColor;
    Rect rect = Rect.fromCenter(center: Offset(centerPoint.x, centerPoint.y), width: width, height: height);
    //根据上面的矩形,构建一个圆角矩形
    RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(10.0));
    canvas.drawRRect(rrect, paint);
  }

  double getRectHeight (Canvas canvas, double pading) {
    double tipsHeight = 30;//提示框高度
    //计算提示框高度
    Size size1 = getTextSize(tipsWidth - pading*2, canvas, textTip, textSize: tipsTextSize);
    tipsHeight += size1.height;
    Size size2 = getTextSize(tipsWidth - pading*2, canvas, nextTextTip, textSize: nextTextSize);
    tipsHeight += size2.height;
    tipsHeight += pading;
    return tipsHeight;
  }

  Size getTextSize (double textWidth, Canvas canvas, String text,
      {double textSize = 14}) {
    /// 新建一个段落建造器，然后将文字基本信息填入;
    ui.ParagraphBuilder pb = ui.ParagraphBuilder(ui.ParagraphStyle(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: textSize,
    ));

    ///设置文字的样式
    // pb.pushStyle(ui.TextStyle(color: textColor));

    if (text == null || text.length == 0) {
      text = "--";
    } else if (text.length > 30) {
      text = text.substring(0, 30);
      text += "...";
    }
    pb.addText(text);
    // 设置文本的宽度约束
    ui.ParagraphConstraints pc = ui.ParagraphConstraints(width: textWidth);
    // 这里需要先layout,将宽度约束填入，否则无法绘制
    ui.Paragraph paragraph = pb.build()..layout(pc);
    return Size(textWidth,paragraph.height);
  }

  ///[textWidth] 文本的宽度
  ///[textOffset] 文本绘制的开始位置 左上角
  ///[text] 绘制的文字内容
  void drawTextFunction(
      double textWidth, Offset textOffset, Canvas canvas, String text,
      {Color textColor = Colors.white, double textSize = 14, TextAlign textAlign = TextAlign.left, Function(Size size) drawedCallback}) {
    ///创建画笔
    var textPaint = Paint();

    ///设置画笔颜色
    textPaint.color = textColor;

    /// 新建一个段落建造器，然后将文字基本信息填入;
    ui.ParagraphBuilder pb = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: textAlign,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: textSize,
    ));

    ///设置文字的样式
    pb.pushStyle(ui.TextStyle(color: textColor));

    if (text == null || text.length == 0) {
      text = "--";
    } else if (text.length > 30) {
      text = text.substring(0, 30);
      text += "...";
    }
    pb.addText(text);
    // 设置文本的宽度约束
    ui.ParagraphConstraints pc = ui.ParagraphConstraints(width: textWidth);
    // 这里需要先layout,将宽度约束填入，否则无法绘制
    ui.Paragraph paragraph = pb.build()..layout(pc);
    canvas.drawParagraph(paragraph, textOffset);
    if(drawedCallback != null) {
      drawedCallback(Size(textWidth,paragraph.height));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}
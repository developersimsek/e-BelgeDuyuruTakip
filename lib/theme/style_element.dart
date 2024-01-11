import 'package:flutter/material.dart';

class AppColorItem {
  final Color transparent = Colors.transparent;
  final Color blue = Colors.blue;
  final Color lightBlue = Colors.lightBlue;
  final Color goldenLightBlue = const Color(0xFF49C8FF);
  final Color white = Colors.white;
  final Color white60 = const Color(0xFFDADADA);
  final Color white70 = Colors.white70;
  final Color grey = Colors.grey;
  final Color black = Colors.black;
}

class AppSizeItem {
  final double size05 = 0.5;
  final double size015 = 1.5;
  final double size5 = 5;
  final double size10 = 10;
  final double size15 = 15;
  final double size16 = 16;
  final double size17 = 17;
  final double size20 = 20;
  final double size22 = 22;
  final double size25 = 25;
  final double size30 = 30;
  final double size35 = 35;
  final double size50 = 50;
  final double size88 = 88;
  final double size90 = 90;
  final double size100 = 100;
  final int sizeInt0 = 0;
  final int sizeInt2 = 2;
  final int sizeInt10 = 10;
  final int sizeInt11 = 11;
  final int sizeInt16 = 16;
  final int sizeInt19 = 19;
}

class AppHeightItem {
  final double height3 = 3;
  final double height4 = 4;
  final double height5 = 5;
  final double height200 = 200;
}

class AppWithItem {
  final double width50 = 50;
  final double width500 = 500;
}

class AppEdgeInsets {
  final EdgeInsets all5 = const EdgeInsets.all(5);
  final EdgeInsets all10 = const EdgeInsets.all(10);
  final EdgeInsets all20 = const EdgeInsets.all(20);
  final EdgeInsets top5 = const EdgeInsets.only(top: 5);
  final EdgeInsets top10 = const EdgeInsets.only(top: 10);
  final EdgeInsets top15 = const EdgeInsets.only(top: 15);
  final EdgeInsets top20 = const EdgeInsets.only(top: 20);
  final EdgeInsets left20 = const EdgeInsets.only(left: 20);
  final EdgeInsets horizontal10 = const EdgeInsets.symmetric(horizontal: 10);
  final EdgeInsets modalEdgeInsets =
      const EdgeInsets.only(top: 0, left: 20, right: 20);
  final EdgeInsets zero = const EdgeInsets.only();
  final EdgeInsets modalDividerPadding =
  const EdgeInsets.only(left: 20, right: 20, bottom: 10);
}

class AppBorderRadius {
  final BorderRadius topRadius30 = const BorderRadius.only(
      topLeft: Radius.circular(30), topRight: Radius.circular(30));
  final BorderRadius allRadius5 = const BorderRadius.all(Radius.circular(5));
  final BorderRadius allRadius10 = const BorderRadius.all(Radius.circular(10));
  final BorderRadius allRadius15 = const BorderRadius.all(Radius.circular(15));
  final BorderRadius allRadius20 = const BorderRadius.all(Radius.circular(20));
}

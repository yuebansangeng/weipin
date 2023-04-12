import 'dart:ffi';

import 'package:flutter/material.dart';
import '../app/services/screenAdapter.dart';
import '../app/services/weipinIcon.dart';

class CircleButton extends StatelessWidget {
  final int width;
  final int height;
  Color? backgroundColor;
  Color? textColor;
  bool? disable;

  final void Function() onClick;

  CircleButton({
    super.key,
    required this.width,
    required this.height,
    this.backgroundColor,
    this.textColor,
    this.disable,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        padding: EdgeInsets.only(
            top: ScreenAdapter.height(15), bottom: ScreenAdapter.height(10)),
        child: GestureDetector(
            child: Container(
              width: ScreenAdapter.height(width),
              height: ScreenAdapter.height(height),
              decoration: BoxDecoration(
                  color: disable!
                      ? Color.fromRGBO(245, 245, 245, 1)
                      : Color.fromRGBO(36, 178, 255, 1),
                  borderRadius: BorderRadius.all(Radius.circular(22))),
              child: Icon(weipinIcon.toNext,
                  color: disable!
                      ? Color.fromRGBO(204, 204, 204, 1)
                      : Color.fromRGBO(255, 255, 255, 0.70)),
            ),
            onTap: () {
              if (disable == true) return;
              onClick();
            }),
      ),
    );
  }
}

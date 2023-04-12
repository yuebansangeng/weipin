import 'dart:ffi';

import 'package:flutter/material.dart';
import '../app/services/screenAdapter.dart';
import '../app/services/weipinIcon.dart';

class Button extends StatelessWidget {
  final int width;
  final int height;
  Color? backgroundColor;
  String? content;
  int? fontSize;
  bool? disable;
  final void Function() onClick;

  Button(
      {super.key,
      required this.width,
      required this.height,
      this.backgroundColor,
      this.fontSize,
      this.disable,
      required this.onClick,
      this.content});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
          width: ScreenAdapter.width(width),
          height: ScreenAdapter.height(height),
          child: ElevatedButton(
            onPressed: () {
              if (disable == true) return;
              onClick();
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
                overlayColor: disable!
                    ? MaterialStateProperty.all(
                        const Color.fromRGBO(245, 245, 245, 1))
                    : MaterialStateProperty.all(Colors.blue),
                elevation: MaterialStateProperty.all(0),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(disable!
                    ? const Color.fromRGBO(245, 245, 245, 1)
                    : const Color.fromRGBO(36, 178, 255, 1))),
            child: Container(
              alignment: Alignment.center,
              child: Text(content ?? '下一步',
                  style: TextStyle(
                      fontSize: ScreenAdapter.fontSize(fontSize ?? 14),
                      color: disable == true
                          ? Color.fromRGBO(102, 102, 102, 1)
                          : Colors.white)),
            ),
          )),
      Positioned(
          top: ScreenAdapter.height(11),
          right: ScreenAdapter.width(12),
          child: Icon(weipinIcon.right,
              size: ScreenAdapter.height(20),
              color: disable == true
                  ? Color.fromRGBO(170, 170, 170, 1)
                  : Color.fromRGBO(255, 255, 255, .7)))
    ]);
  }
}

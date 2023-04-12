import 'dart:ffi';

import 'package:flutter/material.dart';
import '../app/services/screenAdapter.dart';
import 'button.dart';
import 'circleButton.dart';

class FloatButton extends StatelessWidget {
  final int width;
  String valueKey;
  int? fontSize;
  bool? disable;
  bool? hasFocus;
  final void Function() onClick;

  FloatButton({
    super.key,
    required this.width,
    required this.valueKey,
    this.fontSize,
    this.disable,
    this.hasFocus,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return hasFocus == true
        ? CircleButton(
            key: ValueKey(valueKey),
            width: width,
            height: width,
            disable: disable,
            onClick: () {
              onClick();
            },
          )
        : Padding(
            padding: EdgeInsets.only(bottom: ScreenAdapter.height(50)),
            child: Container(child: NextButton(onClick, disable)),
          );
  }
}

Widget NextButton(onClick, [disable]) {
  return Center(
      child: Button(
    width: 191,
    height: 44,
    disable: disable ?? false,
    onClick: () {
      onClick();
    },
    backgroundColor: const Color.fromRGBO(36, 178, 255, 1),
  ));
}

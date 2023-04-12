import 'package:flutter/material.dart';

import '../../../../services/screenAdapter.dart';
import '../../../../services/weipinIcon.dart';

class SwicthButton extends StatelessWidget {
  final void Function() onLeftClick;
  final void Function() onRightClick;

  SwicthButton({
    super.key,
    required this.onLeftClick,
    required this.onRightClick,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            onLeftClick();
          },
          child: Icon(
            weipinIcon.change,
            size: ScreenAdapter.height(24),
            color: const Color.fromRGBO(51, 51, 51, 1),
          ),
        ),
        SizedBox(width: ScreenAdapter.width(22)),
        GestureDetector(
          onTap: () {
            onRightClick();
          },
          child: Icon(
            weipinIcon.setting,
            size: ScreenAdapter.height(24),
            color: const Color.fromRGBO(51, 51, 51, 1),
          ),
        ),
      ],
    );
  }
}

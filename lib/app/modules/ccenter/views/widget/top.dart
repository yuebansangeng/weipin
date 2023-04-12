import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/screenAdapter.dart';
import '../../../../services/weipinIcon.dart';

class TopInfo extends StatelessWidget {
  final String avatar;
  final String name;
  final void Function() onClick;

  TopInfo({
    super.key,
    required this.avatar,
    required this.name,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border:
                Border.all(color: Colors.white, width: ScreenAdapter.width(2)),
            borderRadius: BorderRadius.circular(32),
            color: Colors.white,
          ),
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: Image.network(
              'https://tvax1.sinaimg.cn/crop.0.0.1080.1080.180/72f858d3ly8fyer9t8knrj20u00u00uh.jpg?KID=imgbed,tva&Expires=1679050601&ssig=11y2ysyUTx',
              width: ScreenAdapter.height(60),
              height: ScreenAdapter.height(60),
            ),
          ),
        ),
        SizedBox(width: ScreenAdapter.width(16)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${name}',
                style: TextStyle(
                  color: const Color.fromRGBO(61, 61, 61, 1),
                  fontSize: ScreenAdapter.fontSize(18),
                )),
            SizedBox(height: ScreenAdapter.height(9)),
            Row(
              children: [
                Text('我的在线简历',
                    style: TextStyle(
                      color: const Color.fromRGBO(61, 61, 61, 1),
                      fontSize: ScreenAdapter.fontSize(12),
                    )),
                SizedBox(width: ScreenAdapter.width(10)),
                GestureDetector(
                  onTap: () {
                    onClick();
                  },
                  child: Image.asset(
                    "assets/images/home/edit.png",
                    width: ScreenAdapter.height(16),
                    height: ScreenAdapter.height(16),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

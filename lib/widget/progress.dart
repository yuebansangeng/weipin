import 'package:flutter/material.dart';
import '../app/services/screenAdapter.dart';
import '../app/services/weipinIcon.dart';

class ProgressLine extends StatelessWidget {
  final int currentIndex;

  const ProgressLine({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          height: ScreenAdapter.height(8),
          width: ScreenAdapter.width(300),
          decoration: BoxDecoration(
              border: Border.all(
                  width: ScreenAdapter.height(0.5),
                  color: const Color.fromRGBO(36, 178, 255, 1)),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(4)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: ScreenAdapter.width((currentIndex + 1) * 100),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(36, 178, 255, 1),
                  borderRadius: BorderRadius.circular(4)),
            ),
          ),
        ),
        currentIndex == 0
            ? Image.asset(
                "assets/images/cinfo/progress1.png",
                width: ScreenAdapter.width(24),
                height: ScreenAdapter.height(21),
              )
            : currentIndex == 1
                ? Image.asset(
                    "assets/images/cinfo/progress2.png",
                    width: ScreenAdapter.width(24),
                    height: ScreenAdapter.height(21),
                  )
                : Image.asset(
                    "assets/images/cinfo/progress3.png",
                    width: ScreenAdapter.width(24),
                    height: ScreenAdapter.height(21),
                  )
      ]),
      Container(
        padding: EdgeInsets.only(top: ScreenAdapter.height(8)),
        height: ScreenAdapter.height(57),
        width: ScreenAdapter.width(300),
        child: GridView(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: ScreenAdapter.width(30),
            ),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '工作经历 ',
                    style: TextStyle(
                        fontSize: ScreenAdapter.fontSize(12),
                        color: const Color.fromRGBO(102, 102, 102, 1)),
                  ),
                  if (currentIndex > 0)
                    Icon(weipinIcon.success,
                        size: ScreenAdapter.fontSize(18),
                        color: const Color.fromRGBO(36, 178, 255, 1))
                  else
                    const Text("")
                ],
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('教育经历',
                    style: TextStyle(
                        fontSize: ScreenAdapter.fontSize(12),
                        color: const Color.fromRGBO(187, 187, 187, 1))),
                if (currentIndex > 1)
                  Icon(weipinIcon.success,
                      size: ScreenAdapter.fontSize(18),
                      color: const Color.fromRGBO(36, 178, 255, 1))
                else
                  const Text("")
              ]),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('求职期望',
                      style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(12),
                          color: const Color.fromRGBO(187, 187, 187, 1))),
                  if (currentIndex > 2)
                    Icon(weipinIcon.success,
                        size: ScreenAdapter.fontSize(18),
                        color: const Color.fromRGBO(36, 178, 255, 1))
                  else
                    const Text("")
                ],
              ),
            ]),
      ),
    ]);
  }
}

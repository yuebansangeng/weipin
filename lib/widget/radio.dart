import 'package:flutter/material.dart';
import '../app/services/screenAdapter.dart';

class RadioButton extends StatelessWidget {
  final int selectIndex;
  final List<String> list;
  final void Function(int, String) onChange;

  const RadioButton(
      {super.key,
      required this.selectIndex,
      required this.list,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      //禁止滑动
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: ScreenAdapter.width(15),
          mainAxisSpacing: ScreenAdapter.height(16),
          childAspectRatio: 130 / 50),
      itemBuilder: ((context, index) {
        return SizedBox(
            child: GestureDetector(
          child: Container(
              decoration: BoxDecoration(
                  color: selectIndex == index
                      ? const Color.fromRGBO(36, 178, 255, 0.06)
                      : const Color.fromRGBO(249, 249, 249, 1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: ScreenAdapter.height(1),
                      color: selectIndex == index
                          ? const Color.fromRGBO(36, 178, 255, 1)
                          : const Color.fromRGBO(36, 178, 255, .06))),
              // rgba(36, 178, 255, 0.06)
              // rgba(36, 178, 255, 1)
              alignment: Alignment.center,
              child: Text(list[index],
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: selectIndex == index
                        ? const Color.fromRGBO(11, 169, 255, 1)
                        : const Color.fromRGBO(153, 153, 153, 1),
                    fontSize: ScreenAdapter.fontSize(14),
                  ))),
          onTap: () {
            // selectIndex = 0;
            onChange!(index, list[index]);
          },
        ));
      }),
    );
  }
}

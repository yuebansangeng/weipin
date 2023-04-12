import 'package:flutter/material.dart';
import '../app/services/screenAdapter.dart';
import '../app/services/weipinIcon.dart';
import '../app/services/Debounce.dart';

class Search extends StatelessWidget {
  final void Function(dynamic)? onChange;
  final void Function(dynamic)? onSubmit;
  final TextEditingController? controller;
  final String value;
  final FocusNode? focusNodeValue;

  const Search(
      {super.key,
      required this.value,
      required this.controller,
      this.onChange,
      this.focusNodeValue,
      this.onSubmit});

  @override
  Widget build(BuildContext context) {
    // controller?.value = TextEditingValue(
    //     text: value ?? "",
    //     selection: TextSelection.fromPosition(TextPosition(
    //         affinity: TextAffinity.downstream, offset: (value ?? "").length)));
    return Stack(children: [
      TextField(
          focusNode: focusNodeValue ?? FocusNode(),
          controller: controller,
          style: TextStyle(
              //修改框框的字体
              fontSize: ScreenAdapter.fontSize(14)),
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              //设置边框四个角的弧度
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Color.fromRGBO(36, 178, 255, 1)),
            ),
            prefixIcon:
                Icon(weipinIcon.searchjob, size: ScreenAdapter.fontSize(20)),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: const Color.fromRGBO(221, 221, 221, 1),
                width: ScreenAdapter.height(2),
              ),
            ), //去掉下划线
          ),
          onChanged: (value) {
            throttle(onChange!)(value);
          },
          //监听键盘的回车事件
          onSubmitted: (value) {
            throttle(onSubmit!)(value);
          }),
      controller?.text != ""
          ? Positioned(
              top: ScreenAdapter.height(16),
              right: ScreenAdapter.width(17),
              child: GestureDetector(
                onTap: () {
                  onChange!("");
                },
                child: Image.asset(
                  "assets/images/cinfo/close.png",
                  width: ScreenAdapter.width(20),
                  height: ScreenAdapter.height(20),
                ),
              ))
          : const Text('')
    ]);
  }
}

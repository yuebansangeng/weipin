import 'package:flutter/material.dart';
import '../app/services/screenAdapter.dart';
import '../app/services/weipinIcon.dart';
import '../app/services/Debounce.dart';

class Search1 extends StatefulWidget {
  final void Function(dynamic)? onChange;
  final void Function(dynamic)? onSubmit;
  final void Function(dynamic)? onFoucs;
  final dynamic Function(dynamic)? validator;
  String? value;
  GlobalKey? formKey;

  Search1(
      {super.key,
      this.formKey,
      this.value,
      this.validator,
      this.onChange,
      this.onSubmit,
      this.onFoucs});

  @override
  State<Search1> createState() => _Search1State();
}

class _Search1State extends State<Search1> {
  late FocusNode focusNode1;
  late TextEditingController _editingController;

  @override
  void initState() {
    _editingController = TextEditingController();
    _editingController.text = widget.value ?? "";
    focusNode1 = FocusNode();
    focusNode1.addListener(() {
      widget.onFoucs!(focusNode1.hasFocus);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Form(
        key: widget.formKey,
        child: TextFormField(
            focusNode: focusNode1,
            controller: _editingController,
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
            validator: (v) {
              return widget.validator!(v);
            },
            onChanged: (value) {
              throttle(widget.onChange!)(value);
            },
            //监听键盘的回车事件
            onFieldSubmitted: (value) {
              throttle(widget.onSubmit!)(value);
            }),
      ),
      _editingController.text != ""
          ? Positioned(
              top: ScreenAdapter.height(16),
              right: ScreenAdapter.width(17),
              child: GestureDetector(
                onTap: () {
                  widget.onChange!("");
                  _editingController.clear();
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

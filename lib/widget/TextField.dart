import 'package:flutter/material.dart';
import '../app/services/screenAdapter.dart';
import '../app/services/weipinIcon.dart';
import '../app/services/Debounce.dart';

class TextFieldWeipin extends StatefulWidget {
  final void Function(dynamic)? onChange;
  final void Function(dynamic)? onSubmit;
  final void Function(dynamic)? onFocus;
  final dynamic Function(dynamic)? validator;
  String? value;
  GlobalKey? formKey;
  String? hintText;

  TextFieldWeipin(
      {super.key,
      this.value,
      this.onChange,
      this.onSubmit,
      this.onFocus,
      this.validator,
      this.formKey,
      this.hintText});

  @override
  State<TextFieldWeipin> createState() => _TextFieldWeipinState();
}

class _TextFieldWeipinState extends State<TextFieldWeipin> {
  late FocusNode focusNode1;
  late TextEditingController editingLifeController;

  @override
  void initState() {
    editingLifeController = TextEditingController();
    editingLifeController.text = widget.value ?? "";
    focusNode1 = FocusNode();
    focusNode1.addListener(() {
      widget.onFocus!(focusNode1.hasFocus);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
        key: ValueKey(widget.key),
        keyboardType: TextInputType.text,
        focusNode: focusNode1,
        controller: editingLifeController,
        validator: (v) {
          return widget.validator!(v);
        },
        onChanged: (value) {
          throttle(widget.onChange!)(value);
        },
        onFieldSubmitted: (value) {
          widget.onSubmit!(value);
        },
        style: TextStyle(
            fontSize: ScreenAdapter.fontSize(14),
            color: const Color.fromRGBO(51, 51, 51, 1)),
        decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromRGBO(249, 249, 249, 1),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide.none),
            hintText: widget.hintText ?? "",
            hintStyle: const TextStyle(height: 1.5)),
        maxLines: 8,
      ),
    );
  }
}

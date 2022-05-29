import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final bool enabled;
  final String text;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final bool isObscure;
  final String errorText;
  final int maxLines;
  final TextInputType textInputType;
  final VoidCallback? onTap;
  final bool readOnly;
  final int maxLength;
  final FocusNode? focus;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixTap;
  final double elevation;
  final void Function(String)? onChange;

  CustomTextField(
      {Key? key,
      this.enabled = true,
      this.text = '',
      this.prefixIcon,
      this.isObscure = false,
      this.errorText = '',
      this.maxLines = 1,
      this.textInputType = TextInputType.text,
      this.onTap,
      this.maxLength = 200,
      required this.controller,
      this.readOnly = false,
      this.suffixIcon,
      this.onSuffixTap,
      this.elevation = 10,
      this.onChange,
      this.focus})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Material(
            shadowColor: Colors.lightBlue.shade100,
            borderRadius: BorderRadius.circular(
                40 - double.parse(widget.maxLines.toString()) * 5),
            elevation: widget.elevation,
            child: TextField(
              onChanged: widget.onChange,
              focusNode: widget.focus,
              inputFormatters: [
                LengthLimitingTextInputFormatter(widget.maxLength),
              ],
              readOnly: widget.readOnly,
              onTap: widget.onTap,
              keyboardType: widget.textInputType,
              maxLines: widget.maxLines,
              obscureText: widget.isObscure,
              controller: widget.controller,
              enabled: widget.enabled,
              cursorHeight: 20,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.grey),
              decoration: InputDecoration(
                  // suffixIcon: GestureDetector(
                  //     onTap: widget.onSuffixTap, child: widget.suffixIcon),
                  prefixIcon: widget.prefixIcon,
                  enabled: widget.enabled,
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(40)),
                  focusedBorder: InputBorder.none,
                  hintText: widget.text,
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.grey.shade400),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(40))),
            ),
          ),
          widget.errorText.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.errorText,
                        style: TextStyle(color: Colors.red),
                      )),
                )
              : Container(),
        ],
      ),
    );
  }
}

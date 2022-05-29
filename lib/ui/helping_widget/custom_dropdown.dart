import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String text;

  String? selectedValue;
  CustomDropdown(
      {Key? key, required this.items, this.selectedValue, this.text = ''})
      : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Text(
            widget.text,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: Colors.grey.shade400),
          ),
          items: widget.items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.grey.shade700),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: widget.selectedValue,
          onChanged: (value) {
            setState(() {
              widget.selectedValue = value as String;
            });
          },
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
          ),
          buttonPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey.shade50),
          buttonElevation: 4,
          itemHeight: 35,
          itemPadding: const EdgeInsets.only(left: 14, right: 14),
          dropdownMaxHeight: 200,
          dropdownPadding: null,
          dropdownFullScreen: true,
          selectedItemHighlightColor: Colors.blue.shade100,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.grey.shade100,
          ),
          dropdownElevation: 8,
          scrollbarRadius: const Radius.circular(40),
          scrollbarThickness: 6,
          scrollbarAlwaysShow: true,
          offset: const Offset(0, 0),
        ),
      ),
    );
  }
}

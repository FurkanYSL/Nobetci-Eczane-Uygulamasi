import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required TextEditingController controller,
    required this.hintText,
    required this.inputType,
    required this.labelText,
    required this.textInputAction,
    this.suffixWidget,
  }) : _controller = controller;

  final TextEditingController _controller;
  final String hintText;
  final String labelText;
  final TextInputType inputType;
  final TextInputAction textInputAction;
  final Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: TextField(
        keyboardType: TextInputType.text,
        controller: _controller,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          suffixIcon: suffixWidget,
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          label: Text(labelText),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

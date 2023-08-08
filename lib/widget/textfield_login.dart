import 'package:flutter/material.dart';

class TextFieldLogin extends StatelessWidget {
  TextEditingController controller;
  String hintName;
  IconData icon;
  bool isobscureText;
  TextInputType inputType;
  bool isEnable;
  Function(String)? validator;

  TextFieldLogin(
      {super.key,
      required this.controller,
      required this.hintName,
      required this.icon,
      this.isobscureText = false,
      this.inputType = TextInputType.text,
      this.isEnable = true,
      required String? Function(dynamic value) validator});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 50,
      child: TextFormField(
        controller: controller,
        obscureText: isobscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.deepPurple),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.deepPurple),
          ),
          prefixIcon: Icon(icon, color: Colors.deepPurple),
          hintText: hintName,
          fillColor: Colors.grey[200],
          filled: true,
        ),
      ),
    );
  }
}

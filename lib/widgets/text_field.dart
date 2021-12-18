import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({
    @required this.hintText,
    @required this.title,
    @required this.keyboardType,
    @required this.controller,
    this.suffixIcon,
    required this.validator,
    this.obscureText,
  });
  final String? hintText;
  final String? title;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Icon? suffixIcon;
  bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: GoogleFonts.raleway(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        TextFormField(
          validator: validator,
          controller: controller,
          keyboardType: keyboardType,
          cursorColor: Colors.white,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
          obscureText: false,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.raleway(
              fontSize: 16,
              color: Colors.grey[500],
            ),
            suffixIcon: suffixIcon,
            border: outlineCustomBorder(),
            errorBorder: outlineCustomBorder(),
            enabledBorder: outlineCustomBorder(),
            focusedBorder: outlineCustomBorder(),
            disabledBorder: outlineCustomBorder(),
            focusedErrorBorder: outlineCustomBorder(),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder outlineCustomBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.white,
        width: 2,
      ),
    );
  }
}

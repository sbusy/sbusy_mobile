import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final bool obscureText;
  final Function onChanged;

  TextFieldWidget({
    this.hintText,
    this.prefixIconData,
    this.suffixIconData,
    this.obscureText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    //final model = Provider.of<HomeModel>(context);

    return TextField(
      onChanged: onChanged,
      obscureText: obscureText,
      cursorColor: Color.fromARGB(255, 102, 18, 222),
      style: TextStyle(
        color: Color.fromARGB(255, 102, 18, 222),
        fontSize: 14.0,
      ),
      decoration: InputDecoration(
        labelStyle: TextStyle(color: Color.fromARGB(255, 102, 18, 222)),
        focusColor: Color.fromARGB(255, 102, 18, 222),
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color.fromARGB(255, 102, 18, 222)),
        ),
        labelText: hintText,
        prefixIcon: Icon(
          prefixIconData,
          size: 18,
          color: Color.fromARGB(255, 102, 18, 222),
        ),
        suffixIcon: GestureDetector(
          // onTap: () {
          //   model.isVisible = !model.isVisible;
          // },
          child: Icon(
            suffixIconData,
            size: 18,
            color: Color.fromARGB(255, 102, 18, 222),
          ),
        ),
      ),
    );
  }
}
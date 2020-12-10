import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final bool hasBorder;

  ButtonWidget({
    this.title,
    this.onPress,
    this.hasBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 102, 18, 222),
          borderRadius: BorderRadius.circular(10),
          border: hasBorder
              ? Border.all(
            color: Color.fromARGB(255, 102, 18, 222),
            width: 1.0,
          )
              : Border.fromBorderSide(BorderSide.none),
        ),
        child: InkWell(
          onTap: onPress,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 60.0,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
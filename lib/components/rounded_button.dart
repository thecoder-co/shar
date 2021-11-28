import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  final String? text;
  final Function? press;
  final Color? color, textColor;
  const RoundedButton({
    Key? key,
    this.text,
    this.press,
    this.color,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: color == null
            ? LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromRGBO(213, 41, 65, 1),
                  Colors.indigo,
                ],
              )
            : null,
        borderRadius: BorderRadius.circular(29),
        color: color,
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        ),
        onPressed: () {
          press!();
        },
        child: Text(
          text!,
          style: GoogleFonts.getFont(
            'Londrina Solid',
            textStyle: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}

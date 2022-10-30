import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shar/constants.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static void loading() {
    Get.defaultDialog(
      backgroundColor: kPrimaryColor,
      content: CircularProgressIndicator(
        color: kGold,
      ),
      radius: 10,
      title: 'Loading',
      titleStyle: GoogleFonts.getFont(
        'Overlock',
        textStyle: TextStyle(
          fontSize: 16,
          color: kGold,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

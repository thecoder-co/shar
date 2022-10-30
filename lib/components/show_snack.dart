import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnack(String title) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(
    SnackBar(
      content: Text(title),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: Colors.orange,
      behavior: SnackBarBehavior.floating,
    ),
  );
}

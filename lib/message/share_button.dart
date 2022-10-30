import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shar/logic/controllers/user_controller.dart';
import 'package:shar/message/share_message.dart';

class ShareButton extends StatelessWidget {
  final int index;
  ShareButton({
    super.key,
    required this.index,
  });
  final u = Get.put(UserContoller());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              Get.to(
                ShareMessage(
                  message: u.profile.value.body!.messages![index],
                ),
              );
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  width: 1.0,
                  color: Colors.green,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Share',
                    style: GoogleFonts.londrinaSolid(
                      textStyle: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.share,
                    color: Colors.green,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

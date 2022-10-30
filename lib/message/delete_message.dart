import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shar/constants.dart';
import 'package:shar/logic/controllers/user_controller.dart';

class DeleteButton extends StatelessWidget {
  final int index;
  DeleteButton({super.key, required this.index});
  final u = Get.put(UserContoller());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: InkWell(
            onTap: () async {
              Get.defaultDialog(
                backgroundColor: kPrimaryColor,
                radius: 10,
                title: 'Delete?',
                content: Text(
                  'Are you sure you want to delete message?',
                  style: GoogleFonts.londrinaSolid(
                    textStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                titleStyle: GoogleFonts.londrinaSolid(
                  textStyle: TextStyle(
                    color: kGold,
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text(
                      'No',
                      style: GoogleFonts.londrinaSolid(
                        textStyle: TextStyle(
                          color: kGold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  TextButton(
                      child: Text(
                        'Yes',
                        style: GoogleFonts.londrinaSolid(
                          textStyle: TextStyle(
                            color: kGold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                      onPressed: () {
                        u.deleteMessage(
                            id: u.profile.value.body!.messages![index].id!);
                        Get.back();
                      }),
                ],
              );
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  width: 1.0,
                  color: Colors.red,
                ),
              ),
              child: Row(
                //align to center
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Delete',
                    style: GoogleFonts.londrinaSolid(
                      textStyle: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.delete_outline,
                    color: Colors.red,
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

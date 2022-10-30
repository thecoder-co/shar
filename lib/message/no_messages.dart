import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoMessages extends StatelessWidget {
  final String user;
  const NoMessages({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Icon(
            Icons.cancel_outlined,
            color: Colors.red,
            size: 150,
          ),
          Text(
            'No message yet, recieve a message using your share code:',
            textAlign: TextAlign.center,
            style: GoogleFonts.londrinaSolid(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          SelectableText(
            "https://shar-ec801.web.app/#/send_message/$user",
            style: GoogleFonts.londrinaSolid(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shar/components/text_field_container.dart';
import 'package:shar/constants.dart';

class SendMessageInputField extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  const SendMessageInputField(
      {Key? key,
      this.hintText,
      this.icon = Icons.person,
      this.onChanged,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SendMessageContainer(
      child: TextFormField(
        expands: true,
        maxLines: null,
        controller: controller,
        minLines: null,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText:
              'Enter your anonymous message. Please, be respectful. Messages you send and how it affects the people being sent those messages are your responsibility.',
          border: InputBorder.none,
          hintMaxLines: 7,
        ),
      ),
    );
  }
}

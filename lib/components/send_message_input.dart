import 'package:flutter/material.dart';
import 'package:shar/components/text_field_container.dart';
import 'package:shar/constants.dart';

class SendMessageInputField extends StatefulWidget {
  final String? hintText;
  final IconData? icon;
  final ValueChanged<String>? onChanged;

  const SendMessageInputField({
    Key? key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  _SendMessageInputFieldState createState() => _SendMessageInputFieldState();
}

class _SendMessageInputFieldState extends State<SendMessageInputField> {
  @override
  Widget build(BuildContext context) {
    return SendMessageContainer(
      child: TextField(
        expands: true,
        maxLines: null,
        minLines: null,
        onChanged: widget.onChanged,
        onSubmitted: widget.onChanged,
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

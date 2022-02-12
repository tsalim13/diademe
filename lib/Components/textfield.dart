import 'package:flutter/material.dart';

class EntryField extends StatelessWidget {
  final String title;
  final String? initialValue;
  final bool? enabled;
  final int? maxLines;
  final int? maxLength;
  final double? fontSize;
  final String? Function(String?)? validator;
  final TextEditingController? textFieldController;
  TextEditingController entryFieldController = TextEditingController();
  EntryField(this.title, {this.initialValue, this.validator, this.enabled, this.maxLines, this.maxLength, this.fontSize, this.textFieldController});
  @override
  Widget build(BuildContext context) {
    textFieldController == null ? entryFieldController.text = initialValue ?? '' : textFieldController!.text = textFieldController!.text;
    return TextFormField(
      maxLength: maxLength,
      textInputAction: TextInputAction.done,
      controller: textFieldController ?? entryFieldController,
      validator: validator,
      enabled: enabled, 
      maxLines: maxLines,
      style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.black, fontSize: fontSize ?? 17),
      decoration: InputDecoration(
          prefixStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.black),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[200]!),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          hintText: title,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.grey, fontSize: fontSize ?? 17)),
    );
  }
}

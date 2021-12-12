import 'package:flutter/material.dart';

class EntryField extends StatelessWidget {
  final String title;
  final String? initialValue;
  final bool? enabled;
  final String? Function(String?)? validator;
  TextEditingController entryFieldController = TextEditingController();
  EntryField(this.title, {this.initialValue, this.validator, this.enabled});
  @override
  Widget build(BuildContext context) {
    entryFieldController.text = initialValue ?? '';
    return TextFormField(
      controller: entryFieldController,
      validator: validator,
      enabled: enabled, 
      style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.black, fontSize: 17),
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
              .copyWith(color: Colors.grey, fontSize: 17)),
    );
  }
}

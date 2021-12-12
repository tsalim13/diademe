import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:diademe/Components/colorButton.dart';
import 'package:diademe/Components/textfield.dart';
import 'package:diademe/Locale/locales.dart';
import 'package:diademe/pages/home.dart';

class Verification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top,
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      locale.enterVerificationCode!,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16,
                          color: Colors.blueGrey.shade700,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      locale.sentOnNumber!,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16,
                          color: Colors.blueGrey.shade700,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(locale.enterVerificationCode!,
                            style: TextStyle(
                              color: Colors.grey[600],
                            )),
                      ],
                    ),
                    EntryField("5 7 8 4 1 0")
                  ],
                ),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Row(
                      children: [
                        ColorButton(locale.submit),
                      ],
                    )),
                Spacer(),
              ],
            ),
          ),
        ),
        beginOffset: Offset(0.0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}

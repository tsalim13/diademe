import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:diademe/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:diademe/Components/colorButton.dart';
import 'package:diademe/Locale/locales.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordPage extends StatelessWidget {
  TextEditingController passwordFieldController = TextEditingController();
  TextEditingController confirmPasswordFieldController =
      TextEditingController();
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
              })),
      body: FadedSlideAnimation(
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Text(
                  "Changement du mot de passe accés propriétaire".toUpperCase(),
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 20,
                      color: Colors.blueGrey.shade700,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text("Mot de passe", style: TextStyle(color: Colors.grey[600])),
                Container(
                  //padding: EdgeInsets.only(left: 35),
                  child: Container(
                    width: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: passwordFieldController,
                          maxLines: 1,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
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
                                borderSide:
                                    BorderSide(color: Colors.grey[200]!),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[400]!),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                              hintText: '••••••••••',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.grey, fontSize: 17)),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text("Confirmez le mot de passe",
                    style: TextStyle(color: Colors.grey[600])),
                Container(
                  //padding: EdgeInsets.only(left: 35),
                  child: Container(
                    width: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          controller: confirmPasswordFieldController,
                          maxLines: 1,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
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
                                borderSide:
                                    BorderSide(color: Colors.grey[200]!),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[400]!),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                              hintText: '••••••••••',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.grey, fontSize: 17)),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        String password = passwordFieldController.text;
                        String confirmPassword =
                            confirmPasswordFieldController.text;
                        if (password == confirmPassword) {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString('password', password);
                          Navigator.pop(context);
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 35),
                        child: Row(
                          children: [
                            ColorButton("Continuer"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer()
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

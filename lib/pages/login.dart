import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:diademe/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:diademe/Components/colorButton.dart';
import 'package:diademe/Locale/locales.dart';

class LoginUi extends StatelessWidget {
  TextEditingController passwordFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
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
                  "Accès propriétaire".toUpperCase(),
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 25,
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
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (passwordFieldController.text == "123456") {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Settings()));
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                          'Mot de passe incorrect',
                                          style: TextStyle(fontSize: 21))),
                                );
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

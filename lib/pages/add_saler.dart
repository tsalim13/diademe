import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:diademe/Components/colorButton.dart';
import 'package:diademe/Components/textfield.dart';
import 'package:diademe/Locale/locales.dart';
import 'package:diademe/pages/home.dart';
import 'package:flutter/services.dart';

class AddSaler extends StatefulWidget {
  @override
  _AddSalerState createState() => _AddSalerState();
}

class _AddSalerState extends State<AddSaler> {
  @override
  void initState() {
    super.initState();
    // SystemChrome.setPreferredOrientations([
    //     DeviceOrientation.portraitUp,
    //     DeviceOrientation.portraitDown,
    // ]);
  }

  @override
  dispose() {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    // ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 25),
        elevation: 15,
        primary: Theme.of(context).primaryColor.withOpacity(0.7),
        onPrimary: Colors.black,
        fixedSize: Size(250, 250));
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
        title: Text('Ajouter un nouveau vendeur'),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
              children: [
                SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.max, children: [
                    Container(width: 80, child: EntryField('name')),
                    Container(width: 80, child: EntryField('name')),
                    Container(width: 80, child: EntryField('name')),
                    Container(width: 80, child: EntryField('name')),
                    Container(width: 80, child: EntryField('name')),
                    Container(width: 80, child: EntryField('name')),
                    Container(width: 80, child: EntryField('name')),
                    Container(width: 80, child: EntryField('name')),
                    Container(width: 80, child: EntryField('name')),
                    Container(width: 80, child: EntryField('name')),
                    Container(width: 80, child: EntryField('name')),
                    Container(width: 80, child: EntryField('name')),
                    Container(width: 80, child: EntryField('name')),
                    Container(width: 80, child: EntryField('name')),
                    Container(width: 80, child: EntryField('name')),
                    Container(width: 80, child: EntryField('name')),
                    Container(width: 80, child: EntryField('name')),
                    Container(width: 80, child: EntryField('name')),
                    Container(width: 80, child: EntryField('name')),
                  ]),
                ),
                VerticalDivider(thickness: 2),
                Column(mainAxisSize: MainAxisSize.max, children: [
                  Container(width: 80, child: EntryField('name')),
                  Container(width: 80, child: EntryField('name')),
                ]),
              ],
            
          ),
        ),
        beginOffset: Offset(0.0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}

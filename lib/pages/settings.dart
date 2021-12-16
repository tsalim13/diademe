import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:diademe/pages/add_saler.dart';
import 'package:flutter/material.dart';
import 'package:diademe/Components/colorButton.dart';
import 'package:diademe/Components/textfield.dart';
import 'package:diademe/Locale/locales.dart';
import 'package:diademe/pages/home.dart';
import 'package:flutter/services.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  

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
    final ButtonStyle style =
      ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 25),
        elevation: 15,
        primary: Theme.of(context).primaryColor.withOpacity(0.7),
        onPrimary: Colors.black,
        fixedSize: Size(250, 250)
      );
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
            }),
        title: Text('Parametres'),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        Padding(
          padding: const EdgeInsets.only(left: 50, right: 50, top: 150),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                style: style,
                onPressed: () {
                  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddSaler()));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_add, size: 70),
                    Text('Ajouter un vendeur')
                ]),
              ),
              ElevatedButton(
                style: style,
                onPressed: () {

                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_search, size: 70),
                    Text('Liste des vendeurs')
                ]),
              ),
              ElevatedButton(
                style: style,
               onPressed: () {
                  
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bar_chart, size: 70),
                    Text('Statistiques')
                ]),
              ),
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

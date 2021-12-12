import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:diademe/Components/colorButton.dart';
import 'package:diademe/Components/textfield.dart';
import 'package:diademe/Locale/locales.dart';
import 'package:diademe/pages/home.dart';
import 'package:flutter/services.dart';

import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddSaler extends StatefulWidget {
  @override
  _AddSalerState createState() => _AddSalerState();
}

class _AddSalerState extends State<AddSaler> {
  final _formKey = GlobalKey<FormState>();
  String? _birthday;
  String? _startDay;
  bool _isActive = true;

  File? image;

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
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 25),
                    child: Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Nom complet',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.67,
                                      color: Colors.grey[850],
                                      fontSize: 17),
                            ),
                            EntryField('Nom et prénom', validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez saisir le nom du vendeur';
                              }
                              return null;
                            }),
                            SizedBox(height: 20),
                            Text(
                              'Numéro de téléphone',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.67,
                                      color: Colors.grey[850],
                                      fontSize: 17),
                            ),
                            EntryField('0666 006 006'),
                            SizedBox(height: 20),
                            Text(
                              'Date de naissance',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.67,
                                      color: Colors.grey[850],
                                      fontSize: 17),
                            ),
                            Row(
                              children: [
                                Flexible(
                                    child: EntryField(
                                  '15/07/1995',
                                  initialValue: _birthday,
                                  enabled: false,
                                )),
                                IconButton(
                                    onPressed: () async {
                                      DateTime? birthday = await showDatePicker(
                                          context: context,
                                          locale: Locale('fr'),
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1940),
                                          lastDate:
                                              DateTime(DateTime.now().year)
                                                  .add(Duration(days: 365)));
                                      setState(() {
                                        _birthday = DateFormat('dd/MM/yyyy')
                                            .format(birthday!);
                                      });
                                    },
                                    icon: const Icon(Icons.calendar_today))
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Date du début de service',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.67,
                                      color: Colors.grey[850],
                                      fontSize: 17),
                            ),
                            Row(
                              children: [
                                Flexible(
                                    child: EntryField(
                                  '15/07/1995',
                                  initialValue: _startDay,
                                  enabled: false,
                                )),
                                IconButton(
                                    onPressed: () async {
                                      DateTime? birthday = await showDatePicker(
                                          context: context,
                                          locale: Locale('fr'),
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1940),
                                          lastDate:
                                              DateTime(DateTime.now().year)
                                                  .add(Duration(days: 365)));
                                      setState(() {
                                        _startDay = DateFormat('dd/MM/yyyy')
                                            .format(birthday!);
                                      });
                                    },
                                    icon: const Icon(Icons.calendar_today))
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  'Active',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.67,
                                          color: Colors.grey[850],
                                          fontSize: 17),
                                ),
                                SizedBox(width: 20),
                                Transform.scale(
                                  scale: 1.3,
                                  child: Switch(
                                    value: _isActive,
                                    onChanged: (value) {
                                      setState(() {
                                        _isActive = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )
                          ]),
                    ),
                  ),
                ),
                VerticalDivider(thickness: 3),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: 350,
                                      height: 350,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(300),
                              child: image == null
                                  ? Image.asset(
                                      'assets/default.png',
                                      
                                      fit: BoxFit.fill,
                                    )
                                  : Image.file(image!, fit: BoxFit.fill,),
                            ),
                          ),
                          SizedBox(height: 25),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                textStyle: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                                elevation: 15,
                                primary: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.7),
                                onPrimary: Colors.black,
                                padding: EdgeInsets.symmetric(vertical: 10)),
                            onPressed: () async {
                              XFile? imageFile = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (imageFile != null) {
                                File? croppedFile =
                                    await ImageCropper.cropImage(
                                        sourcePath: imageFile.path);
                                setState(() {
                                  image = croppedFile;
                                });
                              }
                            },
                            child: Row(
                              children: [
                                Icon(Icons.photo),
                                Text('Ajouter une photo')
                              ],
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                        elevation: 15,
                        primary:
                            Theme.of(context).primaryColor.withOpacity(0.9),
                        onPrimary: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 12)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child: Text('Ajouter'),
                  ),
                ),
              ],
            ),
          ],
        ),
        beginOffset: Offset(0.0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}

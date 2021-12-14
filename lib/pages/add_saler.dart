import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:diademe/Dao/SalerDao.dart';
import 'package:diademe/Dao/SalerReviewDao.dart';
import 'package:diademe/Models/Saler.dart';
import 'package:diademe/database/database.dart';
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
import 'package:path_provider/path_provider.dart';

class AddSaler extends StatefulWidget {
  @override
  _AddSalerState createState() => _AddSalerState();
}

class _AddSalerState extends State<AddSaler> {
  late AppDatabase database;
  late SalerDao salerDao;

  TextEditingController nameFieldController = TextEditingController();
  TextEditingController phoneFieldController = TextEditingController();
  // TextEditingController birthdayFieldController = TextEditingController();
  // TextEditingController startdayFieldController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? _birthday;
  String? _startDay;
  bool _isActive = true;

  File? croppedImage;
  late final String path;

  @override
  void initState() {
    super.initState();

    $FloorAppDatabase
        .databaseBuilder('app_database.db')
        .build()
        .then((value) async {
      this.database = value;
      Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();
      path = appDocumentsDirectory.path + '/images';
      salerDao = database.salerDao;

      if (!await Directory(path).exists()) {
        Directory _new = await Directory(path).create(recursive: true);
      }
    });

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
                            }, textFieldController: nameFieldController),
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
                            EntryField('0666 006 006',
                                textFieldController: phoneFieldController),
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
                                  //textFieldController: birthdayFieldController
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
                                        if (birthday != null) {
                                          _birthday = DateFormat('dd/MM/yyyy')
                                              .format(birthday);
                                        } else {
                                          _birthday = null;
                                        }
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
                                  //textFieldController: startdayFieldController
                                )),
                                IconButton(
                                    onPressed: () async {
                                      DateTime? start = await showDatePicker(
                                          context: context,
                                          locale: Locale('fr'),
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1940),
                                          lastDate:
                                              DateTime(DateTime.now().year)
                                                  .add(Duration(days: 365)));
                                      setState(() {
                                        if (start != null) {
                                          _startDay = DateFormat('dd/MM/yyyy')
                                              .format(start);
                                        } else {
                                          _startDay = null;
                                        }
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
                                    activeColor: Theme.of(context).primaryColor,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 25),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 380,
                            height: 380,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(300),
                              child: croppedImage == null
                                  ? Image.asset(
                                      'assets/default.png',
                                      fit: BoxFit.fill,
                                    )
                                  : Image.file(
                                      croppedImage!,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                          SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 270,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      textStyle: const TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.w500),
                                      elevation: 15,
                                      primary: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.7),
                                      onPrimary: Colors.black,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10)),
                                  onPressed: () async {
                                    XFile? imageFile = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    if (imageFile != null) {
                                      File? croppedFile =
                                          await ImageCropper.cropImage(
                                        sourcePath: imageFile.path,
                                        aspectRatioPresets: [
                                          CropAspectRatioPreset.square
                                        ],
                                      );
                                      setState(() {
                                        croppedImage = croppedFile;
                                      });
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.photo_camera),
                                      SizedBox(width: 10),
                                      Text('Ajouter une photo')
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      textStyle: const TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.w500),
                                      elevation: 15,
                                      primary: Colors.red.withOpacity(0.7),
                                      onPrimary: Colors.black,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10)),
                                  onPressed: () {
                                    setState(() {
                                      croppedImage = null;
                                    });
                                  },
                                  child: Icon(Icons.delete),
                                ),
                              )
                            ],
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (croppedImage == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.orange,
                                content:
                                    Text('Veuillez séléctionner une photo', style: TextStyle(fontSize: 21))),
                          );
                        } else {
                          try {
                            String newImageName = DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString() +
                                croppedImage!.path.split('/').last;
                            File newImage = croppedImage!
                                .copySync(path + "/" + newImageName);
                            await salerDao.insertSaler(Saler(
                                name: nameFieldController.text,
                                phone: phoneFieldController.text,
                                birthday: _birthday ?? '',
                                startday: _startDay ?? '',
                                actif: _isActive,
                                image: newImage.path.split('/').last));
                                var a = await salerDao.findAllSalers();
                            setState(() {
                              croppedImage = null;
                              nameFieldController.text = '';
                              phoneFieldController.text = '';
                              _birthday = null;
                              _startDay = null;
                            });
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text('Erreur', style: TextStyle(fontSize: 21))),
                            );
                          }
                        }
                      }
                    },
                    child: Text('Valider'),
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

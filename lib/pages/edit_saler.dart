import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:diademe/Bloc/Database/database_bloc.dart';
import 'package:diademe/Bloc/Database/database_state.dart';
import 'package:diademe/Models/Saler.dart';
import 'package:flutter/material.dart';
import 'package:diademe/Components/textfield.dart';
import 'package:diademe/Locale/locales.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditSaler extends StatefulWidget {
  final Saler saler;

  const EditSaler({Key? key, required this.saler}) : super(key: key);
  @override
  _EditSalerState createState() => _EditSalerState();
}

class _EditSalerState extends State<EditSaler> {
  late LoadedDatabaseState _databaseState;

  TextEditingController nameFieldController = TextEditingController();
  TextEditingController phoneFieldController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? _birthday;
  String? _startDay;
  bool _isActive = true;

  File? croppedImage;

  @override
  void initState() {
    _databaseState =
        BlocProvider.of<DatabaseBloc>(context).state as LoadedDatabaseState;

    nameFieldController.text = widget.saler.name;
    phoneFieldController.text = widget.saler.phone;
    _birthday = widget.saler.birthday;
    _startDay = widget.saler.startday;
    _isActive = widget.saler.actif;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 25),
        elevation: 15,
        primary: Theme.of(context).primaryColor.withOpacity(0.7),
        onPrimary: Colors.black,
        fixedSize: Size(250, 250));
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
          title: Text('Modifier vendeur'),
          centerTitle: true,
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return FadedSlideAnimation(
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Flexible(
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
                                  EntryField('Nom et prénom',
                                      validator: (value) {
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
                                      maxLength: 10,
                                      textFieldController:
                                          phoneFieldController),
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
                                            DateTime? birthday =
                                                await showDatePicker(
                                                    context: context,
                                                    locale: Locale('fr'),
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(1940),
                                                    lastDate: DateTime(
                                                            DateTime.now().year)
                                                        .add(Duration(
                                                            days: 365)));
                                            setState(() {
                                              if (birthday != null) {
                                                _birthday =
                                                    DateFormat('dd/MM/yyyy')
                                                        .format(birthday);
                                              } else {
                                                _birthday = null;
                                              }
                                            });
                                          },
                                          icon:
                                              const Icon(Icons.calendar_today))
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
                                            DateTime? start =
                                                await showDatePicker(
                                                    context: context,
                                                    locale: Locale('fr'),
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(1940),
                                                    lastDate: DateTime(
                                                            DateTime.now().year)
                                                        .add(Duration(
                                                            days: 365)));
                                            setState(() {
                                              if (start != null) {
                                                _startDay =
                                                    DateFormat('dd/MM/yyyy')
                                                        .format(start);
                                              } else {
                                                _startDay = null;
                                              }
                                            });
                                          },
                                          icon:
                                              const Icon(Icons.calendar_today))
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
                                          activeColor:
                                              Theme.of(context).primaryColor,
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
                                Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  height: MediaQuery.of(context).size.width / 3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(300),
                                    child: croppedImage == null
                                        ? Image.file(
                                            File(_databaseState.path +
                                                "/" +
                                                widget.saler.image),
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
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10)),
                                        onPressed: () async {
                                          XFile? imageFile = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.gallery);
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                            primary:
                                                Colors.red.withOpacity(0.7),
                                            onPrimary: Colors.black,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10)),
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
                              primary: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.9),
                              onPrimary: Colors.black,
                              padding: EdgeInsets.symmetric(vertical: 12)),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                File? newImage = null;
                                if (croppedImage != null) {
                                  String newImageName = DateTime.now()
                                          .millisecondsSinceEpoch
                                          .toString() +
                                      croppedImage!.path.split('/').last;
                                  newImage = croppedImage!.copySync(
                                      _databaseState.path + "/" + newImageName);
                                }

                                await _databaseState.salerDao.updateSaler(Saler(
                                    id: widget.saler.id,
                                    name: nameFieldController.text,
                                    phone: phoneFieldController.text,
                                    birthday: _birthday ?? '',
                                    startday: _startDay ?? '',
                                    actif: _isActive,
                                    image: croppedImage != null
                                        ? newImage!.path.split('/').last
                                        : widget.saler.image));
                                if (croppedImage != null) {
                                  try {
                                    File(_databaseState.path +
                                            "/" +
                                            widget.saler.image)
                                        .delete();
                                  } catch (e) {}
                                }

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text(
                                          'Vendeur modifier avec succés',
                                          style: TextStyle(fontSize: 21))),
                                );
                                Navigator.pop(context);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text('Erreur',
                                          style: TextStyle(fontSize: 21))),
                                );
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
            ),
            beginOffset: Offset(0.0, 0.3),
            endOffset: Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
          );
        }));
  }
}

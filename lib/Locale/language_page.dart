import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diademe/Components/bottom_bar.dart';
import 'package:diademe/pages/home.dart';

import 'language_cubit.dart';

class LanguageList {
  final String? title;

  LanguageList({this.title});
}

class Languages extends StatefulWidget {
  @override
  _LanguagesState createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {
  bool sliderValue = false;
  late LanguageCubit _languageCubit;
  String? selectedLocal;

  @override
  void initState() {
    super.initState();
    _languageCubit = BlocProvider.of<LanguageCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> language = [
      'Français',
      'English',
      'عربى',
      
      // 'bahasa Indonesia',
      // 'português',
      // 'Español',
      // 'italiano',
      // 'Türk',
      // 'Kiswahili'
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('Change Language',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold)),
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: language.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return RadioListTile(
                    value: language[index],
                    groupValue: selectedLocal,
                    title: Text(
                      language[index],
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    onChanged: (dynamic value) {
                      setState(() {
                        selectedLocal = value;
                      });
                    },
                  );
                },
              ),
              SizedBox(
                height: 100,
              ),
            ],
            physics: BouncingScrollPhysics(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomBar(
                text: 'Submit',
                onTap: () {
                  if (selectedLocal == 'English') {
                    _languageCubit.selectEngLanguage();
                  } else if (selectedLocal == 'عربى') {
                    _languageCubit.selectArabicLanguage();
                  } else if (selectedLocal == 'Français') {
                    _languageCubit.selectFrenchLanguage();
                  } else if (selectedLocal == 'bahasa Indonesia') {
                    _languageCubit.selectIndonesianLanguage();
                  } else if (selectedLocal == 'português') {
                    _languageCubit.selectPortugueseLanguage();
                  } else if (selectedLocal == 'Español') {
                    _languageCubit.selectSpanishLanguage();
                  } else if (selectedLocal == 'italiano') {
                    _languageCubit.selectItalianLanguage();
                  } else if (selectedLocal == 'Türk') {
                    _languageCubit.selectTurkishLanguage();
                  } else if (selectedLocal == 'Kiswahili') {
                    _languageCubit.selectSwahiliLanguage();
                  }

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                }),
          ),
        ],
      ),
    );
  }
}

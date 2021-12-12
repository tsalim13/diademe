import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'Locale/language_cubit.dart';
import 'Locale/locales.dart';

import 'Locale/language_page.dart';
import 'Theme/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
  runApp(Phoenix(child: DiademeFeedback()));
}

class DiademeFeedback extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>(
          create: (context) => LanguageCubit(),
        ),
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (_, locale) {
          return MaterialApp(
            localizationsDelegates: [
              const AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en'),
              // const Locale('pt'),
              const Locale('fr'),
              // const Locale('id'),
              const Locale('ar'),
              // const Locale('es'),
              // const Locale('it'),
              // const Locale('tr'),
              // const Locale('sw'),
            ],
            locale: locale,
            theme: appTheme,
            home: Languages(),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'dart:async';
import 'Languages/arabic.dart';
import 'Languages/english.dart';
import 'Languages/french.dart';
import 'Languages/indonesian.dart';
import 'Languages/italian.dart';
import 'Languages/portuguese.dart';
import 'Languages/spanish.dart';
import 'Languages/swahili.dart';
import 'Languages/turkish.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': english(),
    'ar': arabic(),
    'pt': portuguese(),
    'fr': french(),
    'id': indonesian(),
    'es': spanish(),
    'it': italian(),
    'tr': turkish(),
    'sw': swahili(),
  };

  String? get welcome {
    return _localizedValues[locale.languageCode]!['welcome'];
  }

  String? get continueText {
    return _localizedValues[locale.languageCode]!['continueText'];
  }

  String? get enterRegistered {
    return _localizedValues[locale.languageCode]!['enterRegistered'];
  }

  String? get phoneNumberToStart {
    return _localizedValues[locale.languageCode]!['phoneNumberToStart'];
  }

  String? get phoneNumber {
    return _localizedValues[locale.languageCode]!['phoneNumber'];
  }

  String? get wellSendCode {
    return _localizedValues[locale.languageCode]!['wellSendCode'];
  }

  String? get enterVerificationCode {
    return _localizedValues[locale.languageCode]!['enterVerificationCode'];
  }

  String? get sentOnNumber {
    return _localizedValues[locale.languageCode]!['sentOnNumber'];
  }

  String? get submit {
    return _localizedValues[locale.languageCode]!['submit'];
  }

  String? get giveYour {
    return _localizedValues[locale.languageCode]!['giveYour'];
  }

  String? get feedback {
    return _localizedValues[locale.languageCode]!['feedback'];
  }

  String? get yourWordMeansALot {
    return _localizedValues[locale.languageCode]!['yourWordMeansALot'];
  }

  String? get bringItOn {
    return _localizedValues[locale.languageCode]!['bringItOn'];
  }

  String? get howWas {
    return _localizedValues[locale.languageCode]!['howWas'];
  }

  String? get cancel {
    return _localizedValues[locale.languageCode]!['cancel'];
  }

  String? get next {
    return _localizedValues[locale.languageCode]!['next'];
  }

  String? get thankYouFor {
    return _localizedValues[locale.languageCode]!['thankYouFor'];
  }

  String? get yourFeedback {
    return _localizedValues[locale.languageCode]!['yourFeedback'];
  }

  String? get weWillTry {
    return _localizedValues[locale.languageCode]!['weWillTry'];
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => [
        'en',
        'ar',
        'fr',
        'in',
        'pt',
        'es',
        'it',
        'tr',
        'sw'
      ].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

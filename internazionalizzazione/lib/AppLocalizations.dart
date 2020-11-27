import 'dart:ui';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  AppLocalizations({
    @required this.locale,
    @required this.data,
  });

  final Locale locale;
  final Map<String, String> data;

  static const LocalizationsDelegate<AppLocalizations> delegate = AppLocalizationsDelegate();

  static Future<AppLocalizations> load(Locale locale) async {
    final jsonString = await rootBundle.loadString("i18n/${locale.languageCode}.json");
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    return AppLocalizations(
      locale: locale,
      data: Map<String, String>.from(jsonMap),
    );
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String translate(String key) => data[key];
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'it'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

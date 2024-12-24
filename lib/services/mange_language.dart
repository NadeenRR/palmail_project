import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum LanguageType { ENGLISH, ARABIC }

const String ARABIC = "ar";
const String ENGLISH = "en";
const String ASSET_PATH_LOCALISATIONS = "assets/translations";

const Locale ARABIC_LOCAL = Locale("ar", "SA");
const Locale ENGLISH_LOCAL = Locale("en", "US");

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.ARABIC:
        return ARABIC;
    }
  }
}

bool isRtl(BuildContext context) {
  final currentLocale = EasyLocalization.of(context)?.locale;

  if (currentLocale?.languageCode == "ar" ||
      currentLocale?.countryCode == "SA") {
    return true;
  }

  return false;
}

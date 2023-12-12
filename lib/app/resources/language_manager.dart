// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import '../services/shared_prefrences/cache_helper.dart';


enum LanguageType {
  ENGLISH,
  ARABIC,
}

const String arabic = "ar";
const String english = "en";
const String asstesLocalePath = "assets/translation";
const Locale ARABIC_LOCAL = Locale("ar", "SA");
const Locale ENGLISH_LOCAL = Locale("en", "US");

extension LanguageTypeExcetention on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ARABIC:
        return arabic;
      case LanguageType.ENGLISH:
        return english;
    }
  }
}

Future<String> getAppLanguage() async {
  String? language = CacheHelper.getData(key: SharedKey.Language);
  if (language != null && language.isNotEmpty) {
    return language;
  }
  return LanguageType.ENGLISH.getValue();
}

Future<void> changeAppLanguage() async {
  String currentLanguage = await getAppLanguage();
  if (currentLanguage == LanguageType.ARABIC.getValue()) {
    CacheHelper.setData(
        key: SharedKey.Language, value: LanguageType.ENGLISH.getValue());
  } else {
    CacheHelper.setData(
        key: SharedKey.Language, value: LanguageType.ARABIC.getValue());
  }
}

Future<Locale> getLocal() async {
  String currentLanguage = await getAppLanguage();
  if (currentLanguage == LanguageType.ARABIC.getValue()) {
    return ARABIC_LOCAL;
  } else {
    return ENGLISH_LOCAL;
  }
}

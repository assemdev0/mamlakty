import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../resources/language_manager.dart';

class SharedFunction{
   static void changeLanguage(context) {
    changeAppLanguage();
    Phoenix.rebirth(context);
  }
}
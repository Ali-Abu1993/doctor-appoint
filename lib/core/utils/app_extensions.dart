import 'package:doctor_appointment/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension AppExtensions on BuildContext{
  AppLocalizations get l1on => AppLocalizations.of(this)!;
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorTheme => ColorScheme.of(this);

  bool get isDark => theme.brightness == Brightness.light;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}
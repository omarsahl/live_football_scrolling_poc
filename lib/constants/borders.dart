import 'package:flutter/widgets.dart';

class Borders {
  Borders._();

  static const bottomSheetRoundedBorder = const RoundedRectangleBorder(
    borderRadius: const BorderRadius.only(
      topLeft: const Radius.circular(25.0),
      topRight: const Radius.circular(25.0),
    ),
  );

  static const topCorners40 = const BorderRadius.only(
    topRight: Radius.circular(40.0),
    topLeft: Radius.circular(40.0),
  );

  static const allCorners2 = const BorderRadius.all(Radius.circular(2.0));
  static const allCorners4 = const BorderRadius.all(Radius.circular(4.0));
  static const allCorners8 = const BorderRadius.all(Radius.circular(8.0));
  static const allCorners16 = const BorderRadius.all(Radius.circular(16.0));
  static const allCorners20 = const BorderRadius.all(Radius.circular(20.0));
  static const allCorners25 = const BorderRadius.all(Radius.circular(25.0));
  static const allCorners30 = const BorderRadius.all(Radius.circular(30.0));
  static const allCorners50 = const BorderRadius.all(Radius.circular(50.0));

  static const buttonRoundedBorder = const RoundedRectangleBorder(
    borderRadius: const BorderRadius.all(const Radius.circular(8.0)),
  );
}

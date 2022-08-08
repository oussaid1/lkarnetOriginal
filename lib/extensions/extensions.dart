import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
// Our design contains Neumorphism design and i made a extention for it
// We can apply it on any  widget

extension Neumorphism on Widget {
  addNeumorphism({
    double borderRadius = 10.0,
    Offset offset = const Offset(5, 5),
    double blurRadius = 10,
    Color topShadowColor = Colors.white60,
    Color bottomShadowColor = const Color(0x26234395),
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        boxShadow: [
          BoxShadow(
            offset: offset,
            blurRadius: blurRadius,
            color: bottomShadowColor,
          ),
          BoxShadow(
            offset: Offset(-offset.dx, -offset.dx),
            blurRadius: blurRadius,
            color: topShadowColor,
          ),
        ],
      ),
      child: this,
    );
  }
}

extension ContextExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  void gotoPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

extension DtExtension on DateTime {
  String formatted() {
    try {
      return DateFormat("yyyy-MM-dd").format(this);
    } catch (e) {
      return '';
    }
  }

  String ddmmyyyy() {
    return '$day/$month/$year';
  }

  String formattedHH() {
    try {
      return DateFormat.yMd().add_jm().format(this);
    } catch (e) {
      return '';
    }
  }

  /// check if given date is today
  bool isMatchToday(DateTime date) {
    if (day == date.day && month == date.month && year == date.year) {
      return true;
    }
    return false;
  }

  bool isMatchToWeek(DateTime date) {
    if (weekday == date.weekday && month == date.month && year == date.year) {
      return true;
    }
    return false;
  }

  /// check if given date is this month
  bool isMatchToMonth(DateTime date) {
    if (month == date.month) {
      return true;
    }
    return false;
  }

  bool isMatchToYear(DateTime date) {
    if (year == date.year) {
      return true;
    }
    return false;
  }

  bool isAs(DateTime other) {
    return day == DateTime.now().day &&
        month == DateTime.now().month &&
        year == DateTime.now().year;
  }
}

/// extension on [List<String>] to turn all items to lower case
extension LowerCaseList on List<String> {
  List<String> toLowerCase() {
    for (int i = 0; i < length; i++) {
      this[i] = this[i].toLowerCase();
    }
    return this;
  }
}

extension Ex on double {
  double toPrecision(int digitsAfter) =>
      double.parse(toStringAsFixed(digitsAfter));
}

extension CountMatch on String {
  matches(
    String str2, {
    bool ignoreCase = true,
    bool ignoreSpaces = true,
  }) {
    toLowerCase();
    str2.toLowerCase();
    var list = [];
    var count = 0;
    for (var item in split('')) {
      if (!item.isAlpha()) {
        if (str2.contains(item) && !list.contains(item)) {
          count++;
          list.add(item);
        }
      }
    }
    // print(count);
    // check if totalLetters is not zero to avoid division by zero
    if ((length + str2.length) > 0) {
      return ((count * 2) / (length + str2.length)) * 100;
    } else {
      return 0;
    }
  }
}

extension on String {
  bool isAlpha() {
    if (isEmpty) {
      return false;
    }
    return codeUnits.every((codeUnit) =>
        (codeUnit >= 65 && codeUnit <= 90) ||
        (codeUnit >= 97 && codeUnit <= 122));
  }
}

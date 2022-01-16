import 'package:flutter/material.dart';

import '../components.dart';
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

  String formattedHH() {
    try {
      return DateFormat.yMd().add_jm().format(this);
    } catch (e) {
      return '';
    }
  }

  String ddmmyyyy() {
    try {
      return DateFormat("yyyy-MM-dd").format(this);
    } catch (e) {
      return '';
    }
  }

  String mmyyyy() {
    try {
      return DateFormat("yyyy-MM").format(this);
    } catch (e) {
      return '';
    }
  }

  String yyyy() {
    try {
      return DateFormat("yyyy").format(this);
    } catch (e) {
      return '';
    }
  }

  DateTime stripTime() {
    {
      return DateTime(year, month, day, 0, 0, 0);
    }
  }

  DateTime stripTimeDay() {
    {
      return DateTime(year, month, 00);
    }
  }

  DateTime stripTimeDayMonth() {
    {
      return DateTime(year, 00, 00);
    }
  }
}

extension Ex on double {
  double toPrecision() => double.parse(toStringAsFixed(2));
}

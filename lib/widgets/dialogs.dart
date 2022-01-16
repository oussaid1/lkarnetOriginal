import 'package:flutter/material.dart';

class Dialogs {
  static Future<void> dialogSimple(BuildContext context,
      {List<Widget>? widgets, String? title}) {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        useRootNavigator: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('$title'),
            actionsPadding: EdgeInsets.only(left: 8, right: 8),
            actions: widgets,
          );
        });
  }

  static Future<void> botomPopUpDialog(BuildContext context, Widget widget,
      {height}) async {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: height ?? MediaQuery.of(context).size.height * 0.7,
            child: SizedBox.expand(child: widget),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  static snackBar(String text) => SnackBar(
        content: Text('$text'),
        backgroundColor: Colors.green[400],
      );
  static snackBarError(String text) =>
      SnackBar(content: Text('$text'), backgroundColor: Colors.red);
}

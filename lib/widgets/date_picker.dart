import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as df;
import 'package:lkarnet/providers/varproviders/var_providers.dart';
import 'package:lkarnet/settings/theme.dart';

class SelectDate extends ConsumerWidget {
  void _selectDate(BuildContext context, ref) async {
    //  final df.DateFormat _formatter = df.DateFormat('yyyy-MM-dd');
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: ref.read(pickedDateTime.state).state,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ))!;
    if (picked != DateTime.now()) {
      ref.read(pickedDateTime.state).state = selectedDateTime = picked;
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    final df.DateFormat _formatter = df.DateFormat('yyyy-MM-dd');
    final _pickedDate = ref.watch(pickedDateTime.state).state;
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        height: 45,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: [],
            color: MThemeData.blurWhite,
          ),
          child: Row(
            children: [
              Container(
                height: 45,
                width: 45,
                child: IconButton(
                  onPressed: () {
                    _selectDate(context, ref);
                  },
                  icon: Icon(
                    CupertinoIcons.calendar,
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: Text(_formatter.format(_pickedDate)),
              ),
            ],
          ),
        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/providers/varproviders/var_providers.dart';
import 'package:lkarnet/extensions/extensions.dart';
import '../const/constents.dart';

class SelectDate extends ConsumerWidget {
  const SelectDate({Key? key, required this.onDateSelected}) : super(key: key);
  final void Function(DateTime) onDateSelected;
  void _selectDate(BuildContext context, ref) async {
    //  final df.DateFormat _formatter = df.DateFormat('yyyy-MM-dd');
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: ref.read(pickedDateTime.state).state,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ))!;
    if (picked != DateTime.now()) {
      onDateSelected(picked);
      ref.read(pickedDateTime.state).state = picked;
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    final _pickedDate = ref.watch(pickedDateTime.state).state;
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          // border: Border.all(color: Colors.grey, width: 1),
          //
          //  color: AppConstants.whiteOpacity,
        ),
        height: 45,
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
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Text(
                _pickedDate.ddmmyyyy(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ));
  }
}

class SelectDate2 extends ConsumerWidget {
  const SelectDate2({Key? key, required this.onDateSelected}) : super(key: key);
  final void Function(DateTime) onDateSelected;
  void _selectDate(BuildContext context, ref) async {
    //  final df.DateFormat _formatter = df.DateFormat('yyyy-MM-dd');
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: ref.read(pickedDateTime2.state).state,
      firstDate: DateTime(2000),
      lastDate: DateTime(2031),
    ))!;
    if (picked != DateTime.now()) {
      onDateSelected(picked);
      ref.read(pickedDateTime2.state).state = picked;
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    final _pickedDate = ref.watch(pickedDateTime.state).state;
    return Container(
        width: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: AppConstants.whiteOpacity),
        height: 45,
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
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Text(
                _pickedDate.ddmmyyyy(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ));
  }
}

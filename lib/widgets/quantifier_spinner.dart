import 'package:flutter/material.dart';

class QuantifierSpinner extends StatelessWidget {
  const QuantifierSpinner(
      {Key? key, required this.onValueChanged, this.initialQuantifier})
      : super(key: key);
  final void Function(String quantifier) onValueChanged;
  final String? initialQuantifier;
  @override
  Widget build(BuildContext context) {
    final _list = <String>['واحدة', 'كيلو', 'علبة', 'لتر'];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        // color: AppConstants.whiteOpacity,
      ),
      width: 120.0,
      height: 45,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonFormField<String>(
              validator: (value) {
                if (value == null) {
                  return 'الرجاء اختيار الكمية';
                }
                return null;
              },
              elevation: 4,
              iconSize: 30,
              icon: Icon(Icons.arrow_drop_down),
              isExpanded: true,
              value: _list.contains(initialQuantifier)
                  ? initialQuantifier
                  : _list[0],
              onChanged: (value) {
                onValueChanged(value ?? _list[0]);
              },
              items: _list.toSet().map((itemName) {
                return DropdownMenuItem<String>(
                  value: itemName,
                  child: Container(
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: new Text(
                        itemName,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }).toList()),
        ),
      ),
    );
  }
}

import 'package:lkarnet/components.dart';
import 'package:lkarnet/providers/varproviders/var_providers.dart';
import 'package:flutter/material.dart';

class QuantifierSpinner extends ConsumerWidget {
  const QuantifierSpinner({Key? key, required this.onValueChanged})
      : super(key: key);
  final void Function(String) onValueChanged;
  @override
  Widget build(BuildContext context, ref) {
    final _list = <String>['واحدة', 'كيلو', 'علبة', 'لتر'];
    var picked = ref.watch(selectedQuantifierProvider.state).state;
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
              value: _list.contains(picked) ? picked : null,
              onChanged: (value) {
                onValueChanged(value ?? _list[0]);
                ref.read(selectedQuantifierProvider.state).state = value;
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

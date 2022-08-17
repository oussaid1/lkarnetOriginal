import 'package:lkarnet/providers/streamproviders/shops_stream_provider.dart';

import 'package:lkarnet/components.dart';
import 'package:flutter/material.dart';

import '../providers/varproviders/var_providers.dart';

class ShopSpinner extends ConsumerStatefulWidget {
  const ShopSpinner({
    Key? key,
    required this.onShopSelected,
    this.focusNode,
    this.initialValue,
  }) : super(key: key);
  final void Function(String?) onShopSelected;
  final FocusNode? focusNode;
  final String? initialValue;
  @override
  ConsumerState<ShopSpinner> createState() => _ShopSpinnerState();
}

class _ShopSpinnerState extends ConsumerState<ShopSpinner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppConstants.whiteOpacity,
      ),
      width: 200.0,
      margin: EdgeInsets.all(8),
      height: 50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ButtonTheme(
          // focusColor: Colors.red,
          //highlightColor: Colors.red,
          alignedDropdown: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radius),
          ),
          child: DropdownButtonFormField<String>(
            borderRadius: BorderRadius.circular(AppConstants.radius),
            dropdownColor: Color.fromARGB(108, 255, 255, 255).withOpacity(0.6),
            alignment: Alignment.center,
            autofocus: true,
            autovalidateMode: AutovalidateMode.always,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(0),
            ),
            elevation: 4,
            iconSize: 30,
            validator: (value) {
              if (value == null) {
                return 'please select shop first !';
              }
              return null;
            },
            icon: Icon(Icons.arrow_drop_down),
            isExpanded: false,
            // hint: Text(
            //   "Select Shop",
            //   textAlign: TextAlign.center,
            //   style: Theme.of(context).textTheme.subtitle2,
            // ),
            value: widget.initialValue != null
                ? widget.initialValue
                : _list.contains(picked)
                    ? picked
                    : null,
            focusColor: AppConstants.primaryColor,
            onChanged: (value) {
              widget.onShopSelected(value);

              widget.focusNode != null
                  ? widget.focusNode!.requestFocus()
                  : null;
              ref.read(pickedShop.state).state = value;
            },
            items: [
              for (var i = 0; i < _list.length; i++)
                DropdownMenuItem<String>(
                  value: _list[i].shopName.toString(),
                  child: Container(
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: new Text(
                        _list[i].shopName.toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

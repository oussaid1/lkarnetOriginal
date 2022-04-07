import 'package:lkarnet/providers/streamproviders/shops_stream_provider.dart';

import 'package:lkarnet/components.dart';
import 'package:flutter/material.dart';

import '../providers/varproviders/var_providers.dart';

class ShopSpinner extends ConsumerStatefulWidget {
  const ShopSpinner({
    Key? key,
    required this.onShopSelected,
  }) : super(key: key);
  final void Function(String?) onShopSelected;
  @override
  ConsumerState<ShopSpinner> createState() => _ShopSpinnerState();
}

class _ShopSpinnerState extends ConsumerState<ShopSpinner> {
  @override
  Widget build(BuildContext context) {
    var _list = ref.watch(shopsProvider.state).state;
    var picked = ref.watch(pickedShop.state).state;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppConstants.whiteOpacity,
      ),
      width: 160.0,
      margin: EdgeInsets.all(8),
      height: 45,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(0),
            ),
            elevation: 4,
            iconSize: 30,
            validator: (value) {
              if (value == null) {
                return 'select shop';
              }
              return null;
            },
            icon: Icon(Icons.arrow_drop_down),
            isExpanded: false,
            hint: Text(
              "Select Shop",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            value: _list.contains(picked) ? picked : null,
            onChanged: (value) {
              setState(() {
                widget.onShopSelected(value);
              });

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

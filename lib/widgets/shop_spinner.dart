import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/providers/streamproviders/shops_stream_provider.dart';
import 'package:lkarnet/providers/varproviders/var_providers.dart';
import 'package:lkarnet/settings/theme.dart';

class ShopSpinner extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    var _list = ref.watch(shopsProvider.state).state;
    var _selectedShop = ref.watch(pickedShop.state).state;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: MThemeData.blurWhite,
      ),
      width: 240.0,
      height: 45,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<String>(
            elevation: 4,
            iconSize: 30,
            underline: Divider(
              height: 2,
              color: Theme.of(context).colorScheme.secondary,
            ),
            icon: Icon(Icons.arrow_drop_down),
            isExpanded: false,
            hint: Text(
              "Select Shop",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            value: _selectedShop,
            onChanged: (value) {
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

  // List<DropdownMenuItem<String>>  tems(List<ShopModel> items) {
  //   for (var i = 0; i < items.length; i++) {
  //     DropdownMenuItem<String>(
  //       value: items[i].shopName,
  //       child: Container(
  //         width: 100,
  //         child: Padding(
  //           padding: const EdgeInsets.only(left: 8.0, right: 8),
  //           child: new Text(
  //             items[i].shopName.toString(),
  //             textAlign: TextAlign.center,
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  // }
}

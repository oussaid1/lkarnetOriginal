import 'package:lkarnet/providers/streamproviders/shops_stream_provider.dart';

import 'package:lkarnet/components.dart';
import 'package:flutter/material.dart';

<<<<<<< HEAD
import '../providers/varproviders/var_providers.dart';

class ShopSpinner extends ConsumerStatefulWidget {
  const ShopSpinner({
    Key? key,
    required this.onShopSelected,
  }) : super(key: key);
=======
import '../models/kitchen/kitchen_item.dart';

class ShopSpinner extends ConsumerWidget {
  const ShopSpinner({Key? key, required this.onShopSelected}) : super(key: key);
>>>>>>> b001677 (kitchen element items crud)
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
<<<<<<< HEAD
              setState(() {
                widget.onShopSelected(value);
              });

=======
              onShopSelected(value);
>>>>>>> b001677 (kitchen element items crud)
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
<<<<<<< HEAD
=======

final kitchenElementProvider = StateProvider<KitchenElement?>((ref) {
  return null;
});

class KitchenElementSpinner extends ConsumerWidget {
  KitchenElementSpinner({Key? key, required this.onSelected});
  final void Function(KitchenElement?) onSelected;
  @override
  Widget build(BuildContext context, ref) {
    List<KitchenElement> _list = [];
    // var _selectedShop = ref.watch(pickedShop.state).state;

    return StreamBuilder<List<KitchenElement>>(
        stream: ref.read(databaseProvider).kitchenElementsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _list = snapshot.data!;
          }
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppConstants.whiteOpacity,
            ),
            width: 240.0,
            height: 45,
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButton<KitchenElement>(
                  elevation: 4,
                  iconSize: 30,
                  underline: Divider(
                    height: 2,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  icon: Icon(Icons.arrow_drop_down),
                  isExpanded: false,
                  hint: Text(
                    "Select Kitchen",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  value: ref.watch(kitchenElementProvider),
                  onChanged: (value) {
                    onSelected(value!);
                    ref.read(kitchenElementProvider.state).state = value;
                  },
                  items: [
                    for (var i = 0; i < _list.length; i++)
                      DropdownMenuItem<KitchenElement>(
                        value: _list[i],
                        child: Container(
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: new Text(
                              _list[i].title.toString(),
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
        });
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
>>>>>>> b001677 (kitchen element items crud)

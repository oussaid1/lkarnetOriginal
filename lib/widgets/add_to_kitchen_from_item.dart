import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/kitchenitembloc/kitchen_item_bloc.dart';
import '../models/item/item.dart';
import '../models/kitchen/kitchen_element.dart';
import '../models/kitchen/kitchen_item.dart';
import '../settings/theme.dart';
import 'kitchen_elements_spinner.dart';

class AddToKitchenFromItem extends StatefulWidget {
  const AddToKitchenFromItem({
    Key? key,
    required this.item,
  }) : super(key: key);
  final ItemModel item;

  @override
  State<AddToKitchenFromItem> createState() => _StateAddToKitchenFromItem();
}

class _StateAddToKitchenFromItem extends State<AddToKitchenFromItem> {
  KitchenElementModel? _kitchenElement;
  // bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Select kitchen Element to add item to',
              style: Theme.of(context).textTheme.subtitle2),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            KitchenElementsSpinner(
              onSelected: (element) {
                setState(() {
                  _kitchenElement = element;
                });
              },
            ),
            Container(
              width: 120,
              child: ElevatedButton(
                  child: Text(
                    'Save',
                  ),
                  onPressed: _kitchenElement == null
                      ? null
                      : () {
                          // final _kitchenItem = KitchenItem(
                          //   itemName: _itemNameController.text,
                          //   itemPrice: double.parse(
                          //       _itemPriceController.text),
                          //   quantity: _quantity,
                          //   quantifier: _quantifier,
                          //   dateBought: _dateBought,
                          //   kitchenElementId: _kitchenElement!.id,
                          //   shopName: _shop,
                          //   dateExpired: null,
                          // );
                          // ref
                          //     .read(operationsProvider)
                          //
                          //
                          var db = context.read<KitchenItemBloc>();
                          db.add(AddKitchenItemEvent(KitchenItemModel.fromItem(
                              widget.item, _kitchenElement!)));
                          Navigator.of(context).pop();
                        },
                  style: MThemeData.raisedButtonStyleSave),
            ),
            // const SizedBox(width: 4),
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

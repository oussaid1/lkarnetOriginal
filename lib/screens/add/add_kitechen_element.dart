import 'package:flutter/cupertino.dart';
import 'package:lkarnet/settings/theme.dart';
import 'package:lkarnet/widgets/date_picker.dart';
import 'package:lkarnet/widgets/quantifier_spinner.dart';
import 'package:flutter/material.dart';

import '../../components.dart';
import '../../models/kitchen/kitchen_item.dart';
import '../tabs/kitchen_item_detailed.dart';

class AddKitchenItem extends ConsumerStatefulWidget {
  final KitchenElement? kitchenElement;
  AddKitchenItem({this.kitchenElement});
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends ConsumerState<AddKitchenItem> {
  double _quantity = 1;
  final GlobalKey<FormState> _formKeyName = GlobalKey<FormState>();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();
  void clear() {
    _itemNameController.clear();
    _itemPriceController.clear();
  }

  void _update() {
    // if (widget.kitchenElement != null) {
    //   setState(() {
    //     _itemNameController.text = widget.kitchenElement!.itemName.toString();
    //     _itemPriceController.text =
    //         (widget.kitchenElement!.itemPrice).toString();
    //     _quantity = widget.kitchenElement!.quantity;
    //   });
    // }
  }

  @override
  void initState() {
    _update();
    super.initState();
  }

  @override
  void dispose() {
    _quantity = 1;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Iterable<KitchenElement> _kOptions = [];
    // final logger = Logger();
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: SizedBox(
          height: 340,
          //width: 200,
          child: BluredContainer(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 8),
                  child: Text(
                    'Add Kitchen Element',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 4.0, top: 10, left: 8, right: 8),
                  child: Form(
                    key: _formKeyName,
                    child: Autocomplete<KitchenElement>(
                      initialValue: TextEditingValue(
                        text: widget.kitchenElement != null
                            ? widget.kitchenElement!.title!
                            : '',
                      ),
                      optionsBuilder:
                          (TextEditingValue textEditingValue) async {
                        if (textEditingValue.text.isEmpty) {
                          return [];
                        }
                        return _kOptions
                            .where((kitchenElement) => kitchenElement.title!
                                .toLowerCase()
                                .startsWith(
                                    textEditingValue.text.toLowerCase()))
                            .toList(growable: true);
                      },
                      displayStringForOption: (KitchenElement kitchenElement) =>
                          kitchenElement.title!,
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController fieldTextEditingController,
                          FocusNode fieldFocusNode,
                          VoidCallback onFieldSubmitted) {
                        return TextField(
                          onChanged: (value) {
                            _itemNameController.text = value;
                          },
                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                          style: Theme.of(context).textTheme.headline6,
                          decoration: InputDecoration(
                            suffix: IconButton(
                              icon: Icon(
                                Icons.clear_outlined,
                                size: 18,
                              ),
                              onPressed: () {
                                fieldTextEditingController.clear();
                              },
                            ),
                            hintText: 'name',
                            hintStyle:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.grey,
                                    ),

                            fillColor: AppConstants.whiteOpacity,
                            filled: true,
                            // labelText: 'Name',
                          ),
                        );
                      },
                      onSelected: (KitchenElement selection) {},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Availability',
                          style: Theme.of(context).textTheme.bodyText1),
                      Availibility(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PiorityRatingWidget(
                    onRatingChanged: (p0) {},
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                widget.kitchenElement == null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 120,
                            child: TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: MThemeData.textButtonStyleCancel),
                          ),
                          Container(
                            width: 120,
                            child: TextButton(
                                child: Text(
                                  'Save',
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Updating...'),
                                  ));
                                },
                                style: MThemeData.textButtonStyleSave),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 120,
                            child: TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: MThemeData.textButtonStyleCancel),
                          ),
                          Container(
                            width: 120,
                            child: TextButton(
                                child: Text(
                                  'Update',
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                onPressed: () {
                                  //   ScaffoldMessenger.of(context)
                                  //       .showSnackBar(SnackBar(
                                  //     content: Text('Updating...'),
                                  //   ));
                                },
                                style: MThemeData.textButtonStyleSave),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

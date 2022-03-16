import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/providers/operationsprovider/operations_provider.dart';
import 'package:lkarnet/providers/varproviders/var_providers.dart';
import 'package:lkarnet/settings/theme.dart';
import 'package:lkarnet/widgets/date_picker.dart';
import 'package:lkarnet/widgets/quantifier_spinner.dart';
import 'package:lkarnet/widgets/shop_spinner.dart';
import 'package:flutter/material.dart';

import '../../components.dart';
import '../../models/kitchen/kitchen_item.dart';
import '../../providers/streamproviders/items_stream_provider.dart';

class AddKitchenItem extends ConsumerStatefulWidget {
  final Item? item;
  final KitchenItem? kitchenItem;
  final KitchenElement? kitchenElement;
  AddKitchenItem({Key? key, this.kitchenItem, this.kitchenElement, this.item})
      : super(key: key);
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends ConsumerState<AddKitchenItem> {
  double _quantity = 1;
  final GlobalKey<FormState> _formKeyName = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPrice = GlobalKey<FormState>();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();
  void clear() {
    _itemNameController.clear();
    _itemPriceController.clear();
  }

  void _update() {
    // check if we have a kitchen item then update the fields
    if (widget.kitchenItem != null) {
      setState(() {
        _itemNameController.text = widget.kitchenItem!.itemName.toString();
        _itemPriceController.text = (widget.kitchenItem!.itemPrice).toString();
        _quantity = widget.kitchenItem!.quantity;
      });
    }

    // check if we have an item then set all the variables to the values of the item
    if (widget.item != null) {
      setState(() {
        _itemNameController.text = widget.item!.itemName.toString();
        _itemPriceController.text = (widget.item!.itemPrice).toString();
        _quantity = widget.item!.quantity;
      });
    }
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
    Iterable<Item> _kOptions = ref.watch(itemsProvider.state).state;
    final logger = Logger();
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height: 540,
        width: 400,
        child: BluredContainer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 8),
                  child: Text(
                    'Add Kitchen Item',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: KitchenElementSpinner(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: ShopSpinner(),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Form(
                    key: _formKeyName,
                    child: SizedBox(
                      height: 50,
                      child: Autocomplete<Item>(
                        initialValue: TextEditingValue(
                          text: widget.kitchenItem != null
                              ? widget.kitchenItem!.itemName!
                              : '',
                        ),
                        optionsBuilder:
                            (TextEditingValue textEditingValue) async {
                          if (textEditingValue.text.isEmpty) {
                            return [];
                          }
                          return _kOptions
                              .where((item) => item.itemName
                                  .toLowerCase()
                                  .startsWith(
                                      textEditingValue.text.toLowerCase()))
                              .toList(growable: true);
                        },
                        displayStringForOption: (Item item) => item.itemName,
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
                              hintStyle: GoogleFonts.robotoSlab(),
                              contentPadding: EdgeInsets.only(top: 4),
                              prefixIcon: Icon(
                                Icons.insert_emoticon_outlined,
                                color: Colors.grey,
                              ),
                              fillColor: AppConstants.whiteOpacity,
                              filled: true,
                              labelText: 'Name',
                            ),
                          );
                        },
                        onSelected: (Item selection) {
                          _itemNameController.text = selection.itemName;
                          _itemPriceController.text =
                              selection.itemPrice.toString();
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Form(
                    key: _formKeyPrice,
                    child: SizedBox(
                      height: 50,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: [
                          //  FilteringTextInputFormatter.allow(RegExp("0-9]"))
                          FilteringTextInputFormatter.allow(
                              RegExp(r'(^\-?\d*\.?\d*)')),
                        ],
                        controller: _itemPriceController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return '';
                          } else if (text.contains(RegExp(r'[A-Z]'))) {
                            return '';
                          } else {
                            return null;
                          }
                        },
                        textAlign: TextAlign.center,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          hintText: ' 00.00',
                          hintStyle: GoogleFonts.robotoSlab(),
                          contentPadding: EdgeInsets.only(top: 4),
                          suffix: IconButton(
                            icon: Icon(
                              Icons.clear_outlined,
                              size: 18,
                            ),
                            onPressed: () {
                              _itemPriceController.clear();
                            },
                          ),
                          prefixIcon: Icon(
                            Icons.monetization_on_outlined,
                          ),
                          fillColor: AppConstants.whiteOpacity,
                          filled: true,
                          labelText: 'Price',
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppConstants.whiteOpacity,
                    ),
                    child: Row(
                      children: [SelectDate()],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: AppConstants.whiteOpacity,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Consumer(builder: (context, ref, child) {
                          return Container(
                            height: 45,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    icon: Icon(
                                      CupertinoIcons.minus_circle,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (_quantity > 1) _quantity -= 0.5;
                                        _quantity = _quantity;
                                      });
                                    }),
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(_quantity.toString()),
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(
                                      CupertinoIcons.plus_circle,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _quantity += 0.5;
                                        _quantity = _quantity;
                                      });
                                    }),
                              ],
                            ),
                          );
                        }),
                        QuantifierSpinner(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                widget.kitchenItem == null
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
                                  final _op = ref.read(operationsProvider);
                                  final _item = Item(
                                    besoinTitle: '',
                                    dateBought:
                                        ref.read(pickedDateTime.state).state,
                                    itemName: _itemNameController.text.trim(),
                                    itemPrice: double.parse(
                                        _itemPriceController.text.trim()),
                                    quantifier:
                                        ref.read(selectedQuantifierProvider),
                                    quantity: _quantity,
                                    shopName: ref.read(pickedShop.state).state!,
                                  );
                                  logger.d(_item);
                                  if (_formKeyName.currentState!.validate() &&
                                      _formKeyPrice.currentState!.validate()) {
                                    _op.addItem(_item).then((value) {
                                      logger.d(value);
                                      if (value) {
                                        _formKeyName.currentState!.reset();
                                        _formKeyPrice.currentState!.reset();
                                      }
                                    });
                                  } //_op.addItem();
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
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Updating...'),
                                  ));
                                  final _op = ref.read(operationsProvider);
                                  final _item = Item(
                                    id: widget.kitchenItem!.id,
                                    besoinTitle: '',
                                    dateBought:
                                        ref.read(pickedDateTime.state).state,
                                    itemName: _itemNameController.text.trim(),
                                    itemPrice: double.parse(
                                        _itemPriceController.text.trim()),
                                    quantifier:
                                        ref.read(selectedQuantifierProvider),
                                    quantity: _quantity,
                                    shopName: ref.read(pickedShop.state).state!,
                                  );
                                  logger.d(_item);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Updated...'),
                                  ));
                                  if (_formKeyName.currentState!.validate() &&
                                      _formKeyPrice.currentState!.validate()) {
                                    _op.updateItem(_item).then((value) {
                                      if (value) {
                                        _formKeyName.currentState!.reset();
                                        _formKeyPrice.currentState!.reset();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('Item Updated'),
                                          duration: Duration(seconds: 1),
                                        ));
                                        Navigator.pop(context);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('Error'),
                                        ));
                                      }
                                    });
                                  } //_op.addItem();
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

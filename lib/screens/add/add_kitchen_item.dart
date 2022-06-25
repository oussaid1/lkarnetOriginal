import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/providers/operationsprovider/operations_provider.dart';
import 'package:lkarnet/settings/theme.dart';
import 'package:lkarnet/widgets/date_picker.dart';
import 'package:lkarnet/widgets/quantifier_spinner.dart';
import 'package:lkarnet/widgets/shop_spinner.dart';
import 'package:flutter/material.dart';

import '../../components.dart';
import '../../models/kitchen/kitchen_element.dart';
import '../../models/kitchen/kitchen_item.dart';
import '../../providers/streamproviders/items_stream_provider.dart';
import '../../widgets/kitchen_elements_spinner.dart';

class AddKitchenItem extends ConsumerStatefulWidget {
  final Item? item;
  final KitchenItem? kitchenItem;
  final KitchenElementModel? kitchenElement;
  AddKitchenItem({Key? key, this.kitchenItem, this.kitchenElement, this.item})
      : super(key: key);
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends ConsumerState<AddKitchenItem> {
  double _quantity = 1;
  String? _shop;
  String? _quantifier = 'واحدة';

  final GlobalKey<FormState> _formKeyName = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPrice = GlobalKey<FormState>();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();
  KitchenElementModel? _kitchenElement;

  DateTime _dateBought = DateTime.now();
  DateTime? _dateExpired;

  bool _isLoading = false;

  void _update() {
    // check if we have a kitchen item then update the fields
    if (widget.kitchenItem != null) {
      _itemNameController.text = widget.kitchenItem!.itemName.toString();
      _itemPriceController.text = (widget.kitchenItem!.itemPrice).toString();
      _quantity = widget.kitchenItem!.quantity;
      _shop = widget.kitchenItem!.shopName!;
      _quantifier = widget.kitchenItem!.quantifier!;
      _dateBought = widget.kitchenItem!.dateBought;
      _dateExpired = widget.kitchenItem!.dateExpired;
    }

    // check if we have an item then set all the variables to the values of the item
    if (widget.item != null) {
      _itemNameController.text = widget.item!.itemName.toString();
      _itemPriceController.text = (widget.item!.itemPrice).toString();
      _quantity = widget.item!.quantity;
      _shop = widget.item!.shopName;
      _quantifier = widget.item!.quantifier!;
      _dateBought = widget.item!.dateBought;
    }
  }

  void clearFields() {
    setState(() {
      _itemNameController.clear();
      _itemPriceController.clear();
      _quantity = 1;
      _shop = "";
      _quantifier = "";
      _dateBought = DateTime.now();
    });
  }

  @override
  void initState() {
    _update();
    super.initState();
  }

  @override
  void dispose() {
    clearFields();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Iterable<Item> _kOptions = ref.watch(itemsProvider.state).state;

    return GlassMaterial(
      circleWidgets: [
        Positioned(
          width: 100,
          height: 100,
          left: 10,
          top: 120,
          child: AppAssets.pinkCircleWidget,
        ),
        Positioned(
          width: 180,
          height: 180,
          right: 80,
          top: 200,
          child: AppAssets.purpleCircleWidget,
        ),
        Positioned(
          width: 140,
          height: 140,
          left: 30,
          bottom: 80,
          child: AppAssets.blueCircleWidget,
        ),
      ],
      gradientColors: AppConstants.myGradients,
      centerWidget: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.transparent,
          excludeHeaderSemantics: true,
          toolbarHeight: 40,
          backgroundColor: AppConstants.whiteOpacity,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppConstants.radius),
              bottom: Radius.circular(AppConstants.radius),
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            widget.kitchenElement != null ? "تعديل المادة" : "اضافة مادة",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        body: BluredContainer(
          margin: EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTitle(context),
                widget.item != null
                    ? _buildKitchenElementSpinner()
                    : SizedBox.shrink(),
                _buildShopSpinner(),
                _buildItemNameAutoComplete(context, _kOptions),
                _buildItemPrice(),
                _buildSelectDateBought(),
                _buildQuantityFier(),
                SizedBox(
                  height: 40,
                ),
                widget.kitchenItem == null
                    ? _buildSave(context)
                    : _buildUpdate(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildUpdate(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 120,
          child: ElevatedButton(
              child: Text(
                'Cancel',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: MThemeData.raisedButtonStyleCancel),
        ),
        Container(
          width: 120,
          child: ElevatedButton(
              child: Text(
                'Update',
              ),
              onPressed: _isLoading
                  ? null
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Updating...'),
                      ));
                      final _op = ref.read(operationsProvider);
                      final _kitchenItem = KitchenItem(
                        id: widget.kitchenItem!.id,
                        besoinTitle: '',
                        dateBought: _dateBought,
                        itemName: _itemNameController.text.trim(),
                        itemPrice:
                            double.tryParse(_itemPriceController.text.trim())!,
                        quantifier: _quantifier,
                        quantity: _quantity,
                        shopName: _shop,
                        dateExpired: _dateExpired,
                        kitchenElementId: widget.kitchenItem!.kitchenElementId,
                      );
                      log(_kitchenItem.toJson());

                      if (_formKeyName.currentState!.validate() &&
                          _formKeyPrice.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        _op.updateKitchenItem(_kitchenItem);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: AppConstants.greenOpacity,
                          content: Text('Item Updated'),
                          duration: Duration(seconds: 1),
                        ));
                        Navigator.pop(context);
                      }
                      // pop
                      //_op.addItem();
                    },
              style: MThemeData.raisedButtonStyleSave),
        ),
      ],
    );
  }

  Row _buildSave(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 120,
          child: ElevatedButton(
              child: Text(
                'Cancel',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: MThemeData.raisedButtonStyleCancel),
        ),
        Container(
          width: 120,
          child: ElevatedButton(
              child: Text(
                'Save',
              ),
              onPressed: _isLoading
                  ? null
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Saving...'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      final _op = ref.read(operationsProvider);
                      final _kitchenItem = KitchenItem(
                        besoinTitle: '',
                        dateBought: _dateBought,
                        itemName: _itemNameController.text.trim(),
                        itemPrice:
                            double.parse(_itemPriceController.text.trim()),
                        quantifier: _quantifier,
                        quantity: _quantity,
                        shopName: _shop,
                        dateExpired: _dateExpired,
                        kitchenElementId: widget.item == null
                            ? widget.kitchenElement!.id!
                            : _kitchenElement!.id!,
                      );
                      // _kitchenItem.toPrint();
                      if (_formKeyName.currentState!.validate() &&
                          _formKeyPrice.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        _op.addKitchenItem(_kitchenItem);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please fill all fields'),
                          ),
                        );
                      }
                    },
              style: MThemeData.raisedButtonStyleSave),
        ),
      ],
    );
  }

  Padding _buildQuantityFier() {
    return Padding(
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
            QuantifierSpinner(
              onValueChanged: (value) {
                setState(() {
                  _quantifier = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildSelectDateBought() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: AppConstants.whiteOpacity,
        ),
        child: Row(
          children: [
            SelectDate(
              onDateSelected: (DateTime date) {
                setState(() {
                  _dateBought = date;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Padding _buildItemPrice() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Form(
        key: _formKeyPrice,
        child: SizedBox(
          height: 50,
          child: TextFormField(
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: [
              //  FilteringTextInputFormatter.allow(RegExp("0-9]"))
              FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)')),
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
            keyboardType: TextInputType.numberWithOptions(decimal: true),
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
    );
  }

  Padding _buildItemNameAutoComplete(
      BuildContext context, Iterable<Item> _kOptions) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Form(
        key: _formKeyName,
        child: SizedBox(
          height: 50,
          child: TypeAheadField<Item>(
            noItemsFoundBuilder: (context) => Text('No Items Found'),
            autoFlipDirection: true,
            minCharsForSuggestions: 2,
            direction: AxisDirection.up,
            hideSuggestionsOnKeyboardHide: true,
            textFieldConfiguration: TextFieldConfiguration(
              onChanged: (text) {
                setState(() {
                  _isLoading = false;
                });
              },
              controller: _itemNameController,
              autofocus: true,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                // no border ,
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 4, right: 4, left: 4),
                fillColor: AppConstants.whiteOpacity,
                filled: true,
                hintText: 'title',
                //alignLabelWithHint: true,

                prefixIcon: Icon(
                  Icons.category,
                  color: Color.fromARGB(117, 212, 211, 211),
                ),
                suffix: IconButton(
                  icon: Icon(
                    Icons.clear_outlined,
                    size: 18,
                  ),
                  onPressed: () {
                    setState(() {
                      _itemNameController.clear();
                    });
                  },
                ),
                // border: OutlineInputBorder(),
              ),
            ),
            suggestionsCallback: (pattern) async {
              return _kOptions
                  .where((item) => item.itemName
                      .toLowerCase()
                      .startsWith(pattern.toLowerCase()))
                  .toList(growable: true);
            },
            itemBuilder: (context, suggestion) {
              return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppConstants.whiteOpacity,
                  ),
                  height: 40,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      suggestion.itemName,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ));
            },
            onSuggestionSelected: (suggestion) {
              _itemNameController.text = suggestion.itemName;
            },
          ),
        ),
      ),
    );
  }

  Row _buildShopSpinner() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(4),
          child: ShopSpinner(
            onShopSelected: (String? s) {
              setState(() {
                _shop = s!;
              });

              // ref.read(pickedShop.state).state = s;
            },
          ),
        ),
      ],
    );
  }

  Row _buildKitchenElementSpinner() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(4),
          child: KitchenElementsSpinner(
            onSelected: (KitchenElementModel? e) {
              _kitchenElement = e;
            },
          ),
        ),
      ],
    );
  }

  Padding _buildTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Add Kitchen Item to :',
                style: Theme.of(context).textTheme.bodyText1),
            widget.kitchenElement != null
                ? Text('${widget.kitchenElement!.title}',
                    style: Theme.of(context).textTheme.headline4)
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

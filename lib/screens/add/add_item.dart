import 'package:flutter/services.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/models/kitchen/kitchen_item.dart';
import 'package:lkarnet/providers/operationsprovider/operations_provider.dart';
import 'package:lkarnet/providers/varproviders/var_providers.dart';
import 'package:lkarnet/settings/theme.dart';
import 'package:lkarnet/widgets/date_picker.dart';
import 'package:lkarnet/widgets/kitchen_elements_spinner.dart';
import 'package:lkarnet/widgets/quantifier_spinner.dart';
import 'package:lkarnet/widgets/shop_spinner.dart';
import 'package:flutter/material.dart';

import '../../components.dart';
import '../../providers/streamproviders/items_stream_provider.dart';
import '../../widgets/item_listtile.dart';
import '../../widgets/number_incrementer.dart';

class AddItem extends ConsumerStatefulWidget {
  final Item? item;
  AddItem({this.item});
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends ConsumerState<AddItem>
    with SingleTickerProviderStateMixin {
  double _quantity = 1;
  final GlobalKey<FormState> _formKeyName = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPrice = GlobalKey<FormState>();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();

  DateTime _dateBought = DateTime.now();
//  KitchenElement? _kitchenElement;
  String? _quantifier = 'واحدة';
  String? _shop;
  bool _isLoading = false;
  Item? _localItem;
  void clear() {
    _itemNameController.clear();
    _itemPriceController.clear();
  }

  void _update() {
    if (widget.item != null) {
      _localItem = widget.item;
      _itemNameController.text = widget.item!.itemName;
      _itemPriceController.text = (widget.item!.itemPrice).toString();
      _quantity = widget.item!.quantity;
      _quantifier = widget.item!.quantifier;
    }
  }

  AnimationController? _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _update();
    super.initState();
  }

  @override
  void dispose() {
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
      gradientColors: [
        Color.fromARGB(255, 134, 32, 230),
        Color.fromARGB(255, 224, 101, 101),
        Color.fromARGB(255, 224, 101, 101),
      ],
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
            widget.item != null ? "تعديل المادة" : "اضافة مادة",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: BluredContainer(
              height: 460, // MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(
                top: 40,
                left: 10,
                right: 10,
                bottom: 20,
              ),
              child: Column(
                children: [
                  _buildShopSpinner(),
                  _buildItemName(context, _kOptions),
                  _buildItemPrice(),
                  _buildSelectDateBought(),
                  _buildQuantityFier(),
                  SizedBox(height: 50),
                  widget.item == null
                      ? _buildSaveButton(context)
                      : _buildUpdateButton(context),
                  // const SizedBox(height: 20),
                  // Container(
                  //   margin: EdgeInsets.all(8),
                  //   //  width: 300,
                  //   // height: 70,
                  //   child: ExpansionTile(
                  //     onExpansionChanged: (bool isExpanded) {
                  //       if (isExpanded) {
                  //         mBottomSheet(context, controller: _controller);
                  //       } else {}
                  //     },
                  //     title: Text(
                  //       'add to Kitchen',
                  //       style: Theme.of(context).textTheme.headline3,
                  //     ),
                  //     children: [
                  //       _localItem != null
                  //           ? AddToKitchenFromItem(
                  //               item: _localItem!,
                  //               op: ref.read(operationsProvider),
                  //             )
                  //           : SizedBox(child: Text("Pleasw save the item first")),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _buildUpdateButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 120,
          child: ElevatedButton(
              child: Text('Cancel'),
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
                style: Theme.of(context).textTheme.headline3,
              ),
              onPressed: _isLoading
                  ? null
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text('Updating...'),
                      ));
                      final _op = ref.read(operationsProvider);
                      final _item = Item(
                        id: widget.item!.id,
                        besoinTitle: '',
                        dateBought: ref.read(pickedDateTime.state).state,
                        itemName: _itemNameController.text.trim(),
                        itemPrice:
                            double.parse(_itemPriceController.text.trim()),
                        quantifier:
                            _quantifier, //ref.read(selectedQuantifierProvider),
                        quantity: _quantity,
                        shopName: _shop!, // ref.read(pickedShop.state).state!,
                      );
                      //  logger.d(_item);

                      if (_formKeyName.currentState!.validate() &&
                          _formKeyPrice.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        _op.updateItem(_item).then((value) {
                          if (value) {
                            _formKeyName.currentState!.reset();
                            _formKeyPrice.currentState!.reset();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: AppConstants.greenOpacity,
                              content: Text('Item Updated'),
                              duration: Duration(seconds: 1),
                            ));
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Error'),
                            ));
                          }
                        });
                      } //_op.addItem();
                    },
              style: MThemeData.raisedButtonStyleSave),
        ),
      ],
    );
  }

  Row _buildSaveButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 120,
          child: ElevatedButton(
              child: Text('Cancel'),
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
                style: Theme.of(context).textTheme.headline3,
              ),
              onPressed: _isLoading
                  ? null
                  : () {
                      // saving
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text('Saving...'),
                        ),
                      );
                      // setState(() {
                      //   _isLoading = true;
                      // });
                      final _op = ref.read(operationsProvider);
                      final _item = Item(
                          besoinTitle: '',
                          dateBought: _dateBought,
                          itemName: _itemNameController.text.trim(),
                          itemPrice:
                              double.parse(_itemPriceController.text.trim()),
                          quantifier: _quantifier,
                          quantity: _quantity,
                          shopName: _shop! //ref.read(pickedShop.state).state!,
                          );
                      // logger.d(_item);
                      if (_formKeyName.currentState!.validate() &&
                          _formKeyPrice.currentState!.validate() &&
                          _shop != null) {
                        _localItem = _item;
                        setState(() {
                          _isLoading = true;
                        });
                        _op.addItem(_item);

                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //         content: Text('Saved'),
                        //         duration: Duration(seconds: 1),
                        //         backgroundColor: AppConstants
                        //             .greenOpacity) //AppConstants.greenOpacity
                        //     );
                        // _itemNameController.clear();
                        //_itemPriceController.clear();
                        //_quantity = 1;
                      }
                      mBottomSheet(context, controller: _controller);

                      // popup dialog do you want to save to kitchen
                    },
              style: MThemeData.raisedButtonStyleSave),
        ),
      ],
    );
  }

  // build bottomsheet for add item
  void mBottomSheet(
    BuildContext context, {
    AnimationController? controller,
    // required Widget child,
  }) {
    showModalBottomSheet(
        transitionAnimationController: controller,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        // backgroundColor: Colors.black,
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        builder: (_) {
          return Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 189, 110, 110),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
            ),
            height: 160,
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: AddToKitchenFromItem(
                item: _localItem!,
                op: ref.read(operationsProvider),
              ),
            ),
          );
        });
  }

  Row _buildQuantityFier() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        NumberIncrementer(
          onDecrement: (value) {
            setState(() {
              _quantity = value;
            });
          },
          onIncrement: (value) {
            setState(() {
              _quantity = value;
            });
          },
          // value: _quantity,
        ),
        Container(
          child: QuantifierSpinner(
            onValueChanged: (value) {
              setState(() {
                _quantifier = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Padding _buildSelectDateBought() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SelectDate(
        onDateSelected: (DateTime date) {
          setState(() {
            _dateBought = date;
          });
        },
      ),
    );
  }

  Padding _buildShopSpinner() {
    return Padding(
      padding: EdgeInsets.all(2),
      child: ShopSpinner(
        //: ref.watch(shopsProvider.state).state,
        onShopSelected: (value) {
          setState(() {
            _shop = value;
          });
        },
      ),
    );
  }

  Padding _buildItemName(BuildContext context, Iterable<Item> _kOptions) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Form(
        key: _formKeyName,
        child: SizedBox(
          height: 50,
          child: TypeAheadField<Item>(
            autoFlipDirection: true,
            minCharsForSuggestions: 2,
            direction: AxisDirection.up,
            hideSuggestionsOnKeyboardHide: true,
            textFieldConfiguration: TextFieldConfiguration(
              controller: _itemNameController,
              autofocus: true,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                //no borders,
                border: InputBorder.none,

                contentPadding: EdgeInsets.only(top: 4, right: 4, left: 4),
                fillColor: AppConstants.whiteOpacity,
                filled: true,
                hintText: 'title',
                //alignLabelWithHint: true,

                prefixIcon: Icon(
                  Icons.shopping_basket,
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
              return ItemTileWidget(
                item: suggestion,
              );
            },
            onSuggestionSelected: (suggestion) {
              _itemNameController.text = suggestion.itemName;
              _itemPriceController.text = suggestion.itemPrice.toString();
              _quantity = suggestion.quantity;
              ref.read(pickedDateTime.state).state = suggestion.dateBought;
            },
          ),
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
            //autovalidateMode: AutovalidateMode.disabled,
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
              border: InputBorder.none,
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
}

class AddToKitchenFromItem extends StatefulWidget {
  const AddToKitchenFromItem({Key? key, required this.item, required this.op})
      : super(key: key);
  final Item item;
  final Operations op;
  @override
  State<AddToKitchenFromItem> createState() => _StateAddToKitchenFromItem();
}

class _StateAddToKitchenFromItem extends State<AddToKitchenFromItem> {
  KitchenElement? _kitchenElement;
  // bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Select kitchen Element to add item to '),
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
                    style: Theme.of(context).textTheme.headline3,
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
                          widget.op.addKitchenItem(KitchenItem.fromItem(
                              widget.item, _kitchenElement!));
                          Navigator.of(context).pop();
                        },
                  style: MThemeData.raisedButtonStyleSave),
            ),
            // const SizedBox(width: 4),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

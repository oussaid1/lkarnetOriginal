import 'package:flutter/cupertino.dart';
import 'package:lkarnet/settings/theme.dart';
import 'package:lkarnet/widgets/date_picker.dart';
import 'package:lkarnet/widgets/quantifier_spinner.dart';
import 'package:flutter/material.dart';

import '../../components.dart';
import '../../models/kitchen/kitchen_item.dart';

class AddItem extends ConsumerStatefulWidget {
  final KitchenElement? kitchenElement;
  AddItem({this.kitchenElement});
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends ConsumerState<AddItem> {
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
          height: 440,
          width: 400,
          child: BluredContainer(
            child: Column(
              children: [
                // Padding(
                //   padding: EdgeInsets.only(top: 20, bottom: 8),
                //   child: ShopSpinner(),
                // ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
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
                      onSelected: (KitchenElement selection) {},
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SelectDate(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Consumer(builder: (context, ref, child) {
                      return Card(
                        color: AppConstants.whiteOpacity,
                        child: Container(
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
                        ),
                      );
                    }),
                    Container(
                      child: QuantifierSpinner(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
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
                                  // final _op = ref.read(operationsProvider);
                                  // final _item = KitchenElement();
                                  // logger.d(_item);
                                  // if (_formKeyName.currentState!.validate() &&
                                  //     _formKeyPrice.currentState!.validate()) {
                                  //   _op.addItem(_item).then((value) {
                                  //     logger.d(value);
                                  //     if (value) {
                                  //       _formKeyName.currentState!.reset();
                                  //       _formKeyPrice.currentState!.reset();
                                  //     }
                                  //   });
                                  // } //_op.addItem();
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
                                  //   final _op = ref.read(operationsProvider);
                                  //   final _item = KitchenElement(
                                  //     id: widget.kitchenElement!.id,
                                  //     besoinTitle: '',
                                  //     dateBought:
                                  //         ref.read(pickedDateTime.state).state,
                                  //     itemName: _itemNameController.text.trim(),
                                  //     itemPrice: double.parse(
                                  //         _itemPriceController.text.trim()),
                                  //     quantifier:
                                  //         ref.read(selectedQuantifierProvider),
                                  //     quantity: _quantity,
                                  //     shopName: ref.read(pickedShop.state).state!,
                                  //   );
                                  //   logger.d(_item);
                                  //   ScaffoldMessenger.of(context)
                                  //       .showSnackBar(SnackBar(
                                  //     content: Text('Updating...'),
                                  //   ));
                                  //   if (_formKeyName.currentState!.validate() &&
                                  //       _formKeyPrice.currentState!.validate()) {
                                  //     _op.updateItem(_item).then((value) {
                                  //       if (value) {
                                  //         _formKeyName.currentState!.reset();
                                  //         _formKeyPrice.currentState!.reset();
                                  //         ScaffoldMessenger.of(context)
                                  //             .showSnackBar(SnackBar(
                                  //           content:
                                  //               Text('KitchenElement Updated'),
                                  //           duration: Duration(seconds: 1),
                                  //         ));
                                  //         Navigator.pop(context);
                                  //       } else {
                                  //         ScaffoldMessenger.of(context)
                                  //             .showSnackBar(SnackBar(
                                  //           content: Text('Error'),
                                  //         ));
                                  //       }
                                  //     });
                                  //   } //_op.addItem();
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

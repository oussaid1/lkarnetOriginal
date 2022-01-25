import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/providers/operationsprovider/operations_provider.dart';
import 'package:lkarnet/providers/varproviders/var_providers.dart';
import 'package:lkarnet/settings/theme.dart';
import 'package:lkarnet/widgets/date_picker.dart';
import 'package:lkarnet/widgets/glasswidget.dart';
import 'package:lkarnet/widgets/quantifier_spinner.dart';
import 'package:lkarnet/widgets/shop_spinner.dart';

import '../../providers/streamproviders/items_stream_provider.dart';

class AddItem extends ConsumerStatefulWidget {
  final Item? item;
  AddItem({this.item});
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends ConsumerState<AddItem> {
  double _quantity = 1;
  final GlobalKey<FormState> _formKeyName = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyPrice = GlobalKey<FormState>();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemPriceController = TextEditingController();

  void _update() {
    if (widget.item != null) {
      setState(() {
        _itemNameController.text = widget.item!.itemName.toString();
        _itemPriceController.text = (widget.item!.itemPrice).toString();
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
    Iterable<String> _kOptions = ref
        .watch(itemsProvider.state)
        .state
        .map((item) => item.itemName)
        .toSet()
        .toList();
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: SizedBox(
          height: 420,
          width: 400,
          child: BluredContainer(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 8),
                  child: ShopSpinner(),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Form(
                    key: _formKeyName,
                    child: Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }
                        return _kOptions.where((String option) {
                          return option
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (String selection) {
                        _itemNameController.text = selection;
                      },
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController textEditingController,
                          FocusNode focusNode,
                          VoidCallback onFieldSubmitted) {
                        return TextFormField(
                          controller: _itemNameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Entrer le nom de l\'article',
                            hintStyle: GoogleFonts.lato(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter some text';
                            }
                            return null;
                          },
                        );
                      },
                      // controller: _itemNameController,
                      // validator: (text) {
                      //   if (text!.isEmpty) {
                      //     return '';
                      //   }
                      //   return null;
                      // },
                      // onChanged: (text) => itemName = text.trim().toString(),
                      // decoration: InputDecoration(
                      //   border: new OutlineInputBorder(
                      //     borderRadius: new BorderRadius.circular(6.0),
                      //     borderSide: new BorderSide(
                      //         color: Theme.of(context).primaryColor,
                      //         style: BorderStyle.none),
                      //   ),
                      //   hintText: 'product name',
                      //   hintStyle: GoogleFonts.robotoSlab(),
                      //   contentPadding: EdgeInsets.only(top: 4),
                      //   labelText: 'Name',
                      //   prefixIcon: Icon(
                      //     Icons.shopping_cart,
                      //     color: Colors.grey,
                      //   ),
                      //   filled: true,
                      //   fillColor: MThemeData.blurWhite,
                      // ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Form(
                    key: _formKeyPrice,
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
                      onChanged: (text) =>
                          _itemPriceController.text = text.trim(),
                      textAlign: TextAlign.center,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(6.0),

                          // borderSide: new BorderSide(width: 0.5),
                        ),
                        hintText: ' 00.00',
                        hintStyle: GoogleFonts.robotoSlab(),
                        contentPadding: EdgeInsets.only(top: 4),
                        prefixIcon: Icon(
                          Icons.monetization_on_outlined,
                          color: Colors.grey,
                        ),
                        fillColor: MThemeData.blurWhite,
                        filled: true,
                        labelText: 'Price',
                      ),
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
                        color: MThemeData.blurWhite,
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
                widget.item != null
                    ? _buildUpdate(context)
                    : _buildSave(context, ref),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildSave(BuildContext context, ref) {
    return Row(
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
                  dateBought: ref.read(pickedDateTime),
                  itemName: _itemNameController.text.trim(),
                  itemPrice: double.parse(_itemPriceController.text.trim()),
                  quantifier: ref.read(selectedQuantifierProvider),
                  quantity: _quantity,
                  shopName: ref.read(pickedShop),
                );
                if (_formKeyName.currentState!.validate() &&
                    _formKeyPrice.currentState!.validate()) {
                  _op.addItem(_item).then((value) {
                    if (value) {
                      _formKeyName.currentState!.reset();
                      _formKeyPrice.currentState!.reset();
                    } else {}
                  });
                } //_op.addItem();
              },
              style: MThemeData.textButtonStyleSave),
        ),
      ],
    );
  }

  Row _buildUpdate(BuildContext context) {
    return Row(
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
                final _op = ref.read(operationsProvider);
                final _item = Item(
                  id: widget.item!.id,
                  besoinTitle: '',
                  dateBought: ref.read(pickedDateTime),
                  itemName: _itemNameController.text.trim(),
                  itemPrice: double.parse(_itemPriceController.text.trim()),
                  quantifier: ref.read(selectedQuantifierProvider),
                  quantity: _quantity,
                  shopName: ref.read(pickedShop.state).state!,
                );
                if (_formKeyName.currentState!.validate() &&
                    _formKeyPrice.currentState!.validate()) {
                  _op.updateItem(_item).then((value) {
                    if (value) {
                      _formKeyName.currentState!.reset();
                      _formKeyPrice.currentState!.reset();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
              style: MThemeData.textButtonStyleSave),
        ),
      ],
    );
  }
}

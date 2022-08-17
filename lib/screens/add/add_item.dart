import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:lkarnet/blocs/itemsbloc/items_bloc.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/providers/varproviders/var_providers.dart';
import 'package:lkarnet/repository/database_operations.dart';
import 'package:lkarnet/settings/theme.dart';
import 'package:lkarnet/widgets/date_picker.dart';
import 'package:lkarnet/widgets/quantifier_spinner.dart';
import 'package:lkarnet/widgets/shop_spinner.dart';
import 'package:flutter/material.dart';

import '../../components.dart';
import '../../providers/streamproviders/items_stream_provider.dart';
import '../../widgets/add_to_kitchen_from_item.dart';
import '../../widgets/item_listtile.dart';
import '../../widgets/number_incrementer.dart';

class AddItem extends ConsumerStatefulWidget {
  final ItemModel? item;
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
  FocusNode _itemNameFocusNode = FocusNode();
  DateTime _dateBought = DateTime.now();
//  KitchenElement? _kitchenElement;
  String? _quantifier = 'واحدة';
  String? _shop;
  bool _isUpdate = false, _canSave = false;
  ItemModel? _localItem;
  void clear() {
    _itemNameController.clear();
    _itemPriceController.clear();
  }

  void _update() {
    if (widget.item != null) {
      _isUpdate = true;
      //   _localItem = widget.item;
      _itemNameController.text = widget.item!.itemName;
      _itemPriceController.text = (widget.item!.itemPrice).toString();
      _quantity = widget.item!.quantity;
      _quantifier = widget.item!.quantifier;
      _dateBought = widget.item!.dateBought;
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
    _controller?.dispose();
    super.dispose();
  }

  final _itmBloc =
      ItemsBloc(databaseOperations: GetIt.I.get<DatabaseOperations>());
  @override
  Widget build(BuildContext context) {
    Iterable<ItemModel> _kOptions = ref.watch(itemsProvider.state).state;

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
                  _buildUpdateButton(context),
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
              child: Text(_isUpdate ? 'Update' : 'Add'),
              onPressed: !_canSave
                  ? null
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text(_isUpdate ? 'updating...' : 'Saving...'),
                      ));

                      if (_formKeyName.currentState!.validate() &&
                          _formKeyPrice.currentState!.validate()) {
                        _isUpdate ? update() : save();
                      }
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
        backgroundColor: Colors.white.withOpacity(0.5),
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        builder: (_) {
          return Container(
            decoration: BoxDecoration(
              //color: Color.fromARGB(255, 189, 110, 110),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
            ),
            height: 160,
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: AddToKitchenFromItem(
                item: _localItem!,
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
        initialValue: widget.item?.shopName,
        focusNode: _itemNameFocusNode,
        //: ref.watch(shopsProvider.state).state,
        onShopSelected: (value) {
          setState(() {
            _shop = value!.shopName ?? '';
          });
        },
      ),
    );
  }

  Padding _buildItemName(BuildContext context, Iterable<ItemModel> _kOptions) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Form(
        key: _formKeyName,
        child: SizedBox(
          height: 50,
          child: TypeAheadField<ItemModel>(
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            autoFlipDirection: true,
            minCharsForSuggestions: 2,
            direction: AxisDirection.up,
            hideSuggestionsOnKeyboardHide: true,
            textFieldConfiguration: TextFieldConfiguration(
              focusNode: _itemNameFocusNode,
              onChanged: (value) => setState(() {
                _canSave = _itemNameController.text.trim().trim().isNotEmpty;
              }),
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
              return SizedBox(
                width: 300,
                child: ItemTileWidget(
                  item: suggestion,
                ),
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
            onChanged: (value) {
              setState(() {
                _canSave = _itemNameController.text.trim().trim().isNotEmpty;
              });
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

  /// save the item to the database
  save() {
    setState(() => _canSave = true);
    final ItemModel item = ItemModel(
      itemName: _itemNameController.text.trim(),
      itemPrice: double.parse(_itemPriceController.text.trim()),
      quantity: _quantity,
      dateBought: _dateBought,
      shopName: _shop ?? '',
      quantifier: _quantifier,
    );
    _localItem = item;
    _itmBloc.add(AddItemEvent(item));
    mBottomSheet(context, controller: _controller);
    clear();
    Navigator.of(context).pop();
  }

  /// update the item in the database
  update() {
    setState(() => _canSave = true);
    final ItemModel item = ItemModel(
      itemName: _itemNameController.text.trim(),
      itemPrice: double.parse(_itemPriceController.text.trim()),
      quantity: _quantity,
      dateBought: _dateBought,
      shopName: _shop ?? '',
      quantifier: _quantifier,
    );
    // _localItem=item;
    _itmBloc.add(UpdateItemEvent(item));
    //mBottomSheet(context, controller: _controller);
    clear();
    Navigator.of(context).pop();
  }
}

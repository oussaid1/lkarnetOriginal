import 'package:flutter/services.dart';
import 'package:lkarnet/components.dart';

import 'package:lkarnet/models/shop/shop_model.dart';
import 'package:lkarnet/providers/operationsprovider/operations_provider.dart';
import 'package:lkarnet/settings/theme.dart';

class AddShop extends ConsumerStatefulWidget {
  final ShopModel? shop;
  const AddShop({
    Key? key,
    this.shop,
  }) : super(key: key);
  @override
  _AddShopState createState() => _AddShopState();
}

class _AddShopState extends ConsumerState<AddShop> {
  final GlobalKey<FormState> _formKeyShop = GlobalKey<FormState>();
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _shopEmailController = TextEditingController();
  final TextEditingController _shopPhoneController = TextEditingController();
  final TextEditingController _shopLimitController = TextEditingController();
  final TextEditingController _shopBesoinController = TextEditingController();
  void _update() {
    if (widget.shop != null) {
      _shopNameController.text = widget.shop!.shopName.toString();
      _shopEmailController.text = widget.shop!.email.toString();
      _shopLimitController.text = (widget.shop!.limit.toString());
      _shopBesoinController.text = widget.shop!.besoinTitle.toString();
      _shopPhoneController.text = widget.shop!.phone.toString();
    }
  }

  void clear() {
    _shopNameController.clear();
    _shopEmailController.clear();
    _shopLimitController.clear();
    _shopBesoinController.clear();
    _shopPhoneController.clear();
  }

  @override
  void initState() {
    super.initState();
    _update();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: SizedBox(
          width: 400,
          height: 460,
          child: BluredContainer(
            child: Form(
              key: _formKeyShop,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: _shopNameController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'shop-name',
                          hintStyle: GoogleFonts.robotoSlab(),
                          contentPadding: EdgeInsets.only(top: 4),
                          prefixIcon: Icon(
                            Icons.person,
                          ),
                          filled: true,
                          label: Text(
                            'name',
                            style: GoogleFonts.robotoSlab(),
                          ),
                          fillColor: AppConstants.whiteOpacity,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: _shopEmailController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'email',
                          hintStyle: GoogleFonts.robotoSlab(),
                          contentPadding: EdgeInsets.only(top: 4),
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                          filled: true,
                          label: Text(
                            'email',
                            style: GoogleFonts.robotoSlab(),
                          ),
                          fillColor: AppConstants.whiteOpacity,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: _shopPhoneController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'phone-number',
                          hintStyle: GoogleFonts.robotoSlab(),
                          contentPadding: EdgeInsets.only(top: 4),
                          prefixIcon: Icon(
                            Icons.phone,
                          ),
                          filled: true,
                          label: Text(
                            'phone',
                            style: GoogleFonts.robotoSlab(),
                          ),
                          fillColor: AppConstants.whiteOpacity,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        controller: _shopBesoinController,
                        decoration: InputDecoration(
                          hintText: 'category',
                          hintStyle: GoogleFonts.robotoSlab(),
                          contentPadding: EdgeInsets.only(top: 4),
                          prefixIcon: Icon(
                            Icons.category,
                          ),
                          filled: true,
                          label: Text(
                            'category',
                            style: GoogleFonts.robotoSlab(),
                          ),
                          fillColor: AppConstants.whiteOpacity,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: [
                          //  FilteringTextInputFormatter.allow(RegExp("0-9]"))
                          FilteringTextInputFormatter.allow(
                              RegExp(r'(^\-?\d*\.?\d*)')),
                        ],
                        validator: (text) {
                          if (text!.isEmpty) {
                            return '';
                          } else if (text.contains(RegExp(r'[A-Z]'))) {
                            return '';
                          } else {
                            return null;
                          }
                        },
                        controller: _shopLimitController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: ' 00.00',
                          hintStyle: GoogleFonts.robotoSlab(),
                          contentPadding: EdgeInsets.only(top: 4),
                          prefixIcon: Icon(
                            Icons.monetization_on,
                          ),
                          fillColor: AppConstants.whiteOpacity,
                          filled: true,
                          label: Text(
                            'limit',
                            style: GoogleFonts.robotoSlab(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    widget.shop == null
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
                                  style: MThemeData.textButtonStyleCancel,
                                ),
                              ),
                              Container(
                                width: 120,
                                child: TextButton(
                                    child: Text(
                                      'Save',
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                    onPressed: () {
                                      final _op = ref.read(operationsProvider);
                                      final ShopModel _shop = ShopModel(
                                        shopName:
                                            _shopNameController.text.trim(),
                                        phone: _shopPhoneController.text.trim(),
                                        besoinTitle:
                                            _shopBesoinController.text.trim(),
                                        limit: double.parse(
                                            _shopLimitController.text.trim()),
                                      );
                                      if (_formKeyShop.currentState!
                                          .validate()) {
                                        _op.addShop(_shop).then((value) {
                                          if (value) clear();
                                          Navigator.of(context).pop();
                                        });
                                      }
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
                                  style: MThemeData.textButtonStyleCancel,
                                ),
                              ),
                              Container(
                                width: 120,
                                child: TextButton(
                                  child: Text(
                                    'Update',
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  onPressed: () {
                                    final _op = ref.read(operationsProvider);
                                    final ShopModel _shop = ShopModel(
                                      id: widget.shop!.id,
                                      shopName: _shopNameController.text.trim(),
                                      phone: _shopPhoneController.text.trim(),
                                      besoinTitle:
                                          _shopBesoinController.text.trim(),
                                      limit: double.parse(
                                          _shopLimitController.text.trim()),
                                    );
                                    if (_formKeyShop.currentState!.validate()) {
                                      _op.updateShop(_shop).then((value) {
                                        if (value) Navigator.pop(context);
                                      });
                                    }
                                  },
                                  style: MThemeData.raisedButtonStyleCancel,
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

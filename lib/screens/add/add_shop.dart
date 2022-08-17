import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:lkarnet/blocs/shopsbloc/shops_bloc.dart';
import 'package:lkarnet/components.dart';

import 'package:lkarnet/models/shop/shop_model.dart';
import 'package:lkarnet/repository/database_operations.dart';
import 'package:lkarnet/settings/theme.dart';
import 'package:flutter/material.dart';

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
  bool _canSave = false;
  void _updateControllers() {
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
    _updateControllers();
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }

  final _shopBloc = ShopsBloc((GetIt.I.get<DatabaseOperations>()));
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
                        onChanged: (text) {
                          setState(() {
                            _canSave =
                                _shopBesoinController.text.trim().isNotEmpty;
                          });
                        },
                        maxLength: 20,
                        decoration: InputDecoration(
                          counterText: '',
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
                          // if (text!.isEmpty) {
                          //   return '';
                          // }
                          return null;
                        },
                        maxLength: 50,
                        decoration: InputDecoration(
                          counterText: '',
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
                          // if (text!.isEmpty) {
                          //   return '';
                          // }
                          return null;
                        },
                        maxLength: 10,
                        decoration: InputDecoration(
                          counterText: '',
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
                        maxLength: 10,
                        decoration: InputDecoration(
                          counterText: '',
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
                        maxLength: 10,
                        decoration: InputDecoration(
                          counterText: '',
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
                    Row(
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
                            style: MThemeData.raisedButtonStyleCancel,
                          ),
                        ),
                        Container(
                          width: 120,
                          child: ElevatedButton(
                              child: Text(
                                widget.shop == null ? 'Save' : 'Update',
                              ),
                              onPressed: !_canSave
                                  ? null
                                  : () {
                                      if (_formKeyShop.currentState!
                                          .validate()) {
                                        if (widget.shop == null) {
                                          _saveShop();
                                        } else {
                                          _updateShop();
                                        }
                                      }
                                    },
                              style: MThemeData.raisedButtonStyleSave),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// save shop
  void _saveShop() {
    setState(() {
      _canSave = false;
    });
    var shop = ShopModel(
      shopName: _shopNameController.text.trim(),
      email: _shopEmailController.text.trim(),
      phone: _shopPhoneController.text.trim(),
      besoinTitle: _shopBesoinController.text.trim(),
      limit: double.parse(_shopLimitController.text),
    );
    _shopBloc.add(AddShopEvent(shop));
    clear();
  }

  /// update shop
  void _updateShop() {
    setState(() {
      _canSave = false;
    });
    var shop = ShopModel(
      shopName: _shopNameController.text.trim(),
      email: _shopEmailController.text.trim(),
      phone: _shopPhoneController.text.trim(),
      besoinTitle: _shopBesoinController.text.trim(),
      limit: double.parse(_shopLimitController.text),
    );
    _shopBloc.add(UpdateShopEvent(shop));
    clear();
  }
}

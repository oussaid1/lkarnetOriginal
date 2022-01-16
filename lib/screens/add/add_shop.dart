import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lkarnet/models/shop/shop_model.dart';
import 'package:lkarnet/providers/operationsprovider/operations_provider.dart';
import 'package:lkarnet/providers/varproviders/add_shop_provider.dart';
import 'package:lkarnet/settings/theme.dart';
import 'package:lkarnet/widgets/glasswidget.dart';

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
  void _update(BuildContext context) {
    if (widget.shop != null) {
      _shopNameController.text = shopName = widget.shop!.shopName.toString();
      _shopEmailController.text = shopEmail = widget.shop!.email.toString();
      _shopLimitController.text = (widget.shop!.limit.toString());
      shopLimit = widget.shop!.limit!;
      _shopPhoneController.text = shopPhone = widget.shop!.phone.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    _update(context);
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: SizedBox(
          width: 400,
          height: 460,
          child: GlassContainer(
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
                        onChanged: (text) => shopName = text.trim(),
                        decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(6.0),
                          ),
                          hintText: 'shop-name',
                          hintStyle: GoogleFonts.robotoSlab(),
                          contentPadding: EdgeInsets.only(top: 4),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                          filled: true,
                          label: Text(
                            'name',
                            style: GoogleFonts.robotoSlab(),
                          ),
                          fillColor: MThemeData.blurWhite,
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
                        onChanged: (text) => shopEmail = text.trim(),
                        decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(6.0),
                            borderSide: new BorderSide(
                                color: Theme.of(context).primaryColor,
                                style: BorderStyle.none),
                          ),
                          hintText: 'email',
                          hintStyle: GoogleFonts.robotoSlab(),
                          contentPadding: EdgeInsets.only(top: 4),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                          filled: true,
                          label: Text(
                            'email',
                            style: GoogleFonts.robotoSlab(),
                          ),
                          fillColor: MThemeData.blurWhite,
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
                        onChanged: (text) => shopPhone = text.trim(),
                        decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(6.0),
                            borderSide: new BorderSide(
                                color: Theme.of(context).primaryColor,
                                style: BorderStyle.none),
                          ),
                          hintText: 'phone-number',
                          hintStyle: GoogleFonts.robotoSlab(),
                          contentPadding: EdgeInsets.only(top: 4),
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.grey,
                          ),
                          filled: true,
                          label: Text(
                            'phone',
                            style: GoogleFonts.robotoSlab(),
                          ),
                          fillColor: MThemeData.blurWhite,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextFormField(
                        onChanged: (text) {
                          slectedShopBesoinTitle = text.trim();
                        },
                        decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(6.0),
                            borderSide: new BorderSide(
                                color: Theme.of(context).primaryColor,
                                style: BorderStyle.none),
                          ),
                          hintText: 'shopping',
                          hintStyle: GoogleFonts.robotoSlab(),
                          contentPadding: EdgeInsets.only(top: 4),
                          prefixIcon: Icon(
                            Icons.category,
                            color: Colors.grey,
                          ),
                          filled: true,
                          label: Text(
                            'shopping',
                            style: GoogleFonts.robotoSlab(),
                          ),
                          fillColor: MThemeData.blurWhite,
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
                        onChanged: (text) =>
                            shopLimit = double.tryParse(text.trim())!,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(6.0),
                            borderSide: new BorderSide(),
                          ),
                          hintText: ' 00.00',
                          hintStyle: GoogleFonts.robotoSlab(),
                          contentPadding: EdgeInsets.only(top: 4),
                          prefixIcon: Icon(
                            Icons.monetization_on,
                            color: Colors.grey,
                          ),
                          fillColor: MThemeData.blurWhite,
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
                    widget.shop != null
                        ? _buildUpdate(context)
                        : _buildSave(context, ref),
                  ],
                ),
              ),
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
            style: MThemeData.textButtonStyleCancel,
          ),
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
                if (_formKeyShop.currentState!.validate()) {
                  _op.addShop().then((value) {
                    if (value) _formKeyShop.currentState!.reset();
                  });
                }
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
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.headline3,
              minimumSize: Size(88, 36),
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 8),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
            ),
          ),
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
              if (_formKeyShop.currentState!.validate()) {
                _op.updateShop(widget.shop!.id!).then((value) {
                  if (value) Navigator.pop(context);
                });
              }
            },
            style: MThemeData.raisedButtonStyleCancel,
          ),
        ),
      ],
    );
  }
}

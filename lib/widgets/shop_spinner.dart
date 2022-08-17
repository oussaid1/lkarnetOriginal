import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lkarnet/models/shop/shop_model.dart';
import 'package:lkarnet/components.dart';
import 'package:flutter/material.dart';
import '../blocs/shopsbloc/shops_bloc.dart';

class ShopSpinner extends StatefulWidget {
  const ShopSpinner({
    Key? key,
    required this.onShopSelected,
    this.focusNode,
    this.initialValue,
  }) : super(key: key);
  final void Function(ShopModel?) onShopSelected;
  final FocusNode? focusNode;
  final String? initialValue;
  @override
  State<ShopSpinner> createState() => _ShopSpinnerState();
}

class _ShopSpinnerState extends State<ShopSpinner> {
  ShopModel? _selectedShop;
  List<ShopModel> _shops = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopsBloc, ShopsState>(
      builder: (context, state) {
        if (state.shops.isNotEmpty) {
          _shops = state.shops;
          if (widget.initialValue != null) {
            _selectedShop = _shops.firstWhere(
              (shop) => shop.id == widget.initialValue,
              orElse: () => _selectedShop!,
            );
          }
        }
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppConstants.whiteOpacity,
          ),
          width: 200.0,
          margin: EdgeInsets.all(8),
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonTheme(
              // focusColor: Colors.red,
              //highlightColor: Colors.red,
              alignedDropdown: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.radius),
              ),
              child: DropdownButtonFormField<ShopModel>(
                borderRadius: BorderRadius.circular(AppConstants.radius),
                dropdownColor:
                    Color.fromARGB(108, 255, 255, 255).withOpacity(0.6),
                alignment: Alignment.center,
                autofocus: true,
                autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(0),
                ),
                elevation: 4,
                iconSize: 30,
                validator: (value) {
                  if (value == null) {
                    return 'please select shop first !';
                  }
                  return null;
                },
                icon: Icon(Icons.arrow_drop_down),
                isExpanded: false,
                // hint: Text(
                //   "Select Shop",
                //   textAlign: TextAlign.center,
                //   style: Theme.of(context).textTheme.subtitle2,
                // ),
                value: _selectedShop,
                focusColor: AppConstants.primaryColor,
                onChanged: (value) {
                  widget.onShopSelected(value);

                  widget.focusNode != null
                      ? widget.focusNode!.requestFocus()
                      : null;
                },
                items: _shops.map((shop) {
                  return DropdownMenuItem<ShopModel>(
                    value: shop,
                    child: Text(
                      shop.shopName ?? '',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

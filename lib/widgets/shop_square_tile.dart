import 'package:flutter/material.dart';
import 'package:lkarnet/widgets/price_curency_widget.dart';

import '../const/constents.dart';
import '../models/shop/shops_data.dart';
import 'glasswidget.dart';

class ShopSquareTile extends StatelessWidget {
  const ShopSquareTile({
    Key? key,
    required this.onTap,
    required this.shopData,
  }) : super(key: key);

  final VoidCallback? onTap;
  final ShopData shopData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color.fromARGB(70, 227, 199, 250),
            offset: Offset(4, 0),
            blurStyle: BlurStyle.normal,
            blurRadius: 10,
          ),
          BoxShadow(
            color: Color.fromARGB(70, 227, 199, 250),
            offset: Offset(-4, 4),
            blurStyle: BlurStyle.normal,
            blurRadius: 10,
          ),
        ]),
        child: BluredContainer(
          height: 100,
          width: 160,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${shopData.shop.shopName}',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  PriceNumberZone(
                    right: const SizedBox.shrink(),
                    withDollarSign: true,
                    price: shopData.shopDataCalculations.itemsSumAfterPayment,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: AppConstants.hintColor,
                        ),
                  ),
                  //const SizedBox(height: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

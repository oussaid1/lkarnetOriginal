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
      child: BluredContainer(
        margin: const EdgeInsets.all(8),
        height: 100,
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PriceNumberZone(
              right: const SizedBox.shrink(),
              withDollarSign: true,
              price: shopData.itemsSumAfterPayment,
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: AppConstants.hintColor,
                  ),
            ),
            Text(
              '${shopData.shop.shopName}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
            //const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../components.dart';
import '../models/shop/shops_data.dart';
import 'price_curency_widget.dart';

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
        height: 100,
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '${shopData.shop.shopName}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ],
            ),
            // PriceNumberZone(
            //   right: const SizedBox.shrink(),
            //   withDollarSign: true,
            //   price: shopData.shopDataCalculations.itemsSumAfterPayment,
            //   style: Theme.of(context).textTheme.headline3!.copyWith(
            //         color: AppConstants.hintColor,
            //       ),
            // ),
            //const SizedBox(height: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: 40,
              width: 158,
              decoration: BoxDecoration(
                  color: Color.fromARGB(59, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'limit',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '${shopData.shop.dailyLimit}',
                      style: Theme.of(context).textTheme.subtitle2,
                      children: <TextSpan>[
                        TextSpan(
                          text: '/',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        TextSpan(text: '${shopData.shop.limit}'),
                      ],
                    ),
                  ),
                  Icon(Icons.play_arrow_rounded, color: Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// this is used to create the shop data card that will be displayed in the shopdetailsmain section

class SimpleShopSquareTile extends StatelessWidget {
  const SimpleShopSquareTile({
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
        height: 80,
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    '${shopData.shop.shopName}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ],
            ),
            PriceNumberZone(
              right: const SizedBox.shrink(),
              withDollarSign: true,
              price: shopData.shopDataCalculations.itemsSumAfterPayment,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: AppConstants.hintColor,
                  ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

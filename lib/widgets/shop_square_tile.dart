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
    return BluredContainer(
      margin: const EdgeInsets.all(8),
      height: 140,
      width: 170,
      child: GestureDetector(
          onTap: onTap,
          child: LayoutBuilder(builder: (context, constraint) {
            return BluredContainer(
              margin: EdgeInsets.all(6),
              height: 120,
              // width: 160,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -(constraint.maxHeight *
                        0.11), // relative to parent's height
                    right: (constraint.maxWidth *
                        0.32), // relative to parent's height
                    child: SizedBox(
                      // relative to parent's height
                      child: Icon(
                        Icons.person_outlined,
                        size: 45,
                        color: Color.fromARGB(178, 255, 255, 255),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: (constraint.maxHeight *
                        0.1), // relative to parent's height
                    //width: 235,
                    left: (constraint.maxWidth *
                        0.25), // relative to parent's height
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${shopData.shop.shopName}',
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                            PriceNumberZone(
                              right: const SizedBox.shrink(),
                              withDollarSign: true,
                              price: shopData.itemsSumAfterPayment,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                    color: AppConstants.hintColor,
                                  ),
                            ),
                            //const SizedBox(height: 8),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          })),
    );
  }
}

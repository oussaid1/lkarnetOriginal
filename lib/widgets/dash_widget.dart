import 'package:flutter/material.dart';
import 'package:lkarnet/models/shop/shops_data.dart';
import 'package:lkarnet/settings/theme.dart';

class DashWidget extends StatelessWidget {
  const DashWidget({
    Key? key,
    required this.shopsData,
  }) : super(key: key);

  final ShopsData shopsData;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      margin: const EdgeInsets.all(8),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: MThemeData.primaryColor,
          child: Text(
            shopsData.shop.shopName.toString().substring(0, 2),
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        title: Text(
          '${shopsData.shop.shopName}',
        ),
        trailing: Column(
          children: [
            Text(
              '${shopsData.itemsSumAfterPayment}',
              style: Theme.of(context).textTheme.headline4,
            ),
            RichText(
              text: TextSpan(
                text: 'N products :',
                style: Theme.of(context).textTheme.subtitle1,
                children: [
                  TextSpan(
                    text: ' ${shopsData.countItems}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ],
        ),
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Total products :',
                        style: Theme.of(context).textTheme.subtitle1,
                        children: [
                          TextSpan(
                            text: ' ${shopsData.itemsSum}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Total payments :',
                        style: Theme.of(context).textTheme.subtitle1,
                        children: [
                          TextSpan(
                            text: ' ${shopsData.paymentsSum}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'N payments :',
                        style: Theme.of(context).textTheme.subtitle1,
                        children: [
                          TextSpan(
                            text: ' ${shopsData.countPayments}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

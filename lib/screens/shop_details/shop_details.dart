import 'package:lkarnet/models/shop/shops_data.dart';
import 'package:flutter/material.dart';
import 'package:lkarnet/widgets/myappbar.dart';

import '../../components.dart';
import '../../widgets/item_listtile.dart';
import '../dash/dashboard.dart';
import '../lists/items.dart';
import '../lists/payments.dart';

class ShopDetails extends StatefulWidget {
  const ShopDetails({Key? key, this.shopData}) : super(key: key);
  final ShopData? shopData;
  @override
  _ShopDetailsState createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlassMaterial(
      circleWidgets: [
        Positioned(
          width: 140,
          height: 140,
          left: 10,
          top: 120,
          child: AppAssets.blueCircleWidget,
        ),
        Positioned(
          width: 180,
          height: 180,
          right: 80,
          top: 200,
          child: AppAssets.purpleCircleWidget,
        ),
        Positioned(
          width: 180,
          height: 180,
          left: 40,
          bottom: 80,
          child: AppAssets.pinkCircleWidget,
        ),
      ],
      gradientColors: AppConstants.myGradients,
      centerWidget: ShopsDetailsBody(shopsData: widget.shopData!),
    );
  }

// build custom listTile

}

class ShopsDetailsBody extends StatelessWidget {
  const ShopsDetailsBody({
    Key? key,
    required this.shopsData,
  }) : super(key: key);

  final ShopData shopsData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BluredContainer(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        start: 0,
        end: 0,
        borderColorOpacity: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${shopsData.shop.shopName}',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ],
              ),
              ShopItemsDetailsWidget(shopsData: shopsData),
              const SizedBox(height: 10),
              ShopPaymentsDetailWidget(shopsData: shopsData),
            ],
          ),
        ),
      ),
    );
  }
}

class ShopItemsDetailsWidget extends StatelessWidget {
  const ShopItemsDetailsWidget({
    Key? key,
    required this.shopsData,
  }) : super(key: key);

  final ShopData shopsData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 390,
      height: 300,
      child: Container(
        color: AppConstants.whiteOpacity,
        child: ExpansionTile(
          trailing: IconButton(
            icon: Icon(Icons.menu_sharp,
                color: Color.fromARGB(106, 255, 255, 255)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemsList(lista: shopsData.items),
                ),
              );
            },
          ),
          title: Text(
            'Items',
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.white),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'count :',
                    style: Theme.of(context).textTheme.subtitle2!),
                TextSpan(
                    text: ' ${shopsData.shopDataCalculations.countItems}',
                    style: Theme.of(context).textTheme.headline5!),
              ])),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'total :',
                    style: Theme.of(context).textTheme.subtitle2!),
                TextSpan(
                    text: ' ${shopsData.shopDataCalculations.itemsSum}',
                    style: Theme.of(context).textTheme.headline4!),
              ])),
            ],
          ),
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ItemTileWidget(
                  item: shopsData.items[index],
                );
              },
              itemCount: shopsData.items.length,
            ),
          ],
        ),
      ),
    );
  }
}

class ShopPaymentsDetailWidget extends StatelessWidget {
  const ShopPaymentsDetailWidget({
    Key? key,
    required this.shopsData,
  }) : super(key: key);

  final ShopData shopsData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 390,
      height: 300,
      child: Container(
        child: Column(
          children: [
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Payments',
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.white),
                        ),
                        IconButton(
                          icon: Icon(Icons.list,
                              color: Color.fromARGB(106, 255, 255, 255)),
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         ItemsList(lista: recentOperations.items),
                            //   ),
                            // );
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'count :',
                              style: Theme.of(context).textTheme.bodyText1!),
                          TextSpan(
                              text:
                                  ' ${shopsData.shopDataCalculations.countPayments}',
                              style: Theme.of(context).textTheme.headline3!),
                        ])),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'total :',
                              style: Theme.of(context).textTheme.bodyText1!),
                          TextSpan(
                              text:
                                  ' ${shopsData.shopDataCalculations.paymentsSum}',
                              style: Theme.of(context).textTheme.headline3!),
                        ])),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return PaymentTile(payment: shopsData.payments[index]);
                },
                itemCount: shopsData.payments.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

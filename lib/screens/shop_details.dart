import 'package:lkarnet/models/shop/shops_data.dart';

import '../components.dart';
import 'home.dart';
import 'lists/items.dart';
import 'lists/payments.dart';

class ShopDetails extends StatefulWidget {
  const ShopDetails({Key? key, this.shopsData}) : super(key: key);
  final ShopsData? shopsData;
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
      gradientColors: [
        Color.fromARGB(255, 48, 199, 237),
        Color.fromARGB(255, 48, 199, 237),
      ],
      centerWidget: ShopsDetailsBody(shopsData: widget.shopsData!),
    );
  }

// build custom listTile

}

class ShopsDetailsBody extends StatelessWidget {
  const ShopsDetailsBody({
    Key? key,
    required this.shopsData,
  }) : super(key: key);

  final ShopsData shopsData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyExpandableFab(),
      backgroundColor: Colors.transparent,
      appBar: buildAppBar(context, title: 'Shop Details'),
      body: SingleChildScrollView(
        child: BluredContainer(
          start: 0,
          end: 0,
          borderColorOpacity: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${shopsData.shop.shopName}',
                          style: Theme.of(context).textTheme.headline2),
                      Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text('Today',
                              style: Theme.of(context).textTheme.headline3!
                              // .copyWith(color: Colors.white),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 390,
                  height: 300,
                  child: BluredContainer(
                    child: Column(
                      children: [
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Items',
                                    style:
                                        Theme.of(context).textTheme.headline3!
                                    // .copyWith(color: Colors.white),
                                    ),
                                Text('count :${shopsData.countItems} ',
                                    style:
                                        Theme.of(context).textTheme.headline4),
                                Text('total : ${shopsData.itemsSum} ',
                                    style:
                                        Theme.of(context).textTheme.headline4),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return ItemTileWidget(
                                  item: shopsData.allItems[index]);
                            },
                            itemCount: shopsData.allItems.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 390,
                  height: 260,
                  child: BluredContainer(
                    child: Column(
                      children: [
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Payments',
                                    style:
                                        Theme.of(context).textTheme.headline3!
                                    // .copyWith(color: Colors.white),
                                    ),
                                Text('count :${shopsData.countPayments} ',
                                    style:
                                        Theme.of(context).textTheme.headline4),
                                Text('total : ${shopsData.paymentsSum} ',
                                    style:
                                        Theme.of(context).textTheme.headline4),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return PaymentTile(
                                  payment: shopsData.allPayments[index]);
                            },
                            itemCount: shopsData.allPayments.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

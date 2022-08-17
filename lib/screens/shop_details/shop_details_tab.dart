import 'package:flutter/material.dart';
import 'package:lkarnet/screens/shop_details/shop_details.dart';
import '../../components.dart';
import '../../models/shop/shops_data.dart';
import 'shop_stats.dart';

class ShopDetailsTab extends StatelessWidget {
  final ShopData? shopData;
  const ShopDetailsTab({Key? key, required this.shopData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GlassMaterial(
      circleWidgets: [
        Positioned(
          width: 100,
          height: 100,
          left: 10,
          top: 120,
          child: AppAssets.pinkCircleWidget,
        ),
        Positioned(
          width: 180,
          height: 180,
          right: 80,
          top: 200,
          child: AppAssets.purpleCircleWidget,
        ),
        Positioned(
          width: 140,
          height: 140,
          left: 30,
          bottom: 80,
          child: AppAssets.blueCircleWidget,
        ),
      ],
      centerWidget: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: BluredContainer(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              leading: Container(),
              backgroundColor: Colors.transparent,
              flexibleSpace: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TabBar(
                    unselectedLabelColor: Theme.of(context).dividerColor,
                    tabs: [
                      Tab(text: 'Items & Payments'),
                      Tab(text: 'Stats'),
                    ],
                  ),
                ],
              ),
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                ShopsDetailsBody(
                  shopsData: shopData!,
                ),
                ShopStatsPage(
                  shopData: shopData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lkarnet/components.dart';
import '../../models/shop/shops_data.dart';
import 'shop_stats_charts.dart';

class ShopStatsPage extends StatefulWidget {
  final ShopData? shopData;
  const ShopStatsPage({Key? key, required this.shopData}) : super(key: key);
  @override
  State<ShopStatsPage> createState() => _ShopStatsPageState();
}

class _ShopStatsPageState extends State<ShopStatsPage> {
  /////////////////
  ShopData? _shopData;
  /////////////////
  @override
  void initState() {
    _shopData = widget.shopData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 12),
        BluredContainer(
          margin: EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width,
          height: 240,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _shopData != null
                  ? LineChartWidgetDate(
                      chartData: _shopData!.itemsDataForAll.dailyItemsChartData,
                      title: "All Items")
                  : const SizedBox()),
        ),
        BluredContainer(
          margin: EdgeInsets.all(8),
          width: 410,
          height: 220,
          child: _shopData != null
              ? PeiWidget(
                  chartData: _shopData!.itemsDataForAll.itemsByNameChartData,
                  title: "Most Expenssive Items",
                )
              : const SizedBox(),
        ),
        BluredContainer(
          margin: EdgeInsets.all(8),
          width: 400,
          height: 220,
          child: ColumnChartWidget(
            chartData: _shopData!.itemsDataForAll.itemsByNameChartData,
            title: "Most Frequent Items",
          ),
        ),
        const SizedBox(
          width: 100,
        ),
      ],
    ));
  }
}

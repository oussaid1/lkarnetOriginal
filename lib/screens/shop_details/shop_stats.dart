import 'package:flutter/material.dart';
import 'package:lkarnet/components.dart';
import '../../models/shop/shops_data.dart';
import 'shop_stats_charts.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

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
        SizedBox(
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.all(8),
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppConstants.whiteOpacity),
              )
            ],
          ),
        ),
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
          width: MediaQuery.of(context).size.width,
          height: 240,
          child: _shopData != null
              ? PeiWidget(
                  chartData: _shopData!.itemsDataForAll.itemsByNameChartData,
                  title: "Most Expenssive Items",
                )
              : const SizedBox(),
        ),
        BluredContainer(
          margin: EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width,
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

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverStickyHeader(
          header: Container(
            height: 50.0,
            color: Colors.blueGrey[700],
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Sticky Header',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                leading: CircleAvatar(
                  child: Text('$index'),
                ),
                title: Text('List tile #$index'),
              ),
              childCount: 20,
            ),
          ),
        ),
      ],
    );
  }
}

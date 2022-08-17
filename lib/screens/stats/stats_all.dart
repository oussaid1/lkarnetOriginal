import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lkarnet/models/statistics/tagged.dart';
import 'package:lkarnet/widgets/charts.dart';
import 'package:lkarnet/widgets/myappbar.dart';
import '../../blocs/datefilterbloc/date_filter_bloc.dart';
import '../../blocs/itemsbloc/items_bloc.dart';
import '../../blocs/payments/payments_bloc.dart';
import '../../blocs/shopsbloc/shops_bloc.dart';
import '../../models/data_sink.dart';
import '../../models/item/item.dart';
import '../../models/payment/payment_model.dart';
import '../../models/shop/shop_model.dart';
import '../../models/shop/shops_data.dart';
import '../../widgets/glasswidget.dart';
import '../dash/dashboard.dart';

class StatsAll extends StatefulWidget {
  @override
  State<StatsAll> createState() => _StatsAllState();
}

class _StatsAllState extends State<StatsAll> {
  List<ItemModel> _items = [];
  List<PaymentModel> _payments = [];
  List<ShopModel> _shops = [];
  ShopData? _shopData;
  @override
  Widget build(BuildContext context) {
    // var chartData = ref.watch(frequentItemsProvider.state).state;
    // var chartData2 = ref.watch(shopsChartsDataProvider.state).state;
    return Scaffold(
      appBar: MyAppBar(
        title: Text("All Statistics"),
      ),
      backgroundColor: Colors.transparent,
      floatingActionButton: MyExpandableFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: BlocBuilder<ItemsBloc, ItemsState>(
        buildWhen: (previous, current) =>
            previous.items.length != current.items.length,
        builder: (context, itemsState) {
          return BlocBuilder<PaymentsBloc, PaymentsState>(
            buildWhen: (previous, current) =>
                previous.payments.length != current.payments.length,
            builder: (context, paymentsState) {
              return BlocBuilder<ShopsBloc, ShopsState>(
                buildWhen: (previous, current) =>
                    previous.shops.length != current.shops.length,
                builder: (context, shopsState) {
                  return BlocBuilder<DateFilterBloc, DateFilterState>(
                    builder: (context, filterState) {
                      //////////////////////////////////////////////////////
                      //////////////////////////////////////////////////////
                      _items = itemsState.items;
                      _payments = paymentsState.payments;
                      _shops = shopsState.shops;
                      //////////////////////////////////////////////////////
                      log('error build ${itemsState.items.length}');

                      /// //////////////////////////////////////////////////////
                      //  final ItemsData _itemsData = ItemsData(items: _items);

                      /// //////////////////////////////////////////////////////
                      DataSink _dataSink = DataSink(
                        shops: _shops,
                        items: _items,
                        payments: _payments,
                      );

                      /// //////////////////////////////////////////////////////
                      List<ShopData> _shopsDataList = _dataSink.allShopsData;

                      /// //////////////////////////////////////////////////////
                      // _shopsDataList.isNotEmpty
                      //     ? _shopData = _shopsDataList[0]
                      //     : _shopData = null;

                      /// items by shop
                      List<Tagged> _dataByShops = _dataSink.taggedShops;

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
                                          chartData: _shopData!.itemsDataForAll
                                              .monthlyItemsChartData,
                                          title: "Items Sold By Month")
                                      : SizedBox(
                                          // width: 400,
                                          // height: 400,
                                          // child: Column(
                                          //   children: _shopData!.itemsDataForAll
                                          //       .monthlyItemsChartData
                                          //       .map((e) => Text(e
                                          //           .itemCalculations.totalPrice
                                          //           .toString()))
                                          //       .toList(),
                                          // ),
                                          )),
                            ),
                            BluredContainer(
                              margin: EdgeInsets.all(8),
                              width: 410,
                              height: 300,
                              child: _shopData != null
                                  ? PeiWidget(
                                      chartData: _shopData!
                                          .itemsDataForAll.itemsByNameChartData,
                                      title: "Items by Shop",
                                    )
                                  : const SizedBox(),
                            ),
                            BluredContainer(
                              margin: EdgeInsets.all(8),
                              width: 400,
                              height: 220,
                              child: ColumnChartWidget(
                                chartData: _dataByShops,
                                title: "Items by Shop",
                              ),
                            ),
                            const SizedBox(
                              width: 100,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/models/item/items_data.dart';
import 'package:lkarnet/models/statistics/statistics_model.dart';
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
import '../../widgets/glasswidget.dart';
import '../dash/dashboard.dart';

class StatsAll extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
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
        builder: (context, itemsState) {
          return BlocBuilder<PaymentsBloc, PaymentsState>(
            builder: (context, paymentsState) {
              return BlocBuilder<ShopsBloc, ShopsState>(
                builder: (context, shopsState) {
                  return BlocBuilder<DateFilterBloc, DateFilterState>(
                    builder: (context, filterState) {
                      //////////////////////////////////////////////////////
                      //////////////////////////////////////////////////////
                      List<ItemModel> _items = itemsState.items;
                      List<PaymentModel> _payments = paymentsState.payments;
                      List<ShopModel> _shops = shopsState.shops;
                      //////////////////////////////////////////////////////
                      /// //////////////////////////////////////////////////////
                      ItemsData _itemsData = ItemsData(items: _items);

                      /// //////////////////////////////////////////////////////
                      DataSink _dataSink = DataSink(_shops, _items, _payments);

                      /// //////////////////////////////////////////////////////
                      // List<ShopData> _shopsDataList = _dataSink.allShopsData;
                      /// //////////////////////////////////////////////////////
                      /// items by date dd/mm/yyyy
                      List<ItemsChartData> _itemsDataList =
                          _itemsData.ddmmyyyyItemsChartData;

                      /// items by name
                      // =
                      //   _itemsData.itemsByNameChartData;

                      /// items by shop
                      List<Tagged> _dataByShops = _dataSink.taggedShops;

                      return SingleChildScrollView(
                        child: Wrap(
                          //mainAxisSize: MainAxisSize.max,
                          children: [
                            const SizedBox(width: 12),
                            BluredContainer(
                              margin: EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width,
                              height: 240,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: LineChartWidgetDate(
                                    chartData: _itemsDataList,
                                    title: "Items by Date"),
                              ),
                            ),
                            BluredContainer(
                              margin: EdgeInsets.all(8),
                              width: 410,
                              height: 300,
                              child: PeiWidgetForTagged(
                                chartData: _dataByShops,
                                title: "Items by Shop",
                              ),
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

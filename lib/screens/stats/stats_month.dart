import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/widgets/charts.dart';

import '../../blocs/datefilterbloc/date_filter_bloc.dart';
import '../../blocs/itemsbloc/items_bloc.dart';
import '../../blocs/payments/payments_bloc.dart';
import '../../blocs/shopsbloc/shops_bloc.dart';
import '../../models/data_sink.dart';
import '../../models/item/item.dart';
import '../../models/item/items_data.dart';
import '../../models/payment/payment_model.dart';
import '../../models/shop/shop_model.dart';
import '../../models/statistics/statistics_model.dart';
import '../../models/statistics/tagged.dart';

class StatsMonth extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    return BlocBuilder<ItemsBloc, ItemsState>(
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
                    //    List<ItemsChartData> _itemsDataList =
                    //      _itemsData.ddmmyyyyItemsChartData;

                    /// items by name
                    List<ItemsChartData> _itemsDataList2 =
                        _itemsData.itemsByNameChartData;

                    /// items by shop
                    List<Tagged> _dataByShops = _dataSink.taggedShops;

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("10 most frequent items"),
                                ),
                                SemiPeiWidget(
                                  _itemsDataList2,
                                  Text(''),
                                )
                              ],
                            ),
                          ),
                          PeiWidgetForTagged(
                            chartData: _dataByShops,
                            title: 'Items by shop',
                          ),
                          SizedBox(
                            height: 50,
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
    );
  }
}

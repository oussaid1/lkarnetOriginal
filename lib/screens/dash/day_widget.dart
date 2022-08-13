import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/models/shop/shops_data.dart';
import 'package:lkarnet/widgets/glasswidget.dart';
import 'package:lkarnet/widgets/items_listview.dart';

import '../../blocs/datefilterbloc/date_filter_bloc.dart';
import '../../blocs/itemsbloc/items_bloc.dart';
import '../../blocs/payments/payments_bloc.dart';
import '../../blocs/shopsbloc/shops_bloc.dart';
import '../../models/item/item.dart';
import '../../models/item/items_filtered.dart';
import '../../models/payment/payment_model.dart';
import '../../models/payment/payments_filtered.dart';
import '../../models/shop/shop_model.dart';

final mlistIndex = StateProvider<int>((ref) {
  return 0;
});

class DailyDash extends ConsumerWidget {
  const DailyDash({
    Key? key,
  }) : super(key: key);

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
                    return BlocBuilder<ItemsBloc, ItemsState>(
                      builder: (context, state) {
                        //////////////////////////////////////////////////////
                        //////////////////////////////////////////////////////
                        //////////////////////////////////////////////////////
                        //////////////////////////////////////////////////////
                        List<Ta _listOfTagged;
                        var _currentIndex = ref.watch(mlistIndex.state).state;

                        final _tagged = _listOfTagged[_currentIndex];
                        //////////////////////////////////////////////////////
                        /// filtered items
                        ItemsFiltered _filteredItems =
                            ItemsFiltered(items: itemsState.items);

                        /// filtered payments
                        PaymentsFiltered _filteredPayments =
                            PaymentsFiltered(payments: paymentsState.payments);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                        List<ItemModel> _items =
                            _filteredItems.itemsByDateFilter;
                        //////////////////////////////////////////////////////
                        List<PaymentModel> _payments =
                            _filteredPayments.paymentsByDateFilter;
                        List<ShopModel> _shops = shopsState.shops;
                        //////////////////////////////////////////////////////
                        var dataSink = DataSink(_shops, _items, _payments);
                        //////////////////////////////////////////////////////
                        ///////////////////////////////////////////////////////
                        ShopDataCalculations _shopDataCalculations =
                            ShopDataCalculations(
                          items: itemsState.items,
                          payments: paymentsState.payments,
                        );
                        ///////////////////////////////////////////////////////
                        ///////////////////////////////////////////////////////
                        /// create a list that contains a date tag and a list of shopdata for that date tag
                        _listOfTagged = _shopDataCalculations.createListOfTagged();
                        ///////////////////////////////////////////////////////
                        ///////////////////////////////////////////////////////
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        icon:
                                            Icon(Icons.arrow_back_ios_rounded),
                                        onPressed: () {
                                          if (_currentIndex > 0)
                                            ref.read(mlistIndex.state).state--;
                                        }),
                                    Row(
                                      children: [
                                        Text(
                                          'Day: ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                        Text('${_tagged.tag}'),
                                      ],
                                    ),
                                    IconButton(
                                        icon: Icon(
                                            Icons.arrow_forward_ios_rounded),
                                        onPressed: () {
                                          if (_currentIndex <
                                              _listOfTagged.length - 1) {
                                            ref.read(mlistIndex.state).state +=
                                                1;
                                          }
                                        }),
                                  ],
                                ),
                              ),
                              _buildMonthlyCard(context, _tagged),
                              Container(
                                width: 420,
                                height: 400,
                                child: ListView.builder(
                                    itemCount: _tagged.shopDataList.length,
                                    itemBuilder: (context, index) {
                                      ShopData shopsData =
                                          _tagged.shopDataList[index];
                                      return BluredContainer(
                                        child: ExpansionTile(
                                          collapsedTextColor: Colors.white,
                                          textColor: Colors.white,
                                          title: Text(
                                              '${shopsData.shop.shopName}'),
                                          trailing:
                                              Text('${shopsData.itemsSum}'),
                                          subtitle: Text(
                                            'N° items : ' +
                                                '${shopsData.countItems}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                          ),
                                          leading: CircleAvatar(
                                            child: Icon(
                                              Icons.account_circle,
                                              color: Colors.grey,
                                            ),
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                          children: [
                                            Container(
                                                width: 400,
                                                height: 400,
                                                child: ItemsListWidget(
                                                    items: shopsData.allItems)),
                                          ],
                                        ),
                                      );
                                    }),
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
      },
    );
  }

  Container _buildMonthlyCard(BuildContext context, Tagged tagged) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BluredContainer(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total-amount',
                      //style: Theme.of(context).textTheme.headline3,
                    ),
                    Text(
                      tagged.itemsSum.toString(),
                      //style: AkThemeData.darkThemeData.textTheme.headline4,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total number of items',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      '${tagged.countItems}',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

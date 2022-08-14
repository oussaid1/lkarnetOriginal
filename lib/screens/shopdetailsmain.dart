import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/models/shop/shop_model.dart';
import 'package:lkarnet/widgets/myappbar.dart';
import '../blocs/datefilterbloc/date_filter_bloc.dart';
import '../blocs/itemsbloc/items_bloc.dart';
import '../blocs/payments/payments_bloc.dart';
import '../blocs/shopsbloc/shops_bloc.dart';
import '../components.dart';
import '../models/data_sink.dart';
import '../models/payment/payment_model.dart';
import '../models/statistics/tagged.dart';
import '../widgets/price_curency_widget.dart';
import '../widgets/shop_square_tile.dart';
import 'dash/dashboard.dart';
import 'shop_details.dart';

class ShopDetailsMain extends ConsumerStatefulWidget {
  const ShopDetailsMain({
    Key? key,
  }) : super(key: key);
  //final ShopData? shopsData;
  @override
  _ShopDetailsState createState() => _ShopDetailsState();
}

class _ShopDetailsState extends ConsumerState<ShopDetailsMain> {
  Tagged? _tagged;

  int _currentIndex = 0;

  //var _isSelected = false;
  @override
  void initState() {
    context.read<ItemsBloc>().add(GetItemsEvent());
    context.read<PaymentsBloc>().add(GetPaymentsEvent());
    context.read<ShopsBloc>().add(GetShopsEvent());
    super.initState();
  }

  //List<Tagged> _listOfTagged = [];
  @override
  Widget build(BuildContext context) {
    //var _listOfTagged = ref.watch(taggedListMMYYProvider.state).state;
    //var _currentIndex = ref.watch(listIndex.state).state;
    // var _tagged = _listOfTagged[ref.watch(tagIndexProvider.state).state];
    //return MonthlyDash();
    //_tagged == null ? _tagged = _listOfTagged[0] : _tagged;
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

                    //////////////////////////////////////////////////////
                    var _dataSink = DataSink(_shops, _items, _payments);
                    //////////////////////////////////////////////////////
                    List<Tagged> _listOfTagged = _dataSink.taggedDistinctDates;

                    final Tagged? _tagged = _listOfTagged[_currentIndex];
                    //////////////////////////////////////////////////////
                    _tagged == null ? _listOfTagged[0] : _tagged;
                    return BluredContainer(
                      start: 0,
                      end: 0,
                      borderColorOpacity: 0,
                      child: Scaffold(
                        backgroundColor: Color.fromARGB(0, 255, 255, 255),
                        floatingActionButton: MyExpandableFab(),
                        floatingActionButtonLocation:
                            FloatingActionButtonLocation.centerFloat,
                        appBar: MyAppBar(
                          title: _tagged != null
                              ? Text(
                                  '${_tagged.tag!.mMMyy()}',
                                )
                              : Text('No tag'),
                          leading:
                              Icon(Icons.calendar_month, color: Colors.black),
                        ),

                        // Next, create a SliverList
                        body: Column(
                          children: [
                            const SizedBox(
                              height: 40,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Monthly',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(186, 255, 255, 255),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            MultiBlocListener(
                              listeners: [
                                BlocListener<ItemsBloc, ItemsState>(
                                  listener: (context, state) {
                                    if (state.items.isNotEmpty) {
                                      setState(() {
                                        _items = state.items;
                                      });
                                    }
                                  },
                                ),
                                BlocListener<ShopsBloc, ShopsState>(
                                  listener: (context, state) {
                                    if (state.shops.isNotEmpty) {
                                      setState(() {
                                        _shops = state.shops;
                                      });
                                    }
                                  },
                                ),
                                BlocListener<PaymentsBloc, PaymentsState>(
                                    listener: (context, state) {
                                  if (state.payments.isNotEmpty) {
                                    setState(() {
                                      _payments = state.payments;
                                    });
                                  }
                                }),
                              ],
                              child: Container(
                                height: 235,
                                width: double.infinity,
                                // color: Color.fromARGB(94, 255, 193, 7),
                                child: Stack(
                                  //fit: StackFit.loose,
                                  children: [
                                    _tagged != null
                                        ? _buildMonthlyCard(context, _tagged)
                                        : Container(),
                                    Positioned(
                                      top: 195,
                                      width: 360,
                                      left: MediaQuery.of(context).size.width /
                                              2 -
                                          180,
                                      child: _buildSelector(_listOfTagged),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            _tagged == null
                                ? SizedBox.shrink()
                                : Container(
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                    height: 300,
                                    width: MediaQuery.of(context).size.width,
                                    child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 1.5,
                                              mainAxisSpacing: 10,
                                              crossAxisSpacing: 10),
                                      itemCount: _tagged.shopsDataList.length,
                                      itemBuilder: (context, index) {
                                        return ShopSquareTile(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ShopDetails(
                                                shopData: _tagged
                                                    .shopsDataList[index],
                                              ),
                                            ),
                                          ),
                                          shopData:
                                              _tagged.shopsDataList[index],
                                        );
                                      },
                                    ),
                                  ),
                          ],
                        ),
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

// build custom listTile

  Widget _buildSelector(List<Tagged> _listOfTagged) {
    return BluredContainer(
      start: 0.5,
      end: 0.5,
      height: 40,
      width: 380,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _listOfTagged.length,
        itemBuilder: (context, index) {
          Tagged tagged = _listOfTagged[index];
          // ref.read(tagedProvider.state).state = tagged;
          // _tagged = tagged;

          return SizedBox(
            width: 100,
            height: 30,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  // tagged.seledcted = !tagged.seledcted;

                  _tagged = tagged;
                });
              },
              child: Card(
                color: _tagged == tagged
                    ? AppConstants.primaryColor
                    : AppConstants.whiteOpacity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // tagged == _tagged ? Text('Selected') : Text(''),
                    Text(
                      tagged.tag,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _buildMonthlyCard(BuildContext context, Tagged tagged) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BluredContainer(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total-amount',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  PriceNumberZone(
                      right: const SizedBox.shrink(),
                      withDollarSign: true,
                      price: tagged.shopDataCalculations.itemsSumAfterPayment,
                      style: Theme.of(context).textTheme.headline2!),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total sum of items',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppConstants.whiteOpacity),
                  ),
                  PriceNumberZone(
                    right: const SizedBox.shrink(),
                    withDollarSign: true,
                    price: tagged.shopDataCalculations.itemsSum,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AppConstants.hintColor,
                        ),
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
                    'Total sum of payments',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppConstants.whiteOpacity),
                  ),
                  PriceNumberZone(
                    right: const SizedBox.shrink(),
                    withDollarSign: true,
                    price: tagged.shopDataCalculations.paymentsSum,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AppConstants.hintColor,
                        ),
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
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppConstants.whiteOpacity),
                  ),
                  PriceNumberZone(
                    right: const SizedBox.shrink(),
                    withDollarSign: true,
                    price: tagged.shopDataCalculations.countItems.toDouble(),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AppConstants.hintColor,
                        ),
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
                    'Total number of payments',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppConstants.whiteOpacity),
                  ),
                  PriceNumberZone(
                    right: const SizedBox.shrink(),
                    withDollarSign: true,
                    price: tagged.shopDataCalculations.countPayments.toDouble(),
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AppConstants.hintColor,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

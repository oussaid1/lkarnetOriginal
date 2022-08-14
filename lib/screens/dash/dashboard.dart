import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lkarnet/components.dart';
import 'package:lkarnet/models/operations_adapter.dart';
import 'package:lkarnet/models/payment/payment_model.dart';
import 'package:lkarnet/models/shop/shop_model.dart';
import 'package:lkarnet/widgets/dialogs.dart';
import '../../blocs/datefilterbloc/date_filter_bloc.dart';
import '../../blocs/itemsbloc/items_bloc.dart';
import '../../blocs/payments/payments_bloc.dart';
import '../../blocs/shopsbloc/shops_bloc.dart';
import '../../models/data_sink.dart';
import '../../models/item/item.dart';
import '../../models/item/items_filtered.dart';
import '../../models/payment/payments_filtered.dart';
import '../../models/shop/shopdata_calculations.dart';
import '../../models/shop/shops_data.dart';
import '../../widgets/item_listtile.dart';
import '../../widgets/myappbar.dart';
import '../../widgets/price_curency_widget.dart';
import '../../widgets/shop_square_tile.dart';
import '../add/add_item.dart';
import '../add/add_kitchen_item.dart';
import '../add/add_payment.dart';
import '../add/add_shop.dart';
import '../lists/items.dart';
import '../lists/payments.dart';
import '../lists/shops.dart';
import '../shop_details.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  //late List<KitchenElement> _kitchenElements;
  // /late List<KitchenItem> _kitchenItems;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    super.initState();
  }

  //late RecentOperation _recentOperation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: MyExpandableFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: MyAppBar(
        title: Text(
          'Dashboard',
          style: Theme.of(context).textTheme.headline2,
        ),
        //  actions: [
        // IconButton(
        //   icon: Icon(Icons.add),
        //   onPressed: () async {
        //     var status = await Permission.storage.request().isGranted;
        //     if (!status) {
        //       toast('Please grant camera permission');
        //     } else {
        //       final backup = Backup(
        //           date: DateTime.now(), items: _items.take(2).toList());
        //       backup.store().then((value) => toast('Backup created'));
        //     }

// You can can also directly ask the permission about its status.

        // context.read<ItemsBloc>().add(GetItemsEvent());
        // context.read<ShopsBloc>().add(GetShopsEvent());
        // context.read<PaymentsBloc>().add(GetPaymentsEvent());
        //      },
        //   ),
        // IconButton(
        //   icon: Icon(Icons.notifications),
        //   onPressed: () async {
        //     //  MNotificationModel.createPlantFoodNotification(expired: '1');
        //     MNotificationModel.createOneTimeNotification(
        //       expired: '2',
        //     );
        //   },
        // ),
        // IconButton(
        //   icon: Icon(Icons.send),
        //   onPressed: () async {
        //     await Workmanager().registerPeriodicTask(
        //         "test_workertask", "test_workertask",
        //         inputData: {"data1": "value1", "data2": "value2"},
        //         frequency: Duration(minutes: 15),
        //         initialDelay: Duration(seconds: 10),
        //         existingWorkPolicy: ExistingWorkPolicy.replace);
        //     // Navigator.pushNamed(context, '/notifications');
        //   },
        // ),
        // NotificationsIconButton(),
        //],
        leading: IconButton(
          icon: Icon(Icons.dashboard),
          onPressed: () {},
        ),
      ),
      body: GlassContainer(
        start: 0,
        end: 0,
        //borderColorOpacity: 0,
        child: SingleChildScrollView(
          child: MultiBlocListener(
            listeners: [
              BlocListener<ItemsBloc, ItemsState>(
                listener: (context, state) {},
              ),
              BlocListener<ShopsBloc, ShopsState>(
                listener: (context, state) {
                  if (state.status == ShopsStatus.loaded) {}
                },
              ),
              BlocListener<PaymentsBloc, PaymentsState>(
                  listener: (context, state) {
                if (state.status == PaymentsStatus.loaded) {}
              }),
            ],
            child: BlocBuilder<ItemsBloc, ItemsState>(
              builder: (context, itemsState) {
                return BlocBuilder<PaymentsBloc, PaymentsState>(
                  builder: (context, paymentsState) {
                    return BlocBuilder<ShopsBloc, ShopsState>(
                      builder: (context, shopsState) {
                        return BlocBuilder<DateFilterBloc, DateFilterState>(
                          builder: (context, filterState) {
                            return BlocBuilder<ItemsBloc, ItemsState>(
                              builder: (context, state) {
                                if (state.items.isNotEmpty) {
                                  //////////////////////////////////////////////////////
                                  //////////////////////////////////////////////////////
                                  //////////////////////////////////////////////////////
                                  //////////////////////////////////////////////////////

                                  //////////////////////////////////////////////////////
                                  /// filtered items
                                  ItemsFiltered _filteredItems =
                                      ItemsFiltered(items: itemsState.items);

                                  /// filtered payments
                                  PaymentsFiltered _filteredPayments =
                                      PaymentsFiltered(
                                          payments: paymentsState.payments);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                  List<ItemModel> _items =
                                      _filteredItems.itemsByDateFilter;
                                  //////////////////////////////////////////////////////
                                  List<PaymentModel> _payments =
                                      _filteredPayments.paymentsByDateFilter;
                                  List<ShopModel> _shops = shopsState.shops;
                                  //////////////////////////////////////////////////////
                                  var dataSink =
                                      DataSink(_shops, _items, _payments);
                                  //////////////////////////////////////////////////////
                                  ///////////////////////////////////////////////////////
                                  ShopDataCalculations _shopDataCalculations =
                                      ShopDataCalculations(
                                    items: itemsState.items,
                                    payments: paymentsState.payments,
                                  );
                                  ///////////////////////////////////////////////////////
                                  ///////////////////////////////////////////////////////
                                  return Column(
                                    children: [
                                      const SizedBox(height: 8),
                                      buildTopWidget(_shopDataCalculations,
                                          items: state.items),
                                      buildShopsWidget(
                                          context, dataSink.allShopsData),
                                      buildRecentOpeerationsWidget(
                                        context,
                                        RecentOperation(itemsState.items,
                                            paymentsState.payments),
                                      )
                                    ],
                                  );
                                } else {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text('no items...'),
                                        SpinKitSquareCircle(
                                          color: Colors.white,
                                          size: 50.0,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  buildShopsWidget(BuildContext context, List<ShopData> _shopsDataList) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        // height: 170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Shops',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Color.fromARGB(106, 255, 255, 255),
                          )),
                ),
                IconButton(
                  icon: Icon(Icons.list,
                      color: Color.fromARGB(106, 255, 255, 255)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShopsList(),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final ShopData shopsData = _shopsDataList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ShopSquareTile(
                      shopData: shopsData,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShopDetails(
                              shopData: shopsData,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                itemCount: _shopsDataList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

// build operations widget
  buildRecentOpeerationsWidget(
      BuildContext context, RecentOperation recentOperations) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon(Icons.dashboard_customize,
              //     color: Color.fromRGBO(255, 255, 255, 1)),
              // const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Recent Operations',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Color.fromARGB(106, 255, 255, 255),
                            )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                    child: Text(
                      'double tap to add the item to kitchen !',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ],
              ),
              // more button

              IconButton(
                icon:
                    Icon(Icons.list, color: Color.fromARGB(106, 255, 255, 255)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ItemsList(lista: recentOperations.items),
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            width: 390,
            height: 340,
            child: ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                final OperationsAdapter recentOperation =
                    recentOperations.recentOperationsList[index];
                return recentOperation.isItem
                    ? ItemTileWidget(
                        animationController: _animationController,
                        onTap: () {
                          Dialogs.dialogSimple(context,
                              title: 'do you want to save to kitchen',
                              widgets: [
                                Container(
                                  child: AddKitchenItem(
                                    item: recentOperation.item!,
                                  ),
                                ),
                              ]);
                        },
                        item: recentOperation.item!,
                      )
                    : PaymentTile(
                        payment: recentOperation.payment!,
                      );
              },
              itemCount: recentOperations.recentOperationsList.length,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  buildTopWidget(ShopDataCalculations shopDataCalculations,
      {List<ItemModel>? items}) {
    return BluredContainer(
      width: 390,
      height: 130,
      child: SizedBox(
        width: 390,
        height: 130,
        child: BluredContainer(
          margin: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Spendings',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  PriceNumberZone(
                    right: const SizedBox.shrink(),
                    withDollarSign: true,
                    price: shopDataCalculations.itemsSumAfterPayment,
                    style: Theme.of(context).textTheme.headline2!,
                  ),
                ],
              ),
              Row(
                children: [
                  buildCircularProgress(shopDataCalculations),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  CircularPercentIndicator buildCircularProgress(
      ShopDataCalculations dataSink) {
    return CircularPercentIndicator(
      animateFromLastPercent: true,
      animation: true,
      curve: Curves.linear,
      radius: 50.0,
      lineWidth: 6.0,
      percent: dataSink.spendingsUnitinterval,
      center: new Text("${dataSink.spendingsPecentage} %",
          style: Theme.of(context).textTheme.headline6),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: Colors.white,
      backgroundColor: Colors.white.withOpacity(0.2),
    );
  }

// build custom listTile
  Widget buildRowTileRecentOpe(OperationsAdapter operation, String currency) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radius),
      ),
      color: AppConstants.whiteOpacity,
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: operation.isItem
                        ? Color(0xFFEBA613)
                        : Color(0xA4E6218D),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppConstants.radius),
                      bottomLeft: Radius.circular(AppConstants.radius),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${operation.quantity}',
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '${operation.quantifier}',
                        style: Theme.of(context).textTheme.subtitle2,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${operation.title}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      '${operation.date!.formatted()}',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    '${operation.amount!.toPrecision(2)}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                Text(
                  '$currency',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyExpandableFab extends StatelessWidget {
  const MyExpandableFab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      distance: 90.0,
      children: [
        ActionButton(
          onPressed: () => Dialogs.botomUpDialog(
            context,
            AddPayment(),
          ),
          icon: const Icon(
            Icons.monetization_on,
            size: 32,
          ),
        ),
        ActionButton(
          onPressed: () => Dialogs.botomUpDialog(
            context,
            AddShop(),
          ),
          icon: const Icon(
            Icons.person_add,
            size: 30,
          ),
        ),
        ActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddItem(),
            ),
          ),
          icon: const Icon(
            Icons.add_shopping_cart_sharp,
            size: 30,
          ),
        ),
      ],
    );
  }
}

// class CounterStorage {
//   Future<String> get _localPath async {
//     final directory = await getApplicationDocumentsDirectory();

//     return directory.path;
//   }

//   Future<File> get _localFile async {
//     // storage permission ask
//     var status = await Permission.storage.status;
//     if (!status.isGranted) {
//       await Permission.storage.request();
//     }
//     // the downloads folder path
//     Directory tempDir = await DownloadsPathProvider.downloadsDirectory;
//     String tempPath = tempDir.path;
//     var filePath = tempPath + '/json.json';
//     // final path = await _localPath;
//     return File('$filePath');
//   }

//   Future<int> readCounter() async {
//     try {
//       final file = await _localFile;

//       // Read the file
//       final contents = await file.readAsString();

//       return int.parse(contents);
//     } catch (e) {
//       // If encountering an error, return 0
//       return 0;
//     }
//   }

//   Future<File> writeCounter(int counter) async {
//     final file = await _localFile;

//     // Write the file
//     return file.writeAsString('$counter');
//   }

//   Future<File> writeFile(String data, String name) async {
//     // storage permission ask
//     var status = await Permission.storage.status;
//     if (!status.isGranted) {
//       await Permission.storage.request();
//     }
//     // the downloads folder path
//     Directory tempDir = await DownloadsPathProvider.downloadsDirectory;
//     String tempPath = tempDir.path;
//     var filePath = tempPath + '/$name';
//     //

//     // the data
//     // var bytes = ByteData.view(data.buffer);
//     // final buffer = bytes.buffer;
//     // // save the data in the path
//     // return File(filePath).writeAsBytes(
//     //     buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
//     return File(filePath).writeAsString(data);
//   }
// }

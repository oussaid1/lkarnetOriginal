import 'package:flutter/material.dart';
import 'package:lkarnet/components.dart';
import 'package:lkarnet/models/operations_adapter.dart';

import 'package:lkarnet/widgets/dialogs.dart';

import '../../models/shop/shops_data.dart';
import '../../providers/streamproviders/items_stream_provider.dart';
import '../../providers/streamproviders/payments_stream_provider.dart';
import '../../providers/streamproviders/shops_stream_provider.dart';
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

class DashBoardPage extends ConsumerStatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends ConsumerState<DashBoardPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var items = ref.watch(itemsProvider.state).state;
    var payments = ref.watch(paymentsProvider.state).state;
    var shops = ref.watch(shopsProvider.state).state;
    var dataSink = DataSink(shops, items, payments);
    List<ShopData> _shopsDataList = dataSink.allShopsData;
    // ref.watch(shopsDataListProvider.state).state;
    var _recentOperations = ref.watch(recentOperationsProvider.state).state;
    // var chartData = ref.watch(shopsChartsDataProvider.state).state;
    //final _db = ref.watch(databaseProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: MyExpandableFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: MyAppBar(
        title: Text(
          'Dashboard',
          style: Theme.of(context).textTheme.headline2,
        ),
        leading: IconButton(
          icon: Icon(Icons.dashboard),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BluredContainer(
        start: 0,
        end: 0,
        borderColorOpacity: 0,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
              buildTopWidget(dataSink),
              buildShopsWidget(context, _shopsDataList),
              buildRecentOpeerationsWidget(
                context,
                _recentOperations,
              )
            ],
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
              height: 140,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final ShopData shopsData = _shopsDataList[index];
                  return ShopSquareTile(
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Recent Operations',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Color.fromARGB(106, 255, 255, 255),
                        )),
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

  buildTopWidget(DataSink dataSink) {
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
                    price: dataSink.itemsSumAfterPayment,
                    style: Theme.of(context).textTheme.headline2!,
                  ),
                ],
              ),
              Row(
                children: [
                  buildCircularProgress(dataSink),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  CircularPercentIndicator buildCircularProgress(DataSink dataSink) {
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
                    '${operation.amount!.toPrecision()}',
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


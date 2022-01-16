import 'package:lkarnet/components.dart';
import 'package:lkarnet/models/operations_adapter.dart';
import 'package:lkarnet/models/overalls.dart';
import 'package:lkarnet/providers/varproviders/var_providers.dart';
import 'package:lkarnet/screens/add/add_item.dart';
import 'package:lkarnet/screens/add/add_payment.dart';
import 'package:lkarnet/screens/lists/items.dart';
import 'package:lkarnet/screens/settings/settings.dart';
import 'package:lkarnet/screens/tabs/dashboard_tab.dart';
import 'package:lkarnet/screens/tabs/list_tab.dart';
import 'package:lkarnet/widgets/dialogs.dart';

import '../models/shop/shops_data.dart';
import '../providers/streamproviders/items_stream_provider.dart';
import '../providers/streamproviders/payments_stream_provider.dart';
import '../providers/streamproviders/shops_stream_provider.dart';
import 'add/add_shop.dart';
import 'lists/payments.dart';
import 'shop_details.dart';
import 'tabs/stats_tab.dart';

final currencyProvider = StateProvider<String>((ref) {
  return 'DH';
});

class HomePage extends ConsumerStatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final logger = Logger();
  //File _pickedFile = File('/storage/emulated/0/Download/test.txt');
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final _currency = ref.watch(currencyProvider.state).state;
    int _selectedPageIndex = ref.watch(selectedPageIndex.state).state;
    var items = ref.watch(itemsProvider.state).state;
    var payments = ref.watch(paymentsProvider.state).state;
    var shops = ref.watch(shopsProvider.state).state;
    var dataSink = DataSink(shops, items, payments);
    List<ShopsData> _shopsDataList = dataSink.allShopsData;
    // ref.watch(shopsDataListProvider.state).state;
    var _recentOperations = ref.watch(recentOperationsProvider.state).state;
    // var chartData = ref.watch(shopsChartsDataProvider.state).state;
    //final _db = ref.watch(databaseProvider);
    OverAlls all = OverAlls(shops: shops, items: items, payments: payments);
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
        gradientColors: [
          const Color(0xFFED8530),
          const Color(0xFFEB8B3C),
        ],
        centerWidget: Scaffold(
            bottomNavigationBar: buildNavigationBar(
                context, _selectedPageIndex, _pageController, ref),
            floatingActionButton: MyExpandableFab(),
            backgroundColor: Colors.transparent,
            appBar: buildAppBar(context, title: 'Home'),
            body: buildPageView(_pageController, ref, context,
                currency: _currency,
                all: all,
                shopsDataList: _shopsDataList,
                recentOperations: _recentOperations)));
  }

  buildPageView(
      PageController _pageController, WidgetRef ref, BuildContext context,
      {required OverAlls all,
      required List<ShopsData> shopsDataList,
      required RecentOperation recentOperations,
      required String currency}) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              ref.read(selectedPageIndex.state).state = index;
            },
            children: [
              buildBody(context,
                  currency: currency,
                  all: all,
                  shopsDataList: shopsDataList,
                  recentOperations: recentOperations),
              DashBoardTab(),
              ListTab(),
              StatsTab(),
              SettingsPage(),
            ],
          ),
        ),
      ],
    );
  }

  BottomNavigationBar buildNavigationBar(context, int _selectedPageIndex,
      PageController _pageController, WidgetRef ref) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      currentIndex: _selectedPageIndex,
      elevation: 8,
      onTap: (index) {
        ref.read(selectedPageIndex.state).state = index;
        _pageController.jumpToPage(
          index,
        );
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: 'Home',
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.dashboard),
          label: 'Dashboard',
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.list),
          label: 'Lists',
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        const BottomNavigationBarItem(
          icon: const Icon(Icons.add_chart),
          label: 'Stats',
          backgroundColor: const Color(0xFFFFC148),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: 'Settings',
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }

  buildBody(BuildContext context,
      {required OverAlls all,
      required List<ShopsData> shopsDataList,
      required RecentOperation recentOperations,
      required String currency}) {
    return BluredContainer(
      start: 0,
      end: 0,
      borderColorOpacity: 0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8),
            buildTopWidget(all, currency),
            // const SizedBox(height: 20),
            buildShopsWidget(context, shopsDataList, currency),
            buildRecentOpeerationsWidget(
              context,
              recentOperations,
              currency,
            )
          ],
        ),
      ),
    );
  }

  buildShopsWidget(
      BuildContext context, List<ShopsData> _shopsDataList, String currency) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.store, color: Color.fromRGBO(255, 255, 255, 1)),
              const SizedBox(width: 8),
              Text('Shops',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2),
            ],
          ),
        ),
        BluredContainer(
          child: SizedBox(
            width: 390,
            height: 160,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final ShopsData shopsData = _shopsDataList[index];

                      return ShopTile(
                        currency: currency,
                        shopData: shopsData,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopDetails(
                                shopsData: shopsData,
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
        ),
      ],
    );
  }

// build operations widget
  buildRecentOpeerationsWidget(
      BuildContext context, RecentOperation recentOperations, String currency) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.receipt_long_sharp, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Recent Operations',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ],
            ),
          ),
          BluredContainer(
            child: SizedBox(
              width: 390,
              height: 340,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final OperationsAdapter recentOperation =
                      recentOperations.recentOperationsList[index];
                  return recentOperation.isItem
                      ? ItemTileWidget(
                          //currency: currency,
                          item: recentOperation.item!,
                        )
                      : PaymentTile(
                          payment: recentOperation.payment!,
                        );
                },
                itemCount: recentOperations.recentOperationsList.length,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  buildTopWidget(OverAlls all, String currency) {
    return SizedBox(
      width: 390,
      height: 80,
      child: BluredContainer(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // buildCircularProgress(),
            // const SizedBox(width: 12),
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Spendings',
                  style: GoogleFonts.sansita(
                    color: Color.fromARGB(255, 170, 0, 79),
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text.rich(
                  TextSpan(
                    text: '${all.itemsSumAfterPayment}',
                    style: GoogleFonts.roboto(
                      color: Color(0xFF1A1619),
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    children: [
                      TextSpan(
                        text: '$currency',
                        style: GoogleFonts.poppins(
                          color: Color(0xFF0A0A0A),
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  CircularPercentIndicator buildCircularProgress() {
    return CircularPercentIndicator(
      animateFromLastPercent: true,
      animation: true,
      curve: Curves.linear,
      radius: 80.0,
      lineWidth: 4.0,
      percent: 0.6,
      center: new Text("60 %"),
      progressColor: Color(0xFFAA2585),
      backgroundColor: Colors.white.withOpacity(0.6),
    );
  }

// build custom listTile
  Widget buildRowTileRecentOpe(OperationsAdapter operation, String currency) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radius),
      ),
      color: Colors.white.withOpacity(0.4),
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

class ShopTile extends StatelessWidget {
  const ShopTile({
    Key? key,
    required this.onTap,
    required this.shopData,
    required this.currency,
  }) : super(key: key);

  final VoidCallback? onTap;
  final ShopsData shopData;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radius),
        ),
        color: Color(0xADC69AE6).withOpacity(0.2),
        child: SizedBox(
          height: 42,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 8),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color(0x7BFFFFFF),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      '${shopData.shop.shopName!.substring(0, 1)}',
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              Expanded(
                child: Text(
                  '${shopData.shop.shopName}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${shopData.itemsSumAfterPayment}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    width: 42,
                    height: 52,
                    child: Text(
                      '$currency',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ],
              ),
            ],
          ),
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
          onPressed: () => Dialogs.botomPopUpDialog(
            context,
            AddPayment(),
          ),
          icon: const Icon(Icons.monetization_on),
        ),
        ActionButton(
          onPressed: () => Dialogs.botomPopUpDialog(
            context,
            AddShop(),
          ),
          icon: const Icon(Icons.person_add),
        ),
        ActionButton(
          onPressed: () => Dialogs.botomPopUpDialog(
            context,
            AddItem(),
          ),
          icon: const Icon(Icons.add_shopping_cart_sharp),
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
AppBar buildAppBar(BuildContext context, {String? title}) {
  return AppBar(
    actions: [
      IconButton(
        icon: Icon(Icons.add_box_outlined),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SettingsPage(),
            ),
          );
        },
      ),
    ],
    leading: Icon(Icons.home, color: Colors.black),
    title: Text(
      title ?? '',
      style: Theme.of(context).textTheme.headline2,
    ),
    elevation: 0,
    shadowColor: Colors.transparent,
    excludeHeaderSemantics: true,
    toolbarHeight: 40,
    backgroundColor: Colors.white.withOpacity(0.4),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppConstants.radius),
        bottom: Radius.circular(AppConstants.radius),
      ),
    ),
  );
}

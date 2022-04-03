import 'package:lkarnet/components.dart';
import 'package:lkarnet/models/operations_adapter.dart';
import 'package:lkarnet/providers/varproviders/var_providers.dart';
import 'package:lkarnet/screens/dash/dashboard.dart';
import 'package:lkarnet/screens/settings/settings.dart';
import '../models/shop/shops_data.dart';
import '../providers/streamproviders/items_stream_provider.dart';
import '../providers/streamproviders/payments_stream_provider.dart';
import '../providers/streamproviders/shops_stream_provider.dart';
import 'shopdetailsmain.dart';
import 'kitchen_stock.dart';
import 'stats/stats_all.dart';
import 'package:flutter/material.dart';

final appTittleProvider = StateProvider<String>((ref) {
  return "Home";
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
    //final _currency = ref.watch(currencyProvider.state).state;
    int _selectedPageIndex = ref.watch(selectedPageIndex.state).state;
    var items = ref.watch(itemsProvider.state).state;
    var payments = ref.watch(paymentsProvider.state).state;
    var shops = ref.watch(shopsProvider.state).state;
    var dataSink = DataSink(shops, items, payments);
    List<ShopData> _shopsDataList = dataSink.allShopsData;
    // ref.watch(shopsDataListProvider.state).state;
    var _recentOperations = ref.watch(recentOperationsProvider.state).state;
    // var chartData = ref.watch(shopsChartsDataProvider.state).state;
    //final _db = ref.watch(databaseProvider);

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
        centerWidget: Scaffold(
            bottomNavigationBar: buildNavigationBar(
                context, _selectedPageIndex, _pageController, ref),
            backgroundColor: Colors.transparent,
            body: buildPageView(_pageController, ref, context,
                dataSink: dataSink,
                shopsDataList: _shopsDataList,
                recentOperations: _recentOperations)));
  }

  buildPageView(
    PageController _pageController,
    WidgetRef ref,
    BuildContext context, {
    required DataSink dataSink,
    required List<ShopData> shopsDataList,
    required RecentOperation recentOperations,
  }) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            //allowImplicitScrolling:true ,
            //clipBehavior:Clip.hardEdge ,
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              ref.read(selectedPageIndex.state).state = index;
            },
            children: [
              DashBoardPage(),
              //DashBoardTab(),
              ShopDetailsMain(),
              // ListTab(),
              //ShopsList(),
              KitchenStockHome(),
              StatsAll(),
              SettingsPage(),
            ],
          ),
        ),
      ],
    );
  }

  buildNavigationBar(context, int _selectedPageIndex,
      PageController _pageController, WidgetRef ref) {
    return BottomNavigationBar(
      backgroundColor: Colors.transparent,
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
          backgroundColor: Color.fromARGB(137, 101, 179, 224),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.dashboard),
          label: 'Dashboard',
          backgroundColor: Color.fromARGB(144, 224, 126, 101),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.kitchen),
          label: 'Kitchen',
          backgroundColor: Color.fromARGB(136, 224, 101, 121),
        ),
        const BottomNavigationBarItem(
          icon: const Icon(Icons.add_chart),
          label: 'Stats',
          backgroundColor: Color.fromARGB(123, 224, 101, 183),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: 'Settings',
<<<<<<< HEAD
          backgroundColor: Color.fromARGB(160, 148, 101, 224),
=======
          backgroundColor: Color.fromARGB(255, 148, 101, 224),
        ),
      ],
    );
  }

  buildBody(
    BuildContext context, {
    required DataSink dataSink,
    required List<ShopData> shopsDataList,
    required RecentOperation recentOperations,
  }) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: MyExpandableFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: buildAppBar(
        context,
        title: 'Home',
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
              buildShopsWidget(context, shopsDataList),
              buildRecentOpeerationsWidget(
                context,
                recentOperations,
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
        height: 170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            SizedBox(
              height: 120,
              child: ListView.builder(
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.dashboard_customize,
                    color: Color.fromRGBO(255, 255, 255, 1)),
                const SizedBox(width: 8),
                Text('Recent Operations',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2),
              ],
            ),
          ),
          SizedBox(
            width: 390,
            height: 340,
            child: ListView.builder(
              itemBuilder: (context, index) {
                final OperationsAdapter recentOperation =
                    recentOperations.recentOperationsList[index];
                return recentOperation.isItem
                    ? ItemTileWidget(
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
    return SizedBox(
      width: 390,
      height: 130,
      child: BluredContainer(
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
    );
  }

  CircularPercentIndicator buildCircularProgress(DataSink dataSink) {
    return CircularPercentIndicator(
      animateFromLastPercent: true,
      animation: true,
      curve: Curves.linear,
      radius: 54.0,
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

class ShopTile extends StatelessWidget {
  const ShopTile({
    Key? key,
    required this.onTap,
    required this.shopData,
    required this.currency,
  }) : super(key: key);

  final VoidCallback? onTap;
  final ShopData shopData;
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

class ShopSquareTile extends StatelessWidget {
  const ShopSquareTile({
    Key? key,
    required this.onTap,
    required this.shopData,
  }) : super(key: key);

  final VoidCallback? onTap;
  final ShopData shopData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: SizedBox(
          width: 120,
          height: 120,
          child: BluredContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.person_outline_sharp,
                      color: Colors.white.withOpacity(0.5),
                      size: 40,
                    ),
                    Text(
                      '${shopData.shop.shopName}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
                PriceNumberZone(
                  right: const SizedBox.shrink(),
                  withDollarSign: true,
                  price: shopData.itemsSumAfterPayment,
                  style: Theme.of(context).textTheme.headline3!,
                ),
                const SizedBox(height: 8),
              ],
            ),
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
          icon: const Icon(
            Icons.monetization_on,
            size: 32,
          ),
        ),
        ActionButton(
          onPressed: () => Dialogs.botomPopUpDialog(
            context,
            AddShop(),
          ),
          icon: const Icon(
            Icons.person_add,
            size: 30,
          ),
        ),
        ActionButton(
          onPressed: () => Dialogs.botomPopUpDialog(
            context,
            AddItem(),
          ),
          icon: const Icon(
            Icons.add_shopping_cart_sharp,
            size: 30,
          ),
>>>>>>> b001677 (kitchen element items crud)
        ),
      ],
    );
  }
}

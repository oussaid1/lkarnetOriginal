import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lkarnet/bloc/payments/payments_bloc.dart';
import 'package:lkarnet/components.dart';
import 'package:lkarnet/providers/authproviders/database_providers.dart';
import 'package:lkarnet/providers/varproviders/var_providers.dart';
import 'package:lkarnet/screens/dash/dashboard.dart';
import 'package:lkarnet/screens/settings/settings.dart';
import '../bloc/itemsbloc/items_bloc.dart';
import '../bloc/shopsbloc/shops_bloc.dart';
import '../repository/database_operations.dart';
import 'shopdetailsmain.dart';
import 'kitchen_stock.dart';
import 'stats/stats_all.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ItemsBloc(databaseOperations: GetIt.I<DatabaseOperations>()),
        ),
        BlocProvider(
          create: (context) => ShopsBloc(GetIt.I<DatabaseOperations>()),
        ),
        BlocProvider(
          create: (context) => PaymentsBloc(GetIt.I<DatabaseOperations>()),
        )
      ],
      child: HomeScreen(),
    );
  }
}

class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  //File _pickedFile = File('/storage/emulated/0/Download/test.txt');
  final PageController _pageController = PageController();
  @override
  void initState() {
    context.read<ItemsBloc>().add(GetItemsEvent());
    context.read<ShopsBloc>().add(GetShopsEvent());
    context.read<PaymentsBloc>().add(GetPaymentsEvent());
    // _notificationsPermition(context);
    // Workmanager().initialize(
    //     callbackDispatcher, // The top level function, aka callbackDispatcher
    //     isInDebugMode:
    //         true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
    //     );
    // _getToken();
    super.initState();
  }

// get device token and insert it in firebase
  Future<String?> getToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      log("FCM Token: $fcmToken");
      ref.read(databaseProvider).insertToken(fcmToken);
      log("token inserted $fcmToken");
      return fcmToken;
    } else {
      log("FCM Token: null");
      return null;
    }
  }

  void _notificationsPermition(BuildContext context) async {
    AwesomeNotifications().createdStream.listen((notification) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.teal,
        content: Text(
          'Notification Created on ${notification.channelKey}',
        ),
      ));
    });

    AwesomeNotifications().actionStream.listen((notification) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => KitchenStockHome(),
        ),
        (route) => route.isFirst,
      );
    });
  }

  @override
  void dispose() {
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final _currency = ref.watch(currencyProvider.state).state;
    int _selectedPageIndex = ref.watch(selectedPageIndex.state).state;
    //var items = <ItemModel>[];
    //ref.watch(itemsProvider.state).state;
    // var payments = ref.watch(paymentsProvider.state).state;
    // var shops = ref.watch(shopsProvider.state).state;
    //  var dataSink = DataSink(shops, items, payments);
    // List<ShopData> _shopsDataList = dataSink.allShopsData;
    // ref.watch(shopsDataListProvider.state).state;
    //  var _recentOperations = ref.watch(recentOperationsProvider.state).state;
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
      centerWidget: BlocConsumer<ItemsBloc, ItemsState>(
        // buildWhen: (previous, current) => current is ItemsLoadedState,
        listener: (context, state) {
          // if (state is ItemsLoadedState) {
          //   dataSink.items = state.items;
          //   log("items loaded ${state.items.length}");
          // }
        },
        builder: (context, state) {
          return Scaffold(
            // appBar: AppBar(
            //   title: Text(
            //     "LKarnet",
            //     style: TextStyle(
            //       fontSize: 30,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            //   centerTitle: true,
            //   actions: [
            //     IconButton(
            //       icon: Icon(Icons.settings),
            //       onPressed: () {
            //         context.read<ItemsBloc>().add(GetItemsEvent());
            //       },
            //     ),
            //   ],
            // ),
            bottomNavigationBar: buildNavigationBar(
                context, _selectedPageIndex, _pageController, ref),
            backgroundColor: Colors.transparent,
            body: buildPageView(
              _pageController,
              ref,
            ),
          );
        },
      ),
    );
  }

  buildPageView(
    PageController _pageController,
    WidgetRef ref,
    // BuildContext context, {
    // required DataSink dataSink,
    // required List<ShopData> shopsDataList,
    // required RecentOperation recentOperations,
  ) {
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
          backgroundColor: Color.fromARGB(160, 148, 101, 224),
        ),
      ],
    );
  }
}

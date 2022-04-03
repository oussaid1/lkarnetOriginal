import 'package:flutter/material.dart';
import 'package:lkarnet/components.dart';
import 'package:lkarnet/models/kitchen/kitchen_element_data.dart';
import 'package:lkarnet/providers/authproviders/database_providers.dart';
import 'package:lkarnet/screens/add/add_kitechen_element.dart';
import '../models/kitchen/kitchen_item.dart';
import '../widgets/availability_widget.dart';
import '../widgets/charts.dart';
import '../widgets/notifications_widget.dart';
import 'lists/unavailiable_elements.dart';
import 'tabs/kitchen_element_detailed.dart';

class KitchenStockHome extends ConsumerStatefulWidget {
  const KitchenStockHome({Key? key}) : super(key: key);

  @override
  ConsumerState<KitchenStockHome> createState() => _KitchenStockHomeState();
}

class _KitchenStockHomeState extends ConsumerState<KitchenStockHome> {
<<<<<<< HEAD
<<<<<<< HEAD
=======
  String filter = '';

>>>>>>> 55dc683 (kitchen element items crud)
=======
  late List<KitchenElement> _kitchenElements;
  late List<KitchenItem> _kitchenItems;
  //SingleKitchenElementData? singleKitchenElementData;
  late List<SingleKitchenElementData> _kitchenElementDataList;
  @override
  void initState() {
    _kitchenElements = [];
    _kitchenItems = [];
    _kitchenElementDataList = [];
    super.initState();
  }

  void clearListsts() {
    _kitchenElements = [];
    _kitchenItems = [];
    _kitchenElementDataList = [];
  }

  @override
  void dispose() {
    _kitchenElements = [];
    _kitchenItems = [];
    _kitchenElementDataList = [];
    super.dispose();
  }

>>>>>>> 1b32af8 (hamdollillah)
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
=======
    List<KitchenElement> kitchenElements = [];
    List<KitchenItem> kitchenItems = KitchenItem.fakeKitchenitems();
    KitchenElementData? kitchenElementData;
>>>>>>> b001677 (kitchen element items crud)
    return BluredContainer(
      start: 0.1,
      end: 0,
      borderColorOpacity: 0,
      child: StreamBuilder<List<KitchenItem>>(
          stream: ref.read(databaseProvider).kitchenItemsStream(),
          builder: (context, snap) {
            return StreamBuilder<List<KitchenElement>>(
                stream: ref.read(databaseProvider).kitchenElementsStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snap.hasData) {
<<<<<<< HEAD
                    clearListsts();
                    _kitchenElements = snapshot.data!;
                    _kitchenItems = snap.data!;
                    for (var i = 0; i < _kitchenElements.length; i++) {
                      _kitchenElementDataList.add(
                        SingleKitchenElementData(
                          _kitchenElements[i],
                          _kitchenItems
                              .where((element) =>
                                  element.kitchenElementId ==
                                  _kitchenElements[i].id)
                              .toList(),
                        ),
                      );
                    }
=======
                    kitchenElements = snapshot.data!;
                    kitchenItems = snap.data!;
                    kitchenElementData =
                        KitchenElementData(kitchenElements, kitchenItems);
>>>>>>> b001677 (kitchen element items crud)
                  }
                  //kitchenElements = KitchenElement.fakeKitchenElements;
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerDocked,
                    floatingActionButton: FloatingActionButton(
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 1a88e7a (kitchen element items crud)
                      heroTag: 'add_kitchen_element',
=======
>>>>>>> 55dc683 (kitchen element items crud)
=======
                      heroTag: 'add_kitchen_element',
>>>>>>> 7cea0f9 (v 0.9.2)
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddKitchenElement(),
                          ),
=======
                      onPressed: () {
                        Dialogs.botomPopUpDialog(
                          context,
                          AddKitchenElement(),
>>>>>>> b001677 (kitchen element items crud)
                        );
                      },
                      child: Icon(Icons.add),
                    ),
                    appBar: AppBar(
                      actions: [
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 7cea0f9 (v 0.9.2)
                        NotificationWidget(
                          count: kitchenElementData!
                              .unavaliableKitchenElements.length,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UnAvailiableElements(
                                    elementData: kitchenElementData!
                                        .unavaliableKitchenElements),
                              ),
                            );
                          },
<<<<<<< HEAD
=======
                        // IconButton(
                        //   icon: Icon(Icons.add_box_outlined),
                        //   onPressed: () async {
                        //     var logger = Logger();
                        //     for (var item in items!) {
                        //       logger.d(item.toMap());
                        //     }
                        //   },
                        // ),
=======
                        ),
>>>>>>> 7cea0f9 (v 0.9.2)
=======
                        _buildNotifications(kitchenElementData, context),
>>>>>>> 05f7265 (..)
=======
=======
>>>>>>> 1a88e7a (kitchen element items crud)
                        _buildNotifications(
                            KitchenElementData(_kitchenElements), context),
>>>>>>> 1b32af8 (hamdollillah)
                      ],
                      leading:
                          Icon(Icons.kitchen_outlined, color: Colors.black),
                      title: Text(
                        'Kitchen Stock ',
=======
                        // IconButton(
                        //   icon: Icon(Icons.add_box_outlined),
                        //   onPressed: () async {
                        //     var logger = Logger();
                        //     for (var item in items!) {
                        //       logger.d(item.toMap());
                        //     }
                        //   },
                        // ),
                      ],
                      leading: Icon(Icons.dashboard, color: Colors.black),
                      title: Text(
                        'Shop Details',
>>>>>>> b001677 (kitchen element items crud)
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      excludeHeaderSemantics: true,
                      toolbarHeight: 40,
                      backgroundColor: AppConstants.whiteOpacity,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(AppConstants.radius),
                          bottom: Radius.circular(AppConstants.radius),
>>>>>>> 55dc683 (kitchen element items crud)
                        ),
                      ],
                      leading:
                          Icon(Icons.kitchen_outlined, color: Colors.black),
                      title: Text(
                        'Kitchen Stock',
                        style: Theme.of(context).textTheme.headline2,
                      ),
<<<<<<< HEAD
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      excludeHeaderSemantics: true,
                      toolbarHeight: 40,
                      backgroundColor: AppConstants.whiteOpacity,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(AppConstants.radius),
                          bottom: Radius.circular(AppConstants.radius),
                        ),
                      ),
=======
>>>>>>> 55dc683 (kitchen element items crud)
                    ),
                    // Next, create a SliverList
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
                          Container(
                            margin: EdgeInsets.all(8),
                            height: 200,
                            width: 400,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 7cea0f9 (v 0.9.2)
                            child: BluredContainer(
                                margin: EdgeInsets.all(8),
                                width: 400,
                                height: 220,
                                child: ColumnKitchenElWidget(kitchenElements)),
                          ),
=======
                          _buildBarChartWidget(kitchenElements),
>>>>>>> 05f7265 (..)
                          const SizedBox(height: 20),
                          kitchenElementData != null
                              ? _buildGridView(context, kitchenElementData)
                              : Container(),
=======
                          ),
                          const SizedBox(height: 20),
<<<<<<< HEAD
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            // height: 440,
                            width: MediaQuery.of(context).size.width,
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.5,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10),
                              itemCount:
                                  kitchenElementData!.kitchenElements.length,
                              itemBuilder: (context, index) {
                                final KitchenElement kitchenElement =
                                    kitchenElementData!.kitchenElements[index];
                                return KitchenItemSquareTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            KitchenItemDetailsScreen(
                                          kitchenElement: kitchenElement,
                                        ),
                                      ),
                                    );
                                  },
                                  kitchenElement: kitchenElement,
                                );
                              },
                            ),
                          ),
>>>>>>> 55dc683 (kitchen element items crud)
=======
                          kitchenElementData != null
                              ? Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  // height: 440,
                                  width: MediaQuery.of(context).size.width,
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 1.5,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10),
                                    itemCount: kitchenElementData!
                                        .kitchenElements.length,
                                    itemBuilder: (context, index) {
                                      final KitchenElement kitchenElement =
                                          kitchenElementData!
                                              .kitchenElements[index];
                                      return KitchenItemSquareTile(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  KitchenElementDetailsScreen(
                                                kitchenElement: kitchenElement,
                                              ),
                                            ),
                                          );
                                        },
                                        kitchenElement: kitchenElement,
                                      );
                                    },
                                  ),
                                )
                              : Container(),
>>>>>>> a71c130 (...)
=======
                          _buildBarChartWidget(_kitchenElements),
                          const SizedBox(height: 20),
                          _buildGridView(context, _kitchenElementDataList),
>>>>>>> 1b32af8 (hamdollillah)
=======
                          _buildBarChartWidget(_kitchenElements),
                          const SizedBox(height: 20),
                          _buildGridView(context, _kitchenElementDataList),
=======
                          Container(
                            margin: EdgeInsets.all(8),
                            height: 200,
                            width: 400,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            // height: 440,
                            width: MediaQuery.of(context).size.width,
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.5,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10),
                              itemCount:
                                  kitchenElementData!.kitchenElements.length,
                              itemBuilder: (context, index) {
                                final KitchenElement kitchenElement =
                                    kitchenElementData!.kitchenElements[index];
                                return KitchenItemSquareTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            KitchenItemDetailsScreen(
                                          kitchenElement: kitchenElement,
                                        ),
                                      ),
                                    );
                                  },
                                  kitchenElement: kitchenElement,
                                );
                              },
                            ),
                          ),
>>>>>>> b001677 (kitchen element items crud)
>>>>>>> 1a88e7a (kitchen element items crud)
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
<<<<<<< HEAD

  Container _buildBarChartWidget(List<KitchenElement> kitchenElements) {
    return Container(
      margin: EdgeInsets.all(8),
      height: 200,
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: BluredContainer(
          margin: EdgeInsets.all(8),
          width: 400,
          height: 220,
          child: ColumnChartKitchenElWidget(kitchenElements)),
    );
  }

  Container _buildGridView(BuildContext context,
      List<SingleKitchenElementData> singleKitchenElementDataList) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      // height: 440,
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12),
        itemCount: singleKitchenElementDataList.length,
        itemBuilder: (context, index) {
          final SingleKitchenElementData kitchenElement =
              singleKitchenElementDataList[index];
          return KitchenItemSquareTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KitchenElementDetailsScreen(
                    kitchenElement: kitchenElement.perfectKitchenElement,
                  ),
                ),
              );
            },
            kitchenElement: kitchenElement.perfectKitchenElement,
          );
        },
      ),
    );
  }

  NotificationWidget _buildNotifications(
      KitchenElementData? kitchenElementData, BuildContext context) {
    return NotificationWidget(
      count: kitchenElementData != null
          ? kitchenElementData.unavaliableKitchenElements.length
          : 0,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UnAvailiableElements(
                elementData: kitchenElementData!.unavaliableKitchenElements),
          ),
        );
      },
    );
  }
=======
>>>>>>> b001677 (kitchen element items crud)
}

class KitchenItemSquareTile extends StatelessWidget {
  const KitchenItemSquareTile({
    Key? key,
    required this.onTap,
    required this.kitchenElement,
  }) : super(key: key);

  final VoidCallback? onTap;
  final KitchenElement kitchenElement;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: BluredContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          //verticalDirection: VerticalDirection.up,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 0, right: 8),
                              child: Text(
                                kitchenElement.title.toString(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                            PiorityRatingWidget(
                              ignoreGestures: true,
                              onRatingChanged: (rating) {},
                              initialRating: kitchenElement.priority!,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // buildKitchenItemDetail(context,
                  //     title: 'Status: ',
                  //     digitWidget: ProgressWidget(
                  //       kitchenElement: kitchenElement,
                  //     )),

                  const SizedBox(height: 10),
                  _buildDetails(context),
                ],
              ),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: SizedBox(
                height: 45,
                child: Card(
                  margin: EdgeInsets.all(0),
                  color: AppConstants.whiteOpacity,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(4.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProgressWidget(
                          kitchenElement: kitchenElement,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${kitchenElement.category!.trim()}',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                            Icon(
                              Icons.fastfood,
                              color: Colors.white.withOpacity(0.5),
                              size: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildDetails(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildKitchenItemDetail(context,
                title: 'Last Bought: ',
                digitWidget: Text(
                  kitchenElement.lastTimeBought,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontFamily: 'Montserrat',
                      color: Color.fromARGB(104, 36, 35, 35).withOpacity(0.6)),
                )),
            buildKitchenItemDetail(context,
                title: 'Times Bought: ',
                digitWidget: Text(
                  kitchenElement.timesBought.toString(),
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Color.fromARGB(104, 36, 35, 35).withOpacity(0.6)),
                )),
          ],
        ),
      ],
    );
  }

  Padding buildKitchenItemDetail(BuildContext context,
      {String? title, Widget? digitWidget}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? '',
            style: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(color: Colors.white.withOpacity(0.3)),
          ),
          digitWidget ?? SizedBox.shrink(),
        ],
      ),
    );
  }
}
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 1a88e7a (kitchen element items crud)
=======

class ProgressWidget extends StatelessWidget {
  const ProgressWidget({
    Key? key,
    required this.kitchenElement,
  }) : super(key: key);
  final KitchenElement kitchenElement;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: SfRadialGauge(
        // backgroundColor: Colors.white,
        axes: <RadialAxis>[
          RadialAxis(
            labelFormat: '${kitchenElement.availability}',
            labelOffset: 15,
            labelsPosition: ElementsPosition.inside,
            axisLabelStyle:
                GaugeTextStyle(fontSize: 8, fontWeight: FontWeight.bold),
            minimum: 0,
            maximum: 10,
            showLabels: true,
            showTicks: false,
            startAngle: 270,
            endAngle: 270,
            axisLineStyle: AxisLineStyle(
              thickness: 0.05,
              color: Color.fromARGB(38, 255, 255, 255),
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                color: Color.fromARGB(99, 255, 255, 255),
                value: kitchenElement.availability!,
                width: 0.95,
                pointerOffset: 0.05,
                sizeUnit: GaugeSizeUnit.factor,
              )
            ],
          )
        ],
      ),
    );
  }
}
<<<<<<< HEAD
>>>>>>> 55dc683 (kitchen element items crud)
=======
>>>>>>> 7cea0f9 (v 0.9.2)
=======
>>>>>>> b001677 (kitchen element items crud)
>>>>>>> 1a88e7a (kitchen element items crud)

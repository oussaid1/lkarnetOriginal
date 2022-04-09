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

  @override
  Widget build(BuildContext context) {
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
                  }
                  //kitchenElements = KitchenElement.fakeKitchenElements;
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerFloat,
                    floatingActionButton: FloatingActionButton(
                      heroTag: 'add_kitchen_element',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddKitchenElement(),
                          ),
                        );
                      },
                      child: Icon(Icons.add),
                    ),
                    appBar: AppBar(
                      actions: [
                        _buildNotifications(
                            KitchenElementsData(_kitchenElements), context),
                      ],
                      leading:
                          Icon(Icons.kitchen_outlined, color: Colors.black),
                      title: Text(
                        'Kitchen Stock ',
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
                        ),
                      ),
                    ),
                    // Next, create a SliverList
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          _buildBarChartWidget(_kitchenElements),
                          const SizedBox(height: 20),
                          _buildGridView(context, _kitchenElementDataList),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }

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
      KitchenElementsData? kitchenElementData, BuildContext context) {
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

import 'package:flutter/material.dart';
import 'package:lkarnet/components.dart';
import 'package:lkarnet/models/kitchen/kitchen_element_data.dart';
import 'package:lkarnet/providers/authproviders/database_providers.dart';
import 'package:lkarnet/screens/add/add_kitechen_element.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../models/kitchen/kitchen_item.dart';
import '../widgets/dialogs.dart';
import 'tabs/kitchen_element_detailed.dart';

class KitchenStockHome extends ConsumerStatefulWidget {
  const KitchenStockHome({Key? key}) : super(key: key);

  @override
  ConsumerState<KitchenStockHome> createState() => _KitchenStockHomeState();
}

class _KitchenStockHomeState extends ConsumerState<KitchenStockHome> {
  @override
  Widget build(BuildContext context) {
    List<KitchenElement> kitchenElements = [];
    List<KitchenItem> kitchenItems = KitchenItem.fakeKitchenitems();
    KitchenElementData? kitchenElementData;
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
                    kitchenElements = snapshot.data!;
                    kitchenItems = snap.data!;
                    kitchenElementData =
                        KitchenElementData(kitchenElements, kitchenItems);
                  }
                  //kitchenElements = KitchenElement.fakeKitchenElements;
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerDocked,
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        Dialogs.botomPopUpDialog(
                          context,
                          AddKitchenElement(),
                        );
                      },
                      child: Icon(Icons.add),
                    ),
                    appBar: AppBar(
                      actions: [
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
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  );
                });
          }),
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
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: BluredContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          kitchenElement.title.toString(),
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        PiorityRatingWidget(
                          onRatingChanged: (rating) {},
                          initialRating: kitchenElement.priority!,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.fastfood,
                          color: Colors.white.withOpacity(0.5),
                          size: 20,
                        ),
                        Text(
                          '${kitchenElement.category}',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              buildKitchenItemDetail(context,
                  title: 'Status: ',
                  digitWidget: ProgressWidget(
                    kitchenElement: kitchenElement,
                  )),
              buildKitchenItemDetail(context,
                  title: 'Last Bought: ',
                  digitWidget: Text(
                    DateTime.now().formatted(),
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontFamily: 'Montserrat',
                        color:
                            Color.fromARGB(104, 36, 35, 35).withOpacity(0.6)),
                  )),
              buildKitchenItemDetail(context,
                  title: 'Times Bought: ',
                  digitWidget: Text(
                    '12',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color:
                            Color.fromARGB(104, 36, 35, 35).withOpacity(0.6)),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildKitchenItemDetail(BuildContext context,
      {String? title, Widget? digitWidget}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? '',
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.white.withOpacity(0.3)),
          ),
          digitWidget ?? SizedBox.shrink(),
        ],
      ),
    );
  }
}

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

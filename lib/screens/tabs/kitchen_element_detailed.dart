import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lkarnet/screens/add/add_kitchen_item.dart';
import 'package:lkarnet/screens/add/add_kitechen_element.dart';

import '../../components.dart';
import '../../models/kitchen/kitchen_item.dart';
import '../../providers/operationsprovider/operations_provider.dart';
import '../../widgets/availability_widget.dart';
import '../../widgets/dialogs.dart';
import '../../widgets/kitchen_item_listtile.dart';
import '../add/edit_kitchen_element.dart';

class KitchenElementDetailsScreen extends ConsumerStatefulWidget {
  const KitchenElementDetailsScreen({Key? key, required this.kitchenElement})
      : super(key: key);
  final KitchenElement kitchenElement;
  @override
  ConsumerState<KitchenElementDetailsScreen> createState() =>
      _KitchenItemDetailsScreenState();
}

class _KitchenItemDetailsScreenState
    extends ConsumerState<KitchenElementDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    //List<KitchenElement> kitchenItems = [];
    return Scaffold(
      //appBar: AppBar(),
      body: GlassMaterial(
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
          Color.fromARGB(255, 134, 32, 230),
          Color.fromARGB(255, 224, 101, 101),
          Color.fromARGB(255, 224, 101, 101),
        ],
        centerWidget: Scaffold(
          backgroundColor: Colors.transparent,

          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            heroTag: 'kitchen_element_details_screen',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddKitchenItem(),
                ),
              );
            },
            child: Icon(Icons.add),
          ),
          appBar: AppBar(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            backgroundColor: Color.fromARGB(54, 221, 170, 170),
            actions: [
              Row(
                children: [
                  Text('Edit'),
                  IconButton(
                    icon: Icon(Icons.edit_outlined),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddKitchenElement(
                            kitchenElement: widget.kitchenElement,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
            title: Text('Details'
                //style: Theme.of(context).textTheme.headline2,
                ),
            titleSpacing: 40,
            flexibleSpace: BluredContainer(
              child: Container(),
            ),
            leadingWidth: 10,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          // Next, create a SliverList
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                BluredContainer(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BluredContainer(
                        height: 54,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  '${widget.kitchenElement.category}',
                                  style: Theme.of(context).textTheme.headline3,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Hero(
                                tag: 'foodCategory',
                                child: Icon(
                                  Icons.fastfood,
                                  color: Colors.white.withOpacity(0.5),
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: GestureDetector(
                                onTap: () {
                                  Dialogs.botomUpDialog(
                                    context,
                                    UpdateKitchenElement(
                                      kitchenElement: widget.kitchenElement,
                                    ),
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ProgressWidget(
                                      kitchenElement: widget.kitchenElement,
                                    ),
                                    Text(
                                      'Status: ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                              color: Colors.white
                                                  .withOpacity(0.3)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 12),
                                  child: Text(
                                    widget.kitchenElement.title.toString(),
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                ),
                                PiorityRatingWidget(
                                  ignoreGestures: true,
                                  onRatingChanged: (rating) {},
                                  initialRating:
                                      widget.kitchenElement.priority!,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Last bought: ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Colors.white.withOpacity(0.3)),
                            ),
                            Text(
                              '${widget.kitchenElement.lastTimeBought}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(104, 36, 35, 35)
                                        .withOpacity(0.6),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Date expired : ',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                      color: Colors.white.withOpacity(0.3)),
                            ),
                            Text(
                              '${widget.kitchenElement.timeExpired}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontFamily: 'Montserrat',
                                    color: Color.fromARGB(104, 36, 35, 35)
                                        .withOpacity(0.6),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                BluredContainer(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  // height: 340,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.kitchenElement.items.length,
                    itemBuilder: (context, index) {
                      final KitchenItem _kitchenItem =
                          widget.kitchenElement.items[index];
                      return GestureDetector(
                        onDoubleTap: () => KitchenItmExpiredButton(
                            kitchenItem: _kitchenItem,
                            op: ref.read(operationsProvider)),
                        child: KitchenItemTileWidget(
                          kitchenItem: _kitchenItem,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// final priorityRatingProvider = StateProvider<double>((ref) {
//   return 0;
// });

class PiorityRatingWidget extends ConsumerWidget {
  const PiorityRatingWidget({
    Key? key,
    required this.onRatingChanged,
    this.initialRating = 0,
    this.itemSize = 18,
    this.ignoreGestures = false,
  }) : super(key: key);
  final void Function(double) onRatingChanged;
  final double itemSize;
  final double initialRating;
  final bool ignoreGestures;
  @override
  Widget build(BuildContext context, ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RatingBar.builder(
          ignoreGestures: ignoreGestures,
          initialRating:
              initialRating, //ref.watch(priorityRatingProvider.state).state,
          itemSize: itemSize,
          minRating: 0,
          direction: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, _) =>
              Icon(Icons.star_border_purple500, color: Colors.amber),
          onRatingUpdate: (rating) {
            //  ref.watch(priorityRatingProvider.state).state = rating;
            onRatingChanged(rating);
          },
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class Availibility extends StatelessWidget {
  Availibility({Key? key, required this.onChanged, this.value = 0})
      : super(key: key);
  final void Function(double) onChanged;
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35,
      height: 35,
      child: GestureDetector(
        onTap: () {
          if (value < 10) {
            value++;
          } else {
            value = 0;
          }
          onChanged(value);
        },
        child: SfRadialGauge(
          // backgroundColor: Colors.white,

          axes: <RadialAxis>[
            RadialAxis(
              labelFormat: '$value',
              maximumLabels: 1,
              labelOffset: 45,
              labelsPosition: ElementsPosition.inside,
              axisLabelStyle:
                  GaugeTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              minimum: 0,
              maximum: 10,
              showLabels: true,
              showTicks: false,
              startAngle: 270,
              endAngle: 270,
              axisLineStyle: AxisLineStyle(
                thickness: 0.05,
                color: Color.fromARGB(120, 78, 62, 62),
                thicknessUnit: GaugeSizeUnit.factor,
              ),
              pointers: <GaugePointer>[
                RangePointer(
                  color: Color.fromARGB(98, 252, 183, 102),
                  value: value,
                  width: 0.95,
                  // pointerOffset: 0.05,
                  sizeUnit: GaugeSizeUnit.factor,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// class PriorityWidget extends StatelessWidget {
//   const PriorityWidget({Key? key, this.priority = 1, this.iconSize = 15})
//       : super(key: key);
//   final int priority;
//   final double iconSize;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 50,
//       height: 10,
//       child: getStars(priority),
//     );
//   }

//   Widget getStars(int priority) {
//     switch (priority) {
//       case 1:
//         return Row(
//           children: [
//             Icon(
//               Icons.star_rate_rounded,
//               color: Colors.yellow,
//               size: iconSize,
//             ),
//             Icon(
//               Icons.star_rate_rounded,
//               color: Colors.yellow,
//               size: iconSize,
//             ),
//             Icon(
//               Icons.star_rate_rounded,
//               color: Colors.yellow,
//               size: iconSize,
//             ),
//           ],
//         );
//       case 2:
//         return Row(
//           children: [
//             Icon(
//               Icons.star_rate_rounded,
//               color: Colors.yellow,
//               size: iconSize,
//             ),
//             Icon(
//               Icons.star_rate_rounded,
//               color: Colors.yellow,
//               size: iconSize,
//             ),
//             Icon(
//               Icons.star_border_rounded,
//               color: Colors.yellow,
//               size: iconSize,
//             ),
//           ],
//         );
//       case 3:
//         return Row(
//           children: [
//             Icon(
//               Icons.star_border_rounded,
//               color: Colors.yellow,
//               size: iconSize,
//             ),
//             Icon(
//               Icons.star_border_rounded,
//               color: Colors.yellow,
//               size: iconSize,
//             ),
//             Icon(
//               Icons.star_border_rounded,
//               color: Colors.yellow,
//               size: iconSize,
//             ),
//           ],
//         );
//       default:
//         return Row(
//           children: [
//             Icon(
//               Icons.star_border_rounded,
//               color: Colors.yellow,
//               size: iconSize,
//             ),
//             Icon(
//               Icons.star_border_rounded,
//               color: Colors.yellow,
//               size: iconSize,
//             ),
//             Icon(
//               Icons.star_border_rounded,
//               color: Colors.yellow,
//               size: iconSize,
//             ),
//           ],
//         );
//     }
//   }
// }

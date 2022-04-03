import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lkarnet/screens/add/add_kitchen_item.dart';
import 'package:lkarnet/screens/kitchen_stock.dart';
import 'package:lkarnet/screens/lists/items.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'package:lkarnet/widgets/date_picker.dart';

import '../../components.dart';
import '../../models/kitchen/kitchen_item.dart';
import '../../settings/theme.dart';
import '../../widgets/dialogs.dart';

class KitchenItemDetailsScreen extends ConsumerStatefulWidget {
  const KitchenItemDetailsScreen({Key? key, required this.kitchenElement})
      : super(key: key);
  final KitchenElement kitchenElement;
  @override
  ConsumerState<KitchenItemDetailsScreen> createState() =>
      _KitchenItemDetailsScreenState();
}

class _KitchenItemDetailsScreenState
    extends ConsumerState<KitchenItemDetailsScreen> {
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
            onPressed: () {
              Dialogs.botomPopUpDialog(
                context,
                AddKitchenItem(
                  kitchenElement: widget.kitchenElement,
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
                      Dialogs.botomPopUpDialog(
                        context,
                        UpdateKitchenElement(),
                      );
                    },
                  ),
                ],
              ),
            ],
            title: Text(
              'Details',
              //style: Theme.of(context).textTheme.headline2,
            ),
            flexibleSpace: BluredContainer(
              child: Container(),
            ),
            leadingWidth: 10,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          // Next, create a SliverList
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                BluredContainer(
                  // decoration: BoxDecoration(
                  //     border: Border.fromBorderSide(
                  //   BorderSide(
                  //     color: Colors.black,
                  //     width: 1,
                  //   ),
                  // )),
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  height: 200,
                  child: SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.kitchenElement.title.toString(),
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                  PriorityWidget(
                                    priority: widget.kitchenElement.priority!,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    Icons.fastfood,
                                    color: Colors.white.withOpacity(0.7),
                                    size: 30,
                                  ),
                                  Text(
                                    '${widget.kitchenElement.category}',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Status: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: Colors.white.withOpacity(0.3)),
                              ),
                              ProgressWidget(
                                kitchenElement: widget.kitchenElement,
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
                                'Last bought: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: Colors.white.withOpacity(0.3)),
                              ),
                              Text(
                                '${widget.kitchenElement.lastTimeBought}',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: Colors.white.withOpacity(0.3)),
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
                                    .subtitle1!
                                    .copyWith(
                                        color: Colors.white.withOpacity(0.3)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                      return KitchenItemTileWidget(
                        kitchenItem: widget.kitchenElement.items[index],
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

class PiorityRatingWidget extends StatelessWidget {
  const PiorityRatingWidget({
    Key? key,
    required this.onRatingChanged,
  }) : super(key: key);
  final void Function(int) onRatingChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Priority', style: Theme.of(context).textTheme.bodyText1),
        SizedBox(
          width: 10,
        ),
        RatingBar.builder(
          initialRating: 2,
          itemSize: 20,
          minRating: 1,
          direction: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
          onRatingUpdate: (rating) {
            onRatingChanged(rating.toInt());
          },
        ),
      ],
    );
  }
}

class UpdateKitchenElement extends StatefulWidget {
  const UpdateKitchenElement({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateKitchenElement> createState() => _UpdateKitchenElementState();
}

class _UpdateKitchenElementState extends State<UpdateKitchenElement> {
  DateTime _dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: BluredContainer(
                start: 0.3,
                end: 0.3,
                width: 400,
                height: 300,
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: Availibility(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: AppConstants.whiteOpacity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Expired Date',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            SelectDate(
                              onDateSelected: (DateTime f) {
                                setState(() {
                                  _dateTime = f;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 120,
                          child: TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: MThemeData.textButtonStyleCancel),
                        ),
                        Container(
                          width: 120,
                          child: TextButton(
                              child: Text(
                                'Save',
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              onPressed: () {},
                              style: MThemeData.textButtonStyleSave),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final availibilityProvider = StateProvider<double>((ref) {
  return 0;
});

class Availibility extends ConsumerWidget {
  Availibility({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    double x = ref.watch(availibilityProvider.state).state;
    return SizedBox(
      width: 35,
      height: 35,
      child: GestureDetector(
        onTap: () {
          if (x < 10) {
            ref.read(availibilityProvider.state).state++;
          } else {
            ref.read(availibilityProvider.state).state = 0;
          }
        },
        child: SfRadialGauge(
          // backgroundColor: Colors.white,
          axes: <RadialAxis>[
            RadialAxis(
              labelFormat: '$x',
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
                  value: x,
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

class PriorityWidget extends StatelessWidget {
  const PriorityWidget({Key? key, this.priority = 1}) : super(key: key);
  final int priority;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 10,
      child: getStars(priority),
    );
  }

  Widget getStars(int priority) {
    switch (priority) {
      case 1:
        return Row(
          children: [
            Icon(
              Icons.star_rate_rounded,
              color: Colors.yellow,
              size: 10,
            ),
            Icon(
              Icons.star_rate_rounded,
              color: Colors.yellow,
              size: 10,
            ),
            Icon(
              Icons.star_rate_rounded,
              color: Colors.yellow,
              size: 10,
            ),
          ],
        );
      case 2:
        return Row(
          children: [
            Icon(
              Icons.star_rate_rounded,
              color: Colors.yellow,
              size: 10,
            ),
            Icon(
              Icons.star_rate_rounded,
              color: Colors.yellow,
              size: 10,
            ),
            Icon(
              Icons.star_border_rounded,
              color: Colors.yellow,
              size: 10,
            ),
          ],
        );
      case 3:
        return Row(
          children: [
            Icon(
              Icons.star_border_rounded,
              color: Colors.yellow,
              size: 10,
            ),
            Icon(
              Icons.star_border_rounded,
              color: Colors.yellow,
              size: 10,
            ),
            Icon(
              Icons.star_border_rounded,
              color: Colors.yellow,
              size: 10,
            ),
          ],
        );
      default:
        return Row(
          children: [
            Icon(
              Icons.star_border_rounded,
              color: Colors.yellow,
              size: 10,
            ),
            Icon(
              Icons.star_border_rounded,
              color: Colors.yellow,
              size: 10,
            ),
            Icon(
              Icons.star_border_rounded,
              color: Colors.yellow,
              size: 10,
            ),
          ],
        );
    }
  }
}

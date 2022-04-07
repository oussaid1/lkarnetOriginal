import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lkarnet/providers/authproviders/database_providers.dart';
import 'package:lkarnet/screens/add/add_kitchen_item.dart';
<<<<<<< HEAD
<<<<<<< HEAD
import 'package:lkarnet/screens/add/add_kitechen_element.dart';
<<<<<<< HEAD

import '../../components.dart';
import '../../models/kitchen/kitchen_element_data.dart';
import '../../models/kitchen/kitchen_item.dart';
import '../../providers/operationsprovider/operations_provider.dart';
import '../../widgets/availability_widget.dart';
import '../../widgets/date_picker.dart';
import '../../widgets/dialogs.dart';
import '../../widgets/kitchen_item_listtile.dart';
import '../add/edit_kitchen_element.dart';
=======
=======
import 'package:lkarnet/screens/add/add_kitechen_element.dart';
>>>>>>> a71c130 (...)
import 'package:lkarnet/screens/kitchen_stock.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
=======
>>>>>>> 7cea0f9 (v 0.9.2)

import '../../components.dart';
import '../../models/kitchen/kitchen_item.dart';
import '../../widgets/availability_widget.dart';
import '../../widgets/dialogs.dart';
import '../../widgets/kitchen_item_listtile.dart';
<<<<<<< HEAD
>>>>>>> 336a080 (thanks Allah)

<<<<<<< HEAD
class KitchenElementDetailsScreen extends ConsumerStatefulWidget {
  const KitchenElementDetailsScreen({Key? key, required this.kitchenElement})
=======
class KitchenItemDetailsScreen extends ConsumerStatefulWidget {
  const KitchenItemDetailsScreen({Key? key, required this.kitchenElement})
>>>>>>> 55dc683 (kitchen element items crud)
=======
import '../add/edit_kitchen_element.dart';

class KitchenElementDetailsScreen extends ConsumerStatefulWidget {
  const KitchenElementDetailsScreen({Key? key, required this.kitchenElement})
>>>>>>> a71c130 (...)
      : super(key: key);
  final KitchenElement kitchenElement;
  @override
  ConsumerState<KitchenElementDetailsScreen> createState() =>
      _KitchenItemDetailsScreenState();
}

class _KitchenItemDetailsScreenState
    extends ConsumerState<KitchenElementDetailsScreen> {
  DateTime? _expiryDate = DateTime.now();

  bool _isLoading = true;
  bool _isExpired = false;
  // an empty list of kitchen items
  List<KitchenItem> _kitchenItems = [];

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
                  builder: (context) => AddKitchenItem(
                    kitchenElement: widget.kitchenElement,
                  ),
                ),
              );
            },
            child: Icon(Icons.add),
          ),
<<<<<<< HEAD
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
<<<<<<< HEAD
                      ref.read(availibilityProvider.state).state =
                          widget.kitchenElement.availability!;
                      ref.read(priorityRatingProvider.state).state =
                          widget.kitchenElement.priority!.toDouble();
                      Dialogs.botomPopUpDialog(
                        context,
<<<<<<< HEAD
<<<<<<< HEAD
                        AddKitchenElement(
=======
                        UpdateKitchenElement(
>>>>>>> 336a080 (thanks Allah)
=======
                        AddKitchenElement(
>>>>>>> a71c130 (...)
                          kitchenElement: widget.kitchenElement,
=======
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddKitchenElement(
                            kitchenElement: widget.kitchenElement,
                          ),
>>>>>>> 05f7265 (..)
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
<<<<<<< HEAD
<<<<<<< HEAD
              icon: Icon(Icons.arrow_back),
=======
              icon: Icon(Icons.arrow_back_ios),
>>>>>>> 55dc683 (kitchen element items crud)
=======
              icon: Icon(Icons.arrow_back),
>>>>>>> a71c130 (...)
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
=======
          appBar: _buildAppBar(context),
>>>>>>> 1b32af8 (hamdollillah)

          // Next, create a SliverList
          body: SingleChildScrollView(
            child: Column(
              children: [
<<<<<<< HEAD
<<<<<<< HEAD
                SizedBox(height: 20),
                _buildTopContainer(context),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Long press to set the expiration date ! if Item expired !',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                _buildBottomContainer(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BluredContainer _buildBottomContainer(BuildContext context) {
    return BluredContainer(
      margin: EdgeInsets.symmetric(horizontal: 8),
      // height: 340,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<List<KitchenItem>>(
          stream: ref.read(databaseProvider).kitchenItemsStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _kitchenItems = snapshot.data!;

              final SingleKitchenElementData _singleKitchenElementData =
                  SingleKitchenElementData(
                widget.kitchenElement,
                _kitchenItems,
              );
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _singleKitchenElementData.perfectKitchenElement.items
                    .length, //widget.kitchenElement.sortedItems.length,
                itemBuilder: (context, index) {
                  final KitchenItem _kitchenItem = _singleKitchenElementData
                      .perfectKitchenElement.items[index];
                  return GestureDetector(
                    onDoubleTap: () => KitchenItmExpiredButton(
                        kitchenItem: _kitchenItem,
                        op: ref.read(operationsProvider)),
                    child: KitchenItemTileWidget(
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: ExpiredSwitch(
                              onChanged: (value) {
                                setState(() {
                                  if (!value) {
                                    _expiryDate = null;
                                  } else {
                                    setState(() {
                                      _isExpired = true;
                                    });
                                  }
                                });
                              },
                            ),
                            //content:
                            actions: [
                              ElevatedButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              ElevatedButton(
                                child: Text('Ok'),
                                onPressed: _isLoading
                                    ? null
                                    : () {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        ref
                                            .read(operationsProvider)
                                            .updateKitchenItem(
                                                _kitchenItem.copyWith(
                                                    dateExpired: _expiryDate,
                                                    kitchenElementId:
                                                        _kitchenItem
                                                            .kitchenElementId));
                                        Navigator.of(context).pop();
                                      },
                              ),
                            ],
                          ),
                        );
                      },
                      kitchenItem: _kitchenItem,
                    ),
                  );
                },
              );
            } else
              return Center(child: Text('something went wrong'));
          }),
    );
  }

  BluredContainer _buildTopContainer(BuildContext context) {
    return BluredContainer(
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BluredContainer(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.kitchenElement.category}',
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
<<<<<<< HEAD
                const SizedBox(height: 30),
                BluredContainer(
=======
                const SizedBox(height: 20),
=======
                SizedBox(height: 20),
>>>>>>> 7cea0f9 (v 0.9.2)
                BluredContainer(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BluredContainer(
                        height: 45,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${widget.kitchenElement.category}',
                            style: Theme.of(context).textTheme.headline3,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: GestureDetector(
                              onTap: () {
                                Dialogs.botomPopUpDialog(
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
                                            color:
                                                Colors.white.withOpacity(0.3)),
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
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 12),
                                child: Text(
                                  widget.kitchenElement.title.toString(),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ),
<<<<<<< HEAD
                              PriorityWidget(
                                priority: widget.kitchenElement.priority!,
=======
                              PiorityRatingWidget(
                                ignoreGestures: true,
                                onRatingChanged: (rating) {},
                                initialRating: widget.kitchenElement.priority!,
>>>>>>> 7cea0f9 (v 0.9.2)
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
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
                const SizedBox(height: 30),
                BluredContainer(
>>>>>>> 55dc683 (kitchen element items crud)
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  // height: 340,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.kitchenElement.sortedItems.length,
                    itemBuilder: (context, index) {
                      final KitchenItem _kitchenItem =
                          widget.kitchenElement.sortedItems[index];
                      return GestureDetector(
                        onDoubleTap: () => KitchenItmExpiredButton(
                            kitchenItem: _kitchenItem,
                            op: ref.read(operationsProvider)),
                        child: KitchenItemTileWidget(
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Expired Date'),
                                content: SelectDate2(
                                  initialDate: DateTime.now(),
                                  onDateSelected: (date) {
                                    setState(() {
                                      _expiryDate = date;
                                    });
                                  },
                                ),
                                actions: [
                                  ElevatedButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ElevatedButton(
                                    child: Text('Ok'),
                                    onPressed: _isLoading
                                        ? null
                                        : () {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            ref
                                                .read(operationsProvider)
                                                .updateKitchenItem(
                                                    _kitchenItem.copyWith(
                                                        dateExpired:
                                                            _expiryDate,
                                                        kitchenElementId:
                                                            _kitchenItem
                                                                .kitchenElementId));
                                            Navigator.of(context).pop();
                                          },
                                  ),
                                ],
                              ),
                            );
                          },
                          kitchenItem: _kitchenItem,
                        ),
                      );
                    },
=======
                const SizedBox(width: 10),
                Hero(
                  tag: 'foodCategory',
                  child: Icon(
                    Icons.fastfood,
                    color: Colors.white.withOpacity(0.5),
                    size: 20,
>>>>>>> 1b32af8 (hamdollillah)
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProgressWidget(
                          kitchenElement: widget.kitchenElement,
                        ),
                        Text(
                          'Status: ',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Colors.white.withOpacity(0.3)),
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
                      padding: const EdgeInsets.only(left: 8.0, right: 12),
                      child: Text(
                        widget.kitchenElement.title.toString(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    PiorityRatingWidget(
                      ignoreGestures: true,
                      onRatingChanged: (rating) {},
                      initialRating: widget.kitchenElement.priority!,
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
                      .copyWith(color: Colors.white.withOpacity(0.3)),
                ),
                Text(
                  '${widget.kitchenElement.lastTimeBought}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(104, 36, 35, 35).withOpacity(0.6),
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
                      .copyWith(color: Colors.white.withOpacity(0.3)),
                ),
                Text(
                  '${widget.kitchenElement.timeExpired}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontFamily: 'Montserrat',
                        color: Color.fromARGB(104, 36, 35, 35).withOpacity(0.6),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
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
    );
  }
}

<<<<<<< HEAD
// final priorityRatingProvider = StateProvider<double>((ref) {
//   return 0;
// });
=======
final priorityRatingProvider = StateProvider<double>((ref) {
  return 0;
});
>>>>>>> a71c130 (...)

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
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 7cea0f9 (v 0.9.2)
          ignoreGestures: ignoreGestures,
          initialRating:
              initialRating, //ref.watch(priorityRatingProvider.state).state,
          itemSize: itemSize,
<<<<<<< HEAD
=======
          initialRating: ref.watch(priorityRatingProvider.state).state,
          itemSize: 20,
>>>>>>> a71c130 (...)
=======
>>>>>>> 7cea0f9 (v 0.9.2)
          minRating: 0,
          direction: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, _) =>
              Icon(Icons.star_border_purple500, color: Colors.amber),
          onRatingUpdate: (rating) {
<<<<<<< HEAD
            //  ref.watch(priorityRatingProvider.state).state = rating;
            onRatingChanged(rating);
=======
            ref.watch(priorityRatingProvider.state).state = rating;
            onRatingChanged(rating.toInt());
>>>>>>> a71c130 (...)
          },
        ),
      ],
    );
  }
}

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
// ignore: must_be_immutable
class Availibility extends StatelessWidget {
  Availibility({Key? key, required this.onChanged, this.value = 0})
      : super(key: key);
  final void Function(double) onChanged;
  double value = 0;
=======
class UpdateKitchenElement extends StatefulWidget {
=======
class UpdateKitchenElement extends ConsumerStatefulWidget {
>>>>>>> 336a080 (thanks Allah)
  const UpdateKitchenElement({
    Key? key,
    required this.kitchenElement,
  }) : super(key: key);
<<<<<<< HEAD

>>>>>>> 55dc683 (kitchen element items crud)
=======
  final KitchenElement kitchenElement;
>>>>>>> 336a080 (thanks Allah)
  @override
  ConsumerState<UpdateKitchenElement> createState() =>
      _UpdateKitchenElementState();
}

class _UpdateKitchenElementState extends ConsumerState<UpdateKitchenElement> {
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
=======
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
                      child: Availibility(
                        onChanged: (value) {
                          // setState(() {
                          //   // = value;
                          // });
                        },
                      ),
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
                                setState(() {});
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
                              onPressed: () {
                                final db = ref.read(databaseProvider);
                                final kitchenElement = KitchenElement(
                                  id: widget.kitchenElement.id,
                                  items: [],
                                  title: widget.kitchenElement.title,
                                  priority: 2, //priorityRating,
                                  availability: ref
                                      .watch(availibilityProvider.state)
                                      .state,
                                );
                                db.addKitchenElement(kitchenElement);
                              },
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

=======
>>>>>>> a71c130 (...)
final availibilityProvider = StateProvider<double>((ref) {
  return 0;
});

class Availibility extends ConsumerWidget {
  Availibility({Key? key, required this.onChanged}) : super(key: key);
  final void Function(double) onChanged;
  @override
  Widget build(BuildContext context, ref) {
    double x = ref.watch(availibilityProvider.state).state;
>>>>>>> 55dc683 (kitchen element items crud)
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
<<<<<<< HEAD
          onChanged(value);
=======
          onChanged(ref.read(availibilityProvider.state).state);
>>>>>>> 336a080 (thanks Allah)
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

<<<<<<< HEAD
<<<<<<< HEAD
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
=======
class PriorityWidget extends StatelessWidget {
  const PriorityWidget({Key? key, this.priority = 1, this.iconSize = 15})
      : super(key: key);
  final int priority;
  final double iconSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
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
              size: iconSize,
            ),
            Icon(
              Icons.star_rate_rounded,
              color: Colors.yellow,
              size: iconSize,
            ),
            Icon(
              Icons.star_rate_rounded,
              color: Colors.yellow,
              size: iconSize,
            ),
          ],
        );
      case 2:
        return Row(
          children: [
            Icon(
              Icons.star_rate_rounded,
              color: Colors.yellow,
              size: iconSize,
            ),
            Icon(
              Icons.star_rate_rounded,
              color: Colors.yellow,
              size: iconSize,
            ),
            Icon(
              Icons.star_border_rounded,
              color: Colors.yellow,
              size: iconSize,
            ),
          ],
        );
      case 3:
        return Row(
          children: [
            Icon(
              Icons.star_border_rounded,
              color: Colors.yellow,
              size: iconSize,
            ),
            Icon(
              Icons.star_border_rounded,
              color: Colors.yellow,
              size: iconSize,
            ),
            Icon(
              Icons.star_border_rounded,
              color: Colors.yellow,
              size: iconSize,
            ),
          ],
        );
      default:
        return Row(
          children: [
            Icon(
              Icons.star_border_rounded,
              color: Colors.yellow,
              size: iconSize,
            ),
            Icon(
              Icons.star_border_rounded,
              color: Colors.yellow,
              size: iconSize,
            ),
            Icon(
              Icons.star_border_rounded,
              color: Colors.yellow,
              size: iconSize,
            ),
          ],
        );
    }
  }
}
>>>>>>> a71c130 (...)
=======
class ExpiredSwitch extends StatefulWidget {
  const ExpiredSwitch({Key? key, required this.onChanged}) : super(key: key);
  final void Function(Map<String, dynamic>) onChanged;
  @override
  State<ExpiredSwitch> createState() => _ExpiredSwitchState();
}

class _ExpiredSwitchState extends State<ExpiredSwitch> {
  bool _isExpired = false;
  DateTime? _expiryDate;
  // bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Expired ?'),
            Switch(
              onChanged: (value) {
                setState(() {
                  if (value) {
                    _isExpired = true;
                    widget.onChanged(
                        {'isExpired': _isExpired, 'expiryDate': _expiryDate});
                  } else {
                    _isExpired = false;
                    widget.onChanged(
                        {'isExpired': _isExpired, 'expiryDate': _expiryDate});
                  }
                  //_isExpired = !value;
                });
              },
              value: _isExpired,
            ),
          ],
        ),
        _isExpired
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Date'),
                  SelectDate2(
                    initialDate: DateTime.now(),
                    onDateSelected: (date) {
                      setState(() {
                        _expiryDate = date;
                        //  _isLoading = false;
                      });
                    },
                  )
                ],
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
>>>>>>> 1b32af8 (hamdollillah)

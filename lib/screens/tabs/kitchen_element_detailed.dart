import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lkarnet/providers/authproviders/database_providers.dart';
import 'package:lkarnet/screens/add/add_kitchen_item.dart';
import 'package:lkarnet/screens/add/add_kitechen_element.dart';

import '../../components.dart';
import '../../models/kitchen/kitchen_element_data.dart';
import '../../models/kitchen/kitchen_item.dart';
import '../../providers/operationsprovider/operations_provider.dart';
import '../../widgets/availability_widget.dart';
import '../../widgets/date_picker.dart';
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
          appBar: _buildAppBar(context),

          // Next, create a SliverList
          body: SingleChildScrollView(
            child: Column(
              children: [
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
                const SizedBox(width: 10),
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

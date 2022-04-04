import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lkarnet/providers/authproviders/database_providers.dart';
import 'package:lkarnet/providers/operationsprovider/operations_provider.dart';
import 'package:lkarnet/screens/add/add_kitchen_item.dart';
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> af91a79 (thanks Allah)
import 'package:lkarnet/screens/add/add_kitechen_element.dart';
<<<<<<< HEAD
=======
=======
import 'package:lkarnet/screens/add/add_kitechen_element.dart';
>>>>>>> e2feaab (v 0.9.8)
import 'package:lkarnet/widgets/myappbar.dart';
<<<<<<< HEAD
>>>>>>> 0b1b10e (v 0.9.4)
=======
=======
import 'package:lkarnet/screens/kitchen_stock.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'package:lkarnet/widgets/date_picker.dart';
>>>>>>> b369bdf (thanks Allah)
>>>>>>> af91a79 (thanks Allah)

import '../../components.dart';
import '../../models/kitchen/kitchen_element_data.dart';
import '../../models/kitchen/kitchen_item.dart';
<<<<<<< HEAD
import '../../widgets/availability_widget.dart';
import '../../widgets/expired_switch.dart';
=======
import '../../providers/authproviders/database_providers.dart';
import '../../settings/theme.dart';
import '../../widgets/dialogs.dart';
>>>>>>> b369bdf (thanks Allah)
import '../../widgets/kitchen_item_listtile.dart';
<<<<<<< HEAD
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
=======
>>>>>>> e2feaab (v 0.9.8)

<<<<<<< HEAD
class KitchenElementDetailsScreen extends ConsumerStatefulWidget {
  const KitchenElementDetailsScreen({Key? key, required this.kitchenElement})
<<<<<<< HEAD
>>>>>>> a71c130 (...)
=======
=======
class KitchenItemDetailsScreen extends ConsumerStatefulWidget {
  const KitchenItemDetailsScreen({Key? key, required this.kitchenElement})
>>>>>>> b001677 (kitchen element items crud)
>>>>>>> 1a88e7a (kitchen element items crud)
      : super(key: key);
  final KitchenElement kitchenElement;
  @override
  ConsumerState<KitchenElementDetailsScreen> createState() =>
      _KitchenItemDetailsScreenState();
}

class _KitchenItemDetailsScreenState
    extends ConsumerState<KitchenElementDetailsScreen> {
  DateTime? _expiryDate = DateTime.now();

  //bool _isLoading = true;
  //bool _isExpired = false;
  // an empty list of kitchen items
  List<KitchenItem> _kitchenItems = [];

  double _availability = 0;
  @override
  void initState() {
    _availability = widget.kitchenElement.availability!;
    //_isLoading = true;
    super.initState();
  }

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
        gradientColors: AppConstants.myGradients,
        centerWidget: Scaffold(
          backgroundColor: Colors.transparent,

          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            heroTag: 'kitchen_element_details_screen',
            onPressed: () {
              Navigator.push(
                context,
<<<<<<< HEAD
                MaterialPageRoute(
                  builder: (context) => AddKitchenItem(
                    kitchenElement: widget.kitchenElement,
                  ),
=======
                AddKitchenItem(
                  kitchenElement: widget.kitchenElement,
>>>>>>> b001677 (kitchen element items crud)
                ),
              );
            },
            child: Icon(Icons.add),
          ),
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
=======
>>>>>>> 1a88e7a (kitchen element items crud)
          appBar: MyAppBar(
            title: Text('${widget.kitchenElement.title}'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
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
=======
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
                        UpdateKitchenElement(
                          kitchenElement: widget.kitchenElement,
                        ),
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
>>>>>>> b001677 (kitchen element items crud)
          ),
>>>>>>> 0b1b10e (v 0.9.4)

          // Next, create a SliverList
          body: SingleChildScrollView(
            child: Column(
              children: [
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 1a88e7a (kitchen element items crud)
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
=======
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
>>>>>>> b001677 (kitchen element items crud)
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
                  return KitchenItemTileWidget(
                    onDoubleTap: () {
                      setState(() {
                        _expiryDate = null;
                      });
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: ExpiredSwitch(
                            onChanged: (value) {
                              setState(() {
                                if (value['isExpired']) {
                                  setState(() {
                                    //  _isLoading = false;
                                    _expiryDate = value['expiryDate'];
                                  });
                                } else {
                                  setState(() {
                                    _expiryDate = null;
                                    //_isLoading = false;
                                  });
                                }
                              });
                            },
                          ),
                          //content:
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),

                                //const Spacer(),
                                ElevatedButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    // setState(() {
                                    //   _isLoading = true;
                                    // });
                                    // _kitchenItem.toPrint();
                                    ref
                                        .read(databaseProvider)
                                        .updateKitchenItem(
                                            _kitchenItem.copyWith(
                                                dateExpired: _expiryDate,
                                                kitchenElementId: _kitchenItem
                                                    .kitchenElementId));
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    kitchenItem: _kitchenItem,
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
            height: 65,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: GestureDetector(
                      onTap: () {
                        // Dialogs.botomUpDialog(
                        //   context,
                        //   UpdateKitchenElement(
                        //     kitchenElement: widget.kitchenElement,
                        //   ),
                        // );
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (mctx) => Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0)),
                                child: Stack(
                                  overflow: Overflow.visible,
                                  fit: StackFit.passthrough,
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Container(
                                      height: 130,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 70, 10, 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            MaterialButton(
                                              onPressed: () {
                                                final db = ref
                                                    .read(operationsProvider);

                                                db.updateKitchenElement(widget
                                                    .kitchenElement
                                                    .copyWith(
                                                        availability:
                                                            _availability));

                                                Navigator.of(context).pop();
                                              },
                                              color: Colors.redAccent,
                                              child: Text(
                                                'Save',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            // const SizedBox(width: 10),
                                            MaterialButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              color: Colors.redAccent,
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        top: -60,
                                        child: CircleAvatar(
                                          backgroundColor:
                                              AppConstants.primaryColor,

                                          ///Color.fromARGB(255, 55, 152, 216),
                                          radius: 60,
                                          child: Availibility(
                                            radius: 120,
                                            initialValue: widget
                                                .kitchenElement.availability!,
                                            onChanged: (value) {
                                              setState(() {
                                                _availability = value;
                                              });
                                            },
                                          ),
                                        )),
                                  ],
                                )));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ProgressWidget(
                                kitchenElement: widget.kitchenElement,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Status: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: Colors.white.withOpacity(0.3)),
                              ),
                              Text(
                                'tap here to change status ... ! ',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
<<<<<<< HEAD
                Hero(
                  tag: 'foodCategory',
                  child: Icon(
                    Icons.fastfood,
                    color: Colors.white.withOpacity(0.5),
                    size: 20,
>>>>>>> 1b32af8 (hamdollillah)
                  ),
=======
                Icon(
                  Icons.fastfood,
                  color: Colors.white.withOpacity(0.5),
                  size: 20,
>>>>>>> 0b1b10e (v 0.9.4)
                ),
              ],
            ),
          ),

          ///  SizedBox(height: 10),
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
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 1a88e7a (kitchen element items crud)
=======
>>>>>>> af91a79 (thanks Allah)
// ignore: must_be_immutable
class Availibility extends StatefulWidget {
  Availibility(
      {Key? key,
      required this.onChanged,
      this.initialValue = 0,
      this.radius = 35})
      : super(key: key);
  final void Function(double) onChanged;
<<<<<<< HEAD
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
=======
  final double radius;

  double initialValue = 0;

  @override
  State<Availibility> createState() => _AvailibilityState();
=======
class UpdateKitchenElement extends StatefulWidget {
=======
class UpdateKitchenElement extends ConsumerStatefulWidget {
>>>>>>> b369bdf (thanks Allah)
  const UpdateKitchenElement({
    Key? key,
    required this.kitchenElement,
  }) : super(key: key);
  final KitchenElement kitchenElement;
  @override
  ConsumerState<UpdateKitchenElement> createState() =>
      _UpdateKitchenElementState();
}

class _UpdateKitchenElementState extends ConsumerState<UpdateKitchenElement> {
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
>>>>>>> b001677 (kitchen element items crud)
}

<<<<<<< HEAD
class _AvailibilityState extends State<Availibility> {
<<<<<<< HEAD
>>>>>>> e2feaab (v 0.9.8)
=======
=======
final availibilityProvider = StateProvider<double>((ref) {
  return 0;
});

class Availibility extends ConsumerWidget {
  Availibility({Key? key, required this.onChanged}) : super(key: key);
  final void Function(double) onChanged;
>>>>>>> b369bdf (thanks Allah)
>>>>>>> af91a79 (thanks Allah)
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
      width: widget.radius,
      height: widget.radius,
      child: GestureDetector(
        onTap: () {
          if (widget.initialValue < 10) {
            setState(() {
              widget.initialValue++;
            });
          } else {
            setState(() {
              widget.initialValue = 0;
            });
          }
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
          onChanged(value);
=======
          onChanged(ref.read(availibilityProvider.state).state);
>>>>>>> 336a080 (thanks Allah)
=======
          widget.onChanged(widget.initialValue);
>>>>>>> e2feaab (v 0.9.8)
=======
          widget.onChanged(widget.initialValue);
=======
          onChanged(ref.read(availibilityProvider.state).state);
>>>>>>> b369bdf (thanks Allah)
>>>>>>> af91a79 (thanks Allah)
        },
        child: SfRadialGauge(
          // backgroundColor: Colors.white,

          axes: <RadialAxis>[
            RadialAxis(
              labelFormat: '${widget.initialValue}',
              maximumLabels: 0,
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
                  color: Color.fromARGB(160, 255, 151, 15),
                  value: widget.initialValue,
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
=======
>>>>>>> 0b1b10e (v 0.9.4)

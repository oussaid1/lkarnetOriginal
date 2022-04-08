import 'package:flutter/material.dart';
<<<<<<< HEAD
<<<<<<< HEAD
=======

import 'package:lkarnet/widgets/date_picker.dart';

>>>>>>> a71c130 (...)
=======
>>>>>>> 7cea0f9 (v 0.9.2)
import '../../components.dart';
import '../tabs/kitchen_element_detailed.dart';

class UpdateKitchenElement extends ConsumerStatefulWidget {
  const UpdateKitchenElement(
      {Key? key,
      required this.onUpdate,
      this.radius = 35,
      this.initialValue = 0})
      : super(key: key);
  final Function(double) onUpdate;
  final double radius;
  final double initialValue;
  @override
  ConsumerState<UpdateKitchenElement> createState() =>
      _UpdateKitchenElementState();
}

class _UpdateKitchenElementState extends ConsumerState<UpdateKitchenElement> {
<<<<<<< HEAD
  double _availability = 1;
  @override
  void initState() {
    super.initState();
  }

=======
>>>>>>> a71c130 (...)
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
<<<<<<< HEAD
                        value: _availability,
                        onChanged: (value) {
                          setState(() {
                            _availability = value;
                          });
=======
                        onChanged: (value) {
                          // setState(() {
                          //   // = value;
                          // });
>>>>>>> a71c130 (...)
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 7cea0f9 (v 0.9.2)
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Container(
                    //     color: AppConstants.whiteOpacity,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: Text(
                    //             'Expired Date',
                    //             style: Theme.of(context).textTheme.bodyText1,
                    //           ),
                    //         ),
                    //         SelectDate(
                    //           onDateSelected: (DateTime f) {
                    //             setState(() {
                    //               _date = f;
                    //             });
                    //           },
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
<<<<<<< HEAD
=======
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
>>>>>>> a71c130 (...)
=======
>>>>>>> 7cea0f9 (v 0.9.2)
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 120,
                          child: ElevatedButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: MThemeData.raisedButtonStyleCancel),
                        ),
                        Container(
                          width: 120,
                          child: ElevatedButton(
                              child: Text(
                                'Save',
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Saving...'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                                final db = ref.read(databaseProvider);
                                final kitchenElement = KitchenElement(
                                  id: widget.kitchenElement.id,
                                  items: [],
                                  title: widget.kitchenElement.title,
<<<<<<< HEAD
                                  priority: widget.kitchenElement
                                      .priority, //priorityRating,
                                  availability: _availability,
                                  category: widget.kitchenElement.category,
                                );
                                db.updateKitchenElement(kitchenElement);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Saved'),
                                      duration: Duration(seconds: 1),
                                      backgroundColor:
                                          AppConstants.greenOpacity),
                                );
<<<<<<< HEAD
=======
                                  priority: 2, //priorityRating,
                                  availability: ref
                                      .watch(availibilityProvider.state)
                                      .state,
                                );
                                db.updateKitchenElement(kitchenElement);
>>>>>>> a71c130 (...)
=======
                                Navigator.of(context).pop();
>>>>>>> 961f4d7 (struggling with item to kitchenItem)
                              },
                              style: MThemeData.raisedButtonStyleSave),
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
=======
    return Availibility(
      initialValue: widget.initialValue,
      radius: widget.radius,
      // value: _availability,
      onChanged: (value) {
        setState(() {
          _availability = value;
        });

        widget.onUpdate(_availability);
      },
>>>>>>> e2feaab (v 0.9.8)
    );
  }
}

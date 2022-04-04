import 'package:flutter/material.dart';
<<<<<<< HEAD
=======

import 'package:lkarnet/widgets/date_picker.dart';

>>>>>>> a71c130 (...)
import '../../components.dart';
import '../../models/kitchen/kitchen_item.dart';
import '../../providers/authproviders/database_providers.dart';
import '../../settings/theme.dart';
import '../tabs/kitchen_element_detailed.dart';

class UpdateKitchenElement extends ConsumerStatefulWidget {
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
<<<<<<< HEAD
  double _availability = 1;
//  double _priorityRating = 1;
//  DateTime _date = DateTime.now();
  @override
  void initState() {
    if (widget.kitchenElement.availability != null) {
      setState(() {
        _availability = widget.kitchenElement.availability!;
      });
    }
    super.initState();
  }

=======
>>>>>>> a71c130 (...)
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
<<<<<<< HEAD
                                  priority: widget.kitchenElement
                                      .priority, //priorityRating,
                                  availability: _availability,
                                  category: widget.kitchenElement.category,
                                );
                                db.updateKitchenElement(kitchenElement);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Saving...'),
                                  ),
                                );
=======
                                  priority: 2, //priorityRating,
                                  availability: ref
                                      .watch(availibilityProvider.state)
                                      .state,
                                );
                                db.updateKitchenElement(kitchenElement);
>>>>>>> a71c130 (...)
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

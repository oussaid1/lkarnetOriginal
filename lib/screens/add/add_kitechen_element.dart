import 'package:lkarnet/providers/authproviders/database_providers.dart';
import 'package:lkarnet/settings/theme.dart';
import 'package:flutter/material.dart';

import '../../components.dart';
import '../../models/kitchen/kitchen_item.dart';
import '../tabs/kitchen_element_detailed.dart';

class AddKitchenElement extends ConsumerStatefulWidget {
  final KitchenElement? kitchenElement;

  AddKitchenElement({this.kitchenElement});

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends ConsumerState<AddKitchenElement> {
  final GlobalKey<FormState> _formKeyName = GlobalKey<FormState>();
  final TextEditingController _itemNameController = TextEditingController();

  void clear() {
    _itemNameController.clear();
  }

  void _update() {
    if (widget.kitchenElement != null) {
      setState(() {
        _itemNameController.text = widget.kitchenElement!.title.toString();
      });
    }
  }

  @override
  void initState() {
    _update();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int priorityRating = 1;

  @override
  Widget build(BuildContext context) {
    // final logger = Logger();
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: SizedBox(
          height: 380,
          //width: 200,
          child: BluredContainer(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 8),
                  child: Text(
                    'Add Kitchen Element',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 4.0, top: 10, left: 8, right: 8),
                  child: Form(
                    key: _formKeyName,
                    child: TextField(
                      onChanged: (value) {
                        _itemNameController.text = value;
                      },
                      controller: _itemNameController,
                      style: Theme.of(context).textTheme.headline6,
                      decoration: InputDecoration(
                        suffix: IconButton(
                          icon: Icon(
                            Icons.clear_outlined,
                            size: 18,
                          ),
                          onPressed: () {
                            _itemNameController.clear();
                          },
                        ),
                        hintText: 'element name',
                        hintStyle:
                            Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: Colors.grey,
                                ),

                        fillColor: AppConstants.whiteOpacity,
                        filled: true,
                        // labelText: 'Name',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Availability',
                          style: Theme.of(context).textTheme.bodyText1),
                      Availibility(
                        onChanged: (value) {
                          // setState(() {
                          //   // = value;
                          // });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                  child: Padding(
                    padding: EdgeInsets.only(top: 18.0, bottom: 18),
                    child: Divider(
                      height: 3,
                      indent: 12,
                      color: Colors.amber,
                      endIndent: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PiorityRatingWidget(
                    onRatingChanged: (int pri) {
                      priorityRating = pri;
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                widget.kitchenElement == null
                    ? Row(
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
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Saving...'),
                                  ));
                                  final db = ref.read(databaseProvider);
                                  final kitchenElement = KitchenElement(
                                    items: [],
                                    title: _itemNameController.text.trim(),
                                    priority: ref
                                        .read(priorityRatingProvider.state)
                                        .state
                                        .toInt(),
                                    availability: ref
                                        .read(availibilityProvider.state)
                                        .state,
                                    id: widget.kitchenElement?.id,
                                    category: widget.kitchenElement?.category,
                                  );
                                  db.addKitchenElement(kitchenElement);
                                },
                                style: MThemeData.textButtonStyleSave),
                          ),
                        ],
                      )
                    : Row(
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
                                  'Update',
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                onPressed: () {
                                  //   ScaffoldMessenger.of(context)
                                  //       .showSnackBar(SnackBar(
                                  //     content: Text('Updating...'),
                                  //   ));
                                },
                                style: MThemeData.textButtonStyleSave),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

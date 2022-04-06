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
  final GlobalKey<FormState> _formKeyTitle = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyCat = GlobalKey<FormState>();
  final TextEditingController _elementCategoryController =
      TextEditingController();
  final TextEditingController _itemNameController = TextEditingController();
  bool _isLoading = false;
  void clear() {
    _elementCategoryController.clear();
    _itemNameController.clear();
  }

  void _update() {
    if (widget.kitchenElement != null) {
      _itemNameController.text = widget.kitchenElement!.title.toString();
      _elementCategoryController.text =
          widget.kitchenElement!.category.toString();
      _availability = widget.kitchenElement!.availability!;
      _priorityRating = widget.kitchenElement!.priority!;
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

  List<KitchenElement> _kitchenElements = [];
  double _priorityRating = 1;
  double _availability = 1;

  @override
  Widget build(BuildContext context) {
    // final logger = Logger();
    return GlassMaterial(
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
          appBar: AppBar(
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
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              widget.kitchenElement != null ? "تعديل المادة" : "اضافة مادة",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              height: 500,
              //width: 200,
              child: BluredContainer(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildTitle(context),
                    _buildKitchenItemName(),
                    _buildElementName(context),
                    const SizedBox(height: 10),
                    _buildPriority(context),
                    const SizedBox(height: 10),
                    _buildDivider(),
                    const SizedBox(height: 15),
                    _buildAvailability(context),
                    SizedBox(height: 40),
                    widget.kitchenElement == null
                        ? _buildSave(context)
                        : _buildUpdate(context),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Padding _buildTitle(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 20, bottom: 8),
        child: Text('Add Kitchen Element',
            style: Theme.of(context).textTheme.headline3));
  }

  Padding _buildDivider() {
    return Padding(
      padding: EdgeInsets.only(top: 18.0, bottom: 18),
      child: Divider(
        height: 3,
        indent: 12,
        color: Colors.amber,
        endIndent: 12,
      ),
    );
  }

  Row _buildUpdate(BuildContext context) {
    return Row(
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
                'Update',
                style: Theme.of(context).textTheme.headline3,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Updating...'),
                ));

                final db = ref.read(databaseProvider);
                final kitchenElement = KitchenElement(
                  items: [],
                  title: _itemNameController.text.trim(),
                  priority: _priorityRating,
                  availability: _availability,
                  id: widget.kitchenElement!.id,
                  category: _elementCategoryController.text.trim(),
                );
                if (_formKeyTitle.currentState!.validate() &&
                    _formKeyCat.currentState!.validate()) {
                  setState(() {
                    _isLoading = true;
                  });
                  db.updateKitchenElement(kitchenElement);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: AppConstants.greenOpacity,
                    content: Text('Updated'),
                  ));
                }
              },
              style: MThemeData.raisedButtonStyleSave),
        ),
      ],
    );
  }

  Row _buildSave(BuildContext context) {
    return Row(
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
              onPressed: _isLoading
                  ? null
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text('Saving...'),
                      ));
                      final db = ref.read(databaseProvider);
                      final kitchenElement = KitchenElement(
                        items: [],
                        title: _itemNameController.text.trim(),
                        priority: _priorityRating,
                        availability: _availability,
                        category: _elementCategoryController.text.trim(),
                      );
                      if (_formKeyTitle.currentState!.validate() &&
                          _formKeyCat.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        db.addKitchenElement(kitchenElement);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: AppConstants.greenOpacity,
                          content: Text('Saved'),
                        ));
                        Navigator.of(context).pop();
                      }
                      ;
                    },
              style: MThemeData.raisedButtonStyleSave),
        ),
      ],
    );
  }

  Padding _buildAvailability(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Availability', style: Theme.of(context).textTheme.bodyText1),
          Availibility(
            value: _availability,
            onChanged: (value) {
              setState(() {
                _availability = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Padding _buildPriority(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Text('Priority', style: Theme.of(context).textTheme.bodyText1),
          ),
          PiorityRatingWidget(
            initialRating: _priorityRating,
            onRatingChanged: (double rating) {
              setState(() {
                _priorityRating = rating;
              });
            },
          ),
        ],
      ),
    );
  }

  Padding _buildElementName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        height: 50,
        child: Form(
          key: _formKeyTitle,
          child: TextField(
            textAlign: TextAlign.center,
            controller: _itemNameController,
            style: Theme.of(context).textTheme.headline6,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.shopping_basket_outlined,
                color: Color.fromARGB(117, 212, 211, 211),
              ),
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
              hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.grey,
                  ),

              fillColor: AppConstants.whiteOpacity,
              filled: true,
              contentPadding: EdgeInsets.only(top: 4, right: 4, left: 4),
              // labelText: 'Name',
            ),
          ),
        ),
      ),
    );
  }

  StreamBuilder<List<KitchenElement>> _buildKitchenItemName() {
    return StreamBuilder<List<KitchenElement>>(
        stream: ref.read(databaseProvider).kitchenElementsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _kitchenElements = snapshot.data!;
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKeyCat,
              child: SizedBox(
                height: 50,
                child: TypeAheadField<KitchenElement>(
                  noItemsFoundBuilder: (context) => Text('No Items Found'),
                  autoFlipDirection: true,
                  minCharsForSuggestions: 2,
                  direction: AxisDirection.up,
                  hideSuggestionsOnKeyboardHide: true,
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _elementCategoryController,
                    autofocus: true,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(top: 4, right: 4, left: 4),
                      fillColor: AppConstants.whiteOpacity,
                      filled: true,
                      hintText: 'title',
                      //alignLabelWithHint: true,

                      prefixIcon: Icon(
                        Icons.category,
                        color: Color.fromARGB(117, 212, 211, 211),
                      ),
                      suffix: IconButton(
                        icon: Icon(
                          Icons.clear_outlined,
                          size: 18,
                        ),
                        onPressed: () {
                          setState(() {
                            _elementCategoryController.clear();
                          });
                        },
                      ),
                      // border: OutlineInputBorder(),
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    return _kitchenElements
                        .where((item) => item.title
                            .toLowerCase()
                            .startsWith(pattern.toLowerCase()))
                        .toList(growable: true);
                  },
                  itemBuilder: (context, suggestion) {
                    return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppConstants.whiteOpacity,
                        ),
                        height: 40,
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            suggestion.title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ));
                  },
                  onSuggestionSelected: (suggestion) {
                    _elementCategoryController.text = suggestion.title;
                  },
                ),
              ),
            ),
          );
        });
  }
}

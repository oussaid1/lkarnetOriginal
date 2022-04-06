import 'package:lkarnet/components.dart';
import 'package:lkarnet/models/item/item.dart';

import 'package:flutter/material.dart';
import 'package:lkarnet/screens/add/add_kitchen_item.dart';

class AddScreen extends StatefulWidget {
  final Item? item;
  AddScreen({
    Key? key,
    this.item,
  }) : super(key: key);
  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
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
      centerWidget: AddKitchenItem(
        item: widget.item,
      ),
    );
  }
}

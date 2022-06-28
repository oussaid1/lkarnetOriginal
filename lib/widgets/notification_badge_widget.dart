import 'package:flutter/material.dart';

import '../components.dart';
import '../models/kitchen/kitchen_element.dart';
import '../models/kitchen/kitchen_element_data.dart';
import '../models/kitchen/kitchen_item.dart';
import '../providers/authproviders/database_providers.dart';
import '../screens/lists/unavailiable_elements.dart';

class NotificationsIconButton extends StatefulWidget {
  const NotificationsIconButton({Key? key, required this.ref})
      : super(key: key);
  final WidgetRef ref;
  @override
  State<NotificationsIconButton> createState() =>
      _NotificationsIconBottonutate();
}

class _NotificationsIconBottonutate extends State<NotificationsIconButton> {
  //  late AnimationController _animationController;
  late List<KitchenElementModel> _kitchenElements;
  late List<KitchenItemModel> _kitchenItems;
  late KitchenElementsData _kitchenElementsData;
  @override
  void initState() {
    _kitchenElements = [];
    _kitchenItems = [];
    // _animationController = AnimationController(
    //   vsync: this,
    //   duration: Duration(milliseconds: 500),
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<KitchenItemModel>>(
        stream: widget.ref.read(databaseProvider).kitchenItemsStream(),
        builder: (context, snapshotItems) {
          if (snapshotItems.hasData) {
            _kitchenItems = snapshotItems.data!;
          }
          return StreamBuilder<List<KitchenElementModel>>(
              stream: widget.ref.read(databaseProvider).kitchenElementsStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _kitchenElements = snapshot.data!;
                  _kitchenElementsData = KitchenElementsData(
                    kitchenElementList: _kitchenElements,
                    kitchenItems: _kitchenItems,
                  );
                  // _kitchenElementData = _kitchenElements
                  //     .map((element) => KitchenElementDataModel(
                  //           kitchenElement: element,
                  //           kitchenItemList: _kitchenItems
                  //               .where((item) =>
                  //                   item.kitchenElementId == element.id)
                  //               .toList(),
                  //         ))
                  //     .toList();
                }
                return NotificationBadgeWidget(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UnAvailiableElements(
                              elementData:
                                  _kitchenElementsData.unavaliableElements),
                        ),
                      );
                    },
                    count: KitchenElementsData(
                      kitchenElementList: _kitchenElements,
                      kitchenItems: _kitchenItems,
                    ).unavaliableElements.length);
              });
        });
  }
}

class NotificationBadgeWidget extends StatelessWidget {
  const NotificationBadgeWidget({
    Key? key,
    this.onTap,
    required this.count,
  }) : super(key: key);
  final VoidCallback? onTap;
  final int count;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Stack(
        fit: StackFit.expand,
        children: [
          count != 0
              ? Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 235, 93, 83),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        '$count',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          IconButton(
            icon: Icon(Icons.notifications_active,
                color: Color.fromARGB(193, 233, 233, 233)),
            onPressed: onTap!,
          ),
        ],
      ),
    );
  }
}

//  Badge(
//       stackFit: StackFit.loose,
//       position: BadgePosition.topEnd(top: 0, end: 0),
//       animationType: BadgeAnimationType.scale,
//       animationDuration: Duration(milliseconds: 300),
//       badgeContent: Text(
//         '$count',
//         style: TextStyle(color: Colors.white),
//       ),
//       badgeColor: Colors.red,
//       child: IconButton(
//         icon: Icon(Icons.notifications_active,
//             color: Color.fromARGB(193, 233, 233, 233)),
//         onPressed: onTap!,
//       ),
//     );
//   }
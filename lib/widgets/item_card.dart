import 'package:flutter/material.dart';
import 'package:lkarnet/models/item/item.dart';

class ItemCard extends StatelessWidget {
  ItemCard({
    Key? key,
    required this.item,
  }) : super(key: key);
  final Item item;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 4, right: 4),
        leading: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(999.0),
            boxShadow: [],
          ),
          height: 45,
          width: 45,
          child: Icon(Icons.shopping_bag_rounded),
        ),
        title: Text(
          item.itemName,
        ),
        trailing: Text(
          '\$ ${item.itemPrix}',
        ),
        subtitle: Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                item.quantity.toString(),
              ),
              Text(
                ' ${item.shopName.toString()}',
              ),
              Text(
                item.formattedDate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

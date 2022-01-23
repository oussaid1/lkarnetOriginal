import 'package:flutter/material.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/settings/theme.dart';
import 'package:lkarnet/widgets/item_card.dart';

class ItemsListSearch extends SearchDelegate {
  ItemsListSearch({
    Key? key,
    required this.listOfItems,
  });

  List<Item> listOfItems = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      Container(
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                query = '';
              },
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
//find the elements that starts with the same query letters.
// allNames is a list that contains all your data ( you can replace it here by an http request or a query from your database )
    return Center(child: Text(query.toString()));
  }

  @override
  Widget buildSuggestions(
    BuildContext context,
  ) {
    var _searchResult = listOfItems
        .where((element) => element.itemName.startsWith(query))
        .toList();
    // switch (listOfItems.length) {
    //   case 0:
    //     searchResult = listOfItems
    //         .where((element) =>
    //             element.dateBought.month.toString().startsWith(query))
    //         .toList();
    //     break;
    //   case 1:
    //     searchResult = listOfItems
    //         .where((element) => element.itemName!.startsWith(query))
    //         .toList();
    //     break;
    //   case 2:
    //     searchResult = listOfItems
    //         .where((element) => element.shopName!.startsWith(query))
    //         .toList();
    //     break;
    //   case 3:
    //     searchResult = listOfItems
    //         .where((element) =>
    //             element.dateBought.day.toString().startsWith(query))
    //         .toList();
    //     break;
    //   default:
    //     searchResult = listOfItems;
    // }

    return Container(
        color: MThemeData.primaryColor,
        child: ListView.builder(
            itemCount: _searchResult.length,
            itemBuilder: (BuildContext context, int index) {
              Item item = _searchResult[index];
              return ItemCard(
                item: item,
              );
            }));
  }
}

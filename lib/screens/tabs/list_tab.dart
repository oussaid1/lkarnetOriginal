import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/models/search/search_delegate.dart';
import 'package:lkarnet/providers/streamproviders/items_stream_provider.dart';
import 'package:lkarnet/screens/lists/items.dart';
import 'package:lkarnet/screens/lists/payments.dart';
import 'package:lkarnet/screens/lists/shops.dart';

class ListTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Container(),
          leadingWidth: 10,
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () => showSearch(
                    context: context,
                    delegate: ItemsListSearch(
                        listOfItems: ref.watch(itemsProvider.state).state))),
          ],
          bottom: TabBar(
            unselectedLabelColor: Theme.of(context).dividerColor,
            tabs: [
              Tab(text: 'Items'),
              Tab(text: 'shops'),
              //Tab(text: 'categories'),
              Tab(text: 'payments'),
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            ItemsList(),
            ShopsList(),
            PaymentsList(),
          ],
        ),
      ),
    );
  }
}

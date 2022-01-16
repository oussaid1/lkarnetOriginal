import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/models/shop/shops_data.dart';
import 'package:lkarnet/settings/theme.dart';

class MothlyList extends ConsumerWidget {
  const MothlyList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    var shopsDataList;
    return ListView.builder(
        itemCount: shopsDataList.length,
        itemBuilder: (context, index) {
          ShopsData shopsData = shopsDataList[index];
          return Container(
            height: 150,
            width: 400,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8, left: 4, right: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            shopsData.shop.shopName.toString(),
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          Text(
                            '',
                            //style: AkThemeData.darkThemeData.textTheme.headline4,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total-number of items',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              SizedBox(
                                width: 60,
                              ),
                              Text(
                                '',
                                style: MThemeData
                                    .darkThemeData.textTheme.subtitle2,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total-sum',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              SizedBox(
                                width: 60,
                              ),
                              Text(
                                '',
                                style: MThemeData
                                    .darkThemeData.textTheme.subtitle2,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total-payments',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              SizedBox(
                                width: 60,
                              ),
                              Text(
                                '',
                                style: MThemeData
                                    .darkThemeData.textTheme.subtitle2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

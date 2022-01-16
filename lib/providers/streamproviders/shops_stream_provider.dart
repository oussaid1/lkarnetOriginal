import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/models/shop/shop_model.dart';
import 'package:lkarnet/providers/authproviders/database_providers.dart';

final shopsStream = StreamProvider<List<ShopModel>>((ref) {
  final _db = ref.watch(databaseProvider);
  return _db.shopsStream();
});

final shopsProvider = StateProvider<List<ShopModel>>((ref) {
  final _stream = ref.watch(shopsStream);
  /*final _distinctItemshops = ref.watch(itemDistinctsProvider);
  for (var item in _distinctItemshops.state.distinctItemShops) {
    shops.add(ShopModel(shopName: item));
  }*/
  return _stream.maybeWhen(
      data: (items) => items.toSet().toList(), orElse: () => []);
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/models/kitchen/kitchen_item.dart';
import 'package:lkarnet/providers/authproviders/database_providers.dart';

final kitchenElementsStream = StreamProvider<List<KitchenElement>>((ref) {
  final _db = ref.watch(databaseProvider);
  return _db.kitchenElementsStream();
});

final kitchenElementsProvider = StateProvider<List<KitchenElement>>((ref) {
  final stream = ref.watch(kitchenElementsStream);
  return stream.maybeWhen(data: (items) => items, orElse: () => []);
});

///
/// stream for KitchenElementItems

final kitchenElementItemsStream = StreamProvider<List<KitchenItem>>((ref) {
  final _db = ref.watch(databaseProvider);
  return _db.kitchenItemsStream();
});

final kitchenElementItemsProvider = StateProvider<List<KitchenItem>>((ref) {
  final stream = ref.watch(kitchenElementItemsStream);
  return stream.maybeWhen(data: (kitchenItem) => kitchenItem, orElse: () => []);
});

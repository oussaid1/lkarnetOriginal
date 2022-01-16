import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/providers/authproviders/database_providers.dart';

final itemsStream = StreamProvider<List<Item>>((ref) {
  final _db = ref.watch(databaseProvider);
  return _db.itemStream();
});

final itemsProvider = StateProvider<List<Item>>((ref) {
  final stream = ref.watch(itemsStream);
  return stream.maybeWhen(data: (items) => items, orElse: () => []);
});

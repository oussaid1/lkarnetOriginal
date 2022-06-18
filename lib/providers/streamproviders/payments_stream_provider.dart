import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/models/payment/payment_model.dart';
import 'package:lkarnet/providers/authproviders/database_providers.dart';

final paymentsStream = StreamProvider<List<PaymentModel>>((ref) {
  final _db = ref.watch(databaseProvider);
  return _db.streamPayments();
});

final paymentsProvider = StateProvider<List<PaymentModel>>((ref) {
  final _stream = ref.watch(paymentsStream);
  return _stream.maybeWhen(data: (items) => items, orElse: () => []);
});

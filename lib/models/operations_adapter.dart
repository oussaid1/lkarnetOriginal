import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/models/payment/payment_model.dart';
import 'package:lkarnet/providers/streamproviders/items_stream_provider.dart';
import 'package:lkarnet/providers/streamproviders/payments_stream_provider.dart';

import '../components.dart';


final recentOperationsProvider = StateProvider<RecentOperation>((ref) {
  final items = ref.watch(itemsProvider);
  final payments = ref.watch(paymentsProvider);
  return RecentOperation(items, payments);
});

class OperationsAdapter {
  Item? item;
  Payment? payment;
  OperationsAdapter.fromItemsAndPayments({this.item, this.payment}) {
    if (item != null) {
      title = item!.itemName;
      date = item!.dateBought;
      amount = item!.itemPrix;
      quantity = item!.quantity;
      quantifier = item!.quantifier!.isEmpty ? "One" : item!.quantifier;
    } else if (payment != null) {
      title = payment!.paidShopName;
      date = payment!.datePaid;
      amount = payment!.paidAmount;
      quantity = 1;
      quantifier = 'paid';
    }
  }
  OperationsAdapter({
    this.title,
    required this.date,
    required this.amount,
    this.quantifier,
    this.quantity,
  });
  String? title;
  DateTime? date;
  double? amount;
  bool get isItem => item != null;
  double? quantity;
  String? quantifier;
}

class RecentOperation {
  List<Item> items;
  List<Payment> payments;
  RecentOperation(this.items, this.payments);
  // get a list of 10 recent payments
  List<Payment> get recentPayments {
    return payments.take(10).toList();
  }

  // get a list of 10 recent items
  List<Item> get recentItems {
    return items.take(10).toList();
  }

  // get a list of OperationsAdapter.fromItemsAndPayments for current shop
  List<OperationsAdapter> get recentOperationsList {
    List<OperationsAdapter> _list = [];
    recentItems.forEach((item) {
      _list.add(new OperationsAdapter.fromItemsAndPayments(item: item));
    });
    recentPayments.forEach((payment) {
      _list.add(OperationsAdapter.fromItemsAndPayments(payment: payment));
    });
    // sort by date
    _list.sort((a, b) => b.date!.compareTo(a.date!));
    return _list;
  }
}

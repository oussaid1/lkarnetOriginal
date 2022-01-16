import 'package:lkarnet/models/shop/shop_model.dart';
import 'package:lkarnet/providers/streamproviders/items_stream_provider.dart';
import 'package:lkarnet/providers/streamproviders/payments_stream_provider.dart';

import '../components.dart';
import '../providers/streamproviders/shops_stream_provider.dart';
import 'item/item.dart';
import 'payment/payment_model.dart';

final overallsProvider = StateProvider<OverAlls>((ref) {
  final items = ref.watch(itemsProvider.state);
  final payments = ref.watch(paymentsProvider.state);
  final shops = ref.watch(shopsProvider.state);
  return OverAlls(
      items: items.state, payments: payments.state, shops: shops.state);
});

class OverAlls {
  List<Item> items = [];
  List<Payment> payments = [];
  List<ShopModel> shops = [];
  OverAlls({
    required this.shops,
    required this.items,
    required this.payments,
  });

  OverAlls copyWith({
    List<Item>? items,
    List<Payment>? payments,
    List<ShopModel>? shops,
  }) {
    return OverAlls(
      shops: shops ?? this.shops,
      items: items ?? this.items,
      payments: payments ?? this.payments,
    );
  }

// // get all items for all shops so as to exclude deleted shops' items
//   List<Item> get itemsForAllShops {
//     List<Item> _items = [];
//     for (var shop in shops) {
//       _items.addAll(items.where((item) => item.shopName == shop.shopName));
//     }
//     return _items;
//   }

//   // get all payments for all shops so as to exclude deleted shops' payments
//   List<Payment> get paymentsForAllShops {
//     List<Payment> _payments = [];
//     for (var shop in shops) {
//       _payments.addAll(
//           payments.where((payment) => payment.paidShopName == shop.shopName));
//     }
//     return _payments;
//   }

  double get itemsSum {
    return items.fold(0, (sum, item) => sum + item.itemPrix);
  }

  double get itemsSumAfterPayment {
    return itemsSum - paymentsSum;
  }

  int get countItems {
    int _x = 0;
    items.forEach((element) => _x += element.count);
    return _x;
  }

  double get paymentsSum {
    return payments.fold(0, (sum, payment) => sum + payment.paidAmount);
  }

  int get countPayments {
    int _x = 0;
    payments.forEach((element) => _x += element.count);
    return _x;
  }
}

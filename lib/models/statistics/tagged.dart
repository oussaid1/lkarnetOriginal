import 'package:lkarnet/models/item/item.dart';
import 'package:lkarnet/models/payment/payment_model.dart';

class Tagged {
  dynamic tag;
  List<ItemModel> items;
  List<PaymentModel> payments;

  Tagged({required this.tag, required this.items, required this.payments});

  /// get a list of shopData
}

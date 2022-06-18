import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/models/item/items_filtered.dart';
import 'package:lkarnet/models/payment/payment_model.dart';
import 'package:lkarnet/providers/streamproviders/payments_stream_provider.dart';

final paymentsFilteredProvider = StateProvider<PaymentsFiltered>((ref) {
  var payments = ref.watch(paymentsProvider.state).state;
  return PaymentsFiltered(payments: payments);
});

class PaymentsFiltered {
  List<PaymentModel> payments = [];
  String? tag;
  DateFilterType? dateFilterType;
  PaymentsFiltered({required this.payments, this.tag, this.dateFilterType});

  List<PaymentModel> get allPayments {
    if (dateFilterType == DateFilterType.ddmmyy) {
      return allItemByDDMMYYTag!;
    } else if (dateFilterType == DateFilterType.mmyy) {
      return allItemByMMYYTag!;
    } else if (dateFilterType == DateFilterType.yy) {
      return allItemByYYTag!;
    }
    return [];
  }

  List<PaymentModel>? get allItemByDDMMYYTag {
    return payments.where((item) => item.toDDMMYY == tag).toList();
  }

  List<PaymentModel>? get allItemByMMYYTag {
    return payments.where((item) => item.toMMYY == tag).toList();
  }

  List<PaymentModel>? get allItemByYYTag {
    return payments.where((item) => item.toYY == tag).toList();
  }

  List<PaymentModel> get allPaymentsThisMonth {
    return payments
        .where((element) => element.datePaid.month == DateTime.now().month)
        .toList();
  }

  List<PaymentModel> get allPaymentsThisYear {
    return payments
        .where((element) => element.datePaid.year == DateTime.now().year)
        .toList();
  }

  PaymentsFiltered copyWith({
    List<PaymentModel>? payments,
    String? tag,
    DateFilterType? dateFilterType,
  }) {
    return PaymentsFiltered(
        payments: payments ?? this.payments,
        tag: tag ?? this.tag,
        dateFilterType: dateFilterType ?? this.dateFilterType);
  }
}

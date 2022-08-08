import 'package:lkarnet/components.dart';
import 'package:lkarnet/models/item/items_filtered.dart';
import 'package:lkarnet/models/payment/payment_model.dart';
import 'package:lkarnet/providers/streamproviders/payments_stream_provider.dart';

final paymentsFilteredProvider = StateProvider<PaymentsFiltered>((ref) {
  var payments = ref.watch(paymentsProvider.state).state;
  return PaymentsFiltered(payments: payments);
});

class PaymentsFiltered {
  List<PaymentModel> payments = [];
  DateFilter? dateFilterType;
  PaymentsFiltered({required this.payments, this.dateFilterType});

  /// get filtered payments by dateFilter
  List<PaymentModel> get paymentsByDateFilter {
    if (dateFilterType == null) {
      return payments;
    }
    return payments;
  }

  /// get payments today
  List<PaymentModel> get paymentsToday {
    return payments.where((payment) {
      return payment.datePaid.day == DateTime.now().day;
    }).toList();
  }

  /// get payments this month
  List<PaymentModel> get paymentsThisMonth {
    return payments
        .where((payment) => payment.datePaid.isMatchToMonth(DateTime.now()))
        .toList();
  }

  /// get payments this year
  List<PaymentModel> get paymentsThisYear {
    return payments
        .where((payment) => payment.datePaid.isMatchToYear(DateTime.now()))
        .toList();
  }
}

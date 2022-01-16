
import 'package:lkarnet/models/payment/payment_model.dart';

abstract class PaymentDbInterface {
  void addPayment(Payment payment);
  bool deletePayment(Payment payment);
  bool updatePayments(Payment payment);
  Stream<List<Payment>> getPayments();
}

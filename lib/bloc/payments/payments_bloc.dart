import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lkarnet/repository/database_operations.dart';

import '../../models/payment/payment_model.dart';

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {
  late final DatabaseOperations _databaseOperations;
  StreamSubscription<List<PaymentModel>>? _itemsSubscription;
  PaymentsBloc(DatabaseOperations databaseOperations)
      : super(PaymentsInitial()) {
    this._databaseOperations = databaseOperations;
    on<PaymentsEvent>((event, emit) {});
    on<GetPaymentsEvent>(_onGetPayments);
    on<LoadPaymentsEvent>(_onLoadPayments);
    on<AddPaymentEvent>((event, emit) {
      _databaseOperations.addPayment(event.payment);
      add(GetPaymentsEvent());
    });
  }

  /// onloadpayments event
  void _onLoadPayments(
      LoadPaymentsEvent event, Emitter<PaymentsState> emit) async {
    emit(PaymentsLoaded(event.payments));
  }

  /// on get payments event
  Future<void> _onGetPayments(
      PaymentsEvent event, Emitter<PaymentsState> emit) async {
    // if (_itemsSubscription != null) {
    //   _itemsSubscription!.cancel();
    // }
    _itemsSubscription = _databaseOperations
        .paymentsStream()
        .listen((payments) => add(LoadPaymentsEvent(payments)));
  }

  @override
  Future<void> close() {
    _itemsSubscription?.cancel();
    return super.close();
  }
}

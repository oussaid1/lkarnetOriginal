part of 'payments_bloc.dart';

abstract class PaymentsState extends Equatable {
  const PaymentsState();

  @override
  List<Object> get props => [];
}

/// payments initial state
class PaymentsInitial extends PaymentsState {}

/// payments loaded state
class PaymentsLoaded extends PaymentsState {
  final List<PaymentModel> payments;

  PaymentsLoaded(this.payments);

  @override
  List<Object> get props => [payments];
}

/// payments loading state
class PaymentsLoading extends PaymentsState {}

/// payments error state
class PaymentsError extends PaymentsState {
  final String message;

  PaymentsError(this.message);

  @override
  List<Object> get props => [message];
}

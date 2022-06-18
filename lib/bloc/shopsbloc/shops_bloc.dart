import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shops_event.dart';
part 'shops_state.dart';

class ShopsBloc extends Bloc<ShopsEvent, ShopsState> {
  ShopsBloc() : super(ShopsInitial()) {
    on<ShopsEvent>((event, emit) {});
  }
}

part of 'shops_bloc.dart';

abstract class ShopsState extends Equatable {
  const ShopsState();
  
  @override
  List<Object> get props => [];
}

class ShopsInitial extends ShopsState {}

part of 'shipping_bloc.dart';

abstract class ShippingState extends Equatable {
  const ShippingState();

  @override
  List<Object> get props => [];
}

class ShippingInitial extends ShippingState {}

class ShippingLoading extends ShippingState {}

class ShippingError extends ShippingState {
  final AppException exception;

  const ShippingError(this.exception);

  @override
  List<Object> get props => [exception];
}

class ShippingSuccess extends ShippingState {
  final CreateOrderResult result;

  const ShippingSuccess(this.result);
  
  @override
  List<Object> get props => [result];
}

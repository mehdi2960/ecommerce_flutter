part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final CartResponse cartResponse;

  const CartSuccess(this.cartResponse);
  @override
  List<Object> get props => [cartResponse];
}

class CartError extends CartState {
  final AppException exception;

  const CartError(this.exception);
}

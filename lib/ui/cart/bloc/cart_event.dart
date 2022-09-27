part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartStarted extends CartEvent {
  final AuthInfo? authInfo;
  final bool isRefreshing;

  const CartStarted(this.authInfo, {this.isRefreshing = false});
}

class CartDeleteButtonClicked extends CartEvent {
  final int cartItemId;

  const CartDeleteButtonClicked(this.cartItemId);
  @override
  List<Object> get props => [cartItemId];
}

class CartAuthInfoChange extends CartEvent {
  final AuthInfo? authInfo;

  const CartAuthInfoChange(this.authInfo);
}

class IncreaseCountButtonClicked extends CartEvent {
  final int cartItemId;

  const IncreaseCountButtonClicked(this.cartItemId);
 @override
  List<Object> get props => [cartItemId];
}

class DecreaseCountButtonClicked extends CartEvent {
  final int cartItemId;

  const DecreaseCountButtonClicked(this.cartItemId);
 @override
  List<Object> get props => [cartItemId];
}

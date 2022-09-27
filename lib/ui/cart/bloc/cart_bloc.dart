import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:nike_ecommerce_flutter/common/exceptions.dart';
import 'package:nike_ecommerce_flutter/data/auth_info.dart';
import 'package:nike_ecommerce_flutter/data/cart_response.dart';
import 'package:nike_ecommerce_flutter/data/repo/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;
  CartBloc(this.cartRepository) : super(CartLoading()) {
    on<CartEvent>(
      (event, emit) async {
        if (event is CartStarted) {
          final authInfo = event.authInfo;
          if (authInfo == null || authInfo.accessToken.isEmpty) {
            emit(CartAuthRequired());
          } else {
            await LoadCartItems(emit,event.isRefreshing);
          }
        } else if (event is CartDeleteButtonClicked) {
          try {
            if (state is CartSuccess) {
              final successState = (state as CartSuccess);
              final index = successState.cartResponse.cartItems
                  .indexWhere((element) => element.id == event.cartItemId);
              successState.cartResponse.cartItems[index].deleteButtonLoading =
                  true;
              emit(CartSuccess(successState.cartResponse));
            }

            // await Future.delayed(const Duration(milliseconds: 2000));
            await cartRepository.delete(event.cartItemId);

            if (state is CartSuccess) {
              final successState = (state as CartSuccess);
              successState.cartResponse.cartItems
                  .removeWhere((element) => element.id == event.cartItemId);
              if (successState.cartResponse.cartItems.isEmpty) {
                emit(CartEmpty());
              } else {
                emit(CartSuccess(successState.cartResponse));
              }
            }
          } catch (e) {
            // debugPrint(e.toString());
          }
        } else if (event is CartAuthInfoChange) {
          if (event.authInfo == null || event.authInfo!.accessToken.isEmpty) {
            emit(CartAuthRequired());
          } else {
            if (state is CartAuthRequired) {
              await LoadCartItems(emit,false);
            }
          }
        }
      },
    );
  }

  Future<void> LoadCartItems(Emitter<CartState> emit, bool isRefreshing) async {
    try {
      if (!isRefreshing) {
        emit(CartLoading());
      }
      final result = await cartRepository.getAll();
      if (result.cartItems.isEmpty) {
        emit(CartEmpty());
      } else {
        emit(CartSuccess(result));
      }
    } catch (e) {
      emit(CartError(AppException()));
    }
  }
}

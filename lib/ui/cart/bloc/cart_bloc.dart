import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
            await LoadCartItems(emit);
          }
        } else if (event is CartDeleteButton) {
        } else if (event is CartAuthInfoChange) {
          if (event.authInfo == null || event.authInfo!.accessToken.isEmpty) {
            emit(CartAuthRequired());
          } else {
            if (state is CartAuthRequired) {
              await LoadCartItems(emit);
            }
          }
        }
      },
    );
  }

  Future<void> LoadCartItems(Emitter<CartState> emit) async {
    try {
      emit(CartLoading());
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

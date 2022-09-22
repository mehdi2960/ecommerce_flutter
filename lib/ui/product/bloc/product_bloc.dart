import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_ecommerce_flutter/common/exceptions.dart';
import 'package:nike_ecommerce_flutter/data/repo/cart_repository.dart';
import 'package:nike_ecommerce_flutter/data/repo/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ICartRepository cartRepository;
  ProductBloc(this.cartRepository) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is CartAddButtonClick) {
        try {
          emit(ProductAddToCartButtonLoading());
          await Future.delayed(Duration(seconds: 2));
          final result =await cartRepository.add(event.productId);
          emit(ProductAddToCartSuccess());
        } catch (e) {
          emit(ProductAddToCartError(AppException()));
        }
      }
    });
  }
}

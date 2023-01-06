part of 'product_list_bloc.dart';

abstract class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object> get props => [];
}

class ProductListStarted extends ProductListEvent {
  final int sort;
  final String searchTerm;

  const ProductListStarted(this.sort, this.searchTerm);

  @override
  List<Object> get props => [sort];
}

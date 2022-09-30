import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_flutter/data/repo/product_repository.dart';
import 'package:nike_ecommerce_flutter/ui/list/bloc/product_list_bloc.dart';
import 'package:nike_ecommerce_flutter/ui/product/product.dart';

class ProductListScreen extends StatelessWidget {
  final int sort;
  const ProductListScreen({Key? key, required this.sort}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('کفش های ورزشی'),
        centerTitle: false,
      ),
      body: BlocProvider<ProductListBloc>(
        create: (context) =>
            ProductListBloc(productRepository)..add(ProductListStarted(sort)),
        child: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            if (state is ProductListSuccess) {
              final products = state.products;
              return GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.65, //width / hight
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final product = products[index];
                  return ProductItem(
                    product: product,
                    borderRadius: BorderRadius.zero,
                  );
                },
              );
            } else {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

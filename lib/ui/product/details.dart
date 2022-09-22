import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_flutter/data/product.dart';
import 'package:nike_ecommerce_flutter/data/repo/cart_repository.dart';
import 'package:nike_ecommerce_flutter/theme.dart';
import 'package:nike_ecommerce_flutter/ui/product/bloc/product_bloc.dart';
import 'package:nike_ecommerce_flutter/ui/product/comment/comment_list.dart';
import 'package:nike_ecommerce_flutter/ui/widgets/image.dart';
import 'package:nike_ecommerce_flutter/utils/util.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  StreamSubscription<ProductState>? stateSubscription;

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    stateSubscription?.cancel();
    _scaffoldKey.currentState?.dispose();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider<ProductBloc>(
        create: (context) {
          final bloc = ProductBloc(cartRepository);
          stateSubscription = bloc.stream.listen(
            (state) {
              if (state is ProductAddToCartSuccess) {
                _scaffoldKey.currentState?.showSnackBar(
                  const SnackBar(
                    content: Text(
                        'محصول مورد نطر با موفقیت به سبد خرید شما اضافه شد'),
                  ),
                );
              } else if (state is ProductAddToCartError) {
                _scaffoldKey.currentState?.showSnackBar(
                  SnackBar(
                    content: Text(state.exception.message),
                  ),
                );
              }
            },
          );
          return bloc;
        },
        child: ScaffoldMessenger(
          key: _scaffoldKey,
          child: Scaffold(
            floatingActionButton: SizedBox(
              width: MediaQuery.of(context).size.width - 48,
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) => FloatingActionButton.extended(
                  onPressed: () {
                    BlocProvider.of<ProductBloc>(context)
                        .add(CartAddButtonClick(widget.product.id));
                  },
                  label: state is ProductAddToCartButtonLoading
                      ? CupertinoActivityIndicator(
                          color: Theme.of(context).colorScheme.onSecondary,
                        )
                      : const Text('افزودن به سبد خرید'),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.width * 0.8,
                  flexibleSpace:
                      ImageLoadingService(imageUrl: widget.product.imageUrl),
                  foregroundColor: LightThemeColors.primaryTextColor,
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.heart),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.product.title,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.product.previousPrice.withPriceLabel,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .apply(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                ),
                                Text(widget.product.price.withPriceLabel),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          'این کتونی شدیدا برای دویدن و راه رفتن مناسب هست و تقریبا. هیچ فشار مخربی رو نمیذارد به پا و زانوان شما انتقال داده شود',
                          style: TextStyle(height: 1.4),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'نظرات کاربران',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'ثبت نظر',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                CommentList(productId: widget.product.id)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

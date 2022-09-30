import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_flutter/common/exceptions.dart';
import 'package:nike_ecommerce_flutter/data/banner.dart';
import 'package:nike_ecommerce_flutter/data/product.dart';
import 'package:nike_ecommerce_flutter/data/repo/banner_repository.dart';
import 'package:nike_ecommerce_flutter/data/repo/product_repository.dart';
import 'package:nike_ecommerce_flutter/ui/home/bloc/home_bloc.dart';
import 'package:nike_ecommerce_flutter/ui/list/list.dart';
import 'package:nike_ecommerce_flutter/ui/product/product.dart';
import 'package:nike_ecommerce_flutter/ui/widgets/error.dart';
import 'package:nike_ecommerce_flutter/ui/widgets/image.dart';
import 'package:nike_ecommerce_flutter/ui/widgets/slider.dart';
import 'package:nike_ecommerce_flutter/utils/util.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeBloc = HomeBloc(
          bannerRepository: bannerRepository,
          productRepository: productRepository,
        );
        homeBloc.add(HomeStarted());
        return homeBloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeSuccess) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  // padding: const EdgeInsets.fromLTRB(12, 12, 12, 100),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Container(
                          height: 56,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/img/nike_logo.png',
                            height: 24,
                            fit: BoxFit.fitHeight,
                          ),
                        );
                      case 2:
                        return BannerSlider(
                          banners: state.banners,
                        );
                      case 3:
                        return _HorizentalProductList(
                          title: 'جدیدترین',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ProductListScreen(
                                  sort: ProductSort.latest,
                                ),
                              ),
                            );
                          },
                          products: state.latestProducts,
                        );
                      case 4:
                        return _HorizentalProductList(
                          title: 'پربازدیدترین',
                          onTap: () {
                              Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ProductListScreen(
                                  sort: ProductSort.popular,
                                ),
                              ),
                            );
                          },
                          products: state.popularProducts,
                        );
                      default:
                        return Container();
                    }
                  },
                );
              } else if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeError) {
                return AppErrorWidget(
                  exception: state.exception,
                  onPress: () {
                    BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                  },
                );
              } else {
                throw Exception('state is not supported');
              }
            },
          ),
        ),
      ),
    );
  }
}

class _HorizentalProductList extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;
  final List<ProductEntity> products;
  const _HorizentalProductList({
    Key? key,
    required this.title,
    required this.onTap,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              TextButton(
                onPressed: onTap,
                child: const Text(
                  'مشاهده همه',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 290,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: 8, right: 8),
            itemCount: products.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductItem(
                product: product,
                borderRadius: BorderRadius.circular(12),
              );
            },
          ),
        )
      ],
    );
  }
}

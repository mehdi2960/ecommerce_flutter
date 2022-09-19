import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_flutter/data/banner.dart';
import 'package:nike_ecommerce_flutter/data/repo/banner_repository.dart';
import 'package:nike_ecommerce_flutter/data/repo/product_repository.dart';
import 'package:nike_ecommerce_flutter/ui/home/bloc/home_bloc.dart';
import 'package:nike_ecommerce_flutter/ui/widgets/image.dart';
import 'package:nike_ecommerce_flutter/ui/widgets/slider.dart';

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
                        return BannerSlider(banners: state.banners,);
                      default:
                        return Container();
                    }
                  },
                );
              } else if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeError) {
                return Center(
                  child: Column(
                    children: [
                      Text(state.exception.message),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                        },
                        child: Text('تلاش دوباره'),
                      ),
                    ],
                  ),
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



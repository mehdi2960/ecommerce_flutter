import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike_ecommerce_flutter/data/auth_info.dart';
import 'package:nike_ecommerce_flutter/data/cart_item.dart';
import 'package:nike_ecommerce_flutter/data/repo/auth_repository.dart';
import 'package:nike_ecommerce_flutter/data/repo/cart_repository.dart';
import 'package:nike_ecommerce_flutter/ui/auth/auth.dart';
import 'package:nike_ecommerce_flutter/ui/cart/bloc/cart_bloc.dart';
import 'package:nike_ecommerce_flutter/ui/cart/cart_item.dart';
import 'package:nike_ecommerce_flutter/ui/widgets/empty_state.dart';
import 'package:nike_ecommerce_flutter/ui/widgets/image.dart';
import 'package:nike_ecommerce_flutter/utils/util.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartBloc? cartBloc;
  @override
  void initState() {
    super.initState();
    AuthRepository.authChangeNotifier.addListener(authChangeNotifierListener);
  }

  void authChangeNotifierListener() {
    cartBloc?.add(
      CartAuthInfoChange(AuthRepository.authChangeNotifier.value),
    );
  }

  @override
  void dispose() {
    AuthRepository.authChangeNotifier
        .removeListener(authChangeNotifierListener);
    cartBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("سبد خرید"),
        ),
        body: BlocProvider<CartBloc>(
          create: (context) {
            final bloc = CartBloc(cartRepository);
            cartBloc = bloc;
            bloc.add(CartStarted(AuthRepository.authChangeNotifier.value));
            return bloc;
          },
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CartError) {
                return Center(
                  child: Text(state.exception.message),
                );
              } else if (state is CartSuccess) {
                return ListView.builder(
                  itemCount: state.cartResponse.cartItems.length,
                  itemBuilder: (context, index) {
                    final data = state.cartResponse.cartItems[index];
                    return CartItem(
                      data: data,
                      onDeleteButtonClick: () {
                        cartBloc?.add(CartDeleteButtonClicked(data.id));
                      },
                    );
                  },
                );
              } else if (state is CartAuthRequired) {
                return EmptyView(
                  message:
                      'برای مشاهده سبد خرید ابتدا وارد حساب کاربری خود شوید',
                  callToAction: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AuthScreen()));
                    },
                    child: const Text("ورود به حساب کاربری"),
                  ),
                  image: SvgPicture.asset(
                    'assets/img/auth_required.svg',
                    width: 140,
                  ),
                );
              } else if (state is CartEmpty) {
                return EmptyView(
                  message: 'تاکنون هیچ آیتمی به سبد خرید خود اضافه نکرده اید',
                  image: SvgPicture.asset('assets/img/empty.svg'),
                );
              } else {
                throw Exception('current cart state is not valid');
              }
            },
          ),
        )

        //  ValueListenableBuilder<AuthInfo?>(
        //   valueListenable: AuthRepository.authChangeNotifier,
        //   builder: (context, authState, child) {
        //     bool isAuthenticated =
        //         authState != null && authState.accessToken.isNotEmpty;
        //     return SizedBox(
        //       width: MediaQuery.of(context).size.width,
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           Text(isAuthenticated
        //               ? 'خوش آمدید'
        //               : 'لطفا وارد حساب کاربری خود شوید'),
        //           isAuthenticated
        //               ? ElevatedButton(
        //                   onPressed: () {
        //                     authRepository.signOut();
        //                   },
        //                   child: const Text('خروج از حساب'),
        //                 )
        //               : ElevatedButton(
        //                   onPressed: () {
        //                     Navigator.of(context, rootNavigator: true).push(
        //                       MaterialPageRoute(
        //                         builder: (context) => const AuthScreen(),
        //                       ),
        //                     );
        //                   },
        //                   child: const Text('ورود'),
        //                 ),
        //           ElevatedButton(
        //             onPressed: () async{
        //               await authRepository.refreshToken();
        //             },
        //             child: const Text('Refresh Token'),
        //           ),
        //         ],
        //       ),
        //     );
        //   },
        // ),
        );
  }
}

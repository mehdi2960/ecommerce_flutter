import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_flutter/data/auth_info.dart';
import 'package:nike_ecommerce_flutter/data/repo/auth_repository.dart';
import 'package:nike_ecommerce_flutter/data/repo/cart_repository.dart';
import 'package:nike_ecommerce_flutter/ui/auth/auth.dart';
import 'package:nike_ecommerce_flutter/ui/cart/bloc/cart_bloc.dart';
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
    AuthRepository.authChangeNotifier.removeListener(authChangeNotifierListener);
    cartBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                            ),
                          ]),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: ImageLoadingService(
                                    imageUrl: data.product.imageUrl,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      data.product.title,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("تعداد"),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            CupertinoIcons.plus_rectangle,
                                          ),
                                        ),
                                        Text(
                                          data.count.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            CupertinoIcons.minus_rectangle,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      data.product.previousPrice.withPriceLabel,
                                      style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    Text(data.product.price.withPriceLabel),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            height: 1,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'حذف از سبد خرید',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (state is CartAuthRequired) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('وارد حساب کاربری خود شوبد'),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AuthScreen(),
                            ),
                          );
                        },
                        child: const Text('ورود به حساب کاربری'),
                      ),
                    ],
                  ),
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

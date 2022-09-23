import 'package:flutter/material.dart';
import 'package:nike_ecommerce_flutter/data/banner.dart';
import 'package:nike_ecommerce_flutter/ui/widgets/image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  final PageController _controller = PageController();
  final List<BannerEntity> banners;
  BannerSlider({
    Key? key,
    required this.banners,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Stack(
        children: [
          PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _controller,
            itemCount: banners.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: ImageLoadingService(
                imageUrl: banners[index].imageUrl,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 8,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: banners.length,
                axisDirection: Axis.horizontal,
                effect: WormEffect(
                  spacing: 4.0,
                  radius: 4.0,
                  dotWidth: 20.0,
                  dotHeight: 3.0,
                  paintStyle: PaintingStyle.fill,
                  dotColor: Colors.grey.shade400,
                  activeDotColor: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

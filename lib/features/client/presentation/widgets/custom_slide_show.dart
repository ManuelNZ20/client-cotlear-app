import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';
import 'widgets.dart';

class CustomSlideShow extends ConsumerWidget {
  const CustomSlideShow({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final banners = ref.watch(bannersProvider.notifier);
    return SizedBox(
      width: double.infinity,
      height: 230,
      child: StreamBuilder(
        stream: banners.getBannersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          final banners = snapshot.data;
          return Swiper(
            itemCount: banners!.length,
            viewportFraction: .8,
            scale: .9,
            autoplay: true,
            itemBuilder: (context, index) {
              final banner = banners[index];
              // return _Slide(banner: banner);
              return BannerCardSwiper(
                imgUrl: banner.imgUrl,
                title: banner.title,
                subTitle: banner.subTitle,
                titleLink: banner.titleLink,
                isActive: banner.isActive,
              );
            },
          );
        },
      ),
    );
  }
}

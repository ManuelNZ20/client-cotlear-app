import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({
    super.key,
    required this.location,
    required this.name,
    required this.brand,
    required this.priceOriginal,
    this.priceDiscountApplied = 0.0,
    required this.img,
    this.isFavorite = false,
    this.isPromocion = false,
    this.offPercentage = 0.0,
    this.onPressedFavorite,
  });
  final String name;
  final String brand;
  final double priceOriginal;
  final double priceDiscountApplied;
  final String img;
  final String location;
  final bool isFavorite;
  final bool isPromocion;
  final double offPercentage;
  final void Function()? onPressedFavorite;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titleTheme = Theme.of(context).textTheme.bodyLarge!.copyWith(
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.bold,
        );
    return Container(
      width: size.width,
      height: 300,
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            blurStyle: BlurStyle.normal,
            offset: Offset(1, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image + reaction + chip
          _ImageProduct(
            img: img,
            isFavorite: isFavorite,
            promotion: isPromocion,
            percentage: offPercentage,
            onPressedFavorite: onPressedFavorite,
          ),
          // title
          GestureDetector(
            onTap: () => context.push(location),
            child: Text(
              name,
              maxLines: 2,
              style: titleTheme,
            ),
          ),
          // brand + views
          BrandWithReViews(
            brand: brand.toUpperCase(),
            reViews: 4.5,
          ),
          PriceWithPriceDiscount(
            priceOriginal: priceOriginal,
            priceDiscountApplied: priceDiscountApplied,
            isPromotion: isPromocion,
          )
          // price
        ],
      ),
    );
  }
}

class _ImageProduct extends StatelessWidget {
  const _ImageProduct({
    required this.img,
    required this.isFavorite,
    bool? promotion,
    double? percentage,
    this.onPressedFavorite,
  })  : isPromocion = promotion ?? false,
        offPercentage = percentage ?? 0.0;
  final String img;
  final bool isFavorite;
  final bool isPromocion;
  final double offPercentage;
  final void Function()? onPressedFavorite;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titlePromotion = Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Theme.of(context).colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        );
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 10,
          ),
          child: Image.network(
            width: size.width,
            height: size.height * .15,
            img,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return SizedBox(
                  width: size.width * .4,
                  height: size.height * .15,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return child;
            },
          ),
        ),
        Positioned(
          right: 0,
          child: IconButton(
            onPressed: onPressedFavorite,
            icon: Icon(
              isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: Colors.grey[400],
            ),
          ),
        ),
        isPromocion
            ? Positioned(
                left: 2,
                top: 6,
                child: Container(
                  width: 80,
                  height: 25,
                  padding: EdgeInsets.zero,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${(offPercentage * 100).toInt()}% OFF',
                      style: titlePromotion,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

class BrandWithReViews extends StatelessWidget {
  const BrandWithReViews({
    super.key,
    required this.brand,
    required this.reViews,
  });
  final String brand;
  final double reViews;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titleBrand = Theme.of(context).textTheme.titleSmall!.copyWith(
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w400,
          color: Colors.grey[500],
          fontSize: 16,
        );
    final titleReView = Theme.of(context).textTheme.titleSmall!.copyWith(
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        );
    return SizedBox(
      width: size.width,
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width * .2,
            child: Text(
              brand,
              style: titleBrand,
            ),
          ),
          SizedBox(
            width: size.width * .13,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star_rate_rounded,
                  color: Colors.amber,
                ),
                Text(
                  reViews.toString(),
                  style: titleReView,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PriceWithPriceDiscount extends StatelessWidget {
  const PriceWithPriceDiscount({
    super.key,
    required this.priceOriginal,
    required this.priceDiscountApplied,
    this.isPromotion,
  });
  final double priceOriginal;
  final double priceDiscountApplied;
  final bool? isPromotion;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titlePrice = Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: 16,
          color: const Color(0xFFD19E63),
          letterSpacing: 1.2,
          overflow: TextOverflow.ellipsis,
        );
    final titlePriceDiscount =
        Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 12,
              color: Colors.grey,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.lineThrough,
              decorationColor: Colors.grey,
              decorationStyle: TextDecorationStyle.solid,
            );
    return SizedBox(
      width: size.width,
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: size.width * .2,
            child: Text(
              'S/. $priceOriginal',
              style: titlePrice,
            ),
          ),
          isPromotion!
              ? Text(
                  'S/. $priceDiscountApplied',
                  style: titlePriceDiscount,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

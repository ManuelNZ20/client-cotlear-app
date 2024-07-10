import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardCategory extends StatelessWidget {
  const CardCategory({
    super.key,
    required this.imgUrl,
    required this.title,
    required this.location,
    required this.isActive,
  });
  final String imgUrl;
  final String title;
  final String location;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titleTheme = Theme.of(context).textTheme.bodySmall!.copyWith();
    return GestureDetector(
      onTap: () => context.push(location),
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 5,
        surfaceTintColor: Colors.white,
        margin: EdgeInsets.zero,
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  width: size.width,
                  height: size.height * .15,
                  imgUrl,
                  fit: BoxFit.fill,
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
              ],
            ),
            Text(
              title,
              softWrap: true,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
              style: titleTheme,
            ),
          ],
        ),
      ),
    );
  }
}

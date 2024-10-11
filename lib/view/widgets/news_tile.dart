import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:newzent/model/news/news_model.dart';
import 'package:newzent/resources/constants/dimension/app_dimension.dart';
import 'package:newzent/resources/constants/routes/routes.dart';
import 'package:newzent/utils/time_util.dart';

class NewsTile extends StatelessWidget {
  final Articles news;
  const NewsTile({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.article, arguments: news);
      },
      child: SizedBox(
        height: 97,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          'https://ioflood.com/blog/wp-content/uploads/2023/10/java_logo_dice_random.jpg',
                        ),
                        radius: 8,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(news.source!.name ?? 'source',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  color: Theme.of(context).primaryColorLight)),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    news.title ?? 'Title not available',
                    style: Theme.of(context).textTheme.headlineLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 19,
                  ),
                  Text(
                    '${TimeUtils.timeAgo(news.publishedAt!)} | ${news.author ?? 'Unknown'}',
                    style: Theme.of(context).textTheme.labelSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 26,
            ),
            Container(
              height: 85,
              width: 85,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(AppDimension().borderRadius),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(news.urlToImage ??
                          'https://rezista.in/wp-content/uploads/2020/07/Hero-Banner-Placeholder-Dark-1024x480-1.png'))),
            )
          ],
        ),
      ),
    );
  }
}

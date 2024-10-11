import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newzent/model/news/news_model.dart';
import 'package:newzent/resources/constants/dimension/app_dimension.dart';
import 'package:newzent/utils/time_util.dart';

class ArticleScreen extends StatelessWidget {
  final Articles news;
  const ArticleScreen({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    final Articles news = Get.arguments;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppDimension().defaultMargin)
            .copyWith(top: 30, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 225,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(AppDimension().borderRadius),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(news!.urlToImage ??
                        'https://rezista.in/wp-content/uploads/2020/07/Hero-Banner-Placeholder-Dark-1024x480-1.png'),
                  )),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              news!.title!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              '${news!.source!.name} | ${TimeUtils.timeAgo(news!.publishedAt!)}',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              news!.description!,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
      ),
    );
  }
}

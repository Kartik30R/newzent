import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:newzent/model/news/news_model.dart';
import 'package:newzent/resources/constants/dimension/app_dimension.dart';
import 'package:newzent/resources/constants/routes/routes.dart';
import 'package:newzent/utils/time_util.dart';

class NewsTile extends StatelessWidget {
  final Articles news;
  final int index;
  final List<Articles> articles;

  const NewsTile({
    super.key,
    required this.news,
    required this.index,
    required this.articles,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          AppRoutes.article,
          arguments: {
            'articles': articles,
            'index': index,
          },
        );
      },
      child: SizedBox(
        height: 97,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.source?.name ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(
                            color:
                                Theme.of(context).primaryColorLight),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    news.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const Spacer(),
                  Text(
                    TimeUtils.timeAgo(news.publishedAt!),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              height: 85,
              width: 85,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(AppDimension().borderRadius),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    news.urlToImage ??
                        'https://rezista.in/wp-content/uploads/2020/07/Hero-Banner-Placeholder-Dark-1024x480-1.png',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

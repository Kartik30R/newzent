import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newzent/model/news/news_model.dart';
import 'package:newzent/resources/constants/color/app_color.dart';
import 'package:newzent/resources/constants/routes/routes.dart';
import 'package:newzent/utils/time_util.dart';

class NewsCard extends StatelessWidget {
  final Articles news;
  final int index;
  final List<Articles> articles;

  const NewsCard({
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          height: 242,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8).copyWith(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: AppColor.darkTertiaryText,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          news.urlToImage ??
                              'https://rezista.in/wp-content/uploads/2020/07/Hero-Banner-Placeholder-Dark-1024x480-1.png',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    news.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 8,
                        backgroundImage: CachedNetworkImageProvider(
                          'https://ioflood.com/blog/wp-content/uploads/2023/10/java_logo_dice_random.jpg',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        news.source?.name ?? '',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Text(
                    '${TimeUtils.timeAgo(news.publishedAt!)}'
                    '${news.author == null ? '' : ' | ${news.author}'}',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

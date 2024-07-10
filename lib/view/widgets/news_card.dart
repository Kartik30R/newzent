import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:newzent/model/news/news_model.dart';
import 'package:newzent/resources/constants/color/app_color.dart';
import 'package:newzent/utils/time_util.dart';
import 'package:newzent/view/screens/app/article_screen.dart';

class NewsCard extends StatelessWidget {
  final Articles news;

  const NewsCard({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleScreen(news: news),));},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
          
          width: double.infinity,
          height: 235,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0).copyWith(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: AppColor.darkTertiaryText,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(news.urlToImage ??
                            'https://rezista.in/wp-content/uploads/2020/07/Hero-Banner-Placeholder-Dark-1024x480-1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    news.title!,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                          backgroundImage: const CachedNetworkImageProvider(
                            'https://ioflood.com/blog/wp-content/uploads/2023/10/java_logo_dice_random.jpg',
                          ),
                          radius: 8,
                        ),
                        const SizedBox(width: 8,),
                      Text(
                        news.source!.name!,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    '${TimeUtils.timeAgo(news.publishedAt!)} ${news.author == null ? 'Unknown' : '| ${news.author}'}',
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

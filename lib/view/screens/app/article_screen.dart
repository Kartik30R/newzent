import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newzent/model/news/news_model.dart';
import 'package:newzent/utils/time_util.dart';

class ArticleScreen extends StatelessWidget {
  final List<Articles> articles;
  final int initialIndex;

  const ArticleScreen({
    super.key,
    required this.articles,
    required this.initialIndex,
  });

  @override
  Widget build(BuildContext context) {
    final PageController controller =
        PageController(initialPage: initialIndex);

    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: controller,
        scrollDirection: Axis.vertical,
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final news = articles[index];

          return Stack(
            fit: StackFit.expand,
            children: [
              /// BACKGROUND IMAGE
              CachedNetworkImage(
                imageUrl: news.urlToImage ??
                    'https://rezista.in/wp-content/uploads/2020/07/Hero-Banner-Placeholder-Dark-1024x480-1.png',
                fit: BoxFit.cover,
              ),

              /// GRADIENT OVERLAY
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.9),
                    ],
                  ),
                ),
              ),

              /// CONTENT
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: Get.back,
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.white),
                      ),

                      const Spacer(),

                      Text(
                        '${news.source?.name ?? ''} • ${TimeUtils.timeAgo(news.publishedAt!)}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        news.title ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        news.description ?? '',
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

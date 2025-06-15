// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:get/get.dart';
import 'package:newzent/resources/constants/dimension/app_dimension.dart';
import 'package:newzent/resources/widgets/app_widgets.dart';
import 'package:newzent/view/widgets/news_card.dart';
import 'package:newzent/view/widgets/news_tile.dart';
import 'package:newzent/view_model/controllers/feed_news_controller.dart';

class FeedScreen extends StatelessWidget {
  final FeedNewsController newsController = Get.put(FeedNewsController());
  final AppDimension dimension = AppDimension();
  final ScrollController _scrollController = ScrollController();

  FeedScreen({super.key}) {
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.atEdge) {
      bool isBottom = _scrollController.position.pixels != 0;
      if (isBottom) {
        newsController.fetchMoreNews();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: SizedBox(height: 20, child: Image.asset('assets/logo.png')),
        ),
        body: Obx(() {
          if (newsController.isLoading.value) {
            return const Center(child: AppWidgets.loadingIndicator);
          } else if (newsController.errorMessage.isNotEmpty) {
            return Center(child: Text('Error: ${newsController.errorMessage}'));
          } else if (newsController.everyThingNews.isEmpty) {
            return const Center(child: Text('No news articles available.'));
          } else {
            return SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  const SizedBox(height: 21),
                  Padding(
                    padding: EdgeInsets.all(dimension.defaultMargin)
                        .copyWith(bottom: 0, top: 0),
                    child: Row(
                      children: [
                        Text('My Feed',
                            style: Theme.of(context).textTheme.titleLarge),
                        const Spacer(),
                        const Icon(Icons.search),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // CarouselSlider.builder(
                  //   itemCount: 5,
                  //   itemBuilder: (context, index, realIndex) {
                  //     return NewsCard(
                  //         news: newsController.everyThingNews[index]);
                  //   },
                  //   options: CarouselOptions(
                  //     height: 235,
                  //     viewportFraction: .8,
                  //     enlargeStrategy: CenterPageEnlargeStrategy.scale,
                  //     enableInfiniteScroll: false,
                  //     initialPage: 2,
                  //     autoPlay: true,
                  //   ),
                  // ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.all(dimension.defaultMargin)
                        .copyWith(bottom: 0, top: 0),
                    child: Row(
                      children: [
                        DropdownButton<String>(
                          value: newsController.currentSort.value,
                          items: newsController.sortBy.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            newsController.currentSort.value = newValue!;
                            newsController.page.value = 1;
                            newsController.fetchEveryThingNews();
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.all(dimension.defaultMargin)
                        .copyWith(bottom: 0, top: 0),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: newsController.everyThingNews.length +
                          (newsController.isLoadingMore.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < newsController.everyThingNews.length) {
                          final newsArticle =
                              newsController.everyThingNews[index];
                          return Column(
                            children: [
                              NewsTile(news: newsArticle),
                              const Divider(height: 32),
                            ],
                          );
                        } else {
                          return const Center(
                              child: AppWidgets.loadingIndicator);
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}

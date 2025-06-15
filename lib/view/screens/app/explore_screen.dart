// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:get/get.dart';
import 'package:newzent/model/news/news_model.dart';
import 'package:newzent/resources/constants/string/app_string.dart';
import 'package:newzent/view/widgets/news_tile.dart';
import 'package:newzent/view_model/controllers/explore_news_controller.dart';

class ExploreScreen extends StatelessWidget {
  final ExploreNewsController newsController = Get.put(ExploreNewsController());

  ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: AppString.categories.length + 1,
      child: Builder(
        builder: (context) {
          final TabController tabController = DefaultTabController.of(context)!;
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              final index = tabController.index;
              if (index == 0 || newsController.topNews.isEmpty) {
                newsController.fetchTopNews();
              } else {
                final category = AppString.categories[index - 1];
                newsController.fetchCategoryNews(category);
              }
            }
          });

          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Explore",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    // CarouselSlider.builder(
                    //   itemCount: 5,
                    //   itemBuilder: (context, index, realIndex) {
                    //     return NewsCard(news: newsController.topNews[index]);
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
                    TabBar(
                      isScrollable: true,
                      tabs: [
                        const Tab(text: 'Top'),
                        ...AppString.categories.map((category) {
                          return Tab(text: category.capitalizeFirst);
                        }).toList(),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height -
                          kToolbarHeight +
                          700, // Adjust height accordingly
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          _buildNewsList(newsController.topNews, null,
                              newsController.isLoadingTopNews),
                          ...AppString.categories.map((category) {
                            return _buildNewsList(
                              newsController.getNewsListByCategory(category),
                              category,
                              newsController
                                  .getLoadingStateByCategory(category),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNewsList(
      RxList<Articles> newsList, String? category, RxBool isLoading) {
    return Obx(() {
      return isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                    !newsController.isFetchingMore.value) {
                  newsController.loadMoreNews(category);
                }
                return false;
              },
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: newsList.length + 1,
                itemBuilder: (context, index) {
                  if (index == newsList.length) {
                    return newsController.isFetchingMore.value
                        ? const Center(child: CircularProgressIndicator())
                        : const SizedBox.shrink();
                  }
                  final news = newsList[index];
                  return Column(
                    children: [
                      NewsTile(news: news),
                      const Divider(height: 32),
                    ],
                  );
                },
              ),
            );
    });
  }
}

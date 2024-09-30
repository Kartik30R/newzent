import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newzent/model/news/news_model.dart';
import 'package:newzent/resources/constants/color/app_color.dart';
import 'package:newzent/resources/constants/dimension/app_dimension.dart';
import 'package:newzent/resources/constants/string/app_string.dart';
import 'package:newzent/view/widgets/news_card.dart';
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

          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                elevation: 5,
                title: SizedBox(
                    height: 20,
                    child: Image.asset(
                      'assets/logo.png',
                    )),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 21,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppDimension().defaultMargin),
                      child: Text(
                        "Explore",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppDimension().defaultMargin),
                      child: const TextField(
                        decoration: InputDecoration(
                            hintText: 'search', prefixIcon: Icon(Icons.search)),
                      ),
                    ),
                    const SizedBox(
                      height: 21,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppDimension().defaultMargin),
                      child: Text(
                        "Editor's Choice",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CarouselSlider.builder(
                      itemCount: 5,
                      itemBuilder: (context, index, realIndex) {
                        return NewsCard(news: newsController.topNews[index]);
                      },
                      options: CarouselOptions(
                        height: 235,
                        viewportFraction: .8,
                        enlargeStrategy: CenterPageEnlargeStrategy.scale,
                        enableInfiniteScroll: false,
                        initialPage: 2,
                        autoPlay: true,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TabBar(
                      dividerHeight: 0,
                      indicator: BoxDecoration(),
                      labelStyle: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: AppColor.primary),
                      unselectedLabelStyle:
                          Theme.of(context).textTheme.headlineMedium,
                      isScrollable: true,
                      tabs: [
                        const Tab(text: 'Top'),
                        ...AppString.categories.map((category) {
                          return Tab(text: category.capitalizeFirst);
                        }).toList(),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height -
                          kToolbarHeight +
                          700,
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.all(AppDimension().defaultMargin),
                            child: _buildNewsList(newsController.topNews, null,
                                newsController.isLoadingTopNews),
                          ),
                          ...AppString.categories.map((category) {
                            return Padding(
                              padding:
                                  EdgeInsets.all(AppDimension().defaultMargin),
                              child: _buildNewsList(
                                newsController.getNewsListByCategory(category),
                                category,
                                newsController
                                    .getLoadingStateByCategory(category),
                              ),
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

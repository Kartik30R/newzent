import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:newzent/model/news/news_model.dart';
import 'package:newzent/repository/news_repo.dart';

class ExploreNewsController extends GetxController {
  @override
  void onInit() {
    fetchTopNews();
    super.onInit();
  }

  final NewsRepo _newsRepo = NewsRepo();

  RxInt pageSize = 10.obs;
  RxString errorMessage = ''.obs;

  RxInt topNewsPage = 1.obs;
  RxInt businessNewsPage = 1.obs;
  RxInt entertainmentNewsPage = 1.obs;
  RxInt generalNewsPage = 1.obs;
  RxInt healthNewsPage = 1.obs;
  RxInt scienceNewsPage = 1.obs;
  RxInt sportsNewsPage = 1.obs;
  RxInt technologyNewsPage = 1.obs;

  RxBool isLoadingTopNews = false.obs;
  RxBool isLoadingBusinessNews = false.obs;
  RxBool isLoadingEntertainmentNews = false.obs;
  RxBool isLoadingGeneralNews = false.obs;
  RxBool isLoadingHealthNews = false.obs;
  RxBool isLoadingScienceNews = false.obs;
  RxBool isLoadingSportsNews = false.obs;
  RxBool isLoadingTechnologyNews = false.obs;

  RxBool isFetchingMore = false.obs;

  RxList<Articles> topNews = <Articles>[].obs;
  RxList<Articles> businessNews = <Articles>[].obs;
  RxList<Articles> entertainmentNews = <Articles>[].obs;
  RxList<Articles> generalNews = <Articles>[].obs;
  RxList<Articles> healthNews = <Articles>[].obs;
  RxList<Articles> scienceNews = <Articles>[].obs;
  RxList<Articles> sportsNews = <Articles>[].obs;
  RxList<Articles> technologyNews = <Articles>[].obs;

  Future<void> fetchTopNews() async {
    await _fetchNewsForCategory(null, topNews, isLoadingTopNews, topNewsPage);
    topNews.refresh();
    if (kDebugMode) {
      print('hit top news');
      print(topNews.toList().toString());
    }
  }

  void fetchCategoryNews(String category) {
    switch (category) {
      case 'business':
        fetchBusinessNews();
        break;
      case 'entertainment':
        fetchEntertainmentNews();
        break;
      case 'general':
        fetchGeneralNews();
        break;
      case 'health':
        fetchHealthNews();
        break;
      case 'science':
        fetchScienceNews();
        break;
      case 'sports':
        fetchSportsNews();
        break;
      case 'technology':
        fetchTechnologyNews();
        break;
    }
  }

  Future<void> fetchBusinessNews() async {
    await _fetchNewsForCategory(
        'business', businessNews, isLoadingBusinessNews, businessNewsPage);
    if (kDebugMode) {
      print('hit business news');
    }
  }

  Future<void> fetchEntertainmentNews() async {
    await _fetchNewsForCategory('entertainment', entertainmentNews,
        isLoadingEntertainmentNews, entertainmentNewsPage);
    if (kDebugMode) {
      print('hit entertainment news');
    }
  }

  Future<void> fetchGeneralNews() async {
    await _fetchNewsForCategory(
        'general', generalNews, isLoadingGeneralNews, generalNewsPage);
    if (kDebugMode) {
      print('hit general news');
    }
  }

  Future<void> fetchHealthNews() async {
    await _fetchNewsForCategory(
        'health', healthNews, isLoadingHealthNews, healthNewsPage);
    if (kDebugMode) {
      print('hit health news');
    }
  }

  Future<void> fetchScienceNews() async {
    await _fetchNewsForCategory(
        'science', scienceNews, isLoadingScienceNews, scienceNewsPage);
    if (kDebugMode) {
      print('hit science news');
    }
  }

  Future<void> fetchSportsNews() async {
    await _fetchNewsForCategory(
        'sports', sportsNews, isLoadingSportsNews, sportsNewsPage);
    if (kDebugMode) {
      print('hit sports news');
    }
  }

  Future<void> fetchTechnologyNews() async {
    await _fetchNewsForCategory('technology', technologyNews,
        isLoadingTechnologyNews, technologyNewsPage);
    if (kDebugMode) {
      print('hit technology news');
    }
  }

  Future<void> loadMoreNews(String? category) async {
    if (category == null) {
      await _loadMoreNewsForCategory(
          null, topNews, topNewsPage, isLoadingTopNews);
    } else {
      switch (category) {
        case 'business':
          await _loadMoreNewsForCategory('business', businessNews,
              businessNewsPage, isLoadingBusinessNews);
          break;
        case 'entertainment':
          await _loadMoreNewsForCategory('entertainment', entertainmentNews,
              entertainmentNewsPage, isLoadingEntertainmentNews);
          break;
        case 'general':
          await _loadMoreNewsForCategory(
              'general', generalNews, generalNewsPage, isLoadingGeneralNews);
          break;
        case 'health':
          await _loadMoreNewsForCategory(
              'health', healthNews, healthNewsPage, isLoadingHealthNews);
          break;
        case 'science':
          await _loadMoreNewsForCategory(
              'science', scienceNews, scienceNewsPage, isLoadingScienceNews);
          break;
        case 'sports':
          await _loadMoreNewsForCategory(
              'sports', sportsNews, sportsNewsPage, isLoadingSportsNews);
          break;
        case 'technology':
          await _loadMoreNewsForCategory('technology', technologyNews,
              technologyNewsPage, isLoadingTechnologyNews);
          break;
      }
    }
  }

  Future<void> _fetchNewsForCategory(String? category,
      RxList<Articles> targetList, RxBool isLoading, RxInt page) async {
    try {
      isLoading(true);
      NewsModel newsModel = await _newsRepo.fetchTopNews(
        page: page.value.toString(),
        pageSize: pageSize.value.toString(),
        category: category,
      );
      print('$newsModel newsModel ');
      targetList.value = _removeDuplicates(newsModel.articles ?? []);
      targetList.refresh();
      print(targetList);
    } catch (e) {
      print(e);
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> _loadMoreNewsForCategory(String? category,
      RxList<Articles> targetList, RxInt page, RxBool isLoading) async {
    try {
      isFetchingMore(true);
      if (page.value < 10) {
        page.value++;
        NewsModel newsModel = await _newsRepo.fetchTopNews(
          page: page.value.toString(),
          pageSize: pageSize.value.toString(),
          category: category,
        );
        targetList.addAll(_removeDuplicates(newsModel.articles ?? []));
        targetList.refresh();
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isFetchingMore(false);
    }
  }

  RxList<Articles> getNewsListByCategory(String category) {
    switch (category) {
      case 'business':
        return businessNews;
      case 'entertainment':
        return entertainmentNews;
      case 'general':
        return generalNews;
      case 'health':
        return healthNews;
      case 'science':
        return scienceNews;
      case 'sports':
        return sportsNews;
      case 'technology':
        return technologyNews;
      default:
        return <Articles>[].obs;
    }
  }

  RxBool getLoadingStateByCategory(String category) {
    switch (category) {
      case 'business':
        return isLoadingBusinessNews;
      case 'entertainment':
        return isLoadingEntertainmentNews;
      case 'general':
        return isLoadingGeneralNews;
      case 'health':
        return isLoadingHealthNews;
      case 'science':
        return isLoadingScienceNews;
      case 'sports':
        return isLoadingSportsNews;
      case 'technology':
        return isLoadingTechnologyNews;
      default:
        return false.obs;
    }
  }

  List<Articles> _removeDuplicates(List<Articles> articles) {
    final uniqueArticles = <String>{};
    final filteredArticles = <Articles>[];

    for (var article in articles) {
      if (uniqueArticles.add(article.title!)) {
        filteredArticles.add(article);
      }
    }

    return filteredArticles;
  }
}

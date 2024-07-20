import 'package:get/get.dart';
import 'package:newzent/model/news/news_model.dart';
import 'package:newzent/repository/news_repo.dart';
import 'package:newzent/view_model/controllers/user_preference.dart';

class FeedNewsController extends GetxController {
  final NewsRepo _newsRepo = NewsRepo();
  UserPreference pref = UserPreference();

  RxInt page = 1.obs;
  RxInt pageSize = 10.obs;
  RxList<Articles> everyThingNews = <Articles>[].obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs;
  RxList<String> sortBy = ['relevancy', 'popularity', 'publishedAt'].obs;
  RxString currentSort = 'relevancy'.obs;
  RxString errorMessage = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchEveryThingNews();
  }

  Future<void> fetchEveryThingNews() async {
    try {
      isLoading(true);
      List<String> interests = await pref.getInterest();
      if (interests.isEmpty) {
        errorMessage('No interests found.');
        return;
      }
      String interestsQuery = interests.map((interest) => '"$interest"').join(' OR ');
      NewsModel newsModel = await _newsRepo.fetchEverythingNews(
        search: interestsQuery,
        page: page.value.toString(),
        pageSize: pageSize.value.toString(),
        sortBy: currentSort.value,
      );
      everyThingNews.value = _removeDuplicates(newsModel.articles ?? []);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchMoreNews() async {
    try {
      isLoadingMore(true);
      page.value++;
      List<String> interests = await pref.getInterest();
      String interestsQuery = interests.map((interest) => '"$interest"').join(' OR ');
      NewsModel newsModel = await _newsRepo.fetchEverythingNews(
        search: interestsQuery,
        page: page.value.toString(),
        pageSize: pageSize.value.toString(),
        sortBy: currentSort.value,
      );
      everyThingNews.addAll(_removeDuplicates(newsModel.articles ?? []));
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoadingMore(false);
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

import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:newzent/model/news/news_model.dart';
import 'package:newzent/repository/news_repo.dart';

class FeedNewsController extends GetxController {
  final NewsRepo _newsRepo = NewsRepo();

  RxInt page = 1.obs;
  RxInt pageSize = 10.obs;
  RxList<Articles> everyThingNews = <Articles>[].obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs;
  RxList<String> sortBy = ['relevancy', 'popularity', 'publishedAt'].obs;
  RxString currentSort = 'relevancy'.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEveryThingNews();
  }
Future<void> fetchEveryThingNews() async {
  try {
    isLoading(true);
    // String interestsQuery = AuthController().interests.map((interest) => '"$interest"').join(' OR ');
    NewsModel newsModel = await _newsRepo.fetchEverythingNews(
      // search: AuthController().interests.first,
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
      NewsModel newsModel = await _newsRepo.fetchEverythingNews(
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

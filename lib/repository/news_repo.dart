import 'package:newzent/data/network/network_api_services.dart';
import 'package:newzent/model/news/news_model.dart';
import 'package:newzent/resources/constants/string/app_string.dart';

class NewsRepo {
  final NetworkApiServices _apiService = NetworkApiServices();

  Future<NewsModel> fetchEverythingNews({
    String? search,
    String? from,
    String? to,
    String? sortBy,
    String? pageSize,
    String? page,
  }) async {
    final headers = {
      'X-Api-Key': AppString.apiKey,
    };

    final params = {
      'q': search ?? 'india',
      'sortBy': sortBy,
      'pageSize': pageSize,
      'page': page,
    };
    params.removeWhere((key, value) => value == null);

    try {
      final response = await _apiService.getApi(AppString.everythingBasePoint,
          headers: headers, params: params);
      print("$response in fetcheverything controller");
      return NewsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<NewsModel> fetchTopNews({
    String? search,
    String? pageSize,
    String? page,
    String? country,
    String? category,
    String? sources,
  }) async {
    final headers = {
      'X-Api-Key': AppString.apiKey,
    };

    final params = {
      'country': country ?? 'us',
      'q': search,
      'pageSize': pageSize,
      'page': page,
      'sources': sources,
      'category': category,
    };
    params.removeWhere((key, value) => value == null);

    try {
      final response = await _apiService.getApi(AppString.topHeadlineBasePoint,
          headers: headers, params: params);
      print('${response} response fetchtopnews');
      return NewsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}

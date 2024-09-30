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
    // DateTime now = DateTime.now();

    final params = {
      'q': search ?? 'india',     
       // 'from': from ?? DateTime(now.year, now.month - 3, now.day).toIso8601String() ,
      // 'to': to ?? now.toIso8601String(),

      'sortBy': sortBy,
      'pageSize': pageSize,
      'page': page,
    };
    params.removeWhere((key, value) => value == null);

    try {
      final response = await _apiService.getApi(AppString.everythingBasePoint,
          headers: headers, params: params);
      return NewsModel.fromJson(response);
    } catch (e) {
      // Handle exception as needed
      rethrow;
    }
  }

  Future<NewsModel> fetchTopNews(
      {String? search,
      String? pageSize,
      String? page,
      String? country,
      String? category,
      String? sources}) async {
    final headers = {
      'X-Api-Key': AppString.apiKey,
    };

    final params = {
      'country': country ?? 'in',
      'q': search,
      'pageSize': pageSize,
      'page': page,
      'sources': sources,
      'category': category
    };
    params.removeWhere((key, value) => value == null);

    try {
      final response = await _apiService.getApi(AppString.topHeadlineBasePoint,
          headers: headers, params: params);
      return NewsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}

import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:news_application/features/news/repository/news_model.dart';
import 'package:http/http.dart' as http;

abstract class NewsDataSource {
  Future<Either<GetNewsResponseModel, Error>> getNews(String? topic);
}

class NewsDataSourceImpl implements NewsDataSource {
  static const _baseUrl = "https://newsdata.io/api/1/latest";
  static const _apiKey = "pub_52213c64873d4d1e7f4aff5dbe027f38f4c6f";

  @override
  Future<Either<GetNewsResponseModel, Error>> getNews(String? topic) async {
    String url = '$_baseUrl?apikey=$_apiKey&domain=bbc&language=en';

    if (topic != null && topic.isNotEmpty) {
      url += '&category=$topic';
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final newsResponse = GetNewsResponseModel.fromJson(jsonResponse);
      return Left(newsResponse);
    } else if (response.statusCode == 429) {
      print('API limit exceeded. Please try again later.');
      return Right(Error());
    } else {
      print('Failed to fetch news. Status code: ${response.statusCode}');
      return Right(Error());
    }
  }
}

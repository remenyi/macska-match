import 'dart:io';

import 'package:http/http.dart';

import '../domain/model/cat.dart';

class RandomCatDataSource {
  Future<Cat> getRandomCat() async {
    final response = await get(Uri.parse('https://cataas.com/cat'));

    if (response.statusCode != 200) throw HttpException('${response.statusCode}');

    return Cat(picture: response.bodyBytes);
  }
}

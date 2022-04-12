import 'dart:convert';

import 'package:cleanarchitecturefluterrando/modules/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  
  final String titleR;
  final String contentR;
  final String imgR;

  ResultSearchModel({required this.titleR, required this.contentR, required this.imgR}) : super(content: contentR, img: imgR, title: titleR);

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'titleR': titleR});
    result.addAll({'contentR': contentR});
    result.addAll({'imgR': imgR});
  
    return result;
  }

  factory ResultSearchModel.fromMap(Map<String, dynamic> map) {
    return ResultSearchModel(
      titleR: map['login'] ?? '',
      contentR: (map['id'] ?? '').toString(),
      imgR: map['avatar_url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultSearchModel.fromJson(String source) => ResultSearchModel.fromMap(json.decode(source));
}

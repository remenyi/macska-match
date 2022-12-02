import 'package:cloud_firestore/cloud_firestore.dart';

class CatUriModel {
  final String uri;
  final Timestamp timestamp;

  CatUriModel({required this.uri, required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'uri': uri,
      'timestamp': timestamp,
    };
  }
}

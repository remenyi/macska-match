import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CatUriModel extends Equatable {
  final String uri;
  final Timestamp timestamp;

  const CatUriModel({required this.uri, required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'uri': uri,
      'timestamp': timestamp,
    };
  }

  @override
  List<Object?> get props => [uri];
}

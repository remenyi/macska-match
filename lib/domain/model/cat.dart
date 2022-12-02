import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Cat extends Equatable {
  final Uint8List picture;
  late final String _hash;

  Cat({
    required this.picture,
  }) {
    _hash = String.fromCharCodes(picture);

  }

  @override
  List<Object?> get props => [_hash];
}

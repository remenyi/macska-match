import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Cat extends Equatable {
  final Uint8List picture;

  const Cat({
    required this.picture,
  });

  @override
  List<Object?> get props => [picture.hashCode];
}

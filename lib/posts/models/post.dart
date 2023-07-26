import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/posts/models/adventure_model.dart';

final class Post extends Equatable {
  Post({required this.adventureModel});

  // final int id;
  // final String title;
  // final String body;
  final AdventureModel adventureModel;
  bool isVisible = false;

  @override
  List<Object> get props => [adventureModel, isVisible];
}

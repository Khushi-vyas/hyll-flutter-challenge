import 'package:equatable/equatable.dart';

final class Post extends Equatable {
  Post({required this.id, required this.title, required this.body});

  final int id;
  final String title;
  final String body;
  bool isVisible = false;

  @override
  List<Object> get props => [id, title, body, isVisible];
}

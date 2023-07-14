import 'dart:convert';

import 'package:http/http.dart' as http;

import '../posts/models/post.dart';

class PostRepository {
  PostRepository(this.httpClient);
  final _postLimit = 10;
  late final http.Client httpClient;
  String userUrl = 'jsonplaceholder.typicode.com';

  Future<List<Post>> fetchPosts([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https(
        userUrl,
        '/posts',
        <String, String>{'_start': '$startIndex', '_limit': '$_postLimit'},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return Post(
          id: map['id'] as int,
          title: map['title'] as String,
          body: map['body'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }
}

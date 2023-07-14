import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/posts/widgets/bottom_loader.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../bloc/post_bloc.dart';
import '../widgets/post_list_item.dart';

class PostsList extends StatelessWidget {
  final controller = SwipableStackController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        switch (state.status) {
          case PostStatus.failure:
            return const Center(child: Text('failed to fetch posts'));
          case PostStatus.success:
            if (state.posts.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            state.posts[0].isVisible = true;
            return SwipableStack(
              controller: controller,
              onSwipeCompleted: (index, swipe) {
                ScaffoldMessenger.of(context)
                  ..clearSnackBars()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(
                          swipe == SwipeDirection.left ? "rejected" : "saved"),
                    ),
                  );

                if (index == controller.currentIndex) {
                  state.posts[index + 1].isVisible = true;
                }
                if (index == state.posts.length - 2) {
                  context.read<PostBloc>().add(PostFetched());
                }
              },
              builder: (context, properties) {
                return properties.index >= state.posts.length
                    ? const BottomLoader()
                    : PostListItem(
                        post: state.posts[properties.index],
                      );
              },
              allowVerticalSwipe: false,
            );

          case PostStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

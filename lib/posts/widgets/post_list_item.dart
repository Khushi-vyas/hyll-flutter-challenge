import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

import '../models/post.dart';

class PostListItem extends StatelessWidget {
  PostListItem({required this.post, super.key});
  final StoryController controller = StoryController();
  final Post post;

  @override
  Widget build(BuildContext context) {
    print(post.adventureModel.id);
    final textTheme = Theme.of(context).textTheme;

    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: post.isVisible
                  ? StoryView(
                      storyItems: [
                        StoryItem.text(
                          title:
                              "${post.adventureModel.id} \n\nHello world!\nStory 1. \n\nTap!",
                          backgroundColor: Colors.orange,
                          roundedTop: true,
                        ),
                        StoryItem.text(
                          title:
                              "${post.adventureModel.id} \n\nHello world!\nStory 2. \n\nTap!",
                          backgroundColor: Colors.blue,
                          roundedTop: true,
                        ),
                      ],
                      controller: controller,
                    )
                  : Offstage(),
            ),
            ListTile(
              leading:
                  Text('${post.adventureModel.id}', style: textTheme.bodySmall),
              title: Text("${post.adventureModel.title}"),
              isThreeLine: true,
              subtitle: Text("${post.adventureModel.primaryDescription}"),
              dense: true,
              shape:
                  RoundedRectangleBorder(side: BorderSide(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}

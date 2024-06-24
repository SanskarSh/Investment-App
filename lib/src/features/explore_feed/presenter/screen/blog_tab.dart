import 'package:flutter/material.dart';
import 'package:investment_app/src/features/explore_feed/data/video_api_service.dart';
import 'package:investment_app/src/features/explore_feed/model/blog_model.dart';

class BlogTab extends StatelessWidget {
  const BlogTab({super.key});

  @override
  Widget build(BuildContext context) {
    final blogApiService = VideoApiService();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: FutureBuilder<List<VideoModel>>(
        future: blogApiService.getVideos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No modules available.'));
          } else {
            final blogTileData = snapshot.data!;
            return buildBody(blogTileData);
          }
        },
      ),
    );
  }

  ListView buildBody(List<VideoModel> blogTileData) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: blogTileData.length,
      itemBuilder: (context, index) {
        final blog = blogTileData[index];
        return ListTile(
          title: Text(blog.title),
          subtitle: Text(blog.description),
        );
      },
    );
  }
}

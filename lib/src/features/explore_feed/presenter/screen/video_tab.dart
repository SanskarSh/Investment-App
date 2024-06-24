import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:investment_app/src/features/explore_feed/data/video_api_service.dart';
import 'package:investment_app/src/features/explore_feed/model/blog_model.dart';

class VideoTab extends StatelessWidget {
  const VideoTab({Key? key}) : super(key: key);

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
        return BuildVideoCard(blog: blog);
      },
    );
  }
}

class BuildVideoCard extends StatelessWidget {
  final VideoModel blog;

  const BuildVideoCard({required this.blog, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String videoCode = YoutubePlayer.convertUrlToId(blog.videoUrl)!;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return VideoPlayerScreen(
              title: blog.title,
              videoUrl: blog.videoUrl,
            );
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        height: 200,
        width: double.infinity,
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://img.youtube.com/vi/$videoCode/hqdefault.jpg"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.primary.withOpacity(.1),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(.1),
                Theme.of(context).colorScheme.primary.withOpacity(.8),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  blog.title,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        height: 1.2,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Text(
                  blog.description,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withOpacity(.8),
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatelessWidget {
  final String title;
  final String videoUrl;

  const VideoPlayerScreen(
      {super.key, required this.videoUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    return Container(
      height: 350,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Center(
        child: Column(
          children: [
            Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.blueAccent,
                  progressColors: const ProgressBarColors(
                    playedColor: Colors.blue,
                    handleColor: Colors.blueAccent,
                  ),
                  onReady: () {
                    // Add optional callback here
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

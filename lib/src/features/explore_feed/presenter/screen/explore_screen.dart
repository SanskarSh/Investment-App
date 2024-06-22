import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:investment_app/src/features/explore_feed/presenter/screen/blog_tab.dart';
import 'package:investment_app/src/features/explore_feed/presenter/screen/module_tab.dart';
import 'package:investment_app/src/features/explore_feed/presenter/screen/video_tab.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor:
                  Theme.of(context).colorScheme.primary.withOpacity(.5),
              indicatorColor: Theme.of(context).colorScheme.primary,
              dividerColor:
                  Theme.of(context).colorScheme.primary.withOpacity(.3),
              labelStyle: Theme.of(context).textTheme.displayMedium,
              tabs: const [
                Tab(text: 'Modules'),
                Tab(text: 'Blog'),
                Tab(text: 'Video'),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  ModuleTab(),
                  BlogTab(),
                  VideoTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:investment_app/src/features/explore_feed/model/module_model.dart';
import 'package:investment_app/src/features/explore_feed/presenter/widget/module_details_sheet.dart';
import 'package:shimmer/shimmer.dart';

class ModuleTile extends StatelessWidget {
  final ModuleModel module;

  const ModuleTile({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            buildBlogDetailsSheet(context);
          },
          child: Container(
            margin: const EdgeInsets.only(top: 8),
            height: 110,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        module.title,
                        maxLines: 2,
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  height: 1.2,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        module.description,
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(.5),
                                ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(.5),
                            size: 16,
                          ),
                          Text(
                            " ● ${module.coins}",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(.5),
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                    height: 80,
                    width: 80,
                    margin: const EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: module.image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(.1),
                          highlightColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(.2),
                          child: Container(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(.1),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
        Divider(
          color: Theme.of(context).colorScheme.primary.withOpacity(.1),
          thickness: 1,
          indent: 8,
          endIndent: 8,
        ),
      ],
    );
  }

  Future<dynamic> buildBlogDetailsSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModuleDetailsSheet(
          module: module,
        );
      },
    );
  }
}

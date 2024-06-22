import 'package:flutter/material.dart';
import 'package:investment_app/src/features/explore_feed/presenter/widget/module_details_sheet.dart';

class ModuleTile extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String imageUrl;

  const ModuleTile({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
  });

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
                        title,
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
                        description,
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
                            " ● $date",
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
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
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
          title: title,
          description: description,
          imageUrl: imageUrl,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:investment_app/src/features/leaderboard/data/leaderboard_api_services.dart';
import 'package:investment_app/src/features/leaderboard/model/leaderboard_model.dart';
import 'package:ionicons/ionicons.dart';

class LeaderBoardScreen extends StatelessWidget {
  const LeaderBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary.withOpacity(.1),
          ),
        ),
        FutureBuilder<List<LeaderBoardModel>>(
          future: LeaderBoardApiServices().getUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No modules available.'));
            } else {
              final usersData = snapshot.data!;
              return Column(
                children: [
                  SizedBox(
                    height: size.height * 0.3,
                    width: size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Spacer(),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.only(top: 20),
                            width: 100,
                            height: size.height * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              color: Colors.brown[600],
                            ),
                            child: Text(
                              "2",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    fontSize: 40,
                                  ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            alignment: Alignment.topCenter,
                            width: 100,
                            height: size.height * 0.2,
                            decoration: BoxDecoration(
                              color: Colors.teal[900]?.withOpacity(.8),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Text(
                              "1",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    fontSize: 40,
                                  ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.only(top: 20),
                            width: 100,
                            height: size.height * 0.1,
                            decoration: BoxDecoration(
                              color: Colors.orange[400],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Text(
                              "3",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    fontSize: 40,
                                  ),
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        child: ListView.builder(
                            itemCount: usersData.length,
                            itemBuilder: (context, index) {
                              final userData = usersData[index];
                              return buildLeaderBoardActor(
                                context,
                                "${index + 1}",
                                userData.name,
                                userData.coins.toString(),
                                userData.isCurrentUser,
                              );
                            }),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  Row buildLeaderBoardActor(
    BuildContext context,
    String index,
    String name,
    String coins,
    bool isCurrentUser,
  ) {
    return Row(
      children: [
        Text(
          index,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(left: 20, bottom: 8),
            height: 90,
            decoration: BoxDecoration(
              border: Border.all(
                color: isCurrentUser
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.transparent,
              ),
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                    ),
                    Text(
                      "$coins pts",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(.5),
                          ),
                    ),
                  ],
                ),
                const Spacer(),
                Icon(
                  Ionicons.caret_up,
                  color: Colors.green[300],
                  size: 32,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

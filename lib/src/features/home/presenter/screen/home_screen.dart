import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:investment_app/src/config/routes/app_route_const.dart';
import 'package:investment_app/src/features/home/data/source/category_data.dart';
import 'package:investment_app/src/features/home/presenter/widget/category_grid.dart';
import 'package:investment_app/src/features/home/presenter/widget/notification_card.dart';
import 'package:ionicons/ionicons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const NotificationCard(),
            const SizedBox(height: 16),
            Row(
              children: [
                buildBalanceButton(context),
                const SizedBox(width: 16),
                buildPortfolioButton(context),
              ],
            ),
            buildRetirementGoalButton(context),
            const SizedBox(height: 16),
            buildRecentTransaction(context),
          ],
        ),
      ),
    );
  }

  Expanded buildPortfolioButton(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => context.goNamed(RouteNames.investment),
        child: Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "30,000.60",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.green,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Portfolio",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(color: Colors.green),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded buildBalanceButton(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => context.goNamed(RouteNames.balance),
        child: Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "₹36,490.29",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Balance",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(.5),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildRetirementGoalButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => context.goNamed(RouteNames.retirement),
            child: Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      "-₹20,884,250",
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Retirement Goal",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(.5),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column buildRecentTransaction(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => const AllCategories(),
                    );
                  },
                  child: Icon(
                    Ionicons.chevron_forward,
                    size: 24,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            children: List.generate(
              categoryMapData.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: buildTransaction(
                    context,
                    categoryMapData[index]['icon'],
                    categoryMapData[index]['color'],
                    categoryMapData[index]['title'],
                    categoryMapData[index]['amount'],
                    categoryMapData[index]['date'],
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  Widget buildTransaction(
    BuildContext context,
    IconData icon,
    Color color,
    String title,
    String amount,
    String date,
  ) {
    return Container(
      color: Theme.of(context).colorScheme.onPrimary,
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: color.withOpacity(.1),
              ),
              child: Icon(
                icon,
                color: color,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  Text(
                    date,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w200,
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(.3),
                        ),
                  ),
                ],
              ),
            ),
            Text(
              "- $amount",
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

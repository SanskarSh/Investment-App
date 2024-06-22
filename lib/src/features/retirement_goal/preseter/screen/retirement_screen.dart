import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:investment_app/src/config/routes/app_route_const.dart';
import 'package:investment_app/src/features/home/presenter/widget/line_graph.dart';
import 'package:ionicons/ionicons.dart';

class RetirementScreen extends StatelessWidget {
  const RetirementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () => context.pushReplacementNamed(RouteNames.home),
          child: Icon(
            Ionicons.chevron_back,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        title: Text(
          'Retirement Predictions',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Current Savings",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w100,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(.5),
                      ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: FittedBox(
                        child: Text(
                          "₹4,00,000",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "+120 / 12%",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          FittedBox(
                            child: Text(
                              "Last Income / Goal",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w100,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(.5),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const Expanded(
            child: Card(
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: LineChartSample2(),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Card(
                            elevation: 0,
                            color: Theme.of(context).colorScheme.surface,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.blue.withOpacity(.5),
                                      width: 10,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: FittedBox(
                                    child: Text(
                                      "24%",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium
                                          ?.copyWith(
                                            color: Colors.blue,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Card(
                            elevation: 0,
                            color: Theme.of(context).colorScheme.surface,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Spacer(),
                                  Expanded(
                                    flex: 3,
                                    child: FittedBox(
                                      child: Text(
                                        "₹2189.00",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Monthly Goal",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w100,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(.5),
                                        ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Card(
                      elevation: 0,
                      color: Theme.of(context).colorScheme.surface,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Ionicons.wallet_outline,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Spacer(),
                                Expanded(
                                  flex: 3,
                                  child: FittedBox(
                                    child: Text(
                                      "₹2189.00",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Monthly Income",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w100,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(.5),
                                      ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

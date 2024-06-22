import 'package:flutter/material.dart';
import 'package:investment_app/src/features/home/presenter/widget/line_graph.dart';
import 'package:ionicons/ionicons.dart';

class TransactionsScreen extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  const TransactionsScreen(
      {super.key,
      required this.icon,
      required this.color,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.surface,
            foregroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Ionicons.chevron_back,
                size: 24,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            title: Text(
              "-\$ 5480.00",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
          body: Column(
            children: [
              const Card(
                margin: EdgeInsets.all(16),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: LineChartSample2(),
                ),
              ),
              const SizedBox(height: 32),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Transactions",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Column(
                        children: [
                          buildTransaction(context, icon, color, title),
                          const SizedBox(height: 4),
                          buildTransaction(context, icon, color, title),
                          const SizedBox(height: 4),
                          buildTransaction(context, icon, color, title),
                          const SizedBox(height: 4),
                          buildTransaction(context, icon, color, title),
                          const SizedBox(height: 4),
                          buildTransaction(context, icon, color, title),
                          const SizedBox(height: 4),
                          buildTransaction(context, icon, color, title),
                          const SizedBox(height: 4),
                          buildTransaction(context, icon, color, title),
                          const SizedBox(height: 4),
                          buildTransaction(context, icon, color, title),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTransaction(
      BuildContext context, IconData icon, Color color, String title) {
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
                    "18 Sep 2021",
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
              "- ₹500",
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

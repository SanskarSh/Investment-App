import 'package:flutter/material.dart';
//     // return Card(
//     //   margin: const EdgeInsets.only(top: 20),
//     //   child: Padding(
//     //     padding: const EdgeInsets.all(16.0),
//     //     child: Column(
//     //       crossAxisAlignment: CrossAxisAlignment.start,
//     //       children: [
//     //         Text(
//     //           companyName,
//     //           style: const TextStyle(
//     //             fontWeight: FontWeight.bold,
//     //             fontSize: 18,
//     //           ),
//     //         ),
//     //         const SizedBox(height: 8),
//     //         Text("Symbol: ${meta['symbol']}"),
//     //         Text("Exchange: ${meta['fullExchangeName']}"),
//     //         Text("Market Price: \$${meta['regularMarketPrice']}"),
//     //         Text("52 Week High: \$${meta['fiftyTwoWeekHigh']}"),
//     //         Text("52 Week Low: \$${meta['fiftyTwoWeekLow']}"),
//     //         Text("Day High: \$${regularData['start']}"),
//     //         Text("Day Low: \$${regularData['end']}"),
//     //         Text("Volume: ${meta['regularMarketVolume']}"),
//     //       ],
//     //     ),
//     //   ),
//     // );

class StockDataTile extends StatelessWidget {
  final String companyName;
  final Map<String, dynamic> data;

  const StockDataTile({
    super.key,
    required this.companyName,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? meta = data['meta'];
    double highest = meta?['fiftyTwoWeekHigh']?.toDouble() ?? 0.0;
    double current = meta?['regularMarketPrice']?.toDouble() ?? 0.0;
    double changeInPercent =
        current != 0 ? ((highest - current) / current) * 100 : 0.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          companyName,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        subtitle: Text("Symbol: ${meta?['symbol'] ?? 'N/A'}"),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "\$${highest.toString().substring(0, 3)}",
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            Text(
              "+${changeInPercent.toString().substring(0, 3)}%",
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.greenAccent,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:investment_app/src/config/routes/app_route_const.dart';
import 'package:ionicons/ionicons.dart';
import 'package:yahoo_finance_data_reader/yahoo_finance_data_reader.dart';

class InvestmentScreen extends StatefulWidget {
  const InvestmentScreen({super.key});

  @override
  State<InvestmentScreen> createState() => _InvestmentScreenState();
}

class _InvestmentScreenState extends State<InvestmentScreen> {
  final YahooFinanceDailyReader yahooFinanceDataReader =
      const YahooFinanceDailyReader();

  final Map<String, String> stockTickers = {
    "Alphabet Inc. (Class A)": "GOOGL",
    "Alphabet Inc. (Class C)": "GOOG",
    "Apple Inc.": "AAPL",
    "Microsoft Corporation": "MSFT",
    "Amazon.com, Inc.": "AMZN",
    "Facebook, Inc.": "META",
    "Tesla, Inc.": "TSLA",
    "Johnson & Johnson": "JNJ",
    "JPMorgan Chase & Co.": "JPM",
    "Visa Inc.": "V",
    "Walmart Inc.": "WMT",
    "Procter & Gamble Co.": "PG",
    "NVIDIA Corporation": "NVDA",
    "The Coca-Cola Company": "KO",
    "PepsiCo, Inc.": "PEP",
    "Intel Corporation": "INTC",
    "Cisco Systems, Inc.": "CSCO",
    "Merck & Co., Inc.": "MRK",
    "Pfizer Inc.": "PFE",
    "Exxon Mobil Corporation": "XOM",
    "Chevron Corporation": "CVX",
    "AT&T Inc.": "T",
    "Verizon Communications Inc.": "VZ",
    "The Walt Disney Company": "DIS",
    "Netflix, Inc.": "NFLX",
    "The Boeing Company": "BA",
    "McDonald's Corporation": "MCD",
    "Nike, Inc.": "NKE"
  };

  Future<List<Map<String, dynamic>>> getAllStockData() async {
    List<Future<Map<String, dynamic>>> futures =
        stockTickers.values.map((ticker) {
      return yahooFinanceDataReader.getDailyData(ticker);
    }).toList();
    return await Future.wait(futures);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Investment',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        leading: GestureDetector(
          onTap: () => context.pushReplacementNamed(RouteNames.home),
          child: Icon(
            Ionicons.chevron_back,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: getAllStockData(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData ||
                  snapshot.data == null ||
                  snapshot.data!.isEmpty) {
                return const Text('No data');
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  String companyName = stockTickers.keys.elementAt(index);
                  Map<String, dynamic> stockData = snapshot.data![index];
                  return StockDataWidget(
                      companyName: companyName, data: stockData);
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class StockDataWidget extends StatelessWidget {
  final String companyName;
  final Map<String, dynamic> data;

  const StockDataWidget({
    super.key,
    required this.companyName,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> meta = data['meta'];
    var highest = meta['fiftyTwoWeekHigh'];

    var current = meta['regularMarketPrice'];

    var changeInPercent = ((highest - current) / current) * 100;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title:
            Text(companyName, style: Theme.of(context).textTheme.displayMedium),
        subtitle: Text("Symbol: ${meta['symbol']}"),
        trailing: Column(
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
    // return Card(
    //   margin: const EdgeInsets.only(top: 20),
    //   child: Padding(
    //     padding: const EdgeInsets.all(16.0),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           companyName,
    //           style: const TextStyle(
    //             fontWeight: FontWeight.bold,
    //             fontSize: 18,
    //           ),
    //         ),
    //         const SizedBox(height: 8),
    //         Text("Symbol: ${meta['symbol']}"),
    //         Text("Exchange: ${meta['fullExchangeName']}"),
    //         Text("Market Price: \$${meta['regularMarketPrice']}"),
    //         Text("52 Week High: \$${meta['fiftyTwoWeekHigh']}"),
    //         Text("52 Week Low: \$${meta['fiftyTwoWeekLow']}"),
    //         Text("Day High: \$${regularData['start']}"),
    //         Text("Day Low: \$${regularData['end']}"),
    //         Text("Volume: ${meta['regularMarketVolume']}"),
    //       ],
    //     ),
    //   ),
    // );
  }
}

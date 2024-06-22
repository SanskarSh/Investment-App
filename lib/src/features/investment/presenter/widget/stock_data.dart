import 'package:flutter/material.dart';
import 'package:investment_app/src/features/investment/presenter/widget/stock_data_tile.dart';
import 'package:ionicons/ionicons.dart';
import 'package:yahoo_finance_data_reader/yahoo_finance_data_reader.dart';

class StockData extends StatefulWidget {
  final String title;
  final Map<String, String> stockTickers;

  const StockData({
    super.key,
    required this.stockTickers,
    required this.title,
  });

  @override
  State<StockData> createState() => _StockDataState();
}

class _StockDataState extends State<StockData> {
  final YahooFinanceDailyReader yahooFinanceDataReader =
      const YahooFinanceDailyReader();

  Future<List<Map<String, dynamic>>> getAllStockData() async {
    List<Future<Map<String, dynamic>>> futures =
        widget.stockTickers.values.map((ticker) {
      return yahooFinanceDataReader.getDailyData(ticker);
    }).toList();
    return await Future.wait(futures);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            widget.title,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Ionicons.close,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: getAllStockData(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data available'));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      String companyName =
                          widget.stockTickers.keys.elementAt(index);
                      Map<String, dynamic> stockData = snapshot.data![index];
                      return StockDataTile(
                          companyName: companyName, data: stockData);
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

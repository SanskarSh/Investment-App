import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:investment_app/src/config/routes/app_route_const.dart';
import 'package:investment_app/src/features/investment/presenter/widget/stock_data.dart';
import 'package:ionicons/ionicons.dart';

class InvestmentScreen extends StatelessWidget {
  const InvestmentScreen({super.key});

  void updateControllerValue(TextEditingController controller) {
    double value = double.parse(controller.text) + 1;
    controller.text = value.toString();
  }

  Widget _buildSuffixIcon(BuildContext context, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Ionicons.add,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Dummy values for the amount of each investment
    const double cryptoAmount = 1000.0;
    const double usStocksAmount = 5000.0;
    const double indianStocksAmount = 2000.0;
    const double mutualFundsAmount = 3000.0;
    const double goldAmount = 1500.0;
    const double corporateBondsAmount = 4000.0;
    const double fixedDepositsAmount = 6000.0;
    const double epfPpfAmount = 2500.0;
    const double realEstateAmount = 10000.0;

    final Map<String, String> usStocks = {
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

    final Map<String, String> indianStocks = {
      "Reliance Industries Limited": "RELIANCE.NS",
      "Tata Consultancy Services Limited": "TCS.NS",
      "HDFC Bank Limited": "HDFCBANK.NS",
      "Infosys Limited": "INFY.NS",
      "Hindustan Unilever Limited": "HINDUNILVR.NS",
      "ICICI Bank Limited": "ICICIBANK.NS",
      "State Bank of India": "SBIN.NS",
      "Bharti Airtel Limited": "BHARTIARTL.NS",
      "Kotak Mahindra Bank Limited": "KOTAKBANK.NS",
      "ITC Limited": "ITC.NS",
      "Larsen & Toubro Limited": "LT.NS",
      "Axis Bank Limited": "AXISBANK.NS",
      "Wipro Limited": "WIPRO.NS",
      "Asian Paints Limited": "ASIANPAINT.NS",
      "Bajaj Finance Limited": "BAJFINANCE.NS",
      "Maruti Suzuki India Limited": "MARUTI.NS",
      "HCL Technologies Limited": "HCLTECH.NS",
      "UltraTech Cement Limited": "ULTRACEMCO.NS",
      "Sun Pharmaceutical Industries Limited": "SUNPHARMA.NS",
      "Nestle India Limited": "NESTLEIND.NS",
      "Mahindra & Mahindra Limited": "M&M.NS",
      "Tech Mahindra Limited": "TECHM.NS",
      "Tata Steel Limited": "TATASTEEL.NS",
      "Power Grid Corporation of India Limited": "POWERGRID.NS",
      "NTPC Limited": "NTPC.NS",
      "Oil and Natural Gas Corporation Limited": "ONGC.NS",
      "IndusInd Bank Limited": "INDUSINDBK.NS",
      "Titan Company Limited": "TITAN.NS",
      "Adani Enterprises Limited": "ADANIENT.NS",
      "Bajaj Auto Limited": "BAJAJ-AUTO.NS",
      "Grasim Industries Limited": "GRASIM.NS",
      "Hindalco Industries Limited": "HINDALCO.NS",
      "Hero MotoCorp Limited": "HEROMOTOCO.NS",
      "Coal India Limited": "COALINDIA.NS",
      "Dr. Reddy's Laboratories Limited": "DRREDDY.NS",
      "Divi's Laboratories Limited": "DIVISLAB.NS",
      "Britannia Industries Limited": "BRITANNIA.NS",
      "Cipla Limited": "CIPLA.NS",
      "Bharat Petroleum Corporation Limited": "BPCL.NS",
      "Eicher Motors Limited": "EICHERMOT.NS",
      "Shree Cement Limited": "SHREECEM.NS",
      "Tata Motors Limited": "TATAMOTORS.NS",
      "SBI Life Insurance Company Limited": "SBILIFE.NS",
      "Indian Oil Corporation Limited": "IOC.NS",
      "Hindustan Zinc Limited": "HINDZINC.NS",
      "Vedanta Limited": "VEDL.NS",
      "JSW Steel Limited": "JSWSTEEL.NS",
      "Godrej Consumer Products Limited": "GODREJCP.NS",
      "Pidilite Industries Limited": "PIDILITIND.NS",
      "Adani Green Energy Limited": "ADANIGREEN.NS",
      "Tata Power Company Limited": "TATAPOWER.NS",
      "Bajaj Finserv Limited": "BAJAJFINSV.NS",
      "Zee Entertainment Enterprises Limited": "ZEEL.NS",
    };

    final Map<String, String> indexMutualFundsTickers = {
      "HDFC Index Fund - Nifty 50 Plan": "0P0000XVBF.BO",
      "Axis Bank Limited": "AXISBANK.NS",
      "Wipro Limited": "WIPRO.NS",
      "Asian Paints Limited": "ASIANPAINT.NS",
      "Bajaj Finance Limited": "BAJFINANCE.NS",
      "Maruti Suzuki India Limited": "MARUTI.NS",
      "HCL Technologies Limited": "HCLTECH.NS",
      "UltraTech Cement Limited": "ULTRACEMCO.NS",
      "Sun Pharmaceutical Industries Limited": "SUNPHARMA.NS",
      "Nestle India Limited": "NESTLEIND.NS",
      "Mahindra & Mahindra Limited": "M&M.NS",
      "Tech Mahindra Limited": "TECHM.NS",
      "Tata Steel Limited": "TATASTEEL.NS",
      "Power Grid Corporation of India Limited": "POWERGRID.NS",
      "NTPC Limited": "NTPC.NS",
      "Oil and Natural Gas Corporation Limited": "ONGC.NS",
      "IndusInd Bank Limited": "INDUSINDBK.NS",
      "Titan Company Limited": "TITAN.NS",
      "Adani Enterprises Limited": "ADANIENT.NS",
      "Bajaj Auto Limited": "BAJAJ-AUTO.NS",
      "Grasim Industries Limited": "GRASIM.NS",
      "Hindalco Industries Limited": "HINDALCO.NS",
      "Hero MotoCorp Limited": "HEROMOTOCO.NS",
      "Coal India Limited": "COALINDIA.NS",
      "Dr. Reddy's Laboratories Limited": "DRREDDY.NS",
      "Divi's Laboratories Limited": "DIVISLAB.NS",
      "Britannia Industries Limited": "BRITANNIA.NS",
      "Cipla Limited": "CIPLA.NS",
      "Bharat Petroleum Corporation Limited": "BPCL.NS",
      "Eicher Motors Limited": "EICHERMOT.NS",
      "Shree Cement Limited": "SHREECEM.NS",
      "Tata Motors Limited": "TATAMOTORS.NS",
      "SBI Life Insurance Company Limited": "SBILIFE.NS",
      "Indian Oil Corporation Limited": "IOC.NS",
      "Hindustan Zinc Limited": "HINDZINC.NS",
      "Vedanta Limited": "VEDL.NS",
      "JSW Steel Limited": "JSWSTEEL.NS",
      "Godrej Consumer Products Limited": "GODREJCP.NS",
      "Pidilite Industries Limited": "PIDILITIND.NS",
      "Adani Green Energy Limited": "ADANIGREEN.NS",
      "Tata Power Company Limited": "TATAPOWER.NS",
      "Bajaj Finserv Limited": "BAJAJFINSV.NS",
      "Zee Entertainment Enterprises Limited": "ZEEL.NS",
    };

    final TextEditingController cryptoController =
        TextEditingController(text: (cryptoAmount - cryptoAmount).toString());
    final TextEditingController usStocksController = TextEditingController(
        text: (usStocksAmount - usStocksAmount).toString());
    final TextEditingController indianStocksController = TextEditingController(
        text: (indianStocksAmount - indianStocksAmount).toString());
    final TextEditingController mutualFundsController = TextEditingController(
        text: (mutualFundsAmount - mutualFundsAmount).toString());
    final TextEditingController goldController =
        TextEditingController(text: (goldAmount - goldAmount).toString());
    final TextEditingController corporateBondsController =
        TextEditingController(
            text: (corporateBondsAmount - corporateBondsAmount).toString());
    final TextEditingController fixedDepositsController = TextEditingController(
        text: (fixedDepositsAmount - fixedDepositsAmount).toString());
    final TextEditingController epfPpfController =
        TextEditingController(text: (epfPpfAmount - epfPpfAmount).toString());
    final TextEditingController realEstateController = TextEditingController(
        text: (realEstateAmount - realEstateAmount).toString());

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Investment'),
        leading: GestureDetector(
          onTap: () => context.pushReplacementNamed(RouteNames.home),
          child: Icon(
            Ionicons.chevron_back,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  readOnly: true,
                  controller: cryptoController,
                  decoration: InputDecoration(
                    prefix: Text("${cryptoAmount.toString()} / "),
                    suffix: _buildSuffixIcon(
                      context,
                      () {
                        // Call the updateControllerValue function
                        updateControllerValue(cryptoController);
                      },
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'Cryptocurrency',
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        controller: usStocksController,
                        decoration: InputDecoration(
                          prefix: Text("${usStocksAmount.toString()} / "),
                          suffix: _buildSuffixIcon(context, () {
                            // Call the updateControllerValue function
                            updateControllerValue(usStocksController);
                          }),
                          border: const OutlineInputBorder(),
                          labelText: 'US Stocks',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return StockData(
                              title: 'US Stocks',
                              stockTickers: usStocks,
                            );
                          },
                        );
                      },
                      child: const Icon(Ionicons.chevron_forward),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        controller: indianStocksController,
                        decoration: InputDecoration(
                          prefix: Text("${indianStocksAmount.toString()} / "),
                          suffix: _buildSuffixIcon(context, () {
                            // Call the updateControllerValue function
                            updateControllerValue(indianStocksController);
                          }),
                          border: const OutlineInputBorder(),
                          labelText: 'Direct Indian Stocks',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return StockData(
                              title: 'Direct Indian Stocks',
                              stockTickers: indianStocks,
                            );
                          },
                        );
                      },
                      child: const Icon(Ionicons.chevron_forward),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        controller: mutualFundsController,
                        decoration: InputDecoration(
                          prefix: Text("${mutualFundsAmount.toString()} / "),
                          suffix: _buildSuffixIcon(context, () {
                            // Call the updateControllerValue function
                            updateControllerValue(mutualFundsController);
                          }),
                          border: const OutlineInputBorder(),
                          labelText: 'Index Mutual Funds',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return StockData(
                              title: 'Index Mutual Funds',
                              stockTickers: indexMutualFundsTickers,
                            );
                          },
                        );
                      },
                      child: const Icon(Ionicons.chevron_forward),
                    ),
                  ],
                ),
                TextFormField(
                  readOnly: true,
                  controller: goldController,
                  decoration: InputDecoration(
                    prefix: Text("${goldAmount.toString()} / "),
                    suffix: _buildSuffixIcon(context, () {
                      // Call the updateControllerValue function
                      updateControllerValue(goldController);
                    }),
                    border: const OutlineInputBorder(),
                    labelText: 'Gold',
                  ),
                ),
                TextFormField(
                  readOnly: true,
                  controller: corporateBondsController,
                  decoration: InputDecoration(
                    prefix: Text("${corporateBondsAmount.toString()} / "),
                    suffix: _buildSuffixIcon(context, () {
                      // Call the updateControllerValue function
                      updateControllerValue(corporateBondsController);
                    }),
                    border: const OutlineInputBorder(),
                    labelText: 'Corporate Bonds',
                  ),
                ),
                TextFormField(
                  readOnly: true,
                  controller: fixedDepositsController,
                  decoration: InputDecoration(
                    prefix: Text("${fixedDepositsAmount.toString()} / "),
                    suffix: _buildSuffixIcon(context, () {
                      // Call the updateControllerValue function
                      updateControllerValue(fixedDepositsController);
                    }),
                    border: const OutlineInputBorder(),
                    labelText: 'Fixed Deposits',
                  ),
                ),
                TextFormField(
                  readOnly: true,
                  controller: epfPpfController,
                  decoration: InputDecoration(
                    prefix: Text("${epfPpfAmount.toString()} / "),
                    suffix: _buildSuffixIcon(context, () {
                      // Call the updateControllerValue function
                      updateControllerValue(epfPpfController);
                    }),
                    border: const OutlineInputBorder(),
                    labelText: 'EPF/PPF',
                  ),
                ),
                TextFormField(
                  readOnly: true,
                  controller: realEstateController,
                  decoration: InputDecoration(
                    prefix: Text("${realEstateAmount.toString()} / "),
                    suffix: _buildSuffixIcon(context, () {
                      // Call the updateControllerValue function
                      updateControllerValue(realEstateController);
                    }),
                    border: const OutlineInputBorder(),
                    labelText: 'Real Estate',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

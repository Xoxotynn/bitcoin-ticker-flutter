import 'package:bitcoin_ticker/rate_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currentCurrency = 'BRL';
  CoinData coinData = CoinData();
  var currencyData;

  @override
  void initState() {
    super.initState();
    getCurrentCoinData(1);
  }

  void getCurrentCoinData(int value) async {
    currencyData = await coinData.getCoinData(currenciesList[value]);
    setState(() {
      currentCurrency = currenciesList[value];
    });
  }

  List<Widget> getRateCards() {
    List<Widget> rateCards = [];

    for (var coin in cryptoList) {
      var rate;
      try {
        rate = currencyData[coin][currentCurrency];
        rateCards.add(Padding(
          padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
          child: RateCard(
            currentCoin: coin,
            rate: rate,
            currentCurrency: currentCurrency,
          ),
        ));
      } catch (e) {
        print(e);
      }
    }

    return rateCards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            '🤑 Coin Ticker',
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ListView(
              children: getRateCards(),
            ),
          ),
          Container(
            height: 256.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: CupertinoPicker(
              itemExtent: 64,
              scrollController: FixedExtentScrollController(initialItem: 1),
              onSelectedItemChanged: (value) {
                getCurrentCoinData(value);
              },
              useMagnifier: false,
              children: currenciesList
                  .map((value) => Center(
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

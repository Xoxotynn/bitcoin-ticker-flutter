import 'package:bitcoin_ticker/network.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC', 'DOT'];

class CoinData {
  Future<dynamic> getCoinData(String currency) async {
    String coins = '';
    for (var coin in cryptoList) {
      coins += coin + ',';
    }

    String url =
        'https://min-api.cryptocompare.com/data/pricemulti?fsyms=$coins&tsyms=$currency';
    NetworkHelper networkHelper = NetworkHelper(url);

    var coinData = await networkHelper.getData();
    return coinData;
  }
}

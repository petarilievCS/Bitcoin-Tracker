import 'package:http/http.dart' as http;
import 'dart:convert';

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

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<double> getCoinData(String currency, String crypto) async {
    http.Response response = await http.get(Uri.https(
        'rest.coinapi.io',
        '/v1/exchangerate/$crypto/$currency',
        {'apikey': 'C3A3969D-1FF0-4984-BF25-3E6F825FE29E'}));

    dynamic data = jsonDecode(response.body);
    return data['rate'];
  }
}

// ignore_for_file: unused_import, unused_local_variable

import 'networking.dart';
import 'package:bitcoin_ticker/coin_data.dart';
const apiKey = '8202DB2C-5FFA-4A77-883C-632B8EFC7DA7';

class CurrencyModel{
  Future<dynamic> getCoinPrice(String coinName, String currency) async {
    NetworkHelper networkHelper = NetworkHelper('https://rest.coinapi.io/v1/exchangerate/$coinName/$currency?apikey=8202DB2C-5FFA-4A77-883C-632B8EFC7DA7#');

    var coinPrice = await networkHelper.getData();
    return coinPrice;

  }
}
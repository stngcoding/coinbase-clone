import 'dart:convert';
import 'package:coinbase_clone/model/coin_data.dart';

import '../model/coin.dart';
import '../model/data_error.dart';
import 'package:http/http.dart' as http;

class CoinRepository {
  static const String _baseUrl = "https://min-api.cryptocompare.com/";

  ///Its fetches the data from the PAI and returns a list of Coin objects
  ///
  ///Returns:
  /// A list of coin objects

  static Future<List<Coin>> getCoins() async {
    const requestUrl =
        '${_baseUrl}data/top/totalvolfull?limit=25&tsym=USD&page=0';

    try {
      final response = await http.Client().get(Uri.parse(requestUrl));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final data = json["Data"] as List<dynamic>;
        //Mapping the data to Coin objects
        return data.map((e) {
          //Mapping the data that comes from JSON to Coin objects
          return Coin.fromMap(e);
        }).toList();
      } else {
        throw Exception("Failed to load currencies");
      }
    } catch (err) {
      throw DataError(message: err.toString());
    }
  }

  static Future<List<CoinData>> getCoinHourlyData(String ticker) async {
    final requestUrl =
        '${_baseUrl}data/v2/histohour?fsym=$ticker&tsym=USD&limit=25';

    try {
      final response = await http.Client().get(Uri.parse(requestUrl));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final data = json['Data']['Data'] as List<dynamic>;

        return data.map((e) {
          return CoinData.fromMap(e);
        }).toList();
      } else {
        throw Exception('Failed to load currencies');
      }
    } catch (err) {
      throw DataError(message: err.toString());
    }
  }
}

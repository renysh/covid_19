import 'dart:convert';

import 'package:covid19/src/model/summary_covid.model.dart';
import 'package:http/http.dart' as http;

class DataApiClient {
  final String _baseUrl = 'https://api.covid19api.com';

  Future<SummaryCovidModel> getSummary() async {
    final getSummaryUrl = '${this._baseUrl}/summary';
    final response = await http.get(getSummaryUrl);
    if (response.statusCode != 200) {
      if (response.statusCode == 401) {
        throw Exception('No autorizado');
      }
      throw Exception('error get horaries');
    }

    final horariesJson = jsonDecode(response.body);
    return SummaryCovidModel.fromJson(horariesJson);
  }
}

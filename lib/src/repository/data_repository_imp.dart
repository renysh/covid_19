import 'package:covid19/src/model/summary_covid.model.dart';

import 'data.repository.dart';
import 'data_api_client.dart';

class CovidRepositoryImp implements CovidRepository {
  DataApiClient _client = DataApiClient();

  @override
  Future<SummaryCovidModel> loadSummary() async {
    return await this._client.getSummary();
  }
}

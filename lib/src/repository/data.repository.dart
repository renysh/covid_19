import 'package:covid19/src/model/summary_covid.model.dart';

abstract class CovidRepository {
  // load summary from web service
  Future<SummaryCovidModel> loadSummary();
}

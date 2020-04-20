import 'package:covid19/src/model/countries_list.model.dart';
import 'package:covid19/src/model/summary_covid.model.dart';
import 'package:covid19/src/widgets/pie_statistics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Global globalData = Provider.of<CountriesListModel>(context).global;
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'INFORMACIÓN GLOBAL',
                style: TextStyle(fontSize: 25.0),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            RichText(
              text: TextSpan(
                text: 'Total confirmados: ',
                style: TextStyle(fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                      text: globalData.totalConfirmed.toString(),
                      style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(height: 300, child: PieStatistics()),
          ],
        ),
      ],
    );
  }
}

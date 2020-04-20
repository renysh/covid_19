import 'package:covid19/src/model/countries_list.model.dart';
import 'package:covid19/src/model/summary_covid.model.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

class PieStatistics extends StatelessWidget {
  const PieStatistics({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(_buildSeriesList(context),
        animate: true,
        behaviors: [
          charts.DatumLegend(
            outsideJustification: charts.OutsideJustification.endDrawArea,
            position: charts.BehaviorPosition.bottom,
            horizontalFirst: false,
            cellPadding: new EdgeInsets.only(right: 5.0, bottom: 4.0),
            showMeasures: true,
            legendDefaultMeasure: charts.LegendDefaultMeasure.firstValue,
            measureFormatter: (num value) {
              return value == null ? '-' : value.toString();
            },
          ),
        ],
        defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
          new charts.ArcLabelDecorator(
              outsideLabelStyleSpec: charts.TextStyleSpec(
                color: charts.Color.white,
                fontSize: 12,
              ),
              leaderLineStyleSpec: charts.ArcLabelLeaderLineStyleSpec(
                color: charts.Color.white,
                length: 20.0,
                thickness: 1.0
              ),
              
              labelPosition: charts.ArcLabelPosition.auto)
        ]));
  }

  _buildSeriesList(BuildContext context) {
    Global globalData = Provider.of<CountriesListModel>(context).global;

    int pending = globalData.totalConfirmed -
        globalData.totalDeaths -
        globalData.totalRecovered;

    final blue = charts.MaterialPalette.blue.makeShades(1);
    final red = charts.MaterialPalette.red.makeShades(1);
    final green = charts.MaterialPalette.green.makeShades(1);

    final data = [
      new LinearData('Aún contagiados', pending),
      new LinearData('Decesos', globalData.totalDeaths),
      new LinearData('Recuperados', globalData.totalRecovered),
    ];

    return [
      new charts.Series<LinearData, String>(
          id: 'Cases',
          domainFn: (LinearData cases, _) => cases.state,
          measureFn: (LinearData cases, _) => cases.cases,
          data: data,
          labelAccessorFn: (LinearData cases, _) =>
              '${double.parse(((cases.cases * 100) / globalData.totalConfirmed).toStringAsFixed(2))} %',
          colorFn: (LinearData segment, _) {
            switch (segment.state) {
              case "Aún contagiados":
                {
                  return blue[1];
                }

              case "Decesos":
                {
                  return red[1];
                }

              case "Recuperados":
                {
                  return green[1];
                }

              default:
                {
                  return red[0];
                }
            }
          }),
    ];
  }
}

/// Sample linear data type.
class LinearData {
  final String state;
  final int cases;

  LinearData(this.state, this.cases);
}

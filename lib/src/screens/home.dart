import 'package:covid19/src/model/countries_list.model.dart';
import 'package:covid19/src/model/summary_covid.model.dart';
import 'package:covid19/src/widgets/dialog_info.dart';
import 'package:covid19/src/widgets/order_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'statistics.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _tab = ValueNotifier(_HomeScreenTab.countries);

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('COVID-19'),
          actions: <Widget>[
            ValueListenableBuilder<_HomeScreenTab>(
              valueListenable: _tab,
              builder: (_, tab, __) => OrderButton(
                isActive: tab == _HomeScreenTab.countries,
              ),
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                Provider.of<CountriesListModel>(context, listen: false)
                  ..loadCountries();
              },
            )
          ],
        ),
        body: Selector<CountriesListModel, bool>(
          selector: (context, model) => model.isLoading,
          builder: (context, isLoading, _) {
            if (isLoading) {
              return Center(
                child: CircularProgressIndicator( valueColor: new AlwaysStoppedAnimation<Color>(Colors.red)),
              );
            }

            return ValueListenableBuilder<_HomeScreenTab>(
              valueListenable: _tab,
              builder: (context, tab, _) {
                switch (tab) {
                  case _HomeScreenTab.statistics:
                    return StatisticsPage();
                  case _HomeScreenTab.countries:
                  default:
                    return Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Text(
                              'Casos confirmados por País',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          _buildListCountries(
                              context,
                              Provider.of<CountriesListModel>(context)
                                  .countries)
                        ],
                      ),
                    );
                }
              },
            );
          },
        ),
        bottomNavigationBar: ValueListenableBuilder<_HomeScreenTab>(
            valueListenable: _tab,
            builder: (context, tab, _) {
              return BottomNavigationBar(
                  backgroundColor: Theme.of(context).primaryColor,
                  selectedItemColor: Colors.redAccent,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.assistant_photo),
                      title: Text('Países'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.assessment),
                      title: Text('Estadísticas'),
                    )
                  ],
                  currentIndex: _HomeScreenTab.values.indexOf(tab),
                  onTap: (int index) =>
                      _tab.value = _HomeScreenTab.values[index]);
            }));
  }

  _buildListCountries(BuildContext context, List<Country> countries) {
    return Expanded(
      child: ListView.separated(
        itemCount: countries.length,
        itemBuilder: (context, index) {
          Country country = countries[index];
          return ListTile(
            title: Text(country.country),
            trailing: Container(
              child: Text(
                country.totalConfirmed.toString(),
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => DialogInfo(
                  country: country,
                ),
              );
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }
}

enum _HomeScreenTab { countries, statistics }

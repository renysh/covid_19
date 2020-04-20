import 'package:covid19/src/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/countries_list.model.dart';
import 'screens/home.dart';

class App extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CountriesListModel()
            ..loadCountries(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'COVID-19',
        theme: CovidTheme.theme,
        home: HomePage(),
      ),
    );
  }
}

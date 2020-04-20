import 'dart:collection';

import 'package:covid19/src/repository/data.repository.dart';
import 'package:covid19/src/repository/data_repository_imp.dart';
import 'package:flutter/material.dart';

import 'summary_covid.model.dart';

enum VisibilityOrder { asc, desc }

class CountriesListModel extends ChangeNotifier {
  final CovidRepository repository = CovidRepositoryImp();

  VisibilityOrder _order;

  VisibilityOrder get order => _order;

  set order(VisibilityOrder order) {
    _order = order;
    print(_order);
    if (this._order == VisibilityOrder.asc) {
      print('ASC');
      this._countries.sort((Country a, Country b) =>
          a.totalConfirmed.compareTo(b.totalConfirmed));
    } else if (this._order == VisibilityOrder.desc) {
      print('DESC');
      this._countries.sort((Country a, Country b) =>
          -a.totalConfirmed.compareTo(b.totalConfirmed));
    }

    notifyListeners();
  }

  List<Country> _countries;

  Global _global;

  UnmodifiableListView<Country> get countries =>
      UnmodifiableListView(_countries);

  Global get global=> _global;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  CountriesListModel({VisibilityOrder order, List<Country> countries})
      : _countries = countries ?? [],
        _order = order ?? VisibilityOrder.desc;

  // Loads remote data - countries
  Future loadCountries() {
    _isLoading = true;
    notifyListeners();

    return repository.loadSummary().then((loadedSummary) {
      this._countries = loadedSummary.countries;
      this._global = loadedSummary.global;
      this._countries.sort((Country a, Country b) =>
          -a.totalConfirmed.compareTo(b.totalConfirmed));
      _isLoading = false;
      notifyListeners();
    }).catchError((err) {
      _isLoading = false;
      notifyListeners();
    });
  }
}

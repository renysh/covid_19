import 'package:covid19/src/model/countries_list.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderButton extends StatelessWidget {
  final bool isActive;
  const OrderButton({Key key, this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isActive,
      child: AnimatedOpacity(
        opacity: isActive ? 1.0 : 0.0,
        duration: Duration(milliseconds: 150),
        child: Consumer<CountriesListModel>(
          builder: (context, model, _) {
            return PopupMenuButton(
              initialValue: model.order,
              itemBuilder: (BuildContext context) => _items(context, model),
              onSelected: (order) => model.order = order,
              icon: Icon(Icons.sort),
            );
          },
        ),
      ),
    );
  }

  List<PopupMenuItem<VisibilityOrder>> _items(
      BuildContext context, CountriesListModel model) {
    final activeStyle =
        Theme.of(context).textTheme.body1.copyWith(color: Colors.redAccent);
    final defaultStyle = Theme.of(context).textTheme.body1;

    return [
      PopupMenuItem<VisibilityOrder>(
        key: Key('__ASC__'),
        value: VisibilityOrder.asc,
        child: Text(
          'Ascendente',
          style:
              model.order == VisibilityOrder.asc ? activeStyle : defaultStyle,
        ),
      ),
      PopupMenuItem<VisibilityOrder>(
        key: Key('__DESC__'),
        value: VisibilityOrder.desc,
        child: Text(
          'Descendente',
          style:
              model.order == VisibilityOrder.desc ? activeStyle : defaultStyle,
        ),
      )
    ];
  }
}

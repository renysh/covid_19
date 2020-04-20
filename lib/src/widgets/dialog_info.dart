import 'package:covid19/src/model/summary_covid.model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

class DialogInfo extends StatelessWidget {
  final Country country;
  const DialogInfo({Key key, @required this.country}) : super(key: key);

  final double padding = 16.0;
  final double avatarRadius = 35.0;

  @override
  Widget build(BuildContext context) {
    print(this.country.country);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(this.padding),
      ),
      elevation: 10.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[_buildBody(context), _buildImageHeader()],
    );
  }

  _buildBody(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.only(
        top: this.padding + this.avatarRadius,
        bottom: this.padding,
        left: this.padding,
        right: this.padding,
      ),
      margin: EdgeInsets.only(top: this.avatarRadius),
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(this.padding),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          Flexible(
            child: Text(
              this.country.country,
              style: TextStyle(
                fontSize: 24.0,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          ResponsiveGridRow(
            children: [
              ResponsiveGridCol(
                xs: 6,
                md: 3,
                child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                    alignment: Alignment(0, 0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Confirmados',
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.orangeAccent, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          this.country.totalConfirmed.toString(),
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
              ),
              ResponsiveGridCol(
                xs: 6,
                md: 3,
                child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                    alignment: Alignment(0, 0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Muertes',
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          this.country.totalDeaths.toString(),
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
              ),
              ResponsiveGridCol(
                xs: 6,
                md: 3,
                child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                    alignment: Alignment(0, 0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Recuperados',
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          this.country.totalRecovered.toString(),
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
              )
            ],
          )
        ],
      ),
    );
  }

  _buildImageHeader() {
    return Positioned(
      left: this.padding,
      right: this.padding,
      child: CircleAvatar(
        backgroundColor: Colors.redAccent,
        radius: this.avatarRadius,
        child: Icon(
          Icons.info,
          color: Colors.white,
          size: 30.0,
        ),
      ),
    );
  }
}

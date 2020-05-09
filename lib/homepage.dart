import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List currencies;
  HomePage(this.currencies);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List currencies;
  final List<MaterialColor> _colors = [Colors.red, Colors.green, Colors.yellow];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crypto Currency"),
      ),
      body: _cryptoWidget(),
    );
  }

  Widget _cryptoWidget() {
    return new Container(
      child: Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              itemCount: widget.currencies.length,
              itemBuilder: (
                BuildContext context,
                int index,
              ) {
                final Map currency = widget.currencies[index];

                final MaterialColor color = _colors[index % _colors.length];

                return _getListItemUi(currency, color);
              },
            ),
          ),
        ],
      ),
    );
  }

  ListTile _getListItemUi(Map currency, MaterialColor color) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        child: Text(currency['name'][0]),
      ),
      title: Text(
        currency['name'],
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: _getSubtitleText(
          currency['price_usd'], currency['percent_change_1h']),
      isThreeLine: true,
    );
  }
}

Widget _getSubtitleText(String priceUSD, String percentageChange) {
  TextSpan priceTextWidget = new TextSpan(
      text: "\$$priceUSD\n", style: new TextStyle(color: Colors.black));
  String percentageChangeText = "1 hour: $percentageChange%";
  TextSpan percentageChangeTextWidget;

  if (double.parse(percentageChange) > 0) {
    percentageChangeTextWidget = new TextSpan(
        text: percentageChangeText, style: new TextStyle(color: Colors.green));
  } else {
    percentageChangeTextWidget = new TextSpan(
        text: percentageChangeText, style: new TextStyle(color: Colors.red));

    return new RichText(
        text: new TextSpan(
            children: [priceTextWidget, percentageChangeTextWidget]));
  }
  return Container();
}

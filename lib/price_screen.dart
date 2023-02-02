// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  CoinData coinData = CoinData();
  double currentPriceBTC = 0;
  double currentPriceETH = 0;
  double currentPriceLTC = 0;

  DropdownButton<String> androidMenu() {
    List<DropdownMenuItem<String>> menuItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      menuItems.add(
        DropdownMenuItem(
          child: Text(currenciesList[i]),
          value: currenciesList[i],
        ),
      );
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: menuItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value.toString();
          updateUI();
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Widget> cupertinoItems = [];
    cupertinoItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      cupertinoItems.add(
        Text(currenciesList[i]),
      );
    }
    return CupertinoPicker(
      onSelectedItemChanged: (index) {
        selectedCurrency = currenciesList[index];
        updateUI();
      },
      itemExtent: 32.0,
      children: cupertinoItems,
    );
  }

  void updateUI() async {
    double rateBTC = await coinData.getCoinData(selectedCurrency, 'BTC');
    double rateETH = await coinData.getCoinData(selectedCurrency, 'ETH');
    double rateLTC = await coinData.getCoinData(selectedCurrency, 'LTC');

    setState(() {
      currentPriceBTC = rateBTC;
      currentPriceETH = rateETH;
      currentPriceLTC = rateLTC;
    });
  }

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = ${currentPriceBTC.toInt()} $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = ${currentPriceETH.toInt()} $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = ${currentPriceLTC.toInt()} $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidMenu(),
          ),
        ],
      ),
    );
  }
}

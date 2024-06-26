// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_import, unused_local_variable, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'package:bitcoin_ticker/services/price.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  //property to store the price of the coins
  late int pricebtc = 0;
  late int priceeth = 0;
  late int priceltc = 0;

  //Object for the of CurrencyModel class
  CurrencyModel currencyModel = CurrencyModel();
  //Variable to Update the currency name in the DropDownButton
  String selectCurrency = 'USD';

  //Function to return the crypto currency cards
  Padding buildcard({required String cryptoType, required int cryptoPrice}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoType = $cryptoPrice $selectCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  //updating price individually with if condition for each coin type
  void updatePrice(dynamic coinData) async {
    var data = await coinData;
    setState(() {
      if (data['asset_id_base'] == 'BTC') {
        double priceInDouble = data['rate'];
        pricebtc = priceInDouble.toInt();
      } else if (data['asset_id_base'] == 'ETH') {
        double priceInDouble = data['rate'];
        priceeth = priceInDouble.toInt();
      } else if (data['asset_id_base'] == 'LTC') {
        double priceInDouble = data['rate'];
        priceltc = priceInDouble.toInt();
      }
    });
  }

  //Function that builds DropDown button for the android
  DropdownButton androidDropDown() {
    //and empty list to store all the list items
    List<DropdownMenuItem<String>> dropDownItems = [];
    //This part get all the items from currenciesList
    for (int i = 0; i < currenciesList.length; i++) {
      //storing the currency of ith index in a string Currency
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem(child: Text(currency), value: currency);
      dropDownItems.add(newItem);
    }

    // returning the dropDownButton
    return DropdownButton(
      value: selectCurrency,
      items: dropDownItems,
      //changing the selected value from the DropDown list to showcase on the button
      onChanged: (value) {
        setState(() {
          selectCurrency = value!;
        });
        //looping through the cryptoList to check price of each coin
        for (String crypto in cryptoList) {
          var coinPrice = currencyModel.getCoinPrice(crypto, selectCurrency);
          updatePrice(coinPrice);
        }
      },
    );
  }

  //Function that builds a picker for iOS
  CupertinoPicker iOSpicker() {
    //and empty list to store all the list items
    List<Widget> cupertinoItems = [];
    //This part get all the items from currenciesList
    for (String currency in currenciesList) {
      var newcupertinoItem = Text(currency);
      cupertinoItems.add(newcupertinoItem);
    }

    //returning the cupertino picker
    return CupertinoPicker(
      children: cupertinoItems,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          //selectcurrency changes the value according to the 'selectedindex'
          selectCurrency = currenciesList[selectedIndex];
        });
        //Looping through the cryptoList for the coin
        for (String crypto in cryptoList) {
          // 'coinPrice' variable to store the value obtained for a coin in a selected currency
          var coinPrice = currencyModel.getCoinPrice(crypto, selectCurrency);
          //passing the 'coinPrice' variable to 'updatePrice' function to change the value according to the cryptocurrency and the currency selected
          updatePrice(coinPrice);
        }
      },
    );
  }

  //Function that builds the dropdown or the picker based on the platform
  Widget? getPicker() {
    //if the platform is ios, it builds the iospicker
    if (Platform.isIOS) {
      return iOSpicker();
    } // if the platform is Android, it builds the androidDropDownButton
    else if (Platform.isAndroid) {
      return androidDropDown();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Appbar
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Center(child: Text('🤑 Coin Ticker')),
      ),
      //Column to store multiple widgets
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //this is the 1st card widget
          buildcard(cryptoType: 'BTC', cryptoPrice: pricebtc),
          //2nd card
          buildcard(cryptoType: 'ETH', cryptoPrice: priceeth),
          //3rd card
          buildcard(cryptoType: 'LTC', cryptoPrice: priceltc),
          //This container is for DropDownButton or the Picker
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              //calling getPicker function to build the button according to the platform
              child: getPicker()),
        ],
      ),
    );
  }
}

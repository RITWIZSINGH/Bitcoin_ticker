// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_import, unused_local_variable, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  //Variable to Update the currency name in the DropDownButton
  String selectCurrency = 'USD';

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
      looping: true,
      children: cupertinoItems,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
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
          //this is the card widget
          Padding(
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
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
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

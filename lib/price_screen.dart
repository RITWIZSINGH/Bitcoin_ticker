// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_import, unused_local_variable, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  //Variable to Update the currency name in the DropDownButton
  String selectCurrency = 'USD';

  //function to make DropDownMenuItem of all the currencies
  List<DropdownMenuItem> getDropDownItems() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      //storing the currency of ith index in a string Currency
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem(child: Text(currency), value: currency);
      dropDownItems.add(newItem);
    }
    return dropDownItems;
  }

  // List<Widget> getCupertinoItems() {
  //   List<Widget> cupertinoItems = [];
  //   for (String currency in currenciesList) {
  //     var newcupertinoItem = Text(currency);
  //     cupertinoItems.add(newcupertinoItem);
  //   }

  //   return cupertinoItems;
  // }

  @override
  Widget build(BuildContext context) {
    //calling the menuItem builder function when the build is called
    getDropDownItems();
    return Scaffold(
      //Appbar
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
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
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            //DropDownbutton
            child: DropdownButton(
              value: selectCurrency,
              items: getDropDownItems(),
              //changing the selected value from the DropDown list
              onChanged: (value) {
                setState(() {
                  selectCurrency = value!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}


// CupertinoPicker(
//                 looping: true,
//                 children: getCupertinoItems(),
//                 itemExtent: 32.0,
//                 onSelectedItemChanged: (selectedIndex) {
//                   print(selectedIndex);
//                 },
        //      )
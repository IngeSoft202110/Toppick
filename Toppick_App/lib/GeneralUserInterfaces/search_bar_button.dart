import 'package:Toppick_App/GeneralUserInterfaces/search_bar_full_screen.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchButton extends StatelessWidget {
  String buttonText;
  int option;
  SearchButton(this.buttonText, this.option);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
      child: Center(
        child: InkWell(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchScreen(this.option)),
            )
          },
          child: Container(
            height: 50.0,
            width: 385.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Color(0xFFF3F3F3)),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20.0),
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
                Text(
                  buttonText,
                  style: TextStyle(fontSize: 18.0, color: Color(0xFFC4C4C4)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

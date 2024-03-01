import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class ReusableRow extends StatelessWidget {
  String title;
 String value;
   final IconData iconData ;
   ReusableRow({super.key,required this.title,required this.value,required this.iconData});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey), // Adjust border color as needed
              borderRadius: BorderRadius.circular(5.0), // Adjust border radius as needed
            ),
            child: Column(
              children: [
                ListTile(
                  title: Text(title),
                  leading: Icon(iconData),
                  trailing: Text(value),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';


class ReusableRowTwo extends StatelessWidget {
  String title;
  String value;

  ReusableRowTwo({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35,top: 15),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(

            ),
            child: Column(
              children: [
                ListTile(
                  title: Padding(
                      padding: EdgeInsets.only(left: 35),
                      child: Text(title,style:const  TextStyle(color: Colors.white,fontSize: 30),)),
                  trailing: Padding(
                      padding: EdgeInsets.only(right: 97),
                      child: Text(value,style:const  TextStyle(color: Colors.white,fontSize: 25),)),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

}

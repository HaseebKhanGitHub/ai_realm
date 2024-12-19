

import 'package:ai_realm/helper/global.dart';
import 'package:ai_realm/model/home_type.dart';
import 'package:ai_realm/widgets/home_card.dart';
import 'package:flutter/material.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appName,style: TextStyle(color: Colors.blue,fontSize:20,fontWeight: FontWeight.bold),),
      backgroundColor: Colors.white,centerTitle: true,elevation: 2,
      actions: [
IconButton(onPressed: (){}, icon: Icon(Icons.brightness_4_outlined,color: Colors.blue,size: 26,))
      ],

      ),

      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: mq.width * .04, vertical: mq.height * .015),

        children: homeType.values.map((e)=>home_card(hometype: e,)).toList(),),
    );
  }
}

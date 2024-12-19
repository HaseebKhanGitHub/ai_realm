import 'package:ai_realm/model/home_type.dart';
import 'package:flutter/material.dart';

import 'package:ai_realm/helper/global.dart';
import 'package:lottie/lottie.dart';

class home_card extends StatelessWidget {
  final homeType hometype;

  const home_card({super.key, required this.hometype});

  @override
  Widget build(BuildContext context) {
    /* Animate.restartOnHotReload = true;*/

    return Container(
      width: double.infinity,
      child: Card(
        color: Colors.blue.withOpacity(.2),
        elevation: 0,
        margin: EdgeInsets.only(bottom: mq.height * .02),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            Lottie.asset(
              "assets/lottie/${hometype.lottie}",
              width: mq.width * .35,
            ),
            Spacer(),
            Text(
              hometype.title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1),
            ),
            Spacer(
              flex: 2,
            )
          ],
        ),
      ),
    );
  }
}

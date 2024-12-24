import 'package:ai_realm/model/home_type.dart';
import 'package:flutter/material.dart';

import 'package:ai_realm/helper/global.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

class home_card extends StatelessWidget {
  final homeType hometype;

  const home_card({super.key, required this.hometype});

  @override
  Widget build(BuildContext context) {
    /* Animate.restartOnHotReload = true;*/
    //    contacthaseebkhan.dev@gmail.com

    return InkWell(
      onTap: hometype.onTap,
      child: Card(
        color: Colors.blue.withOpacity(.2),
        elevation: 0,
        margin: EdgeInsets.only(bottom: mq.size.height * .02),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: hometype.leftAlign
            ? Row(
                children: [
                  Padding(
                    padding: hometype.padding,
                    child: Lottie.asset(
                      "assets/lottie/${hometype.lottie}",
                      width: mq.size.width * .35,
                    ),
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
              )
            : Row(
                children: [
                  Spacer(flex: 2),
                  Text(
                    hometype.title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1),
                  ),
                  Spacer(),
                  Container(
                    width: mq.size.width * .35,
                    child: Padding(
                      padding: hometype.padding,
                      child: Lottie.asset(
                        "assets/lottie/${hometype.lottie}",
                      ),
                    ),
                  ),
                ],
              ),
      ).animate().fade(duration: 1.seconds),
    );
  }
}

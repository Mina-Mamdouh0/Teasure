import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constance/constance.dart';

class PartPayment extends StatelessWidget {
  const PartPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var TextTheme = Theme.of(context).textTheme;
    var MediaQueryWidth = MediaQuery.of(context).size.width;
    var MediaQueryHeight = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          title: Text(
            "ادفع جزء من المبلغ",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: ListView(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + defaultPadding),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Column(
                              children: const [
                                Text(
                                  "المبلغ المستحق",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 20),
                                ),
                                Text(
                                  "10,500.10 ر.س ",
                                  style: TextStyle(fontSize: 25),
                                ),
                              ],
                            ),

                            const VerticalDivider(
                              color: Colors.black,
                              thickness: 2,
                            ),

                            Column(
                              children: const [
                                Text(
                                  "المبلغ المستحق",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 20),
                                ),
                                Text(
                                  "10,500.10 ر.س ",
                                  style: TextStyle(fontSize: 25),
                                ),
                              ],
                            )
                          ],
                        ),

                      ),

                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("المبلغ المتبقى",style: TextStyle(
fontSize: 21
                  ),),
                  const Text("15,633,20 ر.ي",style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                    color: Colors.red
                  ),)


                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

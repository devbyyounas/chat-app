import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_project/accounts.dart';
import 'package:my_project/callpage.dart';
import 'package:my_project/home.dart';
import 'package:my_project/settings.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var height, width;
  int index = 0;
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: height,
                width: width,
                color: Colors.amber,
                child: PageView(
                  controller: controller,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    HomePage(),
                    CallPage(),
                    AccountPage(),
                    SettingPage()
                  ],
                ),
              ),
            ),
            Card(
              elevation: 2,
              child: Container(
                height: height * 0.1,
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                        onTap: () {
                          controller.jumpToPage(0);
                        },
                        child: Icon(
                          Icons.message,
                          color: index == 0 ? Colors.black : Colors.grey,
                        )),
                    InkWell(
                      onTap: () {
                        controller.jumpToPage(1);
                      },
                      child: Icon(
                        Icons.call,
                        color: index == 1 ? Colors.black : Colors.grey,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.jumpToPage(2);
                      },
                      child: Icon(
                        Icons.account_circle,
                        color: index == 2 ? Colors.black : Colors.grey,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.jumpToPage(2);
                      },
                      child: Icon(
                        Icons.settings,
                        color: index == 2 ? Colors.black : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

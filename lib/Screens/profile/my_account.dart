

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libozzle/shared/components/constans.dart';
import 'package:libozzle/shared/styles/colors.dart';
import 'myAccountScreens/compony_screen.dart';
import 'myAccountScreens/user_screen.dart';

class MyAccount extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton.icon(onPressed: () {}, label: Text(lang == 'ar'?'تعبئة رصيدك':'Add Balance',style: TextStyle(color: redDefaultColor,fontSize: 15),),
            icon: Icon(Icons.add,color: redDefaultColor,),),
          ],
          bottom: TabBar(
            indicatorWeight: 2,
            indicatorColor: Colors.red,
            tabs: [
              Tab(
                child: Text( lang == 'ar'?'المستخدم':'User',style: TextStyle(color: Colors.black,fontSize: 20),),
              ),
              Tab(
                child: Text( lang == 'ar'?'الشركة':'Company',style: TextStyle(color: Colors.black,fontSize: 20)),
              ),
            ],
          ),
        ),
        body: Directionality(
          textDirection: lang == 'ar'?TextDirection.rtl : TextDirection.ltr,
          child: const TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                UserScreen(),
                CompanyScreen(),
              ],
            ),
        ),
      ),
    );
  }
}

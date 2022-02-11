import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:lbz/Logics/app_logic/app_controller.dart';
import 'package:lbz/Logics/profile_logic/profile_controller.dart';
import 'package:lbz/Screens/components/components.dart';
import 'package:lbz/assets/flaticon_icons.dart';
import 'package:lbz/shared/components/constans.dart';
import 'package:lbz/shared/components/varibales_combonents.dart';
import 'package:lbz/shared/styles/colors.dart';

class WalletCharge extends StatefulWidget {
  const WalletCharge({Key? key}) : super(key: key);

  @override
  _WalletChargeState createState() => _WalletChargeState();
}

class _WalletChargeState extends State<WalletCharge> {
  var profileController = Get.find<ProfileController>();
  var amountController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var appController = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(lang == 'ar'?'شحن المحفظة':'Wallet Charging'),centerTitle: true,),
      body:Form(
        key: formKey,
        child: Directionality(
          textDirection: lang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(lang == 'ar'?'الرجاء تعبئة البيانات المطلوبة':'Please fill in the required information',style: TextStyle(fontSize: 30,color: Colors.black54),maxLines: 2,overflow: TextOverflow.ellipsis,),
              ),
              Icon(FlatIcon.wallet,color: Colors.black45,size: 90,),
              CardField(
                onCardChanged: (card) {
                  print(card);
                },),
              Padding(
                padding: const EdgeInsets.only(top: 15,left: 8,right: 8),
                child: SizedBox(
                    height: 50,
                    child: defualtTextForm2(context,
                        controler: amountController,
                        type: TextInputType.number,
                        label: lang == 'ar' ? 'قيمة' : 'Amount',
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your Amount';
                          }
                          return null;
                        }, radius: 5)),
              ),
              Obx((){
                if(profileController.isLoading.value){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                    child: Center(child: CircularProgressIndicator(),),
                  );
                }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                    child: button(lang == 'ar'?'دفع':'Pay', null,color: redDefaultColor,clr: Colors.white,onPress: ()async{
                      final paymentMethod =
                          await Stripe.instance.createPaymentMethod(PaymentMethodParams.card(),);
                      print(paymentMethod.id);
                      profileController.insertBalance(amountController.text.replaceAll(new RegExp(r'[^0-9]'),''), paymentMethod.id).then((value) {
                        appController.getBalance();
                      });
                      Get.back();
                    }),
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}

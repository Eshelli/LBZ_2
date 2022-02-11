import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libozzle/Logics/login_register_logic/login_register_controller.dart';
import 'package:libozzle/Screens/components/components.dart';
import 'package:libozzle/shared/components/varibales_combonents.dart';
import 'package:libozzle/shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var registerController = Get.find<LoginRegisterController>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPassController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children:
            [
              Text('Create an account',style: const TextStyle(fontSize: 40),overflow: TextOverflow.ellipsis,),
              SizedBox(height: 20,),
              defualtTextForm(context, controler: nameController,label: 'User name', type: TextInputType.text, radius: 15),
              SizedBox(height: 10,),
              defualtTextForm(context, controler: emailController,label: 'Email', type: TextInputType.emailAddress, radius: 15),
              const SizedBox(height: 10,),
              defualtTextForm(context, controler: passwordController,label: 'Password', type: TextInputType.text, radius: 15),
              const SizedBox(height: 10,),
              defualtTextForm(context, controler: confirmPassController,label: 'Confirm Password', type: TextInputType.text, radius: 15),
              const SizedBox(height: 10,),
              defualtTextForm(context, controler: phoneController,label: 'PhoneNumber', type: TextInputType.number, radius: 15),
              const SizedBox(height: 20,),
              SizedBox(height: 50,child: button('Sign up', null,onPress: (){registerController.register(nameController.text, emailController.text, phoneController.text, passwordController.text, confirmPassController.text);},clr: Colors.white,color: redDefaultColor,fontSize: 28)),
            ],
          ),
        ),
      ),
    );
  }
}
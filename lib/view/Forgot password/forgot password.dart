
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/provider/Forgot%20Password%20PRovider.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/components/RoundButton.dart';
import 'package:tech_media/res/components/TextFormField.dart';
import 'package:tech_media/res/fonts.dart';
import 'package:tech_media/utils/routes/route_name.dart';

import '../../provider/loginProvider.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  final emailfocus = FocusNode();
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final passwordfocus = FocusNode();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    emailfocus.dispose();
    passwordfocus.dispose();
    passwordController.dispose();

  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height *1 ;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Forgot Password...',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: AppColors.primaryTextTextColor,fontFamily: AppFonts.sfProDisplayBold),),
                    Text('Enter Email to reset Password',style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal,color: Colors.black,fontFamily: AppFonts.sfProDisplayMedium),),
                  ],
                ),
                const SizedBox(height: 200,),
                Form(
                    key: _formkey,
                    child:Column(
                      children: [
                        Padding(
                          padding:const EdgeInsets.symmetric(horizontal: 10),
                          child: InputTextFormField(myConrtoller: emailController, focusNode: emailfocus, onfieoldSubmittedView:(_){
                          }, obsecureText: false, keyboardType: TextInputType.text, hint: 'email', onValidator:(value){
                            return value.isEmpty ? 'enter email' : null ;
                          }),
                        ),
                        const SizedBox(height: 20,),

                      ],
                    ) ),
                const SizedBox(height: 20,),
                const SizedBox(height:20),

                Consumer<ForgotPasswordProvider>(builder: (context,Provider,child){
                  return   RoundButton(title: 'Reset', loading: Provider.loading,ontap: (){
                    if(_formkey.currentState!.validate()){

                    }
                    Provider.forgotPasswordFtn(context,emailController.text,);
                  });

                }),

                const SizedBox(
                  height: 20,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

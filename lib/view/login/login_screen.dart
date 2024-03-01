import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/components/RoundButton.dart';
import 'package:tech_media/res/components/TextFormField.dart';
import 'package:tech_media/res/fonts.dart';
import 'package:tech_media/utils/Messages_making/Messages.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/provider/loginProvider.dart';
import 'package:tech_media/view/signup/sign_up_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    return Scaffold(
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
                        Text('Welcome To The App',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: AppColors.primaryTextTextColor,fontFamily: AppFonts.sfProDisplayBold),),
                        Text('Enter Email to connect to your app',style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal,color: Colors.black,fontFamily: AppFonts.sfProDisplayMedium),),
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
                                  generalUtills.focusftn(context, emailfocus, passwordfocus);
                             }, obsecureText: false, keyboardType: TextInputType.text, hint: 'email', onValidator:(value){
                               return value.isEmpty ? 'enter email' : null ;
                             }),
                           ),
                           const SizedBox(height: 20,),
                           Padding(
                             padding:const EdgeInsets.symmetric(horizontal: 10),
                             child: InputTextFormField(myConrtoller: passwordController, focusNode: passwordfocus, onfieoldSubmittedView:(_){

                             }, obsecureText: false, keyboardType: TextInputType.text, hint: 'Passsword', onValidator:(value){
                               return value.isEmpty ? 'Enter Password' : null ;
                             }
                             ),
                           ),
                         ],
                       ) ),
                   const SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen:const SignScreen(),
                        );

                      },
                      child:const Text.rich(
                       TextSpan(
                           text: 'Dont Have an Account ?',
                           style: TextStyle(),
                           children: [
                             TextSpan(
                               text: 'Sign Up ',
                               style: TextStyle(decoration: TextDecoration.underline,fontWeight: FontWeight.normal,fontSize: 18,color: AppColors.hintColor),
                             )
                           ]
                       ),

                                         ),
                    ),
                   const SizedBox(height:20),

                   Consumer<LoginProvider>(builder: (context,Provider,child){
                     return   RoundButton(title: 'Login', loading: Provider.loading,ontap: (){
                       if(_formkey.currentState!.validate()){

                       }
                            Provider.loginFtn(emailController.text, passwordController.text,context);
                     });

                   }),

                   const SizedBox(
                     height: 20,
                   ),
                  Padding(
                    padding:const EdgeInsets.only(left: 200),
                    child:  InkWell(
                      onTap: (){
                       Navigator.pushNamed(context, RouteName.forgotPassword);
                      },
                      child:const Text.rich(
                         TextSpan(
                           text: 'Forgot Password ?',
                           style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300,color: AppColors.hintColor),

                         ),

                       ),
                    ),
                  )

                 ],
               ),
             ),
           ),
         ),
    );
  }
}

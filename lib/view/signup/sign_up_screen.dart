import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/provider/signup_dart.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/components/RoundButton.dart';
import 'package:tech_media/res/components/TextFormField.dart';
import 'package:tech_media/res/fonts.dart';
import 'package:tech_media/utils/Messages_making/Messages.dart';
import 'package:tech_media/utils/routes/route_name.dart';


class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignScreen> {
  final emailController = TextEditingController();
  final emailfocus = FocusNode();
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final passwordfocus = FocusNode();
  final usernameController = TextEditingController();
  final focusNode = FocusNode();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    emailfocus.dispose();
    passwordfocus.dispose();
    passwordController.dispose();
    usernameController.dispose();
    focusNode.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider(create: (_) => signinProvider(),child: Consumer<signinProvider>(builder: (context,provider,child){
          return SingleChildScrollView(
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
                      Text('Sign in ',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: AppColors.primaryTextTextColor,fontFamily: AppFonts.sfProDisplayBold),),
                      Text('sign in to continue',style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal,color: Colors.black,fontFamily: AppFonts.sfProDisplayMedium),),
                    ],
                  ),
                  const SizedBox(height: 200,),
                  Form(
                      key: _formkey,
                      child:Column(

                        children: [
                          Padding(
                            padding:const EdgeInsets.symmetric(horizontal: 10),
                            child: InputTextFormField(myConrtoller: usernameController, focusNode: focusNode, onfieoldSubmittedView:(_){
                               generalUtills.focusftn(context, focusNode,emailfocus);

                            }, obsecureText: false, keyboardType: TextInputType.text, hint: 'Username', onValidator:(value){
                              return value.isEmpty ? 'enter username' : null ;
                            }),
                          ),
                          const SizedBox(height: 20,),
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

                            }, obsecureText: true, keyboardType: TextInputType.text, hint: 'Passsword', onValidator:(value){
                              return value.isEmpty ? 'Enter Password' : null ;
                            }
                            ),
                          ),
                        ],
                      ) ),
                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, RouteName.loginScreen);
                    },
                    child:const Text.rich(
                      TextSpan(
                          text: 'Already have an account ?',
                          style: TextStyle(),
                          children: [
                            TextSpan(
                              text: 'Login ',
                              style: TextStyle(decoration: TextDecoration.underline,fontWeight: FontWeight.normal,fontSize: 18,color: AppColors.hintColor),
                            )
                          ]
                      ),

                    ),
                  ),
                  const SizedBox(height:20),
                  RoundButton(title: 'Sign in', loading: provider.loading,ontap: (){
                    if(_formkey.currentState!.validate()){
                      provider.SignUpftn(context, usernameController.text.toString(), emailController.text.toString(), passwordController.text.toString());
                    }

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
          );

        }),)

        ),
    );
  }
}

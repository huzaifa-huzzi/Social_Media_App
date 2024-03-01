import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';



class InputTextFormField extends StatelessWidget {
   InputTextFormField({super.key,
     required this.myConrtoller,
      this.autoFocus = false,
     required this.focusNode,
     required this.onfieoldSubmittedView,
     required this.obsecureText,
     required this.keyboardType,
     required this.hint,
     this.enable = true,
     required this.onValidator,



   });

  final TextEditingController myConrtoller;
  final FocusNode focusNode;
  final FormFieldSetter onfieoldSubmittedView;
  final FormFieldValidator onValidator;
  final TextInputType keyboardType;
  final String hint;
  final bool obsecureText;
  final bool enable,autoFocus;


  @override
  Widget build(BuildContext context) {
    return   TextFormField(
      controller: myConrtoller,
      focusNode: focusNode,
      onFieldSubmitted: onfieoldSubmittedView,
      obscureText: obsecureText,
      validator: onValidator,
      keyboardType: keyboardType,

      decoration: InputDecoration(
        hintText: hint,
        hintStyle:const TextStyle(fontSize: 18,color: AppColors.primaryTextTextColor),

        border: OutlineInputBorder(
          borderSide:const BorderSide(color: AppColors.textFieldDefaultBorderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:const BorderSide(color: AppColors.hintColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

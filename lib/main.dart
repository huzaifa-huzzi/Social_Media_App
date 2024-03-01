import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/provider/Forgot%20Password%20PRovider.dart';
import 'package:tech_media/provider/HomePageProvider.dart';
import 'package:tech_media/provider/chatMessageProvider.dart';
import 'package:tech_media/provider/loginProvider.dart';
import 'package:tech_media/provider/profilepicture.provider.dart';
import 'package:tech_media/provider/signup_dart.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/fonts.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> signinProvider()),
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(create: (_) => ForgotPasswordProvider()),
      ChangeNotifierProvider(create: (_) => ImagePickerNotifier()),
      ChangeNotifierProvider(create: (_) => MessageProvider()),
    ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: AppColors.primaryMaterialColor,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme:const AppBarTheme(
              color: AppColors.whiteColor,
              centerTitle: true,
              titleTextStyle: TextStyle(fontSize: 22,fontFamily: AppFonts.sfProDisplayMedium,color: AppColors.primaryTextTextColor),
            ),
            textTheme: TextTheme(
              //text Fonts
              titleLarge:Theme.of(context).textTheme.headlineLarge,
              titleSmall: Theme.of(context).textTheme.headlineSmall,
              titleMedium: Theme.of(context).textTheme.headlineSmall,

              // body fonts
              bodyLarge: Theme.of(context).textTheme.bodyLarge,
              bodySmall: Theme.of(context).textTheme.bodySmall,

              //captions



            )
        ),
        initialRoute: RouteName.splashScreen,
        onGenerateRoute: Routes.generateRoute,
      ),
    );

  }
}


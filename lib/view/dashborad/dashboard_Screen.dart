import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tech_media/view/Home_Page/HomePage.dart';
import 'package:tech_media/view/Messages/Messages_Screen.dart';
import 'package:tech_media/view/profile/Profile_Screen.dart';



class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  FirebaseAuth auth = FirebaseAuth.instance;


  PersistentTabController _controller = PersistentTabController(initialIndex: 0);



  List<Widget> _buildScreens() {
    return  const [
      HomeScreen(),
      MessagesScreen(),
      ProflieScreen(),
    ];
  }


  List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
  PersistentBottomNavBarItem(
  icon:const Icon(Icons.home,color: Colors.black,),
  activeColorPrimary: Colors.black,
    inactiveIcon:const Icon(Icons.home,color: Colors.white,)
  ),

    PersistentBottomNavBarItem(
      icon:const Icon(Icons.message,color: Colors.white,),
      activeColorPrimary: Colors.black,
      inactiveIcon: const Icon(Icons.message,color: AppColors.textFieldDefaultBorderColor,),
    ),
    PersistentBottomNavBarItem(
      icon:const Icon(Icons.person,color: Colors.black,),
      activeColorPrimary: Colors.black,
      inactiveIcon:  const  Icon(Icons.person,color:Colors.white)
    ),
    ];
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.grey, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties:const ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation:const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style15, // Choose the nav bar style with this property.
      ),
    );

  }
}

import 'package:flutter/material.dart';
import 'package:to_do_app/app_theme.dart';
import '../Task_Tap/Task_screen.dart';
import '../settings_tap/settings_screen.dart';
import '../Task_Tap/add_task_bottom.dart';

class HomeScreen extends StatefulWidget {
  static const String RouteName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  int selectedIndex = 0;
  List<Widget> tapsList=[TaskScreen(),SettingsScreen()];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To DO List', style: Theme
          .of(context)
          .textTheme
          .titleLarge,)),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        child: BottomNavigationBar(
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showaddTaskBottomSheet();
        },
          child: Icon(Icons.add),
          shape: StadiumBorder(side: BorderSide(color:AppTheme.white, width: 4)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tapsList[selectedIndex],
    );
  }

  void showaddTaskBottomSheet() {
    showModalBottomSheet(context: context, builder: (context)=>AddTaskBottom())  ;
  }
}

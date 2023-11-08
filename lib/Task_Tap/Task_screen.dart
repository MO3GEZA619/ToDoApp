import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/FirerBase_Utils.dart';
import 'package:to_do_app/Task_Tap/tasks.dart';
import 'package:to_do_app/app_theme.dart';
import 'package:to_do_app/Task_Tap/task_widget.dart';
import 'package:to_do_app/providers/list_provider.dart';
import '../providers/list_provider.dart';

class TaskScreen extends StatefulWidget {
  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> tasksList = [];
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    if(listProvider.tasksList.isEmpty){listProvider.getAllTasksFromFirestore();}
    return Column(
      children: [
        CalendarTimeline(
          initialDate: listProvider.selectedDate,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) {
            listProvider.changeSelectedDate(date);
          },
          leftMargin: 20,
          monthColor: AppTheme.black,
          dayColor: AppTheme.black,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: AppTheme.lightBlue,
          dotsColor: AppTheme.white,
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TaskWidgetItem(task: listProvider.tasksList[index],);
            },
            itemCount: listProvider.tasksList.length,
          ),
        )
      ],
    );
  }

}

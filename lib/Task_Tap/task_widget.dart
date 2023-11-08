import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/Task_Tap/tasks.dart';
import 'package:to_do_app/app_theme.dart';

class TaskWidgetItem extends StatelessWidget {
  Task task;
  TaskWidgetItem({required this.task });
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            borderRadius: BorderRadius.only(topLeft:Radius.circular(15),bottomLeft: Radius.circular(15)),
            onPressed: (context){
            },
            backgroundColor: AppTheme.red,
            foregroundColor: AppTheme.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: AppTheme.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              height: 80,
              width: 4,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(task.title??'',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Theme.of(context).primaryColor)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(task.description??'',
                      style: Theme.of(context).textTheme.titleMedium),
                )
              ],
            )),
            Container(
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppTheme.lightBlue,
              ),
              child: Icon(Icons.check, color: AppTheme.white, size: 35),
            ),
          ],
        ),
      ),
    );
  }
}

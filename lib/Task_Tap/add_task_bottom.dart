import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/FirerBase_Utils.dart';
import 'package:to_do_app/Task_Tap/tasks.dart';
import 'package:to_do_app/app_theme.dart';
import 'package:to_do_app/providers/list_provider.dart';

class AddTaskBottom extends StatefulWidget {
  @override
  State<AddTaskBottom> createState() => _AddTaskBottomState();
}

class _AddTaskBottomState extends State<AddTaskBottom> {
  DateTime selectedDate=DateTime.now();
  var formkey=GlobalKey<FormState>();
  String title='';
  String description='';
  late ListProvider listProvider;
  @override
  Widget build(BuildContext context) {
    listProvider =Provider.of<ListProvider>(context);
    return Container(
      padding: EdgeInsets.all(12),
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          Text(
            'Add new Task',
            style: Theme.of(context).textTheme.titleMedium,
          ),

          Form(
            key: formkey ,
              child:
              Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
               children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (text){
                    title=text;
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter Task title',
                      hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 22),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Invalid Task title';
                    }
                    return null;
                  },

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (text){
                    description=text;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Task description',
                    hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 22),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black,)),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Invalid Task description';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  'Select Date',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.grey,fontSize: 22),
                ),
              ),
              InkWell(
                onTap: (){
                  ShowCalender();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.grey,fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              ElevatedButton(
                  onPressed:(){
                AddTask();
              }, child:
              Text('Add',
              style: Theme.of(context).textTheme.titleLarge,)),
            ],
          ))
        ],
      ),
    );
  }

  void ShowCalender() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
    }
    setState(() {});

  }
  void AddTask() {
    if(formkey.currentState?.validate()==true){
      Task task= Task(
          title: title,
          description: description,
          date: selectedDate,
      );
      FirebaseUtils.addTaskToFirebase(task).timeout(
        Duration(milliseconds: 500),
        onTimeout: (){
          print('task added succesfully');
          listProvider.getAllTasksFromFirestore();
          Navigator.pop(context);
        }
      );

    }
  }
}

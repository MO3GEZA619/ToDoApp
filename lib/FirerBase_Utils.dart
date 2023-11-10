import 'package:cloud_firestore/cloud_firestore.dart';
import 'Task_Tap/tasks.dart';

class FirebaseUtils {

  static CollectionReference<Task> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
        fromFirestore: (snapshot, options) => Task.fromFireStore(snapshot.data()!),
        toFirestore: (value, options) => value.toFireStore()
    );
  }

  static Future<void> addTaskToFirebase(Task task) {
    var collection = getTaskCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }
  static Future<List<Task>> getTaskFromFireBase() async {
    List<Task> tasks = [];
    QuerySnapshot<Task> snapshot = await getTaskCollection().get();
    tasks = snapshot.docs.map((doc) => doc.data()).toList();
    return tasks;
  }

  static Future<void> deleteTaskFromFireStore(Task task) async {
    var taskCollection =  await getTaskCollection();
    var documentReference = taskCollection.doc(task.id);
    documentReference.delete();

  }
  static updateTaskFromFireStore(Task task) {
    var taskCollection = getTaskCollection();
    var documentReference = taskCollection.doc(task.id);
    documentReference.update(task.toFireStore());
  }

  static void updateData(Task task){
    var collection = getTaskCollection();
    var doc=collection.doc(task.id);doc.update(task.toFireStore());
  }
  static void deleteData(Task task){
    var collection=getTaskCollection();
    var doc=collection.doc(task.id);
    doc.delete();
  }
}
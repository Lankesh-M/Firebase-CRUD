import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  //collect
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  //create: Note
  Future<void> addNote(String note) {
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }

  //read: Read the notes from database
  Stream<QuerySnapshot> getNotesStream() {
    final noteStream = notes.orderBy('timestamp', descending: true).snapshots();
    return noteStream;
  }

  //update: Update: given doc id
  Future<void> updateNote(String docId, String newNote) {
    return notes.doc(docId).update(
      {
        'note': newNote,
        'timestamp': Timestamp.now(),
      },
    );
  }

  //delete: Delete the given doc id note
  Future<void> deleteNote(String docId) {
    return notes.doc(docId).delete();
  }

  //Collection to store user specific data

  final CollectionReference userData =
      FirebaseFirestore.instance.collection('notes');

  //create: Note
  // Future<void> addUser(String name, int age, String gender) {
  //   return userData.add({
  //     'First name': name,
  //     // 'Seond name': secondName,
  //     'Age': age,
  //     'Gender': gender,
  //   });
  // }

  //read: Read the notes from database
  // Stream<QuerySnapshot> getUserData() {
  //   // final noteStream = notes.orderBy('timestamp', descending: true).snapshots();
  //   // return noteStream;
  // }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:crud/services/firestore.dart';
import 'package:crud/features/app/widgets/app_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  final TextEditingController textcontroller = TextEditingController();
  void openNoteBox({String? docId}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textcontroller,
        ),
        actions: [
          //Add Button
          ElevatedButton(
            onPressed: () {
              if (docId == null) {
                FirestoreServices().addNote(textcontroller.text);
              } else {
                FirestoreServices().updateNote(docId, textcontroller.text);
              }

              textcontroller.clear();

              Navigator.pop(context);
            },
            child: docId == null ? const Text("Add") : const Text("Update"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Center(child: Text("Notes")),
        backgroundColor: Colors.purple,
      ),
      drawer: AppDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirestoreServices().getNotesStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List noteslist = snapshot.data!.docs;

            return ListView.builder(
              itemCount: noteslist.length,
              itemBuilder: ((context, index) {
                //Get each individual doc
                DocumentSnapshot document = noteslist[index];
                String docId = document.id;

                //get each data
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String eachNote = data['note'];

                //Display as list tile
                return ListTile(
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          openNoteBox(docId: docId);
                        },
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      IconButton(
                        onPressed: () {
                          FirestoreServices().deleteNote(docId);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                  title: Text(eachNote),
                );
              }),
            );
          } else {
            return const Text("Add some note to show preview");
          }
        },
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/features/app/screens/home.dart';
import 'package:crud/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserData extends StatelessWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController genderController = TextEditingController();
    TextEditingController occupationController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    Future<void> storeUserData(
      String uid,
      String name,
      String age,
      String gender,
      String occupation,
    ) async {
      await FirebaseFirestore.instance.collection('userData').doc(uid).set({
        'Name': name,
        'Age': age,
        'Gender': gender,
        'Occupation': occupation,
      });
    }

    void _saveUserDetails() async {
      if (_formKey.currentState!.validate()) {
        // Get the current user
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          // Save user details to Firestore
          await storeUserData(
            user.uid,
            nameController.text,
            ageController.text,
            genderController.text,
            occupationController.text,
          );
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              //Or use Navigator.Replacement
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Fill your details")),
        backgroundColor: Colors.amber[300],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //for Name
              const Text(
                "Full ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your full name",
                      hintStyle: TextStyle(fontStyle: FontStyle.italic)),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              // For Age
              Text(
                "Age",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: ageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your age",
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              // For Gender
              Text(
                "Gender",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: genderController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your gender';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Male or Female",
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Occupation",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: occupationController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Ocuupation';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your Occupation",
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),

              //Button for Saving the user details
              Center(
                child: ElevatedButton(
                  onPressed: _saveUserDetails,
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:crud_sqllite_app/model/user.dart';
import 'package:crud_sqllite_app/services/user_service.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);
  @override
  State<AddUser> createState() => AddUserState();
}

class AddUserState extends State<AddUser> {
  var userNameController = TextEditingController();
  var userContactController = TextEditingController();
  var userDescriptionController = TextEditingController();

  bool validateName = false;
  bool validateContact = false;
  bool validateDescription = false;

  var userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SQLITE CRUD")),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Add New User",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: userNameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Enter name",
                  labelText: 'Name',
                  errorText: validateName ? 'Name value can\'t be empty' : null,
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: userContactController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Enter your contact number",
                  labelText: 'ContactNumber',
                  errorText:
                      validateContact ? 'Contact value can\'t be empty' : null,
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: userDescriptionController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "Enter description",
                  labelText: 'Description',
                  errorText: validateDescription
                      ? 'description value can\'t be empty'
                      : null,
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  TextButton(
                    child: const Text("Save details"),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.green,
                      textStyle: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        userNameController.text.isEmpty
                            ? validateName = true
                            : validateName = false;
                        userContactController.text.isEmpty
                            ? validateContact = true
                            : validateContact = false;
                        userDescriptionController.text.isEmpty
                            ? validateDescription = true
                            : validateDescription = false;
                      });
                      if (validateName == false &&
                          validateContact == false &&
                          validateDescription == false) {
                        //print("good data can save");
                        var user = User();
                        user.name = userNameController.text;
                        user.contact = userContactController.text;
                        user.description = userDescriptionController.text;

                        var result = await userService.saveUser(user);
                        Navigator.pop(context, result);
                      }
                    },
                  ),
                  const SizedBox(width: 20.0),
                  TextButton(
                    child: const Text("Clear"),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.red,
                      textStyle: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      userNameController.text = '';
                      userContactController.text = '';
                      userDescriptionController.text = '';
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:crud_sqllite_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:crud_sqllite_app/model/user.dart';

class EditUser extends StatefulWidget {
  final User user;
  const EditUser({Key? key, required this.user}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  var userNameController = TextEditingController();
  var userContactController = TextEditingController();
  var userDescriptionController = TextEditingController();

  bool validateName = false;
  bool validateContact = false;
  bool validateDescription = false;

  var userService = UserService();

  @override
  void initState() {
    setState(() {
      userNameController.text = widget.user.name ?? '';
      userContactController.text = widget.user.contact ?? '';
      userDescriptionController.text = widget.user.description ?? '';
    });
    super.initState();
  }

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
                "Edit New User",
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
                    child: const Text("Update details"),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.green,
                      textStyle:const TextStyle(
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
                        user.id = widget.user.id;
                        user.name = userNameController.text;
                        user.contact = userContactController.text;
                        user.description = userDescriptionController.text;

                        var result = await userService.updateUser(user);
                        Navigator.pop(context, result);
                      }
                    },
                  ),
                 const SizedBox(width: 20.0),
                  TextButton(
                    child:const Text("Clear"),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.red,
                      textStyle:const TextStyle(
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

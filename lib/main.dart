import 'package:crud_sqllite_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:crud_sqllite_app/screens/addUser.dart';
import 'package:crud_sqllite_app/services/user_service.dart';
import 'package:crud_sqllite_app/screens/viewUser.dart';
import 'package:crud_sqllite_app/screens/editUser.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late List<User> userList = <User>[];
  final userService = UserService();

  getAllUserDetails() async {
    var users = await userService.readAllUser();
    userList = <User>[];

    users.forEach((user) {
      setState(() {
        var userModel = User();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.contact = user['contact'];
        userModel.description = user['description'];

        userList.add(userModel);
      });
    });
  }

  @override
  void initState() {
    getAllUserDetails();
    super.initState();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _deleteFormDialog(BuildContext context, userId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: Text("Are you sure to delete?"),
            actions: [
              TextButton(
                child: Text("Delete"),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.red,
                ),
                onPressed: () async {
                  var result = userService.deleteUser(userId);
                  if (result != null) {
                    Navigator.pop(context);
                    getAllUserDetails();
                    _showSuccessSnackBar("data deleted successfully");
                  }
                },
              ),
              TextButton(
                child: Text("close"),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.teal,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SQLITE CRUD"),
      ),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewUser(
                                user: userList[index],
                              )));
                },
                leading: const Icon(Icons.person),
                title: Text(userList[index].name ?? ''),
                subtitle: Text(userList[index].contact ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditUser(
                                      user: userList[index],
                                    ))).then((data) {
                          if (data != null) {
                            getAllUserDetails();
                            _showSuccessSnackBar("Data updated successfully");
                          }
                        });
                      },
                      icon: const Icon(Icons.edit, color: Colors.blue),
                    ),
                    IconButton(
                      onPressed: () {
                        _deleteFormDialog(context, userList[index].id);
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                )),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddUser()))
              .then((data) {
            if (data != null) {
              getAllUserDetails();
              _showSuccessSnackBar("Data saved successfully");
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

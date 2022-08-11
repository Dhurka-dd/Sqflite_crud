import 'package:flutter/material.dart';
import 'package:crud_sqllite_app/model/user.dart';

class ViewUser extends StatefulWidget {
  final User user;
  const ViewUser({Key? key, required this.user}) : super(key: key);

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SQLITE CRUD")),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Full Details",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey,
                  fontSize: 20,
                )),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: const Text("Name",
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                ),
                Text(
                  widget.user.name ?? '',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: const Text("Contact",
                      style: const TextStyle(
                        color: Colors.teal,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                ),
                Text(
                  widget.user.contact ?? '',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Description",
                    style: const TextStyle(
                      color: Colors.teal,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.user.description ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

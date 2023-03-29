import 'package:fb_crud/models/users_model.dart';
import 'package:fb_crud/services/firebase.dart';
import 'package:fb_crud/widgets/textformfiled_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

//Todo: Set User Data
final TextEditingController _nameController = TextEditingController();
final TextEditingController _messageController = TextEditingController();
final TextEditingController _numberController = TextEditingController();

//Todo Update User Data

final TextEditingController _updateName = TextEditingController();
final TextEditingController _updateMessage = TextEditingController();
final TextEditingController _updateNumber = TextEditingController();

class _HomepageScreenState extends State<HomepageScreen> {
  void addData() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(12),
          title: const Center(child: Text('Enter User Data')),
          clipBehavior: Clip.antiAlias,
          elevation: 1,
          alignment: Alignment.center,
          children: [
            TextFormFieldWidget(
              controller: _nameController,
              labelText: 'Name',
              prefixIcon: Icons.person_rounded,
            ),
            TextFormFieldWidget(
              controller: _messageController,
              labelText: 'Message',
              prefixIcon: Icons.messenger_outline_rounded,
            ),
            TextFormFieldWidget(
              controller: _numberController,
              labelText: 'Number',
              prefixIcon: Icons.phone_rounded,
            ),
            MaterialButton(
              onPressed: () async {
                await FirebaseClass().addUserData(
                  _nameController.text,
                  _messageController.text,
                  _numberController.text,
                );
                Get.back();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.green.shade400,
              height: 50,
              child: const Text(
                'Done',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Firebase CRUD Operation'),
        actions: [
          IconButton(
            onPressed: () {
              addData();
            },
            icon: const Icon(
              Icons.add_rounded,
              color: Colors.red,
              size: 30,
            ),
          ),
        ],
      ),

      //Todo: Get Users Data
      body: StreamBuilder<List<UserModel>>(
        stream: FirebaseClass().getUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(5),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: InkWell(
                      onTap: () {
                        _updateName.text = snapshot.data![index].name;
                        _updateMessage.text = snapshot.data![index].message;
                        _updateNumber.text = snapshot.data![index].number;
                        showDialog(
                          context: context,
                          builder: (context) => SimpleDialog(
                            title: const Center(child: Text('Edit User Data')),
                            children: [
                              TextFormFieldWidget(
                                controller: _updateName,
                                labelText: 'Name',
                                prefixIcon: Icons.person_rounded,
                              ),
                              TextFormFieldWidget(
                                controller: _updateMessage,
                                labelText: 'Message',
                                prefixIcon: Icons.messenger_outline_rounded,
                              ),
                              TextFormFieldWidget(
                                controller: _updateNumber,
                                labelText: 'Number',
                                prefixIcon: Icons.phone_rounded,
                              ),
                              MaterialButton(
                                onPressed: () async {
                                  FirebaseClass().updateUserDataWithDate(
                                    snapshot.data![index].id,
                                    _updateName.text,
                                    _updateMessage.text,
                                    _updateNumber.text,
                                  );
                                  setState(() {});
                                  Get.back();
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                color: Colors.green.shade400,
                                height: 50,
                                child: const Text(
                                  'Update Edit',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.edit_rounded,
                        color: Colors.green,
                      ),
                    ),
                    title: Text(snapshot.data![index].name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data![index].message),
                        Text(snapshot.data![index].number),
                      ],
                    ),
                    trailing: InkWell(
                      onTap: () async {
                        await FirebaseClass()
                            .deleteUserData(snapshot.data![index].id);
                        setState(() {});
                      },
                      child: const Icon(
                        Icons.delete_rounded,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

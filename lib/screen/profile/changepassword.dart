import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qstar/controllers/editprofilecontroller.dart';
import 'package:get/get.dart';
import 'package:qstar/constant.dart';
import 'dart:convert';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class Animal {
  final int id;
  final String name;

  Animal({
    required this.id,
    required this.name,
  });
}

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<ChangePassword> {
  @override
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  final EditprofileController editprofileController =
      Get.put(EditprofileController());
  //List<Animal> _selectedAnimals = [];

  // ignore: prefer_typing_uninitialized_variables
  var body;

  @override
  void initState() {
    _fetchUser();
    super.initState();
  }

  void _fetchUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('user');

    // ignore: avoid_print
    print(token);
    if (token != null) {
      // ignore: avoid_print
      print(token.toString());
      body = json.decode(token);
      // ignore: avoid_print
      print(body["id"]);
      editprofileController.fetchProfile(body["id"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leadingWidth: 40,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              icon: const Icon(Icons.arrow_back),
              color: mPrimaryColor),
          title: const SizedBox(
            child: Text(
              "Edit Password",
              style: TextStyle(
                color: mPrimaryColor,
                fontSize: 23,
                fontFamily: 'font1',
              ),
            ),
          ),
        ),
        body: editprofileController.obx(
            (editForm) => Form(
                  key: editprofileController.EditProf,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 16, top: 25, right: 16),
                    child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: ListView(
                          children: [
                            const SizedBox(height: 24),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Password",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: editprofileController.passControl,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: mPrimaryColor, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    editprofileController.pass =
                                        value.toString();
                                  },
                                  validator: (value) {
                                    return editprofileController
                                        .validatePass(value!);
                                  },
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "new Password",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: editprofileController.passControl,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: mPrimaryColor, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    editprofileController.pass =
                                        value.toString();
                                  },
                                  validator: (value) {
                                    return editprofileController
                                        .validatePass(value!);
                                  },
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Confirm new Password",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                TextFormField(
                                  controller: editprofileController.passControl,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: mPrimaryColor, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    editprofileController.pass =
                                        value.toString();
                                  },
                                  validator: (value) {
                                    return editprofileController
                                        .validatePass(value!);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  height: 35,
                                ),
                                // ignore: deprecated_member_use
                                RaisedButton.icon(
                                  onPressed: () {
                                    editprofileController.editProf(body["id"]);
                                    // ignore: avoid_print
                                    print(editprofileController.isLoading);
                                    // ignore: unrelated_type_equality_checks
                                    editprofileController.isLoading == true
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : _showMessage();
                                  },
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  label: const Text(
                                    'Update Password',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  icon: const Icon(
                                    Icons.update,
                                    color: Colors.white,
                                  ),
                                  textColor: mPrimaryColor,
                                  splashColor: Colors.white,
                                  color: mPrimaryColor,
                                ),
                                // ignore: deprecated_member_use

                                const SizedBox(
                                  height: 35,
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                ),
            onLoading: Center(child: loadData()),
            onEmpty: const Text("Can't fetch data"),
            onError: (error) => Center(child: Text(error.toString()))));
  }

  ImagePicker picker = ImagePicker();

  void _showMessage() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('info'),
              content:
                  Text(json.decode(editprofileController.edited)["message"]),
              actions: <Widget>[
                // ignore: deprecated_member_use
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('ok'),
                ),
              ],
            ));
  }

  loadData() {
    // Here you can write your code for open new view
    EasyLoading.show();
    Future.delayed(const Duration(milliseconds: 500), () {
// Here you can write your code

      EasyLoading.dismiss();
    });
  }
}

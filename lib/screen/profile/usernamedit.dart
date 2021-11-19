import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:qstar/controllers/editprofilecontroller.dart';
import 'package:qstar/controllers/unameditcontroller.dart';
import 'package:qstar/screen/profile/profile.dart';
import 'dart:convert';
import 'dart:io';

import '../../constant.dart';

class unamedit extends StatelessWidget {
  UnameController unameController = Get.put(UnameController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: mPrimaryColor,
                onPressed: () {
                  Navigator.of(context).pop(true);
                }),
            actions: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: unameController.saved == false
                    ? Text("Save", style: TextStyle(color: mPrimaryColor))
                    : Text(
                        "Saved",
                        style: TextStyle(color: mPrimaryColor),
                      ),
              ),
              unameController.isLoading == false 
                  ? IconButton(
                      onPressed: () {
                        unameController.editUname();
                      },
                      icon: unameController.saved==false?Icon(Icons.save):Icon(Icons.check),
                      color: mPrimaryColor)
                  : SizedBox(
                    height: 1,
                    width: 50,
                      child: Center(
                        child: CircularProgressIndicator(
                            // ignore: unrelated_type_equality_checks
                            color: mPrimaryColor),
                      ),
                    ),
            ],
          ),
          body: Form(
            key: unameController.EditUname,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Container(
              padding: EdgeInsets.only(left: 16, top: 25, right: 16),
              child: ListView(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: unameController.unameControl,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: mPrimaryColor, width: 2.0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onSaved: (value) {
                        unameController.uname = value.toString();
                      },
                      validator: (value) {
                        return unameController.validateunName(value!);
                      },
                    ),
                    unameController.unames != ''
                        ? Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "username already taken try ${unameController.unames.toString()}",
                              style: const TextStyle(
                                color: mPrimaryColor,
                              ),
                            ))
                        : Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              '',
                              style: const TextStyle(
                                color: mPrimaryColor,
                              ),
                            ))
                  ],
                ),
              ]),
            ),
          ),
        ));
  }
}

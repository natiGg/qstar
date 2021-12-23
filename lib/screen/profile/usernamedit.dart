// ignore_for_file: unrelated_type_equality_checks, duplicate_ignore

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:get/get.dart';
import 'package:qstar/controllers/unameditcontroller.dart';

import '../../constant.dart';

// ignore: camel_case_types, must_be_immutable
class unamedit extends StatelessWidget {
  UnameController unameController = Get.put(UnameController());

  unamedit({Key? key}) : super(key: key);
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
              // ignore: duplicate_ignore, duplicate_ignore
              Padding(
                padding: const EdgeInsets.all(20.0),
                // ignore: unrelated_type_equality_checks
                child: unameController.saved == false
                    ? const Text("Save", style: TextStyle(color: mPrimaryColor))
                    : const Text(
                        "Saved",
                        style: TextStyle(color: mPrimaryColor),
                      ),
              ),
              unameController.isLoading == false
                  ? IconButton(
                      onPressed: () {
                        unameController.editUname();
                      },
                      icon: unameController.saved == false
                          ? const Icon(Icons.save)
                          : const Icon(Icons.check),
                      color: mPrimaryColor)
                  : const SizedBox(
                      height: 1,
                      width: 50,
                      child: Center(
                        // ignore: duplicate_ignore
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
              padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
              child: ListView(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Username",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "username already taken try ${unameController.unames.toString()}",
                              style: const TextStyle(
                                color: mPrimaryColor,
                              ),
                            ))
                        : const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              '',
                              style: TextStyle(
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

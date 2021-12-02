import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:qstar/constant.dart';

import 'package:qstar/remote_services/service.dart';

import 'package:flutter/material.dart';
import 'package:qstar/screen/feed/model/user.dart';
import 'dart:io';

import 'package:rich_text_controller/rich_text_controller.dart';

class FeedController extends GetxController with StateMixin {
  var perfectMatches;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchPerfectMatches();
  }

  void fetchPerfectMatches() async {
    try {
      perfectMatches = await RemoteServices.fetchPerfectMatch();
      print(perfectMatches);
      if (perfectMatches.length >= 1) {
        change(perfectMatches, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } on Exception {
      change(null, status: RxStatus.error("Something went wrong"));
    }
  }

}

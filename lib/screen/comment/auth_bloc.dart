// ignore_for_file: constant_identifier_names

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'user.dart';

const Duration _defaultDelayResponse = Duration(seconds: 1);

class AuthBloc extends ChangeNotifier {
  static const TAG = 'AuthBloc';

  Result<User?>? user;

//  User get user

  AuthBloc() {
    _getUserFromLocal().then((value) {
      user = Result.value(value);
      notifyListeners();
    });
  }

  ///
  /// Fetch user from local SharePreference
  Future _getUserFromLocal() async {
    return Future<bool?>.delayed(_defaultDelayResponse, () async {
      return null;
    });
  }

  ///Handle action sign in of user
  ResultFuture<bool> signIn(String username, String password) {
    return ResultFuture<bool>(Future.delayed(_defaultDelayResponse, () {
      user = Result.value(User('dangngocduc.bk@gmail.com', 'dangngocduc',
          'assets/sample/ic_avatar_1.jpg', 'Dang Ngoc Duc'));
      notifyListeners();
      return true;
    }));
  }
}

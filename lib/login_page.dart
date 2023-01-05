import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

import 'api/api_user_calls.dart';
import 'main.dart';

const users = const {
  '1@1.com': 'one',
};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    var statusCode = await loginUser(data.name, data.password);
    debugPrint("statuscode: $statusCode");
    return Future.delayed(loginTime).then((_) {
      if (statusCode == 400) {
        return 'Server error: Access Forbidden';
      }
      if (statusCode != 200) {
        return 'Server error: $statusCode';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return "Null";
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'MEP-chat',
      //TODO add image?
      // logo: AssetImage('assets/images/'),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MyHomePage(
            title: 'MEP-chat',
          ),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}

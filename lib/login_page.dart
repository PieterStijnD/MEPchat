import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'api/api_general.dart';
import 'api/api_user_calls.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Duration get loginTime => Duration(milliseconds: 2250);

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'MEP-chat',
      //TODO add image?
      // logo: AssetImage('assets/images/'),
      onLogin: _authUser,
      onSignup: _signupUser,
      additionalSignupFields: [
        UserFormField(keyName: "Username", displayName: "username"),
        UserFormField(
            keyName: "Phone", displayName: "phone", icon: Icon(Icons.phone))
      ],
      onSubmitAnimationCompleted: () {
        context.go('/');
      },
      onRecoverPassword: _recoverPassword,
    );
  }

  Future<String?> _authUser(LoginData data) async {
    List apiKeyStatusCode = await loginUser(context, data.name, data.password);

    Provider.of<ApiData>(context, listen: false)
        .updateApiKey(apiKeyStatusCode[0]);

    return Future.delayed(loginTime).then((_) {
      if (apiKeyStatusCode[1] == 400) {
        return 'Server error: Access Forbidden';
      }
      if (apiKeyStatusCode[1] != 200) {
        return 'Server error: ${apiKeyStatusCode[1]}';
      }
      Provider.of<ApiData>(context, listen: false)
          .updateApiKey(apiKeyStatusCode[0]);
      print("key:");
      print("${Provider.of<ApiData>(context, listen: false).getApiKey()}");

      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) async {
    var additionalDataPhone = data.additionalSignupData!["Phone"];
    var addtionalDataUsername = data.additionalSignupData!["Username"];

    var statusCode = await registerUser(
        data.name, data.password, additionalDataPhone, addtionalDataUsername);

    return Future.delayed(loginTime).then((_) {
      if (statusCode == 400) {
        return 'Server error: Access Forbidden';
      }
      if (statusCode != 201) {
        return 'Server error: $statusCode';
      }
      return null;
    });
  }

  Future<String> _recoverPassword(String name) async {
    debugPrint('Name: $name');
    var statusCode = await resetUser(name);

    return Future.delayed(loginTime).then((_) {
      if (statusCode == 400) {
        return 'User not exists';
      }
      return "Null";
    });
  }
}

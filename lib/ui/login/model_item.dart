import 'package:analysist/core/constants.dart';
import 'package:analysist/core/styles_manager.dart';
import 'package:analysist/ui/login/login.dart';
import 'package:flutter/material.dart';

class LoginModelItem extends StatelessWidget {
  LoginModel loginModel;
  LoginModelItem({Key? key, required this.loginModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          loginModel.icon,
          size: 45,
        ),
        Text(
          translate(
            loginModel.title,
          ),
          textAlign: TextAlign.center,
          style: getBoldStyle(color: Colors.black, fontSize: 15),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.3,
          child: Text(
            translate(
              loginModel.body,
            ),
            textAlign: TextAlign.center,
            style: getRegularStyle(color: Colors.black),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

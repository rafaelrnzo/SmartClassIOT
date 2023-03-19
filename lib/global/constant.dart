import 'package:flutter/material.dart';

const baseApi = 'http://spklu.solusi-rnd.tech/api/';
const loginApi = 'http://spklu.solusi-rnd.tech/api/login';
const registerApi = '$baseApi/register';
const logoutApi = '$baseApi/logout';
const userApi = '$baseApi/user';

const serverError = 'server eror';
const unauthorized = 'unauthorized';
const somethingWrong = 'something Wrong';

TextButton LoadTextButton(String lable, Function onpressed){
  return TextButton(onPressed: () => onpressed, child: Text(lable));
}
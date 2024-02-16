import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin  CommonVariables {
  late final formKey = GlobalKey<FormState>();
  late RxBool secureText = true.obs;
  late RxBool secureText2 = true.obs;
  bool isAppOpen = false;
}


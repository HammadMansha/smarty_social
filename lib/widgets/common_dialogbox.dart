import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_assets/app_assets.dart';
import '../constants/app_colors/app_colors.dart';

class DialogHelper {
  static Future<void> showCommonDialog(
    BuildContext context, {
    required VoidCallback,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: Get.height / 2,
            width: Get.width / 1.6,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.asset(AppAssets.selectCamera),
                ).marginOnly(left: 20),
                SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.asset(AppAssets.selectGallery),
                ).marginOnly(right: 20)
              ],
            ),
          ),
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  // ✅ يفضل دايماً استخدام key في الـConstructor
  const CustomButton({super.key, required this.text, this.onTap});

  final String text;
  final VoidCallback? onTap; // ده بيسمح إن الـonTap يكون null

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // ✅ ده هو التعديل الأساسي:
      // لو onTap ليه قيمة، استخدمه، وإلا استخدم دالة فاضية () {}
      onTap: onTap,

      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ), // ✅ يفضل استخدام const هنا
          ),
        ),
      ),
    );
  }
}

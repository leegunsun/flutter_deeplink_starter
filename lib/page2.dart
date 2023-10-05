import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Deeppage extends StatefulWidget {
  const Deeppage({super.key});

  @override
  State<Deeppage> createState() => _DeeppageState();
}

class _DeeppageState extends State<Deeppage> {

  final text = Get.arguments ?? 'Default Text';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(text)
      ),
    );
  }
}

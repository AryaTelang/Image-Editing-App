
import 'package:flutter/cupertino.dart';

class Random extends StatefulWidget {
  const Random({Key? key}) : super(key: key);

  @override
  State<Random> createState() => _RandomState();
}

class _RandomState extends State<Random> {
  @override
  Widget build(BuildContext context) {
    return const Text("random");
  }
}

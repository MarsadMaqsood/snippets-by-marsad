import 'package:flutter/material.dart';
import 'package:touch_fx/touch_fx.dart';

class TouchEffectScreen extends StatefulWidget {
  const TouchEffectScreen({super.key});

  @override
  State<TouchEffectScreen> createState() => _TouchEffectScreenState();
}

class _TouchEffectScreenState extends State<TouchEffectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: TouchEffectLayer(
        config: TouchEffectConfig(shape: TouchShape.triangle),
      ),
    );
  }
}

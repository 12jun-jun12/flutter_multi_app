import 'package:flutter/material.dart';
import 'package:flutter_multi_app/custom_app_bar.dart';
import 'package:flutter_multi_app/utility/app_logger.dart';
import 'package:rive/rive.dart';

class FlutterRiveView extends StatefulWidget {
  const FlutterRiveView({super.key, required this.title});
  final String title;

  @override
  State<FlutterRiveView> createState() => _FlutterRiveViewState();
}

class _FlutterRiveViewState extends State<FlutterRiveView> {
  SMITrigger? _bump;

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'StateMachine1');
    if (controller == null) {
      logger.w('State Machine Controller is null');
      return;
    }
    artboard.addController(controller);
    _bump = controller.getTriggerInput('tap');
  }

  void _hitBump() => _bump?.fire();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(onPressed: _hitBump, child: const Text('Trigger Bump')),
            Expanded(
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: RiveAnimation.asset(
                  'assets/myfirstrive.riv',
                  fit: BoxFit.cover,
                  onInit: _onRiveInit,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

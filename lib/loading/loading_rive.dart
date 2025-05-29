import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoadingRive extends StatelessWidget {
  const LoadingRive({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Center(
        child: SizedBox(
          width: size.width * 0.5,
          child: const RiveAnimation.asset('assets/loading.riv'),
        ),
      ),
    );
  }
}

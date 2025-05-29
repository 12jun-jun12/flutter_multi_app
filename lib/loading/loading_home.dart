import 'package:flutter/material.dart';
import 'package:flutter_multi_app/custom_app_bar.dart';
import 'package:flutter_multi_app/loading/loading_rive.dart';

class LoadingHome extends StatelessWidget {
  const LoadingHome({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            showDialog(
              context: context,
              useSafeArea: false,
              barrierDismissible: false,
              builder: (loadingContext) {
                return LoadingRive();
              },
            );
            await Future.delayed(Duration(seconds: 3));
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
          child: Text('Show Loading!!'),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Custom App Bar',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      actions: [
        // IconButton(
        //   icon: const Icon(Icons.search),
        //   onPressed: () {
        //     // Handle search action
        //   },
        // ),
        // IconButton(
        //   icon: const Icon(Icons.notifications),
        //   onPressed: () {
        //     // Handle notifications action
        //   },
        // ),
      ],
    );
  }
}

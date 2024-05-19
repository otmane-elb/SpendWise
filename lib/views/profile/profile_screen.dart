import 'package:flutter/material.dart';

import '../home/widgets/custom_curved_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          CustomCurvedContainer(
            height: height,
            pageName: 'Profile',
            isHome: false,
          ),
        ],
      ),
    );
  }
}

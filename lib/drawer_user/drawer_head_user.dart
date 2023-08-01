import 'package:flutter/material.dart';

class DrawerHeadUser extends StatelessWidget {
  final VoidCallback action;
  final String name;
  final String Url;
  const DrawerHeadUser({super.key, required this.action, required this.name, required this.Url});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width,
      height: size.height * 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: size.height * 0.05,
            backgroundImage: NetworkImage(Url),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * 0.03,
              ),
              Text(name),
              IconButton(
                  onPressed: action,
                  icon: const Icon(Icons.settings))
            ],
          ),
        ],
      ),
    );
  }
}

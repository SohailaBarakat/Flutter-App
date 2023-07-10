import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text("مرحبا"),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("تسجيل الخروج"),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<Auth>(context, listen: false).logout();
            },
          )
        ],
      ),
    );
  }
}

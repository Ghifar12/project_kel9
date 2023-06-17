import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:project_kel9/screen/admin/dashbord_admin.dart';
import 'package:project_kel9/screen/login.dart';
import 'config/asset.dart';
import 'model/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: Asset.colorPrimaryDark,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(builder: (context, AsyncSnapshot<User?> snapshoot) {
        return DashboardAdmin();
      }),
    );
  }
}

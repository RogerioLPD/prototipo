import 'package:flutter/material.dart';
import 'package:prototipo/adm_secun_mobile.dart';
import 'package:prototipo/adm_secundario_web.dart';

class HomeClientePage extends StatelessWidget {
  const HomeClientePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const ClienteMobilePage();
        } else {
          return const AdminSecundarioPage();
        }
      },
    );
  }
}

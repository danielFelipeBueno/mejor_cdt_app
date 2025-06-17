


import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarBlur extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final VoidCallback onLogout;
  final bool connected;

  const AppBarBlur({
    super.key,
    required this.userName,
    required this.onLogout,
    required this.connected
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blur + semi-transparente
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Container(
              height: preferredSize.height + MediaQuery.of(context).padding.top,
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ),

        // Contenido del appbar
        AppBar(
          backgroundColor: Colors.transparent, // ¡Importante!
          elevation: 0,
          title: Text(
            'Hola $userName',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: connected?null:const Icon(
            CupertinoIcons.wifi_exclamationmark,
          ),
          actions: [
            IconButton(
              onPressed: onLogout,
              icon: const Icon(CupertinoIcons.square_arrow_right),
            )
          ],
        ),
      ],
    );
  }
}

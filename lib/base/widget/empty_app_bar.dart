/* Developed by Eng Mouaz M AlShahmeh */
import 'package:flutter/material.dart';

class EmptyAppBar extends AppBar implements PreferredSizeWidget {

  EmptyAppBar({Key? key}):super(key: key,
    elevation: 0.0,
  );

  @override
  Size get preferredSize => const Size(0.0, 0.0);
}

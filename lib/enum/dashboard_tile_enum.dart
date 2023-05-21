import 'package:flutter/material.dart';

import '../utilities/app_images.dart';
import '../views/snakes/snake_compare_screen.dart';
import '../views/snakes/snake_info_pdf_screen.dart';
import '../views/snakes/snakes_screen.dart';
import '../views/user_screens/user_search_screen.dart';

enum DashboardTileEnum {
  snakes('Snakes', AppImages.snakes, null, true, SnakesScreen.routeName),
  compare(
      'Compare', AppImages.compare, null, true, SnakeCompareScreen.routeName),
  emergeny('First Aid', '', Icons.add, false,
      'https://stjohnwa.com.au/online-resources/first-aid-information-and-resources/snake-bite'),
  comunity('Community', '', Icons.facebook, false,
      'https://m.facebook.com/groups/snakeidentificationaustralia/?ref=share&mibextid=ykz3hl'),
  user('Search User', AppImages.searchUser, null, true,
      UserSearchScreen.routeName),
  infoPDF('Tutorial', 'assets/info.pdf', Icons.menu_book_rounded, true,
      SnakeInfoPdfScreen.routeName),
  theme('Theme', '', null, false, '');

  const DashboardTileEnum(
    this.title,
    this.image,
    this.icon,
    this.hasScreen,
    this.routeName,
  );
  final String title;
  final String image;
  final IconData? icon;
  final bool hasScreen;
  final String routeName;
}

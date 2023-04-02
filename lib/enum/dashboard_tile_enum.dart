import '../views/snakes/snake_compare_screen.dart';
import '../views/snakes/snakes_screen.dart';
import '../views/user_screens/user_search_screen.dart';

enum DashboardTileEnum {
  snakes('Snakes', '', true, SnakesScreen.routeName),
  compare('Compare', '', true, SnakeCompareScreen.routeName),
  emergeny('Emergency', '', false, ''),
  comunity('Comunity', '', false, ''),
  user('Search User', '', true, UserSearchScreen.routeName);

  const DashboardTileEnum(
    this.title,
    this.image,
    this.hasScreen,
    this.routeName,
  );
  final String title;
  final String image;
  final bool hasScreen;
  final String routeName;
}

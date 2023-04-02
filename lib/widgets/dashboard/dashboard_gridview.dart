import 'package:flutter/material.dart';

import '../../enum/dashboard_tile_enum.dart';
import 'dashboard_tile.dart';

class DashboardGridview extends StatelessWidget {
  const DashboardGridview({super.key});

  @override
  Widget build(BuildContext context) {
    final List<DashboardTileEnum> tiles = <DashboardTileEnum>[
      DashboardTileEnum.snakes,
      DashboardTileEnum.compare,
      DashboardTileEnum.emergeny,
      DashboardTileEnum.comunity,
      DashboardTileEnum.user,
    ];
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 8,
        childAspectRatio: 4 / 5,
      ),
      primary: false,
      shrinkWrap: true,
      itemCount: tiles.length,
      itemBuilder: (BuildContext context, int index) =>
          DashboardTile(tile: tiles[index], index: index),
    );
  }
}

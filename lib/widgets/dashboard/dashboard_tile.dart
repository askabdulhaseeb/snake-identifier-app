import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../enum/dashboard_tile_enum.dart';
import '../custom_widgets/custom_shadow_bg_widget.dart';

Future<void> launchURL(Uri uri) async {
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch');
  }
}

class DashboardTile extends StatelessWidget {
  const DashboardTile({required this.tile, required this.index, super.key});
  final DashboardTileEnum tile;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: index % 2 == 0
          ? const EdgeInsets.only(left: 16)
          : const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () async {
          if (tile.hasScreen) {
            Navigator.of(context).pushNamed(tile.routeName);
          } else if (tile == DashboardTileEnum.emergeny) {
            await launchURL(Uri(scheme: 'tel', path: tile.routeName));
          } else {
            await launchURL(Uri.parse('https://devmarkaz.com'));
          }
        },
        child: CustomShadowBgWidget(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.1),
                    offset: const Offset(0, 0),
                    blurRadius: 1,
                    spreadRadius: 3,
                  )
                ],
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Image.asset(tile.image),
                    ),
                  ),
                  Text(
                    tile.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

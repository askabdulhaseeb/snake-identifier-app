import 'package:flutter/material.dart';

import '../../enum/venomous_type.dart';
import '../../models/snake.dart';
import '../../utilities/app_images.dart';
import '../../views/snakes/snake_detail_screen.dart';
import '../custom_widgets/custom_network_image.dart';
import '../custom_widgets/custom_shadow_bg_widget.dart';

class SnakeSmallTile extends StatelessWidget {
  const SnakeSmallTile({required this.snake, required this.index, super.key});
  final Snake snake;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: index % 2 == 0
          ? const EdgeInsets.only(left: 16)
          : const EdgeInsets.only(right: 16),
      child: CustomShadowBgWidget(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<SnakeDetailScreen>(
                builder: (BuildContext context) =>
                    SnakeDetailScreen(snake: snake),
              ));
            },
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
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: <Widget>[
                        SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: CustomNetworkImage(
                            imageURL: snake.imageURL[0],
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (snake.level != VenomousLevel.nonVenomous)
                          SizedBox(
                            width: 26,
                            child: Image.asset(AppImages.warning),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          snake.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 18),
                        ),
                        Text(
                          snake.scientificName,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
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

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'custom_network_image.dart';

class CustomUrlSlider extends StatelessWidget {
  const CustomUrlSlider({required this.urls, super.key});
  final List<String> urls;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items:
          urls.map((String proDetail) => _Attachment(url: proDetail)).toList(),
      options: CarouselOptions(
        aspectRatio: 4 / 3,
        viewportFraction: 1,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
      ),
    );
  }
}

class _Attachment extends StatelessWidget {
  const _Attachment({required this.url, Key? key}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: double.infinity,
      child: InteractiveViewer(
        child: CustomNetworkImage(imageURL: url),
      ),
    );
  }
}

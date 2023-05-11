import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SnakeInfoPdfScreen extends StatelessWidget {
  const SnakeInfoPdfScreen({Key? key}) : super(key: key);
  static const String routeName = '/snake-info-pdf';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfPdfViewer.asset('assets/info.pdf'),
    );
  }
}

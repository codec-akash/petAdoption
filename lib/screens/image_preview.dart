import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreview extends StatelessWidget {
  final String url;
  const ImagePreview({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview"),
      ),
      body: PhotoView(
        imageProvider: NetworkImage(url),
      ),
    );
  }
}

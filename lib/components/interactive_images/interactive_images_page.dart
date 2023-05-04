import 'package:flutter/material.dart';
import 'package:flwebkit/components/interactive_images/interactive_images_component.dart';

class InteractiveImagesPage extends StatelessWidget {
  const InteractiveImagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Interactive images")),
      body: const Center(
        child: InteractiveImagesComponent(images: [
          "assets/images/p1r.png",
          "assets/images/p2r.png",
          "assets/images/p3r.png",
          "assets/images/p2r.png",
          "assets/images/p1r.png",
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flwebkit/components/interactive_images/interactive_images_page.dart';
import 'package:flwebkit/components/pagination/pagination_page.dart';

class BasePage extends StatelessWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PaginationPage(),
                        ));
                  },
                  child: const Text("Pagination")),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InteractiveImagesPage(),
                        ));
                  },
                  child: const Text("Interactive images")),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flwebkit/components/pagination/pagination_component.dart';

class PaginationPage extends StatelessWidget {
  const PaginationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagination"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: PaginationComponent(
              forceDisableButtons: false,
              onPageChanged: (value) {},
              pagesCount: 10,
              style: PaginationButtonStyle.both,
              buttonsMargin: 5,
              paginationButtonsCount: 4,
              borderRadius: 5,
            ),
          ),
        ],
      ),
    );
  }
}

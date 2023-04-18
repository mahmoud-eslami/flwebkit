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
              onPageChanged: (value) {},
              pagesCount: 10,
              style: PaginationButtonStyle.both,
              buttonsMargin: 5,
              paginationButtonsCount: 4,
              borderRadius: 5,
              primaryColor: Colors.black,
            ),
          ),
          Center(
            child: PaginationComponent(
              onPageChanged: (value) {},
              pagesCount: 10,
              style: PaginationButtonStyle.icon,
              buttonsMargin: 5,
              paginationButtonsCount: 10,
              borderRadius: 0,
              primaryColor: Colors.red,
            ),
          ),
          Center(
            child: PaginationComponent(
              onPageChanged: (value) {},
              pagesCount: 10,
              style: PaginationButtonStyle.both,
              buttonsMargin: 5,
              paginationButtonsCount: 2,
              borderRadius: 20,
              primaryColor: Colors.indigo,
            ),
          ),
          Center(
            child: PaginationComponent(
              onPageChanged: (value) {},
              pagesCount: 19,
              style: PaginationButtonStyle.both,
              buttonsMargin: 5,
              height: 22,
              paginationButtonsCount: 20,
              borderRadius: 20,
              primaryColor: Colors.green,
            ),
          ),
          Center(
            child: PaginationComponent(
              onPageChanged: (value) {},
              pagesCount: 19,
              style: PaginationButtonStyle.both,
              buttonsMargin: 5,
              height: 30,
              paginationButtonsCount: 1,
              borderRadius: 20,
              primaryColor: Colors.orange,
            ),
          ),
          Center(
            child: PaginationComponent(
              onPageChanged: (value) {},
              pagesCount: 5,
              style: PaginationButtonStyle.both,
              buttonsMargin: 5,
              height: 50,
              paginationButtonsCount: 5,
              borderRadius: 5,
              primaryColor: Colors.black,
              prevWidget: Text(
                "👈🏻",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              nextWidget: Text(
                "👉🏻",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum PaginationButtonStyle { icon, text, both }

class PaginationComponent extends HookWidget {
  const PaginationComponent({
    Key? key,
    required this.pagesCount,
    required this.onPageChanged,
    required this.style,
    this.borderRadius = 5,
    this.paginationButtonsCount = 5,
    this.height = 40,
    this.buttonsMargin = 5,
    this.primaryColor = Colors.black,
  }) : super(key: key);

  final int pagesCount, paginationButtonsCount;
  final PaginationButtonStyle style;
  final double height, buttonsMargin, borderRadius;
  final Color primaryColor;
  final ValueChanged<int>? onPageChanged;

  @override
  Widget build(BuildContext context) {
    var currentPage = useState(1);
    var startPage = useState(1);

    useEffect(() {
      onPageChanged?.call(currentPage.value);

      if (currentPage.value > startPage.value + paginationButtonsCount) {
        startPage.value =
            min(currentPage.value - paginationButtonsCount, pagesCount);
      } else if (currentPage.value < startPage.value) {
        startPage.value = max(1, currentPage.value - paginationButtonsCount);
      }

      return;
    }, [currentPage.value]);

    return SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PaginationButton(
            onPressed: () {
              if (currentPage.value > 1) {
                currentPage.value--;
              }
            },
            radius: borderRadius,
            style: style,
            icon: Icons.arrow_back,
            height: height,
            text: "Previous",
            primaryColor: primaryColor,
          ),
          SizedBox(
            width: buttonsMargin,
          ),
          for (var i = startPage.value;
              i <= min(startPage.value + paginationButtonsCount, pagesCount);
              i++)
            GestureDetector(
              onTap: () => currentPage.value = i,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(
                  horizontal: 2,
                ),
                decoration: BoxDecoration(
                  color: currentPage.value == i ? primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(
                    color: primaryColor,
                    width: 1.5,
                  ),
                ),
                height: height,
                width: height,
                child: Center(
                  child: Text(
                    "$i",
                    style: TextStyle(
                      color:
                          currentPage.value == i ? Colors.white : primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          SizedBox(
            width: buttonsMargin,
          ),
          PaginationButton(
            onPressed: () {
              if (currentPage.value < pagesCount) {
                currentPage.value++;
              }
            },
            radius: borderRadius,
            style: style,
            icon: Icons.arrow_forward,
            height: height,
            text: "Next",
            primaryColor: primaryColor,
          ),
        ],
      ),
    );
  }
}

class PaginationButton extends StatelessWidget {
  const PaginationButton(
      {super.key,
      required this.style,
      required this.height,
      required this.onPressed,
      required this.primaryColor,
      required this.radius,
      this.text,
      this.icon});

  final PaginationButtonStyle style;
  final IconData? icon;
  final String? text;
  final double height, radius;
  final VoidCallback? onPressed;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      color: Colors.white,
    );
    Widget child;
    if (style == PaginationButtonStyle.icon) {
      child = Icon(
        icon ?? Icons.arrow_forward_ios,
        color: Colors.white,
      );
    } else if (style == PaginationButtonStyle.text) {
      child = Center(
          child: Text(
        text ?? "Default text",
        style: textStyle,
      ));
    } else {
      child = Row(
        children: [
          Text(
            text ?? "Default text",
            style: textStyle,
          ),
          const SizedBox(
            width: 5,
          ),
          Icon(
            icon,
            color: Colors.white,
          ),
        ],
      );
    }

    return InkWell(
      onTap: () {
        onPressed?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: primaryColor,
            width: 1.5,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        height: height,
        child: child,
      ),
    );
  }
}

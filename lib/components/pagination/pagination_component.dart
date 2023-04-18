import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

getSecondaryColor(Color primaryColor) {
  return primaryColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
}

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
    this.prevWidget,
    this.nextWidget,
  }) : super(key: key);

  final int pagesCount, paginationButtonsCount;
  final PaginationButtonStyle style;
  final double height, buttonsMargin, borderRadius;
  final Color primaryColor;
  final ValueChanged<int>? onPageChanged;
  final Widget? prevWidget, nextWidget;

  @override
  Widget build(BuildContext context) {
    var currentPage = useState(1);
    var startPage = useState(1);

    useEffect(() {
      onPageChanged?.call(currentPage.value);

      if (currentPage.value > startPage.value + paginationButtonsCount) {
        startPage.value = min(currentPage.value, pagesCount);
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
            mainChild: prevWidget,
            iconSize: height - 5,
            enabled: currentPage.value > 1,
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
                  color: currentPage.value == i
                      ? primaryColor
                      : Colors.transparent,
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
                      color: currentPage.value == i
                          ? getSecondaryColor(primaryColor)
                          : primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          SizedBox(
            width: buttonsMargin,
          ),
          PaginationButton(
            mainChild: nextWidget,
            iconSize: height - 5,
            enabled: currentPage.value < pagesCount,
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
      required this.enabled,
      required this.iconSize,
      this.mainChild,
      this.text,
      this.icon});

  final Widget? mainChild;
  final PaginationButtonStyle style;
  final IconData? icon;
  final String? text;
  final double height, radius, iconSize;
  final VoidCallback? onPressed;
  final Color primaryColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    TextStyle tStyle = TextStyle(
      color: enabled ? getSecondaryColor(primaryColor) : Colors.grey,
    );
    Widget child;
    if (mainChild != null) {
      child = mainChild!;
    } else if (style == PaginationButtonStyle.icon) {
      child = Icon(
        icon ?? Icons.star,
        color: enabled ? getSecondaryColor(primaryColor) : Colors.grey,
        size: iconSize,
      );
    } else if (style == PaginationButtonStyle.text) {
      child = Center(
          child: Text(
        text ?? "Default text",
        style: tStyle,
      ));
    } else {
      child = Row(
        children: [
          Text(
            text ?? "Default text",
            style: tStyle,
          ),
          const SizedBox(
            width: 5,
          ),
          Icon(
            icon,
            color: enabled ? getSecondaryColor(primaryColor) : Colors.grey,
            size: iconSize,
          ),
        ],
      );
    }

    return InkWell(
      onTap: () {
        onPressed?.call();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: enabled ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: enabled ? primaryColor : Colors.grey,
            width: 1.5,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        height: height,
        child: Center(child: child),
      ),
    );
  }
}

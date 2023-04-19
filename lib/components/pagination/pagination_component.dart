import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'color_model.dart';

enum PaginationButtonStyle { icon, text, both }

class PaginationComponent extends HookWidget {
  const PaginationComponent({
    Key? key,
    required this.pagesCount,
    required this.onPageChanged,
    required this.style,
    this.forceDisableButtons = false,
    this.colors = const ColorModel(
      activeBorderColor: Colors.black,
      inactiveBorderColor: Colors.grey,
      activeTextColor: Colors.white,
      inactiveTextColor: Colors.grey,
      activeBackgroundColor: Colors.black,
      inactiveBackgroundColor: Colors.white,
      activeIconColor: Colors.white,
      inactiveIconColor: Colors.grey,
      selectedPageButtonBackgroundColor: Colors.black,
      pageButtonBackgroundColor: Colors.white,
      selectedPageButtonBorderColor: Colors.black,
      pageButtonBorderColor: Colors.grey,
      selectedPageButtonTextColor: Colors.white,
      pageButtonTextColor: Colors.grey,
    ),
    this.borderRadius = 5,
    this.paginationButtonsCount = 5,
    this.height = 40,
    this.buttonsMargin = 5,
    this.prevWidget,
    this.nextWidget,
  }) : super(key: key);

  final int pagesCount, paginationButtonsCount;
  final PaginationButtonStyle style;
  final double height, buttonsMargin, borderRadius;
  final ValueChanged<int>? onPageChanged;
  final Widget? prevWidget, nextWidget;
  final ColorModel colors;
  final bool forceDisableButtons;

  @override
  Widget build(BuildContext context) {
    var currentPage = useState(1);
    var startPage = useState(1);

    useEffect(() {
      onPageChanged?.call(currentPage.value);

      if (currentPage.value > startPage.value + paginationButtonsCount) {
        var difference = pagesCount - currentPage.value;
        if (difference < paginationButtonsCount) {
          startPage.value = max(1, pagesCount - paginationButtonsCount);
        } else {
          startPage.value = min(currentPage.value, pagesCount);
        }
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
            forceDisabled: forceDisableButtons,
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
            colors: colors,
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
                      ? colors.selectedPageButtonBackgroundColor
                      : colors.pageButtonBackgroundColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(
                    color: currentPage.value == i
                        ? colors.selectedPageButtonBorderColor
                        : colors.pageButtonBorderColor,
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
                          ? colors.selectedPageButtonTextColor
                          : colors.pageButtonTextColor,
                    ),
                  ),
                ),
              ),
            ),
          SizedBox(
            width: buttonsMargin,
          ),
          PaginationButton(
            forceDisabled: forceDisableButtons,
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
            colors: colors,
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
      required this.colors,
      required this.radius,
      required this.enabled,
      required this.iconSize,
      required this.forceDisabled,
      this.mainChild,
      this.text,
      this.icon});

  final Widget? mainChild;
  final PaginationButtonStyle style;
  final IconData? icon;
  final String? text;
  final double height, radius, iconSize;
  final VoidCallback? onPressed;
  final ColorModel colors;
  final bool enabled, forceDisabled;

  @override
  Widget build(BuildContext context) {
    TextStyle tStyle = TextStyle(
      color: enabled ? colors.activeTextColor : colors.inactiveTextColor,
    );
    Widget child;
    if (mainChild != null) {
      child = mainChild!;
    } else if (style == PaginationButtonStyle.icon) {
      child = Icon(
        icon ?? Icons.star,
        color: enabled ? colors.activeIconColor : colors.inactiveIconColor,
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
            color: enabled ? colors.activeIconColor : colors.inactiveIconColor,
            size: iconSize,
          ),
        ],
      );
    }

    return InkWell(
      onTap: () {
        if (!forceDisabled) onPressed?.call();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: enabled
              ? colors.activeBackgroundColor
              : colors.inactiveBackgroundColor,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color:
                enabled ? colors.activeBorderColor : colors.inactiveBorderColor,
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

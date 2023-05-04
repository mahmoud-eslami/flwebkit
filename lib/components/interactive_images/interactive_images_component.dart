import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class InteractiveImagesComponent extends HookWidget {
  const InteractiveImagesComponent({Key? key, required this.images})
      : super(key: key);

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    var currentImage = useState(20);
    var hover = useState(false);
    var hoverdIndex = useState(0);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        images.length,
        (index) {
          bool isSelected = index == currentImage.value;
          bool isHovered = hover.value && index == hoverdIndex.value;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: MouseRegion(
              onEnter: (event) {
                hover.value = true;
                hoverdIndex.value = index;
              },
              onExit: (event) {
                hover.value = false;
              },
              child: GestureDetector(
                onTap: () => currentImage.value = index,
                child: AnimatedContainer(
                  width: isSelected
                      ? 250
                      : isHovered
                          ? 90
                          : 60,
                  height: MediaQuery.of(context).size.height * .4,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  duration: const Duration(
                    milliseconds: 600,
                  ),
                  curve: Curves.decelerate,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * .3,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(10),
                            ),
                            child: Image.asset(
                              images[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          if (isSelected)
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Lorem Ipsum is simply dummy text of"
                                    " the printing and typesetting industry.",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.black38,
                                        ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Title #${index + 1}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PopUpMenuWidget<T> extends StatelessWidget {
  const PopUpMenuWidget({
    super.key,
    required this.items,
  });

  final List<PopupMenuEntry<T>> items;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24 / 2),
      child: Icon(
        Icons.more_vert,
        size: 24,
      ),
      onTap: () {
        final RenderBox button = context.findRenderObject()! as RenderBox;
        final RenderBox overlay = Navigator.of(context)
            .overlay!
            .context
            .findRenderObject()! as RenderBox;

        final offset = Offset(0, button.size.height);

        final RelativeRect position = RelativeRect.fromRect(
          Rect.fromPoints(
            button.localToGlobal(offset, ancestor: overlay),
            button.localToGlobal(button.size.bottomRight(offset),
                ancestor: overlay),
          ),
          Offset.zero & overlay.size,
        );
        showMenu(
          context: context,
          position: position,
          items: items,
        );
      },
    );
  }
}

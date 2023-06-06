import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/ui/pages/home/manage_password/manage_password_page.dart';
import 'package:my_password_app/ui/pages/views/floating_button_drawer.dart';
import 'package:my_password_app/ui/widgets/space_widget.dart';

class FloatingButtonView extends ConsumerStatefulWidget {
  const FloatingButtonView({
    super.key,
  });

  @override
  ConsumerState<FloatingButtonView> createState() => _FloatingButtonViewState();
}

class _FloatingButtonViewState extends ConsumerState<FloatingButtonView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: 'floatingButton1',
          onPressed: () async {
            await ManagePasswordPage.show(
              context: context,
            );
          },
          child: Icon(Icons.add),
        ),
        SpaceWidget.hori8,
        FloatingButtonDrawer(),
      ],
    );
  }
}

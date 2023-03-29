import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/core/providers/password/password_notifier.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_size.dart';
import 'package:my_password_app/ui/widgets/modal_password_widget.dart';

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
    // return SizedBox();
    final passwordRead = ref.read(passwordProvider.notifier);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: 'floatingButton1',
          onPressed: () {
            ModalPasswordWidget.show(
              context: context,
              onPressedSave: (val) {
                passwordRead.add(val);
                Navigator.pop(context);
              },
            );
          },
          child: Icon(Icons.add),
        ),
        KSize.hori8,
        FloatingActionButton(
          heroTag: 'floatingButton2',
          onPressed: () {
            // passwordRead.sync();
            // return;
            Scaffold.of(context).openEndDrawer();
          },
          child: Icon(Icons.menu),
        ),
      ],
    );
  }
}

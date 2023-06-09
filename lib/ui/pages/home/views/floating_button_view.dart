import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/ui/pages/home/home_notifier.dart';
import 'package:my_password_app/ui/pages/home/manage_password/manage_password_page.dart';

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
    return Wrap(
      direction: Axis.vertical,
      spacing: 8,
      children: [
        FloatingActionButton(
          child: Icon(Icons.upload),
          onPressed: () {
            ref.read(homeNotifier.notifier).push();
          },
        ),
        FloatingActionButton(
          child: Icon(Icons.download),
          onPressed: () {
            ref.read(homeNotifier.notifier).pull();
          },
        ),
        FloatingActionButton(
          heroTag: 'floatingButton1',
          onPressed: () async {
            await ManagePasswordPage.show(
              context: context,
              managePasswordPage: ManagePasswordPage(),
            );
          },
          child: Icon(Icons.add),
        ),
      ],
    );
  }
}

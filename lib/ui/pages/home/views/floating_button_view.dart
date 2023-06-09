import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/core/enums/sync_enum.dart';
import 'package:my_password_app/ui/pages/home/home_notifier.dart';
import 'package:my_password_app/ui/pages/home/manage_password/manage_password_page.dart';
import 'package:my_password_app/ui/widgets/alert_dialog_widget.dart';

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
          child: Icon(Icons.merge),
          onPressed: () {
            AlertDialogWidget.show(
              context,
              child: AlertDialogWidget(
                title:
                    'Aksi ini akan menimpa data yang sama dan akan menggambungkan data yang berbeda dari penyimpanan lokal dan google drive',
                onPressYes: () {
                  Navigator.pop(context);
                  ref.read(homeNotifier.notifier).sycnData(
                        sync: SyncEnum.merge,
                      );
                },
              ),
            );
          },
        ),
        FloatingActionButton(
          child: Icon(Icons.upload),
          onPressed: () {
            AlertDialogWidget.show(
              context,
              child: AlertDialogWidget(
                title: 'Aksi ini akan menimpa semua data ada di google drive',
                onPressYes: () {
                  Navigator.pop(context);
                  ref.read(homeNotifier.notifier).sycnData(
                        sync: SyncEnum.push,
                      );
                },
              ),
            );
          },
        ),
        FloatingActionButton(
          child: Icon(Icons.download),
          onPressed: () {
            AlertDialogWidget.show(
              context,
              child: AlertDialogWidget(
                title:
                    'Aksi ini akan menimpa semua data ada di penyimpanan lokal',
                onPressYes: () {
                  Navigator.pop(context);
                  ref.read(homeNotifier.notifier).sycnData(
                        sync: SyncEnum.pull,
                      );
                },
              ),
            );
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/extensions/context_extension.dart';
import 'package:my_password_app/core/providers/sign_in/sign_in_notifier.dart';
import 'package:my_password_app/ui/konstans/k_size.dart';
import 'package:my_password_app/ui/pages/home/home_v2_page.dart';

class SignInFingerPrintView extends ConsumerStatefulWidget {
  const SignInFingerPrintView({super.key});

  @override
  ConsumerState<SignInFingerPrintView> createState() =>
      _SignInFingerPrintViewState();
}

class _SignInFingerPrintViewState extends ConsumerState<SignInFingerPrintView> {
  @override
  void initState() {
    auth();
    super.initState();
  }

  void auth() {
    ref.read(signInProvider.notifier).authWithBiometric(context);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(signInProvider, (prev, next) {
      if (next.isLoggedIn) {
        context.pushAndReplace(HomeV2Page());
      }
    });

    final fingerSize = KSize.s48;
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(fingerSize),
          onTap: () {
            auth();
          },
          child: Container(
            margin: EdgeInsets.all(KSize.s8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(fingerSize),
              color: Colors.white,
            ),
            child: Icon(
              Icons.fingerprint,
              color: Colors.blue,
              size: fingerSize,
            ),
          ),
        )
      ],
    );
  }
}

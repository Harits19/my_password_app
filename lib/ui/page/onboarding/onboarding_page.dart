import 'package:flutter/material.dart';
import 'package:my_password_app/konstan/k_ui.dart';
import 'package:easy_localization/easy_localization.dart';

class OnboardingPage extends StatelessWidget {
  static const routeName = "/onboarding";

  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(KUi.edgeLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(),
              KUi.verticalMedium,
              Text(
                "onboarding".tr(),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}

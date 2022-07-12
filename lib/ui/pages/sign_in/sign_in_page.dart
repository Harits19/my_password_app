import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_password_app/cubits/auth/auth_cubit.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:my_password_app/ui/app_ui/show_helper.dart';
import 'package:my_password_app/ui/pages/home/home_page.dart';
import 'package:my_password_app/ui/app_ui/navigator_helper.dart';

class SignInPage extends StatefulWidget {
  static const routeName = "/sign-in";

  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  int _selectedPage = 0;
  late final _pageController = PageController(initialPage: _selectedPage);

  late final Timer? _timer;

  List<int> get _pageItem => [0, 1, 2, 3];
  int _manySpin = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (time) async {
      final nexPage = (_pageController.page?.toInt() ?? 0) + 1;
      await _pageController.animateToPage(
        nexPage,
        duration: Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _timer?.cancel();
  }

  void _pageChanged(int currentPage) {
    print("current page $currentPage");
    _selectedPage = currentPage % _pageItem.length;
    print("selected page $_selectedPage");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignIn) {
          NavigatorHelper.popAll(context, HomePage.routeName);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _pageChanged,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Text(_pageItem[_selectedPage].toString()),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    _pageItem.length,
                    (index) => Icon(
                      Icons.circle,
                      color:
                          index == _selectedPage ? Colors.blue : Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(KSize.s16),
                child: ElevatedButton(
                  child: Text(
                    "signInGoogle".tr(),
                  ),
                  onPressed: () async {
                    ShowHelper.showLoading(context);
                    try {
                      await authCubit.signInWithGoogle();
                    } catch (e) {
                      ShowHelper.snackbar(context, e);
                    }
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

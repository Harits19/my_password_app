import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_locale.dart';

enum Tr {
  cantBeEmpty(
    'Can\' be Empty',
    'Text tidak boleh kosong',
  ),

  save(
    'Save',
    'Simpan',
  ),
  notMatch(
    'Not Match',
    'Tidak Sama',
  );

  const Tr(
    this._id,
    this._en,
  );

  final String _id;
  final String _en;

  String value(BuildContext context) {
    final locale = EasyLocalization.of(context)?.currentLocale;
    if (locale == KLocale.id) {
      return _id;
    }
    return _en;
  }
}

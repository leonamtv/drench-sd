import 'package:drench/pages/home_page/components/connection_dialog/connection_dialog_form.dart';
import 'package:flutter/material.dart';

class ConnectionDialogService {
  Future show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => _alertDialog(context),
    );
  }

  AlertDialog _alertDialog(BuildContext context) {
    return new AlertDialog(
      title: Text('Conectar-se a outro dispositivo'),
      contentPadding: EdgeInsets.fromLTRB(16, 20, 16, 16),
      content: _content(),
    );
  }

  Widget _content() {
    return ConnectionDialogForm();
  }
}

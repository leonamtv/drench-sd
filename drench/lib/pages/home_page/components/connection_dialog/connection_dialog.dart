import 'package:drench/pages/home_page/components/connection_dialog/connection_dialog_form.dart';
import 'package:drench/pages/home_page/components/connection_dialog/connection_dialog_form_controller.dart';
import 'package:flutter/material.dart';

class ConnectionDialog {
  final ConnectionDialogFormController formController =
      new ConnectionDialogFormController();

  Future show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => _alertDialog(context),
    );
  }

  AlertDialog _alertDialog(BuildContext context) {
    return new AlertDialog(
      title: Text('Conectar-se a outro dispositivo'),
      content: _content(),
      actions: _actions(context),
    );
  }

  Widget _content() {
    return ConnectionDialogForm(
      controller: formController,
    );
  }

  List<Widget> _actions(BuildContext context) {
    return <Widget>[
      new FlatButton(
        onPressed: () =>
            Navigator.of(context).pop(this.formController.getValues()),
        textColor: Theme.of(context).primaryColor,
        child: const Text('Iniciar conexão'),
      ),
    ];
  }
}

import 'package:drench/pages/home_page/components/connection_dialog/connection_dialog_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConnectionDialogForm extends StatefulWidget {
  final ConnectionDialogFormController controller;

  ConnectionDialogForm({this.controller}) {}

  @override
  _ConnectionDialogFormState createState() =>
      _ConnectionDialogFormState(controller);
}

class _ConnectionDialogFormState extends State<ConnectionDialogForm> {
  TextEditingController _ipAddressFieldController;
  TextEditingController _portFieldController;
  bool _isServer = true;
  bool _isTcp = true;

  _ConnectionDialogFormState(ConnectionDialogFormController controller) {
    this._ipAddressFieldController = TextEditingController(text: '127.0.0.1');
    this._portFieldController = TextEditingController();

    controller.getValues = this.getValues;
  }

  getValues() {
    return {
      'idAddress': this._ipAddressFieldController.text,
      'port': this._portFieldController.text,
      'isServer': this._isServer,
      'isTcp': this._isTcp
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ipAddressField(),
        _portField(),
        SizedBox(
          height: 40,
        ),
        _isServerField(),
        _isTcpField(),
      ],
    );
  }

  Widget _ipAddressField() {
    return TextField(
      controller: _ipAddressFieldController,
      autofocus: true,
      decoration: InputDecoration(
        labelText: 'Endereço Ip',
      ),
    );
  }

  Widget _portField() {
    return TextField(
      controller: _portFieldController,
      decoration: InputDecoration(
        labelText: 'Porta',
      ),
    );
  }

  Widget _isServerField() {
    return SwitchListTile(
      title: const Text('Servidor'),
      value: _isServer,
      onChanged: (bool value) {
        setState(() {
          _isServer = value;
        });
      },
    );
  }

  Widget _isTcpField() {
    return SwitchListTile(
      title: const Text('Usar TCP'),
      value: _isTcp,
      onChanged: (bool value) {
        setState(() {
          _isTcp = value;
        });
      },
    );
  }
}

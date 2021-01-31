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
  bool _isTcp = true;
  bool _isServer = false;
  TextEditingController _ipAddressFieldController;
  TextEditingController _portFieldController;

  _ConnectionDialogFormState(ConnectionDialogFormController controller) {
    this._ipAddressFieldController = TextEditingController(text: '127.0.0.1');
    this._portFieldController = TextEditingController();

    controller.getValues = this.getValues;
  }

  getValues() {
    var values = {'isTcp': _isTcp, 'port': this._portFieldController.text};

    if (hasIsServerField()) {
      values['isServer'] = _isServer;
    }

    if (hasIpAddressField()) {
      values['ipAddress'] = this._ipAddressFieldController.text;
    }

    return values;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _getFields(),
    );
  }

  List<Widget> _getFields() {
    List<Widget> fields = [
      _isTcpField(),
    ];

    if (hasIsServerField()) {
      fields.add(_isServerField());
    }

    fields.add(SizedBox(height: 40));

    if (hasIpAddressField()) {
      fields.add(_ipAddressField());
    }

    fields.add(_portField());

    return fields;
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

  bool hasIsServerField() {
    return _isTcp;
  }

  bool hasIpAddressField() {
    return !_isTcp || _isTcp && !_isServer;
  }
}

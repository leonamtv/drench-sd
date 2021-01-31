import 'package:drench/features/multiplayer/socket/connection_params.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConnectionDialogForm extends StatefulWidget {
  ConnectionDialogForm() {}

  @override
  _ConnectionDialogFormState createState() => _ConnectionDialogFormState();
}

class _ConnectionDialogFormState extends State<ConnectionDialogForm> {
  bool _isTcp = true;
  bool _isServer = false;
  TextEditingController _ipAddressFieldController;
  TextEditingController _portFieldController;

  _ConnectionDialogFormState() {
    this._ipAddressFieldController = TextEditingController(text: '127.0.0.1');
    this._portFieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _getFields(),
      ),
    );
  }

  List<Widget> _getFields() {
    List<Widget> list = [
      _isTcpField(),
      hasIsServerField() ? _isServerField() : null,
      SizedBox(height: 20),
      hasIpAddressField() ? _ipAddressField() : null,
      _portField(),
      SizedBox(height: 40),
      _submitButton()
    ];

    return list.where((field) => field != null).toList();
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

  Widget _ipAddressField() {
    return TextField(
      controller: _ipAddressFieldController,
      autofocus: true,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'Endereço Ip',
      ),
    );
  }

  Widget _portField() {
    return TextField(
      controller: _portFieldController,
      textInputAction: TextInputAction.go,
      onSubmitted: (_) => _initConnection(),
      decoration: InputDecoration(
        labelText: 'Porta',
      ),
    );
  }

  Widget _submitButton() {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            _submitButtonText(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        onPressed: _initConnection,
      ),
    );
  }

  String _submitButtonText() {
    if (!this._isTcp) {
      return 'Abrir porta UDP';
    }

    if (this._isServer) {
      return 'Iniciar servidor TCP';
    }

    return 'Estabelecer conexão TCP';
  }

  _initConnection() {
    ConnectionParams params = this.getValues();
    Navigator.of(this.context).pop(params);
  }

  ConnectionParams getValues() {
    return ConnectionParams(
      isTcp: _isTcp,
      isServer: hasIsServerField() ? _isServer : null,
      ipAddress:
          hasIpAddressField() ? this._ipAddressFieldController.text : null,
      port: this._portFieldController.text,
    );
  }

  bool hasIsServerField() {
    return _isTcp;
  }

  bool hasIpAddressField() {
    return !_isTcp || _isTcp && !_isServer;
  }
}

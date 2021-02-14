import 'package:drench/features/multiplayer/socket/connection_params.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  TextEditingController _remotePortFieldController;

  _ConnectionDialogFormState() {
    this._ipAddressFieldController = TextEditingController(text: '127.0.0.1');
    this._portFieldController = TextEditingController(text: '2121');
    this._remotePortFieldController = TextEditingController(text: '2122');
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
      hasRemotePortField() ? _remotePortField() : null,
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
      textInputAction:
          hasRemotePortField() ? TextInputAction.next : TextInputAction.go,
      onSubmitted: (_) => hasRemotePortField() ? null : _initConnection(),
      onChanged: (String port) {
        setState(() {});
      },
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        labelText: 'Porta',
        errorText:
            isValidPort() ? null : 'Porta inválida. Precisa ser maior que 1024',
      ),
    );
  }

  Widget _remotePortField() {
    return TextField(
      controller: _remotePortFieldController,
      textInputAction: TextInputAction.go,
      onSubmitted: (_) => _initConnection(),
      onChanged: (String port) {
        setState(() {});
      },
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        labelText: 'Porta remota',
        errorText: isValidRemotePort()
            ? null
            : 'Porta inválida. Precisa ser maior que 1024',
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
        onPressed:
            isValidPort() && (hasRemotePortField() ? isValidRemotePort() : true)
                ? _initConnection
                : null,
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
      port: int.parse(this._portFieldController.text),
      remotePort: int.parse(this._remotePortFieldController.text),
    );
  }

  bool isValidPort() {
    String port = _portFieldController.text;

    if (port.isNotEmpty && int.parse(port) <= 1024) {
      return false;
    }

    return true;
  }

  bool isValidRemotePort() {
    String remotePort = _remotePortFieldController.text;

    if (remotePort.isNotEmpty && int.parse(remotePort) <= 1024) {
      return false;
    }

    return true;
  }

  bool hasIsServerField() {
    return _isTcp;
  }

  bool hasRemotePortField() {
    return !_isTcp;
  }

  bool hasIpAddressField() {
    return !_isTcp || _isTcp && !_isServer;
  }
}

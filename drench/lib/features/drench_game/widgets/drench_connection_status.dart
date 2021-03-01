import 'package:drench/features/multiplayer/connection_params.model.dart';
import 'package:flutter/widgets.dart';

class DrenchConnectionStatus extends StatelessWidget {
  final ConnectionParams connectionParams;

  final TextStyle textStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  DrenchConnectionStatus({this.connectionParams});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(child: _textsWidgets()),
    );
  }

  _textsWidgets() {
    if (this.connectionParams == null) {
      return _withoutConnection();
    }

    if (this.connectionParams.isTcp && this.connectionParams.isServer) {
      return _tcpServer();
    }

    return _tcpClientOrUpd();
  }

  _withoutConnection() {
    return Text(
      'Sem conexão',
      style: textStyle,
    );
  }

  _tcpServer() {
    return Column(
      children: <Widget>[
        Text(
          'Servidor TCP aberto na porta ${this.connectionParams.port}',
          style: textStyle,
        ),
        SizedBox(
          height: 5,
        ),
        _clienteInfoInTcpServer(),
      ].where((element) => element != null).toList(),
    );
  }

  Widget _clienteInfoInTcpServer() {
    if (this.connectionParams.remoteIpAddress == null) {
      return null;
    }

    return Text(
      'Cliente connectado: ${this.connectionParams.remoteIpAddress}:${this.connectionParams.remotePort}',
      style: textStyle,
    );
  }

  Widget _tcpClientOrUpd() {
    return Column(
      children: <Widget>[
        Text(
          getTcpClientOrUpdText(),
          style: textStyle,
        ),
      ],
    );
  }

  String getTcpClientOrUpdText() {
    if (connectionParams.isTcp) {
      return 'Cliente TCP conectado ao servidor ${this.connectionParams.ipAddress}:${this.connectionParams.port}';
    }

    return 'Host UDP aberto na porta ${this.connectionParams.port}';
  }
}

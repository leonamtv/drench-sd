import 'dart:convert';
import 'dart:io';

import 'package:drench/features/multiplayer/socket/connection_params.model.dart';
import 'package:drench/features/multiplayer/socket/tcp/tcp_connection.dart';
import 'package:drench/features/multiplayer/socket/tcp/udp_connection.dart';
import 'package:rxdart/subjects.dart';

class SocketConnectionService {
  BehaviorSubject<ConnectionParams> currentConnectionParams$ =
      BehaviorSubject<ConnectionParams>();

  ReplaySubject<Map<String, dynamic>> dataReceiving$ =
      ReplaySubject<Map<String, dynamic>>();

  TcpConnection _tcp;
  UdpConnection _udp;

  SocketConnectionService() {
    _tcp = TcpConnection(socketConnectionService: this);
    _udp = UdpConnection(socketConnectionService: this);
  }

  void connect(ConnectionParams connectionParams) {
    closeActiveConnections();

    if (connectionParams.isTcp) {
      this._tcp.openConnection(connectionParams);
      return;
    }

    this._udp.openConnection(connectionParams);
  }

  void sendData(Map<String, dynamic> data) {
    ConnectionParams connectionParams = getConnectionParams();

    if (connectionParams == null) {
      print("There's no active connection");
      return;
    }

    if (connectionParams.isTcp) {
      this._tcp.sendMessage(json.encode(data));
      return;
    }

    this._udp.sendMessage(json.encode(data));
  }

  void updateConnectionParams(ConnectionParams connectionParams) {
    if (connectionParams == null) {
      this.currentConnectionParams$.add(null);
      return;
    }

    ConnectionParams newObject = ConnectionParams(
        isTcp: connectionParams.isTcp,
        isServer: connectionParams.isServer,
        ipAddress: connectionParams.ipAddress,
        port: connectionParams.port,
        remoteIpAddress: connectionParams.remoteIpAddress,
        remotePort: connectionParams.remotePort);

    this.currentConnectionParams$.add(newObject);
  }

  void broadcastMessageReceived(dynamic data) {
    try {
      dataReceiving$.add(json.decode(data));
      dataReceiving$.add(json.decode(data));
    } catch (e) {}
  }

  void closeActiveConnections() {
    this._tcp.closeActiveConnections();
    this._tcp.closeActiveConnections();
  }

  getInformationMessage(String message) {
    return json.encode({'type': 'information', 'message': message});
  }

  ConnectionParams getConnectionParams() {
    return this.currentConnectionParams$.value;
  }
}

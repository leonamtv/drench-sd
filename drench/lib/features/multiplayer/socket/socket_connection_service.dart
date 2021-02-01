import 'dart:convert';
import 'dart:io';

import 'package:drench/features/multiplayer/socket/connection_params.model.dart';
import 'package:rxdart/subjects.dart';

class SocketConnectionService {
  BehaviorSubject<ConnectionParams> currentConnectionParams$ =
      BehaviorSubject<ConnectionParams>();

  ReplaySubject<Map<String, dynamic>> dataReceiving$ =
      ReplaySubject<Map<String, dynamic>>();

  Socket tcpClient;
  Socket tcpRemoteClient;
  ServerSocket tcpServer;

  void connect(ConnectionParams connectionParams) {
    closeActiveConnections();

    if (connectionParams.isTcp) {
      this.connectWithTcp(connectionParams);
      return;
    }

    print(connectionParams.toJson());
  }

  void connectWithTcp(ConnectionParams connectionParams) async {
    print('-----');
    print(connectionParams.toJson());
    if (connectionParams.isServer) {
      openTcpServer(connectionParams);
      return;
    }

    connectWithTcpClient(connectionParams);
  }

  void openTcpServer(ConnectionParams connectionParams) async {
    this.tcpServer =
        await ServerSocket.bind(InternetAddress.anyIPv4, connectionParams.port);

    updateConnectionParams(connectionParams);

    this.tcpServer.listen(handleClientConnectionInTcpServer);
  }

  handleClientConnectionInTcpServer(Socket client) {
    print(
      'Connection from '
      '${client.remoteAddress.address}:${client.remotePort}',
    );

    if (tcpRemoteClient != null) {
      print(
        'Another client connected. Closing connection with '
        '${client.remoteAddress.address}:${client.remotePort}',
      );

      client.write(getInformationMessage('another-client-connected'));
      client.close();
      return;
    }

    ConnectionParams connectionParams = getConnectionParams();

    client.write(getInformationMessage('welcome-to-drench'));
    this.tcpRemoteClient = client;
    this.listenDataReceiving(client);

    connectionParams.remoteIpAddress = client.remoteAddress.address;
    connectionParams.remotePort = client.remotePort;

    updateConnectionParams(connectionParams);
  }

  void connectWithTcpClient(ConnectionParams connectionParams) async {
    this.tcpClient = await Socket.connect(
      connectionParams.ipAddress,
      connectionParams.port,
    );
    this.listenDataReceiving(this.tcpClient);

    updateConnectionParams(connectionParams);
  }

  void sendData(Map<String, dynamic> data) {
    ConnectionParams connectionParams = getConnectionParams();

    if (connectionParams == null) {
      print('There\'s no active connection');
      return;
    }

    if (connectionParams.isTcp) {
      this.sendWithTcp(json.encode(data));
    }
  }

  void sendWithTcp(String data) {
    Socket client = getActiveTcpClient();

    if (client == null) {
      print('Inactive TCP client');
      print(getConnectionParams().toJson());

      updateConnectionParams(null);
      return;
    }

    client.write(data);
  }

  Socket getActiveTcpClient() {
    ConnectionParams connectionParams = getConnectionParams();

    if (connectionParams.isServer) {
      return this.tcpRemoteClient;
    }

    return this.tcpClient;
  }

  void listenDataReceiving(Socket client) {
    client.listen((event) {
      print(
          '---- Message from ${client.remoteAddress.address}:${client.remotePort}');

      var data = new String.fromCharCodes(event).trim();
      print(data);

      try {
        dataReceiving$.add(json.decode(data));
      } catch (e) {}
    });
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

  void closeActiveConnections() {
    if (this.tcpClient != null) {
      this.tcpClient.destroy();
      print('destroy tcpClient');
      this.tcpClient = null;
    }

    if (this.tcpRemoteClient != null) {
      this.tcpRemoteClient.destroy();
      print('destroy tcpRemoteClient');
      this.tcpRemoteClient = null;
    }

    if (this.tcpServer != null) {
      this.tcpServer.close();
      print('close tcpServer');
      this.tcpServer = null;
    }
  }

  getInformationMessage(String message) {
    return json.encode({'type': 'information', 'message': message});
  }

  ConnectionParams getConnectionParams() {
    return this.currentConnectionParams$.value;
  }
}

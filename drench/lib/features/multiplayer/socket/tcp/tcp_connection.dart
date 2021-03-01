import 'dart:io';

import 'package:drench/features/multiplayer/connection_params.model.dart';
import 'package:drench/features/multiplayer/socket/socket_connection_service.dart';

class TcpConnection {
  SocketConnectionService socketConnectionService;

  ServerSocket tcpServer;
  Socket tcpClient;
  Socket tcpRemoteClient;

  TcpConnection({this.socketConnectionService});

  void openConnection(ConnectionParams connectionParams) async {
    if (connectionParams.isServer) {
      openTcpServer(connectionParams);
      return;
    }

    connectWithTcpClient(connectionParams);
  }

  void openTcpServer(ConnectionParams connectionParams) async {
    this.tcpServer =
        await ServerSocket.bind(InternetAddress.anyIPv4, connectionParams.port);

    this.socketConnectionService.updateConnectionParams(connectionParams);
    this.tcpServer.listen(handleClientConnectionInTcpServer);
  }

  handleClientConnectionInTcpServer(Socket client) {
    print(
      'Connection from '
      '${client.remoteAddress.address}:${client.remotePort}',
    );

    if (tcpRemoteClient != null) {
      rejectClientConnection(client);
      return;
    }

    ConnectionParams connectionParams =
        this.socketConnectionService.getConnectionParams();

    client.write(
      this.socketConnectionService.getInformationMessage('welcome-to-drench'),
    );

    this.tcpRemoteClient = client;
    this.listenDataReceiving(client);

    connectionParams.remoteIpAddress = client.remoteAddress.address;
    connectionParams.remotePort = client.remotePort;

    this.socketConnectionService.updateConnectionParams(connectionParams);
  }

  rejectClientConnection(Socket client) {
    print(
      'Another client connected. Closing connection with '
      '${client.remoteAddress.address}:${client.remotePort}',
    );

    client.write(this
        .socketConnectionService
        .getInformationMessage('another-client-connected'));
    client.close();
  }

  void connectWithTcpClient(ConnectionParams connectionParams) async {
    this.tcpClient = await Socket.connect(
      connectionParams.ipAddress,
      connectionParams.port,
    );
    this.listenDataReceiving(this.tcpClient);

    this.socketConnectionService.updateConnectionParams(connectionParams);
  }

  void listenDataReceiving(Socket client) {
    client.listen((event) {
      print(
        '---- Message from ${client.remoteAddress.address}:${client.remotePort}',
      );

      var data = new String.fromCharCodes(event).trim();

      this.socketConnectionService.broadcastMessageReceived(data);
    });
  }

  void sendMessage(String data) {
    Socket client = getActiveTcpClient();

    if (client == null) {
      print('Inactive TCP client');
      print(this.socketConnectionService.getConnectionParams().toJson());

      this.socketConnectionService.updateConnectionParams(null);
      return;
    }

    client.write(data);
  }

  Socket getActiveTcpClient() {
    ConnectionParams connectionParams =
        this.socketConnectionService.getConnectionParams();

    if (connectionParams.isServer) {
      return this.tcpRemoteClient;
    }

    return this.tcpClient;
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
}

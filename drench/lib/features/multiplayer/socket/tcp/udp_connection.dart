import 'dart:io';

import 'package:drench/features/multiplayer/socket/connection_params.model.dart';
import 'package:drench/features/multiplayer/socket/socket_connection_service.dart';

class UdpConnection {
  SocketConnectionService socketConnectionService;

  RawDatagramSocket udpServer;

  UdpConnection({this.socketConnectionService});

  void openConnection(ConnectionParams connectionParams) async {
    openUdpServer(connectionParams);
  }

  void openUdpServer(ConnectionParams connectionParams) async {
    this.udpServer = await RawDatagramSocket.bind(
        InternetAddress.anyIPv4, connectionParams.port);

    this.socketConnectionService.updateConnectionParams(connectionParams);

    this.listenDataReceiving();
  }

  void listenDataReceiving() {
    this.udpServer.listen((RawSocketEvent event) {
      Datagram datagram = this.udpServer.receive();

      if (datagram == null) {
        return;
      }

      String message = new String.fromCharCodes(datagram.data).trim();

      this.socketConnectionService.broadcastMessageReceived(message);
    });
  }

  void sendMessage(String data) async {
    ConnectionParams connectionParams =
        this.socketConnectionService.getConnectionParams();

    List<InternetAddress> addresses = await InternetAddress.lookup(
        connectionParams.ipAddress,
        type: InternetAddressType.IPv4);

    this.udpServer.send(data.codeUnits, addresses[0], connectionParams.port);
  }

  void closeActiveConnections() {
    if (this.udpServer != null) {
      this.udpServer.close();
      print('close udpServer');
      this.udpServer = null;
    }
  }
}

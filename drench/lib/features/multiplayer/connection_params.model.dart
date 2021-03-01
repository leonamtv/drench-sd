class ConnectionParams {
  bool isSocket;
  bool isTcp;
  bool isServer;
  String ipAddress;
  int port;
  String remoteIpAddress;
  int remotePort;

  ConnectionParams(
      {this.isSocket,
      this.isTcp,
      this.isServer,
      this.ipAddress,
      this.port,
      this.remoteIpAddress,
      this.remotePort});

  Map<String, dynamic> toJson() => {
        'isSocket': isSocket,
        'isTcp': isTcp,
        'isServer': isServer,
        'ipAddress': ipAddress,
        'port': port,
        'remoteIpAddress': remoteIpAddress,
        'remotePort': remotePort,
      };
}

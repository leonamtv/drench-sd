class ConnectionParams {
  bool isTcp;
  bool isServer;
  String ipAddress;
  int port;
  String remoteIpAddress;
  int remotePort;

  ConnectionParams(
      {this.isTcp,
      this.isServer,
      this.ipAddress,
      this.port,
      this.remoteIpAddress,
      this.remotePort});

  Map<String, dynamic> toJson() => {
        'isTcp': isTcp,
        'isServer': isServer,
        'ipAddress': ipAddress,
        'port': port,
        'remoteIpAddress': remoteIpAddress,
        'remotePort': remotePort,
      };
}

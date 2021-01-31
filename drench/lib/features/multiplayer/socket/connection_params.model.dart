class ConnectionParams {
  bool isTcp;
  bool isServer;
  String ipAddress;
  String port;

  ConnectionParams({this.isTcp, this.isServer, this.ipAddress, this.port}) {}

  Map<String, dynamic> toJson() => {
        'isTcp': isTcp,
        'isServer': isServer,
        'ipAddress': ipAddress,
        'port': port
      };
}

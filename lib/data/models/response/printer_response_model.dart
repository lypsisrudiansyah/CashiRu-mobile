class PrinterModel {
  final String name;
  final String macAddress;
  final int paperSize;

  PrinterModel({
    required this.name,
    required this.macAddress,
    required this.paperSize,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'macAddress': macAddress,
    'paperSize': paperSize,
  };

  factory PrinterModel.fromJson(Map<String, dynamic> json) => PrinterModel(
    name: json['name'],
    macAddress: json['macAddress'],
    paperSize: json['paperSize'],
  );
}

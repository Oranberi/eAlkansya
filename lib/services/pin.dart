class Pin {
  late int id;
  late final int pin;

  Pin({required this.id, required this.pin});

  Pin.fromMap(Map<String, dynamic> item)
      : id = item["id"],
        pin = item["pin"];

  Map<String, Object> toMap() {
    return {'id': id, 'pin': pin};
  }
}

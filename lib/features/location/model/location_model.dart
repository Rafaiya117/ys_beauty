class LocationModel {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String imagePath;

  const LocationModel({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.imagePath,
  });

  LocationModel copyWith({
    String? id,
    String? name,
    String? address,
    double? latitude,
    double? longitude,
    String? imagePath,
  }) {
    return LocationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  String toString() {
    return 'LocationModel(id: $id, name: $name, address: $address, latitude: $latitude, longitude: $longitude, imagePath: $imagePath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LocationModel &&
        other.id == id &&
        other.name == name &&
        other.address == address &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.imagePath == imagePath;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        address.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        imagePath.hashCode;
  }
}

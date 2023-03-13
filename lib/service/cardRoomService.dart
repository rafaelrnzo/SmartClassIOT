class Post {
  final String uuid;
  final String name_room;
  final String available_devices;

  Post({required this.uuid, required this.name_room, required this.available_devices});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      uuid: json[0]['uuid'],
      name_room: json[0]['name_room'],
      available_devices: json[0]['available_devices'],
    );
  }
}
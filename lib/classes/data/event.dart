import 'package:keef_w_wen/classes/data/participant.dart';
import 'package:latlong2/latlong.dart';

class Event {
  final String id;
  String title;
  String thumbnailSrc;
  List<String> images;
  String description;
  double rating;
  String hostOwner;
  double distance;
  String location;
  LatLng coordinates;
  bool isPrivate;
  bool needsId;
  final DateTime dateCreated;
  DateTime dateStart;
  DateTime dateClosed;
  int seats;
  int likes;
  double price;
  bool openStatus;
  List<String> tags;
  List<Participant> participants;

  Event({
    required this.id,
    required this.title,
    required this.thumbnailSrc,
    required this.images,
    required this.description,
    required this.rating,
    required this.hostOwner,
    required this.distance,
    required this.location,
    required this.coordinates,
    required this.isPrivate,
    required this.needsId,
    required this.dateCreated,
    required this.dateStart,
    required this.dateClosed,
    required this.seats,
    required this.likes,
    required this.price,
    required this.openStatus,
    required this.tags,
    required this.participants,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    List<Participant> participants =
        (json['participants'] as List<dynamic>?)?.map((participant) {
          return Participant(
            username: participant['username'] as String,
            isHost: participant['isHost'] as bool? ?? false,
            isOwner: participant['isOwner'] as bool? ?? false,
          );
        }).toList() ??
        [];

    return Event(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      thumbnailSrc: json['thumbnailSrc'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      description: json['description'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      hostOwner: participants.firstWhere((p) => p.isOwner ?? false).username,
      distance: (json['distance'] ?? 0).toDouble(),
      location: json['location'] ?? '',
      coordinates: LatLng(
        json['coordinates']['lat'] ?? 0.0,
        json['coordinates']['lng'] ?? 0.0,
      ),
      isPrivate: json['isPrivate'] ?? false,
      needsId: json['needsId'] ?? false,
      dateCreated: DateTime.parse(
        json['dateCreated'] ?? '1970-01-01T00:00:00Z',
      ),
      dateStart: DateTime.parse(json['dateStart'] ?? '1970-01-01T00:00:00Z'),
      dateClosed: DateTime.parse(json['dateClosed'] ?? '1970-01-01T00:00:00Z'),
      seats: (json['seats'] ?? 0).toInt(),
      likes: (json['likes'] ?? 0).toInt(),
      price: (json['price'] ?? 0.0).toDouble(),
      openStatus: json['openStatus'] ?? false,
      tags: List<String>.from(json['tags'] ?? []),
      participants: participants,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'thumbnailSrc': thumbnailSrc,
      'images': images,
      'description': description,
      'rating': rating,
      'hostOwner': hostOwner,
      'distance': distance,
      'location': location,
      "coordinates": {
        "lat": coordinates.latitude,
        "lng": coordinates.longitude,
      },
      'isPrivate': isPrivate,
      'hasIdentification': needsId,
      'dateCreated': dateCreated.toIso8601String(),
      'dateClosed': dateClosed.toIso8601String(),
      'dateStart': dateStart.toIso8601String(),
      'seats': seats,
      'likes': likes,
      'price': price,
      'openStatus': openStatus,
      'tags': tags,
      'participants':
          participants
              .map(
                (p) => {
                  'username': p.username,
                  'isHost': p.isHost,
                  'isOwner': p.isOwner,
                },
              )
              .toList(),
    };
  }
}

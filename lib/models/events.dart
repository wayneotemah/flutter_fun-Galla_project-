// To parse this JSON data, do
//
//     final event = eventFromJson(jsonString);

import 'dart:convert';

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Collection {
  Collection({required this.title, required this.number, required this.event});

  String title;
  int number;
  List<Event> event;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        title: json["title"],
        number: json["number"],
        event: List<Event>.from(json["event"].map((x) => Event.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "number": number,
        "event": List<dynamic>.from(event.map((x) => x.toJson())),
      };
}

class Event {
  Event({
    required this.id,
    required this.eventName,
    required this.imageUrl,
    required this.discription,
    required this.location,
    required this.date,
    required this.time,
    required this.duration,
    required this.inperson,
    required this.organizer,
  });

  int id;
  String eventName;
  String imageUrl;
  String discription;
  String location;
  DateTime date;
  String time;
  String duration;
  bool inperson;
  List<Organizer> organizer;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        eventName: json["event_name"],
        imageUrl: json["image_url"],
        discription: json["discription"],
        location: json["location"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        duration: json["duration"],
        inperson: json["inperson"],
        organizer: List<Organizer>.from(
            json["organizer"].map((x) => Organizer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_name": eventName,
        "image_url": imageUrl,
        "discription": discription,
        "location": location,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "duration": duration,
        "inperson": inperson,
        "organizer": List<dynamic>.from(organizer.map((x) => x.toJson())),
      };
}

class Organizer {
  Organizer({
    required this.id,
    required this.email,
    required this.username,
    required this.isActive,
    required this.dateJoined,
  });

  int id;
  String email;
  String username;
  bool isActive;
  DateTime dateJoined;

  factory Organizer.fromJson(Map<String, dynamic> json) => Organizer(
        id: json["id"],
        email: json["email"],
        username: json["username"],
        isActive: json["is_active"],
        dateJoined: DateTime.parse(json["date_joined"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "username": username,
        "is_active": isActive,
        "date_joined": dateJoined.toIso8601String(),
      };
}

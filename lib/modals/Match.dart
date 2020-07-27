import 'package:cloud_firestore/cloud_firestore.dart';

class Matches {
  String game;
  String name;
  String status;
  int ticket;
  String imageUrl;
  String map;
  String matchNo;
  int maxParticipants;
  int perKill;
  String prizePool;
  String id;
  Timestamp time;
  bool resultOut;
  String roomId;
  String roomPassword;

  Matches(
      {this.game,
      this.name,
      this.status,
      this.ticket,
      this.imageUrl,
      this.map,
      this.matchNo,
      this.maxParticipants,
      this.perKill,
      this.prizePool,
      this.id,
      this.time,
      this.resultOut,
      this.roomId,
      this.roomPassword});
}

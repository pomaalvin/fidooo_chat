import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String id;
  String text;
  DateTime createdAt;
  bool bot;
  Message({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.bot,
  });
  factory Message.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Message(
      id: doc.id,
      createdAt: data["createdAt"] is Timestamp? (data["createdAt"] as Timestamp).toDate() : DateTime.now(),
      text: data["text"] ?? "",
      bot: data["bot"] ?? false,
    );
  }
}

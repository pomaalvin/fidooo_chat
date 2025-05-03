import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String id;
  String title;
  DateTime createdAt;
  Chat({required this.id, required this.title, required this.createdAt});

  factory Chat.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Chat(
      id: doc.id,
      title: data['title'] ?? '',
      createdAt: data["createdAt"] is Timestamp? (data["createdAt"] as Timestamp).toDate() : DateTime.now(),
    );
  }
}

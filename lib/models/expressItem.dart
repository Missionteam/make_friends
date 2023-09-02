import 'package:cloud_firestore/cloud_firestore.dart';

class ExpressItem {
  final String title;
  final String imageUrl;
  final String express;
  bool isSelected;
  final DocumentReference? reference;

  ExpressItem(
      {required this.title,
      required this.imageUrl,
      required this.express,
      this.reference,
      this.isSelected = false});

  factory ExpressItem.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data()!;
    return ExpressItem(
      title: map['title'],
      imageUrl: map['imageUrl'],
      express: map['express'],
      isSelected: map['isSelected'],
      reference: snapshot.reference,
    );
  }
}

List<ExpressItem> expressList = [
  ExpressItem(express: "a", title: 'Title 1', imageUrl: 'path/to/image1.png'),
  ExpressItem(express: "b", title: 'Title 2', imageUrl: 'path/to/image2.png'),
  ExpressItem(express: "c", title: 'Title 3', imageUrl: 'path/to/image3.png'),
  ExpressItem(express: "d", title: 'Title 4', imageUrl: 'path/to/image4.png'),
  ExpressItem(express: "e", title: 'Title 5', imageUrl: 'path/to/image5.png'),
  ExpressItem(express: "f", title: 'Title 6', imageUrl: 'path/to/image6.png'),
  ExpressItem(express: "g", title: 'Title 7', imageUrl: 'path/to/image7.png'),
  ExpressItem(express: "h", title: 'Title 8', imageUrl: 'path/to/image8.png'),
  ExpressItem(express: "i", title: 'Title 9', imageUrl: 'path/to/image9.png'),
  ExpressItem(express: "j", title: 'Title 10', imageUrl: 'path/to/image10.png'),

  // ... 他の要素も追加
];

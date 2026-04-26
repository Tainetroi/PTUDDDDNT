import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CrudServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Lấy collection contacts của user hiện tại
  CollectionReference get _contactsCollection {
    final uid = _auth.currentUser!.uid;
    return _firestore.collection('users').doc(uid).collection('contacts');
  }

  // Lấy danh sách contacts (real-time stream)
  Stream<QuerySnapshot> getContacts() {
    return _contactsCollection.orderBy('name').snapshots();
  }

  // Thêm contact mới
  Future<void> addContact({
    required String name,
    required String phone,
    required String email,
  }) async {
    await _contactsCollection.add({
      'name': name,
      'phone': phone,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Cập nhật contact
  Future<void> updateContact({
    required String docId,
    required String name,
    required String phone,
    required String email,
  }) async {
    await _contactsCollection.doc(docId).update({
      'name': name,
      'phone': phone,
      'email': email,
    });
  }

  // Xóa contact
  Future<void> deleteContact(String docId) async {
    await _contactsCollection.doc(docId).delete();
  }
}

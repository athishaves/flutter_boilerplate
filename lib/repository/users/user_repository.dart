import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_screen/repository/users/user_data.dart';

class UserRepository {
  final String _authId;
  UserRepository({required String authId}) : _authId = authId;

  final userRef =
      FirebaseFirestore.instance.collection('users').withConverter<UserData>(
            fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
          );

  Future<DocumentReference<UserData>> addUser({required name}) async {
    return userRef.add(UserData(name: name));
  }

  Future<UserData> fetchUserData() async {
    DocumentSnapshot<UserData> snapShot = await userRef.doc(_authId).get();
    return snapShot.data() ?? UserData.error;
  }
}

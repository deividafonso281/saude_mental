/*
This class defines all the possible read/write locations from the FirebaseFirestore database.
In future, any new path can be added here.
This class work together with FirestoreService and FirestoreDatabase.
 */

class FirestorePath {
  static String entity(String uid, String collection, String entity) =>
      'users/$entity';
  static String collection(String uid, String collection) => 'users';
}

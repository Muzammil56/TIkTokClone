import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tik_tok_clone/constants.dart';
import 'package:tik_tok_clone/models/user.dart';

class SearchController extends GetxController {
  final Rx<List<User>> _searchUsers = Rx<List<User>>([]);

  List<User> get searchedUsers  => _searchUsers.value;

  searchUser(String typedUser) async {
    _searchUsers.bindStream(
      fireStore
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: typedUser)
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<User> retValue = [];
          for (var element in query.docs) {
            retValue.add(User.fromSnap(element));
          }
          return retValue;
        },
      ),
    );
  }
}

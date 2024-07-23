import 'package:get/get.dart';
import 'package:tiktok/commons.dart';
import 'package:tiktok/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchController extends GetxController {
  final Rx<List<User>> _searchedUsers = Rx<List<User>>([]);

  List<User> get searchedUsers => _searchedUsers.value;

  searchUser(String typedUser) async {
    print('hello');
    _searchedUsers.bindStream(
      firestore
          .collection('user_data')
          .where('name', isGreaterThanOrEqualTo: typedUser)
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<User> users = [];
          for (var userSnap in query.docs) {
            users.add(User.fromSnap(userSnap));
          }
          return users;
        },
      ),
    );
  }
}

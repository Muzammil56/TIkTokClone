import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_tok_clone/constants.dart';
import 'package:tik_tok_clone/controllers/search_controller.dart';
import 'package:tik_tok_clone/models/user.dart';
import 'package:tik_tok_clone/views/screens/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: TextField(
              onSubmitted: (value) => searchController.searchUser(value),
              decoration: InputDecoration(
                filled: false,
                hintText: 'search',
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: white,
                ),
              ),
            ),
          ),
          body: searchController.searchedUsers.isEmpty
              ? Center(
                  child: Text(
                    'Search for Users',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: white,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: searchController.searchedUsers.length,
                  itemBuilder: (context, index) {
                    User user = searchController.searchedUsers[index];
                    return ListTile(
                      onTap: () => Get.to(()=> ProfileScreen(uid: user.uid)),
                      leading: CircleAvatar(
                        backgroundColor: backgroundColor,
                        backgroundImage: NetworkImage(user.profilePhoto),
                      ),
                      title: Text(
                        user.name,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                    );
                  }));
    });
  }
}

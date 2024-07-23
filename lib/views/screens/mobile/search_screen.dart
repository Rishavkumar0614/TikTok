import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tiktok/models/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktok/controllers/search_controller.dart' as controller;
// import 'package:tiktok/views/screens/profile_screen.dart';

class MobileSearchScreen extends StatelessWidget {
  MobileSearchScreen({super.key});

  final controller.SearchController searchController =
      Get.put(controller.SearchController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red[400],
            title: TextFormField(
              decoration: const InputDecoration(
                filled: false,
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onFieldSubmitted: (value) => searchController.searchUser(value),
            ),
          ),
          body: searchController.searchedUsers.isEmpty
              ? Center(
                  child: Text(
                    'Search for users',
                    style: GoogleFonts.ibmPlexSans(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: searchController.searchedUsers.length,
                  itemBuilder: (context, index) {
                    User user = searchController.searchedUsers[index];
                    return InkWell(
                      // onTap: () => Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => ProfileScreen(uid: user.uid),
                      //   ),
                      // ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            user.profilePhoto,
                          ),
                        ),
                        title: Text(
                          user.name,
                          style: GoogleFonts.ibmPlexSans(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}

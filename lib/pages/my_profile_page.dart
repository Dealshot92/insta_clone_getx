import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/my_profile_controller.dart';
import 'package:ngdemo17/views/item_profile_post.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final _controller = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    _controller.apiLoadMember();
    _controller.apiLoadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Billabong',
            fontSize: 25,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _controller.dialogLogout();
            },
            icon: Icon(Icons.exit_to_app),
            color: Color.fromRGBO(193, 53, 132, 1),
          ),
        ],
      ),
      body: GetBuilder<ProfileController>(
        builder: (context) {
          return Stack(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _controller.showPicker(context);
                      },
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(70),
                              border: Border.all(
                                width: 1.5,
                                color: Color.fromRGBO(193, 53, 132, 1),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(35),
                              child: _controller.img_url.isEmpty
                                  ? const Image(
                                      image: AssetImage(
                                          'assets/images/ic_person.png'),
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      _controller.img_url,
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 80,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.add_circle,
                                  color: Colors.purple,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    //#myinfos
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      _controller.fullname.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      _controller.email,
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),

                    //#mycounts
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 80,
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    _controller.count_posts.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "POSTS",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    _controller.count_followers.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "FOLLOWERS",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    _controller.count_following.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "FOLLOWING",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _controller.axisCount = 1;
                                  });
                                },
                                icon: Icon(Icons.list_alt),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _controller.axisCount = 2;
                                  });
                                },
                                icon: Icon(Icons.grid_view),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //#my posts
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: _controller.axisCount),
                        itemCount: _controller.items.length,
                        itemBuilder: (ctx, index) {
                          return itemOfPost(
                              _controller.items[index], _controller);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              _controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }
}

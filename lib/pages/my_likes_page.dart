import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/item_likes_post.dart';

import '../controllers/my_likes_controller.dart';

class MyLikesPage extends StatefulWidget {
  const MyLikesPage({super.key});

  @override
  State<MyLikesPage> createState() => _MyLikesPageState();
}

class _MyLikesPageState extends State<MyLikesPage> {
  final _controller = Get.find<LikesController>();

  @override
  void initState() {
    super.initState();
    _controller.apiLoadLikes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Likes',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Billabong',
            fontSize: 30,
          ),
        ),
      ),
      body: GetBuilder<LikesController>(
        builder: (context) {
          return Stack(
            children: [
              ListView.builder(
                itemCount: _controller.items.length,
                itemBuilder: (ctx, index) {
                  return itemOfPost(_controller.items[index], _controller);
                },
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

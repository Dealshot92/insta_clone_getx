import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ngdemo17/controllers/my_feed_controller.dart';
import '../views/item_feed_post.dart';

class MyFeedPage extends StatefulWidget {
  final PageController? pageController;

  const MyFeedPage({super.key, this.pageController});

  @override
  State<MyFeedPage> createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage> {
  final _controller = Get.find<FeedController>();

  @override
  void initState() {
    super.initState();
    _controller.apiLoadFeeds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Instagram",
          style: TextStyle(
              color: Colors.black, fontFamily: 'Billabong', fontSize: 30),
        ),
        actions: [
          IconButton(
            onPressed: () {
              widget.pageController!.animateToPage(2,
                  duration: const Duration(microseconds: 200),
                  curve: Curves.easeIn);
            },
            icon: const Icon(Icons.camera_alt),
            color: const Color.fromRGBO(193, 53, 132, 1),
          ),
        ],
      ),
      body: GetBuilder<FeedController>(
        builder: (context) {
          return Stack(
            children: [
              ListView.builder(
                itemCount: _controller.items.length,
                itemBuilder: (ctx, index) {
                  return itemOfPost(_controller.items[index], context);
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

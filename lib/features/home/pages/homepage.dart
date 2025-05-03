import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:taxverse_web/core/constants/routers.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.black,
              floating: true,
              automaticallyImplyLeading: false,
              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Taxverse', style: TextStyle(color: Colors.white)),
                      Row(
                        children: [
                          Text('HOME'),
                          Gap(40),
                          Text('SERVICE'),
                          Gap(40),
                          Text('PORTFOLIO'),
                          Gap(40),
                          Text('TEAM'),
                          Gap(40),
                          Text('TESTIMONIAL'),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          context.go(Routers.drawerScreen);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Add other slivers here
            SliverToBoxAdapter(
              child: Container(
                height: 1500,
                color: Colors.black,
                child: const Center(child: Text('Main Content Here')),
              ), // Add your main content here
            ),
          ],
        ),
      ),
    );
  }
}

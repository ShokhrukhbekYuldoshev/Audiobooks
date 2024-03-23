import "package:shimmer/shimmer.dart";
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:audiobooks/src/core/router/app_router.dart';
import 'package:audiobooks/src/presentation/bloc/home/home_bloc.dart';
import 'package:audiobooks/src/presentation/widgets/audiobook_widget.dart';
import 'package:audiobooks/src/presentation/widgets/author_widget.dart';
import 'package:audiobooks/src/presentation/widgets/player_bottom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const PlayerBottomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Stack(
              children: [
                // Cover image
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage('assets/images/cover.jpg'),
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.darken,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Audiobooks',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                              ),
                    ),
                  ),
                ),
                // Settings button
                Positioned(
                  top: MediaQuery.of(context).padding.top,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRouter.settingsRoute);
                    },
                    tooltip: 'Settings',
                  ),
                ),

                // Search bar
                // Positioned(
                //   top: 150,
                //   left: 20,
                //   right: 20,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: TextField(
                //       decoration: InputDecoration(
                //         hintText: 'Search for audiobooks',
                //         prefixIcon: const Icon(Icons.search),
                //         border: InputBorder.none,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 20),
            // Recommended audiobooks
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Recommended',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  // TODO: Implement view all to navigate to a page with all audiobooks
                  // TextButton(
                  //   onPressed: () {},
                  //   child: const Text('View all'),
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return SizedBox(
                    height: 170,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.grey[300] ?? Colors.grey,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: 150,
                                height: 150,
                              ),
                              if (index < 4) const SizedBox(width: 20),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                } else if (state is HomeLoaded) {
                  return SizedBox(
                    height: 170,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.audiobooks.length,
                      itemBuilder: (context, index) {
                        final audiobook = state.audiobooks[index];
                        return Row(
                          children: [
                            AudiobookWidget(audiobook: audiobook),
                            if (index < state.audiobooks.length - 1)
                              const SizedBox(width: 20),
                          ],
                        );
                      },
                    ),
                  );
                } else if (state is HomeError) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 20),

            // Popular authors
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Popular authors',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return SizedBox(
                    height: 170,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.grey[300] ?? Colors.grey,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                width: 150,
                                height: 150,
                              ),
                              if (index < 4) const SizedBox(width: 20),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                } else if (state is HomeLoaded) {
                  return SizedBox(
                    height: 170,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.authors.length,
                      itemBuilder: (context, index) {
                        final author = state.authors[index];
                        return Row(
                          children: [
                            AuthorWidget(author: author),
                            if (index < state.authors.length - 1)
                              const SizedBox(width: 20),
                          ],
                        );
                      },
                    ),
                  );
                } else if (state is HomeError) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

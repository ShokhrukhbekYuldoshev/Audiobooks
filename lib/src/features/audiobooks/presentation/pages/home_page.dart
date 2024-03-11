import 'package:audiobooks/src/core/router/app_router.dart';
import 'package:audiobooks/src/features/audiobooks/presentation/bloc/audiobooks_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audiobooks'),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: BlocBuilder<AudiobooksBloc, AudiobooksState>(
        builder: (context, state) {
          if (state is AudiobooksLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AudiobooksLoaded) {
            return ListView.builder(
              itemCount: state.audiobooks.length,
              itemBuilder: (context, index) {
                final audiobook = state.audiobooks[index];
                return ListTile(
                  title: Text(audiobook.title),
                  // join the authors.name list into a single string
                  subtitle:
                      Text(audiobook.authors.map((e) => e.fullName).join(', ')),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRouter.audiobookDetailsRoute,
                      arguments: audiobook,
                    );
                  },
                );
              },
            );
          } else if (state is AudiobooksError) {
            return Center(
              child: Text(state.message),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

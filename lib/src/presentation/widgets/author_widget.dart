import 'package:audiobooks/src/domain/entities/author_entity.dart';
import 'package:flutter/material.dart';

class AuthorWidget extends StatelessWidget {
  const AuthorWidget({
    super.key,
    required this.author,
  });

  final AuthorEntity author;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inversePrimary.withAlpha(50),
            borderRadius: BorderRadius.circular(100),
          ),
          width: 150,
          height: 150,
          child: const Icon(Icons.person, size: 100),
        ),
        Text(
          author.fullName,
        ),
      ],
    );
  }
}

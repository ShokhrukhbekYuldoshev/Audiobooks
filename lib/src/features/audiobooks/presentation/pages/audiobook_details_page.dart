import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'package:audiobooks/src/features/audiobooks/domain/entities/audiobook_entity.dart';

class AudiobookDetailsPage extends StatelessWidget {
  final AudiobookEntity audiobook;

  const AudiobookDetailsPage({
    super.key,
    required this.audiobook,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audiobook Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                audiobook.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: HtmlWidget(
                audiobook.description,
                textStyle: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'word.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Word> favoriteWords = ModalRoute.of(context)?.settings.arguments as List<Word>? ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Words'),
        backgroundColor: Colors.lightBlueAccent.shade400,
      ),
      body: favoriteWords.isNotEmpty
          ? ListView.builder(
              itemCount: favoriteWords.length,
              itemBuilder: (context, index) {
                final word = favoriteWords[index];
                return Card(
                  key: ValueKey(word.id),
                  color: Colors.lightBlueAccent.shade200,
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: const Icon(
                      Icons.stacked_line_chart,
                      color: Colors.black,
                    ),
                    title: Text(
                      word.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      word.mean,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: Text('No favorites yet'),
            ),
    );
  }
}

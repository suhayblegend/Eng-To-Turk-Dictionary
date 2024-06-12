import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> _allWords = [
    {'id': 1, 'name': 'Good morning', 'mean': 'Günaydın'},
    {'id': 2, 'name': 'Good afternoon', 'mean': 'İyi öğleden sonra'},
    {'id': 3, 'name': 'Good evening', 'mean': 'İyi akşamlar'},
    {'id': 4, 'name': 'Hello', 'mean': 'Merhaba'},
    {'id': 5, 'name': 'Hi', 'mean': 'Selam'},
    {'id': 6, 'name': 'How are you?', 'mean': 'Nasılsın?'},
    {'id': 7, 'name': 'I\'m fine, thank you', 'mean': 'İyiyim, teşekkür ederim'},
    {'id': 8, 'name': 'And you?', 'mean': 'Ve sen?'},
    {'id': 9, 'name': 'Have a nice day', 'mean': 'İyi günler'},
    {'id': 10, 'name': 'Goodbye', 'mean': 'Hoşçakal'},
    {'id': 99, 'name': 'What\'s the 101 on that new trend?', 'mean': 'O yeni trend hakkında temel bilgiler ne?'},
    {'id': 100, 'name': 'It\'s all the rage right now', 'mean': 'Şu anda herkesin dilinde'},
  ];

  late List<Word> _foundWords;
  late List<Word> _favoriteWords;

  @override
  void initState() {
    super.initState();
    _foundWords = _allWords.map((word) => Word.fromMap(word)).toList();
    _favoriteWords = _foundWords.where((word) => word.favorite).toList();
  }

  void _filter(String key) {
    setState(() {
      if (key.isEmpty) {
        _foundWords = _allWords.map((word) => Word.fromMap(word)).toList();
      } else {
        _foundWords = _allWords
            .where((element) =>
                element['name'].toLowerCase().contains(key.toLowerCase()))
            .map((word) => Word.fromMap(word))
            .toList();
      }
    });
  }

  void _toggleFavorite(int id) {
    setState(() {
      final word = _foundWords.firstWhere((word) => word.id == id);
      word.favorite = !word.favorite;
      _favoriteWords = _foundWords.where((word) => word.favorite).toList();
    });
  }

  void _shareApp() {
    // Implement sharing functionality
    // For example, using the 'share' package
    // Share.share('Check out this GRE Vocabulary app!');
  }

  void _navigateToFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FavoritesPage(favoriteWords: _favoriteWords)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GRE Vocabulary Application'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favorites'),
              onTap: _navigateToFavorites,
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share'),
              onTap: _shareApp,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => _filter(value),
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                labelText: 'Search...',
                labelStyle: TextStyle(
                  color: Colors.black,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                icon: Icon(
                  Icons.list,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: _foundWords.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundWords.length,
                      itemBuilder: (context, index) {
                        final word = _foundWords[index];
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
                            trailing: IconButton(
                              icon: Icon(
                                word.favorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () => _toggleFavorite(word.id),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text('Nothing Found'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class Word {
  final int id;
  final String name;
  final String mean;
  bool favorite;

  Word({
    required this.id,
    required this.name,
    required this.mean,
    this.favorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mean': mean,
      'favorite': favorite ? 1 : 0,
    };
  }

  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      id: map['id'],
      name: map['name'],
      mean: map['mean'],
      favorite: map['favorite'] == 1,
    );
  }
}

class FavoritesPage extends StatelessWidget {
  final List<Word> favoriteWords;

  const FavoritesPage({Key? key, required this.favoriteWords}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Words'),
      ),
      body: favoriteWords.isNotEmpty
          ? ListView.builder(
              itemCount: favoriteWords.length,
              itemBuilder: (context, index) {
                final word = favoriteWords[index];
                return ListTile(
                  title: Text(word.name),
                  subtitle: Text(word.mean),
                );
              },
            )
          : const Center(
              child: Text('No favorite words yet.'),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'favorites_page.dart';
import 'word.dart'; // Import the Word class
import 'package:share/share.dart';

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
    _favoriteWords = [];
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
      final index = _foundWords.indexWhere((word) => word.id == id);
      if (index != -1) {
        _foundWords[index].favorite = !_foundWords[index].favorite;
        if (_foundWords[index].favorite) {
          _favoriteWords.add(_foundWords[index]);
        } else {
          _favoriteWords.removeWhere((word) => word.id == id);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade500,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent.shade400,
        title: const Text(
          'ENGLISH TO TURKISH DICTIONARY',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent.shade400,
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
              leading: Icon(Icons.favorite),
              title: Text('Favorites'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavoritesPage(),
                    settings: RouteSettings(arguments: _favoriteWords),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share'),
              onTap: () {
                Share.share('Check out this amazing GRE Vocabulary app!');
              },
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
            const SizedBox(
              height: 5,
            ),
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

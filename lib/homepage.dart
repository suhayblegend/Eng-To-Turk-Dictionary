import 'package:flutter/material.dart';

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

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _passwordController = TextEditingController();
  final String _correctPassword = 'naseristhebestteacher';

  void _login() {
    String enteredPassword = _passwordController.text.trim();
    if (enteredPassword == _correctPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Incorrect Password'),
          content: const Text('Please enter the correct password to continue.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Enter Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> _allWords = [
    {'id': 1, 'name': 'Good morning', 'mean': 'Günaydın'},
    {'id': 2, 'name': 'Good afternoon', 'mean': 'İyi öğleden sonra'},
    {'id': 3, 'name': 'Good evening', 'mean': 'İyi akşamlar'},
    {'id': 4, 'name': 'Hello', 'mean': 'Merhaba'},
    {'id': 5, 'name': 'Hi', 'mean': 'Selam'},
    {'id': 6, 'name': 'How are you?', 'mean': 'Nasılsın?'},
    {
      'id': 7,
      'name': 'I\'m fine, thank you',
      'mean': 'İyiyim, teşekkür ederim'
    },
    {'id': 8, 'name': 'And you?', 'mean': 'Ve sen?'},
    {'id': 9, 'name': 'Have a nice day', 'mean': 'İyi günler'},
    {'id': 10, 'name': 'Goodbye', 'mean': 'Hoşçakal'},
    {
      'id': 99,
      'name': 'What\'s the 101 on that new trend?',
      'mean': 'O yeni trend hakkında temel bilgiler ne?'
    },
    {
      'id': 100,
      'name': 'It\'s all the rage right now',
      'mean': 'Şu anda herkesin dilinde'
    },
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
            if (_favoriteWords.isNotEmpty)
              Column(
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Favorites',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _favoriteWords.length,
                      itemBuilder: (context, index) {
                        final word = _favoriteWords[index];
                        return ListTile(
                          title: Text(word.name),
                          subtitle: Text(word.mean),
                        );
                      },
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: LoginPage(),
  ));
}

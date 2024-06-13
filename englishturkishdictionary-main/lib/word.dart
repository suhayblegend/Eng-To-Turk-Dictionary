class Word {
  final int id;
  final String name;
  final String mean;
  final String englishPronunciation; // Text for English TTS
  final String turkishPronunciation; // Text for Turkish TTS
  bool favorite;

  Word({
    required this.id,
    required this.name,
    required this.mean,
    required this.englishPronunciation,
    required this.turkishPronunciation,
    this.favorite = false,
  });

  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      id: map['id'],
      name: map['name'],
      mean: map['mean'],
      englishPronunciation: map['englishPronunciation'],
      turkishPronunciation: map['turkishPronunciation'],
      favorite: map['favorite'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mean': mean,
      'englishPronunciation': englishPronunciation,
      'turkishPronunciation': turkishPronunciation,
      'favorite': favorite,
    };
  }
}

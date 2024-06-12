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

  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      id: map['id'],
      name: map['name'],
      mean: map['mean'],
      favorite: map['favorite'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mean': mean,
      'favorite': favorite,
    };
  }
}

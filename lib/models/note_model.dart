class Note {
  final int id;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String title;
  final String content;

  Note({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.content,
  });

  // Factory constructor to create a Note instance from JSON
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      userId: json['userId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      title: json['title'],
      content: json['content'],
    );
  }

  // Method to convert Note instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'title': title,
      'content': content,
    };
  }
  static List<Note> fromList(data){
    if(data is! List) print( 'data is not list in note lists');
    List<Note> list = [];
    for(var item in data){
      list.add(Note.fromJson(item));
    }
    return list;
  }
}

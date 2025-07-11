class ToDo {
  ToDo({required this.title, required this.date});

  ToDo.fromJson(Map<String,dynamic> json)
  : title = json['title'],
    date = DateTime.parse(json['datetime']);

  
  String title;
  DateTime date;

  void setTitle(String title) {
    this.title = title;
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'datetime': date.toIso8601String()};
  }
}

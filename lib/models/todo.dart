class Todo {
  String id;
  String title;
  String content;
  DateTime createdAt;
  DateTime updatedAt;

  Todo({title, content}) {
    this.id = DateTime.now().toString();
    this.title = title;
    this.content = content;
    this.createdAt = DateTime.now();
    this.updatedAt = DateTime.now();
  }
}

class VerseModel {
    VerseModel({
        required this.book,
        required this.chapter,
        required this.scripture,
        required this.verse,
    });

    int book;
    int chapter;
    String scripture;
    int verse;

    factory VerseModel.fromJson(Map<String, dynamic> json) => VerseModel(
        book: json["Book"],
        chapter: json["Chapter"],
        scripture: json["Scripture"],
        verse: json["Verse"],
    );

    Map<String, dynamic> toJson() => {
        "Book": book,
        "Chapter": chapter,
        "Scripture": scripture,
        "Verse": verse,
    };
}

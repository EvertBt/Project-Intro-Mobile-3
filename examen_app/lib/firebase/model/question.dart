class Question {
  Question(
      {this.question = '',
      this.type = 'open',
      this.score = 0,
      this.answer = ''});

  String? question;
  String answer;
  int score;
  String type;
}

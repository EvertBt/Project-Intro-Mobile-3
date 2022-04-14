class Question {
  Question(
      {this.question = '',
      this.type = 'open',
      this.score = 0,
      this.maxScore = 1,
      this.answer = ''});

  String? question;
  String answer;
  int score;
  int maxScore;
  String type;
}

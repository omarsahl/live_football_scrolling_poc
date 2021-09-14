class Comment {
  final int order;

  final int minute;

  final bool goal;

  final String commentText;

  String get time {
    // After the match has finished the minute will be equal to 0
    if (minute == 0 && order != 1) {
      return 'FT';
    }

    return "$minute";
  }

  Comment(
    this.order,
    this.minute,
    this.goal,
    this.commentText,
  );
}

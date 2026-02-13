class CommitModel {
  final String message;

  CommitModel({required this.message});

  factory CommitModel.fromJson(Map<String, dynamic> json) {
    return CommitModel(message: json['commit']['message'] ?? '');
  }
}

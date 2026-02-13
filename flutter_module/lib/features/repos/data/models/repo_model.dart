class RepoModel {
  final String name;
  final String description;
  final OwnerModel ownerModel;

  RepoModel({
    required this.name,
    required this.description,
    required this.ownerModel,
  });

  factory RepoModel.fromJson(Map<String, dynamic> json) {
    return RepoModel(
      name: json['name'] ?? "",
      description: json['description'] ?? "No description",
      ownerModel: OwnerModel.fromJson(json['owner']),
    );
  }
}

class OwnerModel {
  final String avatarUrl;

  OwnerModel({required this.avatarUrl});

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(avatarUrl: json['avatar_url'] ?? "");
  }
}

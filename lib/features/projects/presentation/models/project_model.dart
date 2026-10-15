class ProjectModel {
  const ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePaths,
    required this.technologies,
    required this.githubUrl,
    this.isFeatured = false,
    this.role,
    this.features = const [],
    this.videoUrl,
  });

  final String id;
  final String title;
  final String description;

  /// Paths to project screenshots stored in assets.
  final List<String> imagePaths;

  /// Technologies displayed as tags.
  final List<String> technologies;

  final String githubUrl;
  final bool isFeatured;

  /// Your role in the project.
  final String? role;

  /// Main features shown on the details page.
  final List<String> features;

  /// Optional demo video URL.
  final String? videoUrl;
}

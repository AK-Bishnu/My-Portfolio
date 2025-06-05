class Project {
  final String title;
  final String shortDescription;
  final String fullDescription;
  final List<String> screenshots;
  final List<String> techStack;
  final String githubUrl;
  final String mainImage;

  Project({
    required this.title,
    required this.shortDescription,
    required this.fullDescription,
    required this.screenshots,
    required this.techStack,
    required this.githubUrl,
    required this.mainImage,
  });
}
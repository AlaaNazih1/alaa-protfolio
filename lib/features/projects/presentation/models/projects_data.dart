import 'project_model.dart';

abstract final class ProjectsData {
  static const List<ProjectModel> projects = [
    ProjectModel(
      id: 'care-companion',
      title: 'Care Companion',
      description:
          'Worked as the Flutter developer responsible for the application '
          'logic layer following Clean Architecture principles. Developed '
          'business logic using Riverpod, implemented repositories, providers, '
          'and use cases, and integrated Firebase services.',

      imagePaths: [
        'assets/images/projects/care_companion/cover1.png',
        'assets/images/projects/care_companion/screenshot_01.png',
        'assets/images/projects/care_companion/screenshot_02.png',
        'assets/images/projects/care_companion/screenshot_03.png',
        'assets/images/projects/care_companion/screenshot_04.png',
        'assets/images/projects/care_companion/screenshot_05.png',
        'assets/images/projects/care_companion/screenshot_06.png',
        'assets/images/projects/care_companion/screenshot_07.png',
        'assets/images/projects/care_companion/screenshot_08.png',
        'assets/images/projects/care_companion/screenshot_09.png',
        'assets/images/projects/care_companion/screenshot_10.png',
        'assets/images/projects/care_companion/screenshot_11.png',
        'assets/images/projects/care_companion/screenshot_12.png',
        'assets/images/projects/care_companion/screenshot_13.png',
        'assets/images/projects/care_companion/screenshot_14.png',
        'assets/images/projects/care_companion/screenshot_15.png',
        'assets/images/projects/care_companion/screenshot_16.png',
        'assets/images/projects/care_companion/screenshot_17.png',
        'assets/images/projects/care_companion/screenshot_18.png',
        'assets/images/projects/care_companion/screenshot_19.png',
      ],
      technologies: ['Flutter', 'Riverpod', 'Firebase', 'Clean Architecture'],
      githubUrl: 'https://github.com/AlaaNazih1/CareCompanion',
      videoUrl: 'assets/videos/care_companion.mp4',
      isFeatured: true,
      role: 'Flutter Developer',
      features: [
        'Clean Architecture',
        'Riverpod state management',
        'Repository and use case patterns',
        'Firebase integration',
      ],
    ),

    ProjectModel(
      id: 'notes-app',
      title: 'Notes App',
      description:
          'Developed a cross-platform notes application using Flutter and '
          'Dart with full CRUD operations. Used Hive as a local NoSQL database '
          'for offline persistence and implemented BLoC/Cubit state management.',

      imagePaths: [
        'assets/images/projects/notes_app/cover2.png',
        'assets/images/projects/notes_app/screenshot_1.png',
        'assets/images/projects/notes_app/screenshot_2.png',
        'assets/images/projects/notes_app/screenshot_3.png',
      ],
      videoUrl: 'assets/videos/notes.mp4',

      technologies: ['Flutter', 'Hive', 'BLoC/Cubit', 'CRUD'],
      githubUrl: 'https://github.com/AlaaNazih1/notes-app',
      features: [
        'Create, edit, and delete notes',
        'Offline local storage',
        'Note color selection',
        'Date tracking',
        'Reusable UI components',
      ],
    ),

    ProjectModel(
      id: 'weather-app',
      title: 'Weather App',
      description:
          'Developed a weather forecast mobile application using Flutter '
          'and integrated a public REST API to fetch weather data. Implemented '
          'loading and error states and a responsive user interface.',
      imagePaths: [
        'assets/images/projects/weather_app/cover3.png',
        'assets/images/projects/weather_app/screenshot_1.png',
        'assets/images/projects/weather_app/screenshot_2.png',
        'assets/images/projects/weather_app/screenshot_3.png',
      ],
      technologies: [
        'Flutter',
        'REST API',
        'Location Services',
        'Real-time Data',
      ],
      videoUrl: 'assets/videos/weather.mp4',
      githubUrl: 'https://github.com/AlaaNazih1/weather_app',
      features: [
        'Weather data from a REST API',
        'Location-based weather updates',
        'Loading and error handling',
        'Responsive interface',
      ],
    ),

    ProjectModel(
      id: 'todo-app',
      title: 'Todo App',
      description:
          'Developed a task management mobile application using Flutter '
          'with CRUD functionality, state management, and a clean user '
          'interface for organizing tasks.',
      imagePaths: [
        'assets/images/projects/todo_app/cover4.png',
        'assets/images/projects/todo_app/screenshot_1.png',
        'assets/images/projects/todo_app/screenshot_2.png',
        'assets/images/projects/todo_app/screenshot_3.png',
        'assets/images/projects/todo_app/screenshot_4.png',
        'assets/images/projects/todo_app/screenshot_5.png',
      ],
      technologies: ['Flutter', 'CRUD', 'State Management', 'Clean UI'],
      githubUrl: 'https://github.com/AlaaNazih1/todo-app',
      videoUrl: 'assets/videos/todoApp.mp4',
      features: [
        'Add tasks',
        'Edit tasks',
        'Delete tasks',
        'Organize task status',
      ],
    ),
  ];

  static ProjectModel? findById(String id) {
    for (final project in projects) {
      if (project.id == id) {
        return project;
      }
    }

    return null;
  }

  static List<ProjectModel> get featuredProjects {
    return projects.where((project) => project.isFeatured).toList();
  }
}

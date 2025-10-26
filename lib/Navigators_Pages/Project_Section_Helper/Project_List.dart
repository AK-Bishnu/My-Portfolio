import 'Project_Model.dart';

final List<Project> projects = [
  Project(
    title: 'AkShop',
    shortDescription: 'A full-stack e-commerce mobile application built with Flutter and Django REST Framework.',
    fullDescription: '''
"AkShop" is a complete e-commerce mobile application developed using Flutter for the frontend and Django REST Framework for the backend. It provides a seamless shopping experience with product browsing, cart management, and order placement functionalities.

The app supports user authentication (sign up, login, logout) and real-time data handling via REST APIs. Users can explore products, add items to the cart, and confirm orders, while all data is synchronized with the Django backend. The backend also includes an admin panel for managing products, users, and orders efficiently.

The Flutter frontend offers a responsive and visually clean UI that enhances usability. The integration between Flutter and Django ensures secure communication using API endpoints for authentication, product retrieval, and order processing.

This project demonstrates full-stack development skills, combining modern mobile UI/UX design with powerful backend logic. It aims to replicate the core functionality of a real-world e-commerce platform, serving as a strong example of a cross-platform, API-driven app architecture.
''',
    techStack: ['Flutter', 'Dart', 'Django REST Framework', 'SQLite', 'REST API'],
    githubUrl: 'https://github.com/AK-Bishnu/Flutter-Django/tree/main/Ak%20Fashion',
    mainImage: 'assets/akShop/akshopCover.png',
    screenshots: [
      'assets/akShop/adminPanel.png',
      'assets/akShop/RegD.jpg',
      'assets/akShop/loginD.jpg',
      'assets/akShop/HomeD.jpg',
      'assets/akShop/MenuD.jpg',
      'assets/akShop/FavD.jpg',
      'assets/akShop/CartD.jpg',
      'assets/akShop/PD_D.jpg',
      'assets/akShop/CreateOrdD.jpg',
      'assets/akShop/OdersD.jpg',
    ],
  ),
  Project(
    title: 'C With Fun',
    shortDescription: 'An interactive game that teaches C programming through levels and challenges.',
    fullDescription: '''
"Learn C" is an interactive, game-based mobile application designed to help beginners learn the C programming language in a fun and engaging way. Instead of traditional tutorials, users progress through levels by completing coding tasks using real C syntax.

The app was developed using Flutter and Dart for cross-platform compatibility, and it integrates the JDoodle API to compile and execute C code in real-time. Each level features a game character, and user-written code controls the actions or outcomes. Visual feedback is provided with animations — a happy character for correct code and a sad or broken character for incorrect submissions.

The project includes a range of levels that teach C concepts like variables, loops, conditional statements, and functions. It also features stage-selection, real-time output comparison, and interactive UI elements. To enhance the learning experience, all levels are unlocked for free exploration and practice.

This project aims to make C programming approachable for newcomers, especially students, by making the learning process enjoyable and rewarding. It encourages self-paced exploration and provides immediate visual cues to help users understand where they went right or wrong in their logic.
''',
    techStack: ['Flutter', 'Dart', 'JDoodle API', ],
    githubUrl: 'https://github.com/AK-Bishnu/Flutter-Projects/tree/main/Learn%20C',
    mainImage: 'assets/learn_c/c-1.jpg',
    screenshots: [
      'assets/learn_c/c-1.jpg',
      'assets/learn_c/c-2.jpg',
      'assets/learn_c/c-3.jpg',
      'assets/learn_c/c-4.jpg',
      'assets/learn_c/c-5.jpg',
      'assets/learn_c/c-6.jpg',
    ],
  ),
  Project(
    title: 'Snake Game',
    shortDescription: 'A classic Snake game,featuring smooth animations, dynamic gameplay.',
    fullDescription: '''
The Snake Game is a classic arcade-style game developed using Flutter. It brings the nostalgic snake experience into a modern, responsive mobile interface. The game starts with a small snake and food items randomly placed on a grid. The player's goal is to eat as much food as possible without hitting the wall or itself.

Built with Flutter and Dart, the game logic is controlled through a `Timer` that continuously updates the game state. The snake is drawn dynamically using `CustomPainter`, and animations make the gameplay feel smooth and interactive. Each time the snake eats food, it grows in size and the player's score increases.

The project was a challenge in managing timed state updates and collision detection within a Flutter UI. No game engine was used — all logic was written from scratch to deeply understand rendering and game mechanics within Flutter.

The purpose of this project was to explore how Flutter can be pushed beyond typical UI into game development. It showcases my understanding of real-time state management, custom drawing, and performance optimization for interactive applications.
''',
    techStack: ['Flutter', 'Dart', ],
    githubUrl: 'https://github.com/AK-Bishnu/Flutter-Projects/tree/main/Snake%20Game',
    mainImage: 'assets/snake/s-1.png',
    screenshots: [
      'assets/snake/s-1.png',
      'assets/snake/s-2.png',
      'assets/snake/s-3.png',
      'assets/snake/s-4.png',
    ],
  ),
  Project(
    title: 'Tetris Game',
    shortDescription: 'A fully playable Tetris game, featuring smooth block movement.',
    fullDescription: '''
The Tetris Game is a block-dropping puzzle game recreated using Flutter without any external game engines. This project replicates the iconic gameplay where different-shaped blocks (tetrominoes) fall from the top, and the player must arrange them to form complete rows.

The game grid is built with Flutter widgets, and each block is painted using `CustomPainter`. The core logic handles piece rotation, movement, collision detection, and row-clearing using pure Dart code. A `Timer` controls the automatic falling of pieces, and `setState` ensures real-time updates for a smooth gaming experience.

Developing Tetris in Flutter allowed me to dive deep into grid-based logic, pixel-perfect rendering, and performance tuning in a reactive UI environment. Unlike typical business apps, this project pushed Flutter to handle continuous rendering and responsive input in a game setting.

The purpose of building this game was to test Flutter’s capability for more complex, animated logic. It also served as a great exercise in thinking through real-time problem-solving, user interaction, and classic game algorithms.
''',
    techStack: ['Flutter', 'Dart',  ],
    githubUrl: 'https://github.com/AK-Bishnu/Flutter-Projects/tree/main/Tetris%20Game',
    mainImage: 'assets/tetris/t-1.png',
    screenshots: [
      'assets/tetris/t-1.png',
      'assets/tetris/t-2.png',
      'assets/tetris/t-3.png',

    ],
  ),


];
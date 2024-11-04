import 'dart:io';

// Enum for Question Typeg 
enum QuestionType { singleChoice, multipleChoice }

// Class for Question
class Question {
  final String questionText;
  final List<String> options;
  final List<int> correctAnswers; // List of indices for correct answers
  final QuestionType type;

  Question(this.questionText, this.options, this.correctAnswers, this.type){
     if (correctAnswers.isEmpty) {
      throw ArgumentError('Each question must have at least one correct answer.');
    }
  }

  bool isCorrect(List<int> choiceIndices) {
    choiceIndices.sort();
    return choiceIndices.length == correctAnswers.length &&
        choiceIndices.every((index) => correctAnswers.contains(index));
  }
}

// Class to store the user's response
class UserResponse {
  final int questionIndex;
  final List<int> chosenAnswers;
  final bool isCorrect;

  UserResponse(this.questionIndex, this.chosenAnswers, this.isCorrect);
}

// Class for participant
class Participant {
  final String firstName;
  final String lastName;
  final int score;

  Participant(this.firstName, this.lastName, this.score);

  String userFile() {
    return '$firstName,$lastName,$score'; // Save format for participant
  }
  

  
  String toString() {
    return "$firstName $lastName Score: $score";
  }
}

// Class for the Quiz
class Quiz {
  final List<Question> questions;
  List<Participant> participants = [];
  int currentIndex = 0;
  int score = 0;

  List<UserResponse> userResponses = [];

    Quiz(this.questions) {
      loadParticipants(); // Load participants from the file on initialization
    }


// Method to load participants from a file
void loadParticipants() {
  final file = File('micro_project\\particpants.txt');
  if (file.existsSync()) {
    List<String> lines = file.readAsLinesSync();
    for (var line in lines) {
      var parts = line.split(',');
      if (parts.length == 3) {  // Expecting firstName, lastName, score
        String firstName = parts[0].trim();
        String lastName = parts[1].trim();
        int score = int.parse(parts[2].trim()); // Parse the score as an integer
        participants.add(Participant(firstName, lastName, score));
      } else {
        print('Invalid line format: $line'); // Error message for invalid lines
      }
    }
  }
}


// Method to save participants to a file
void saveParticipants() {
  final file = File('micro_project\\particpants.txt');
  List<String> lines = participants.map((p) => p.userFile()).toList();
  file.writeAsStringSync(lines.join('\n'));
}

  // Method to start the quiz
  void startQuiz() {
    clearScreen();
    
    score = 0;
    userResponses.clear();    
    currentIndex = 0;
    // Get user name
    stdout.write('Enter your first name: ');
    String firstName = stdin.readLineSync() ?? 'Guest';
    stdout.write('Enter your last name: ');
    String lastName = stdin.readLineSync() ?? 'User';
    print('\nWelcome, $firstName $lastName! Let\'s start the quiz.\n');

    while (currentIndex < questions.length) {
      Question currentQuestion = questions[currentIndex];
      print('Question ${currentIndex + 1}: ${currentQuestion.questionText}');
      for (int i = 0; i < currentQuestion.options.length; i++) {
        print('${String.fromCharCode(65 + i)}. ${currentQuestion.options[i]}');
      }

      // Show question type instructions
      if (currentQuestion.type == QuestionType.singleChoice) {
        print('This is a single-choice question. Enter your choice (A, B, C, or D):');
      } else {
        print('This is a multiple-choice question. Enter your choices (e.g., A,B):');
      }

      // Get user input
      stdout.write('Your answer: ');
      String? input = stdin.readLineSync();
      List<int> choiceIndices;


      // Parse user input for multiple or single-choice questions
      if (currentQuestion.type == QuestionType.singleChoice) {
        int choiceIndex = input != null ? input.toUpperCase().codeUnitAt(0) - 65 : -1;
        choiceIndices = [choiceIndex];
      } else {
        choiceIndices = input != null
            ? input.toUpperCase().split(',').map((e) => e.trim().codeUnitAt(0) - 65).toList()
            : [];
      }

      // Validate user input
      if (choiceIndices.any((index) => index < 0 || index >= currentQuestion.options.length)) {
        print('Invalid choice. Please try again.\n');
        continue;
      }

      // Check if the answer is correct
      bool isCorrect = currentQuestion.isCorrect(choiceIndices);
      if (isCorrect) {
        score++;
      } 
      // Save the user's response
      userResponses.add(UserResponse(currentIndex, choiceIndices, isCorrect));

      currentIndex++;
    }

    // Display the final score and save participant data
    Participant participant = Participant(firstName, lastName, score);
    participants.add(participant);
    clearScreen();
    print('Quiz completed! Your score is $score out of ${questions.length}.\n');
    displayResults();
    saveParticipants(); // Save participants to the file
    print('Press Enter to continue...');
    stdin.readLineSync();
    clearScreen(); 
    showOptions();
  }

  // Method to display detailed results
  void displayResults() {
    print('Your Result:\n');
    for (var response in userResponses) {
      Question question = questions[response.questionIndex];
      String userAnswer = response.chosenAnswers
          .map((index) => '${String.fromCharCode(65 + index)}: ${question.options[index]}')
          .join(', ');
      String status = response.isCorrect ? 'Correct' : 'Wrong';
      String correctAnswer = response.isCorrect
          ? ''
          : ' (Correct answer: ${question.correctAnswers.map((index) => '${String.fromCharCode(65 + index)}: ${question.options[index]}').join(', ')})';

      print('Question ${response.questionIndex + 1}: Your answer: $userAnswer - $status$correctAnswer');
      print(''); // Blank line for spacing
    }
  }

  void quizMenu() {
    print('Choose one option?');
    print('1. Start quiz');
    print('2. View all participants\' scores');

    stdout.write('Enter your choice (1 or 2): ');
    String? choice = stdin.readLineSync();

    if (choice == '1') {
      startQuiz(); // Start a new quiz
    } else if (choice == '2') {
      listAllScores(); 
    } else {
      print('Invalid choice. Please try again.\n');
      showOptions();
    }
  }

  // Method to display post-quiz options
  void showOptions() {
    print('Choose one option?');
    print('1. Start quiz');
    print('2. View all participants\' scores');

    stdout.write('Enter your choice (1 or 2): ');
    String? choice = stdin.readLineSync();

    if (choice == '1') {
      startQuiz(); // Start a new quiz
    } else if (choice == '2') {
      listAllScores(); 
    } else {
      print('Invalid choice. Please try again.\n');
      showOptions();
    }
  }

  // Clear screen
  void clearScreen() {
    print('\x1B[2J\x1B[0;0H');
  }

  // Method to list all participants' scores
  void listAllScores() {
    clearScreen();
    if (participants.isEmpty) {
      print('No participants have taken the quiz yet.\n');
    } else {
      print('Scores of all participants:\n');
      print('Particpants name:');
      for (var participant in participants) {
        print(participant.toString());
      }
    }
    print('Press Enter to continue...');
    stdin.readLineSync();
    clearScreen(); 
    showOptions(); 
  }
}


// Main function


// Main function
void main() {
  // Create some sample questions
List<Question> questionList = [
    Question('What programming language does Flutter use?', ['Java', 'Dart', 'Python', 'C++'], [1], QuestionType.singleChoice),
    Question('What widget is used to create a simple button in Flutter?', ['Text', 'Row', 'ElevatedButton', 'Container'], [2], QuestionType.singleChoice),
    Question('Which company developed Flutter?', ['Apple', 'Google', 'Microsoft', 'Facebook'], [1], QuestionType.singleChoice),
    Question('Which of the following are Flutter widgets?', ['Container', 'Padding', 'FontSize', 'ListView'], [0, 1, 3], QuestionType.multipleChoice),
    Question('Which of these are IDEs commonly used for Flutter development?', ['VS Code', 'Android Studio', 'Xcode', 'IntelliJ IDEA'], [0, 1, 3], QuestionType.multipleChoice),
    Question('Which platforms does Flutter support?', ['iOS', 'Android', 'Web', 'Linux'], [0, 1, 2, 3], QuestionType.multipleChoice),
  ];

  // Create a Quiz instance
  Quiz quiz = Quiz(questionList);

  // Start the quiz
  quiz.quizMenu();
}


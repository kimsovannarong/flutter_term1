String bracketsMatching(String input) {
  List<String> stack = []; //empty stack (LIFO)

  Map<String, String> brackets = {
    '(': ')',
    '[': ']',
    '{': '}',
  };

  for (var character in input.split('')) {
    // check open bracket
    if (brackets.containsKey(character)) {
      stack.add(character);

    } else if (brackets.containsValue(character)) {
      if (stack.isEmpty) {
        return "Not balanced";
      }
      String lastBracket = stack.last;
      // Check matching bracket
      if (brackets[lastBracket] != character) {
        return "Not balanced";
      }
      stack.removeLast();
    }
  }

  if (stack.isEmpty) {
    return "Balanced";
  } else {
    return "Not balanced";
  }
}

void main() {
  String text1 = "{what is (42)}?";
  String text2 = "[text}";
  String text3 = "{[[(a)b]c]d}";

  print(bracketsMatching(text1)); // balanced
  print(bracketsMatching(text2)); // not balanced
  print(bracketsMatching(text3)); // balanced

}
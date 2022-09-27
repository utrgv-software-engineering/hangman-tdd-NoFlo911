import 'package:http/http.dart' as http;

class HangmanGame {
  String _word;
  String _correctGuesses = "";
  String _wrongGuesses = "";

  //Constructor starts off with blank strings that we will concatenate during the course of play
  HangmanGame(String word) {
    _word = word;
    _correctGuesses = "";
    _wrongGuesses = "";
  }

  String correctGuesses() {
    return _correctGuesses;
  }

  String wrongGuesses() {
    return _wrongGuesses;
  }

  String word() {
    return _word;
  }

  bool guess(String letter) {
    // TODO: Fill this in
    if (letter == null || letter.length > 1) {
      throw ArgumentError();
    } else if (_word.contains(letter.toLowerCase()) &&
        !_correctGuesses.contains(letter.toLowerCase()) &&
        ((letter.codeUnitAt(0) >= 65 && letter.codeUnitAt(0) <= 90) ||
            (letter.codeUnitAt(0) >= 97 && letter.codeUnitAt(0) <= 122))) {
      _correctGuesses += letter;
    } else if (!_word.contains(letter.toLowerCase()) &&
        !_wrongGuesses.contains(letter.toLowerCase()) &&
        ((letter.codeUnitAt(0) >= 65 && letter.codeUnitAt(0) <= 90) ||
            (letter.codeUnitAt(0) >= 97 && letter.codeUnitAt(0) <= 122))) {
      _wrongGuesses += letter;
    } else if ((_word.contains(letter.toLowerCase()) &&
            _correctGuesses.contains(letter.toLowerCase()) &&
            ((letter.codeUnitAt(0) >= 65 && letter.codeUnitAt(0) <= 90) ||
                (letter.codeUnitAt(0) >= 97 && letter.codeUnitAt(0) <= 122))) ||
        (!_word.contains(letter.toLowerCase()) &&
            _wrongGuesses.contains(letter.toLowerCase()) &&
            ((letter.codeUnitAt(0) >= 65 && letter.codeUnitAt(0) <= 90) ||
                (letter.codeUnitAt(0) >= 97 && letter.codeUnitAt(0) <= 122)))) {
      return false;
    } else if ((letter.codeUnitAt(0) > 90 && letter.codeUnitAt(0) < 97) ||
        (letter.codeUnitAt(0) > 122) ||
        (letter.codeUnitAt(0) < 65)) {
      throw ArgumentError();
    }
    return true;
  }

  String blanksWithCorrectGuesses() {
    // TODO: Fill this in
    String finalanswer = "";
    for (int i = 0; i < _word.length; i++) {
      if (_correctGuesses.contains(_word[i])) {
        finalanswer += _word[i];
      } else {
        finalanswer += '-';
      }
    }
    return finalanswer;
  }

  String status() {
    // TODO: Fill this in
    String playerstatus;
    if (blanksWithCorrectGuesses() == _word) {
      playerstatus = "win";
    } else if (_wrongGuesses.length == 7) {
      playerstatus = "lose";
    } else {
      playerstatus = "play";
    }
    return playerstatus;
  }

  //when running integration tests always return "banana"
  static Future<String> getStartingWord(bool areWeInIntegrationTest) async {
    String word;
    Uri endpoint = Uri.parse("http://randomword.saasbook.info/RandomWord");
    if (areWeInIntegrationTest) {
      word = "banana";
    } else {
      try {
        var response = await http.post(endpoint);
        word = response.body;
      } catch (e) {
        word = "error";
      }
    }

    return word;
  }
}

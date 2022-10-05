import 'package:http/http.dart' as http;

class HangmanGame {
  String _word;
  String _correctGuesses = "";
  String _wrongGuesses = "";
  int _score;

  //Constructor starts off with blank strings that we will concatenate during the course of play
  HangmanGame(String word) {
    _word = word;
    _correctGuesses = "";
    _wrongGuesses = "";
    _score = 0;
  }

  int score() {
    return _score;
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
    RegExp is_a_letter = new RegExp(r'[a-zA-Z]');
    if (letter == null || letter.length > 1 || !is_a_letter.hasMatch(letter)) {
      throw ArgumentError();
    }
    letter = letter.toLowerCase();
    if ((_correctGuesses.contains(letter)) ||
        (_wrongGuesses.contains(letter))) {
      return false;
    }

    if (_word.contains(letter)) {
      _correctGuesses += letter;
      if (_word.length <= 8) {
        if (letter.allMatches(_word).length > 1) {
          _score += 10;
        }
        _score += 10;
      } else {
        if (letter.allMatches(_word).length > 1) {
          _score += 20;
        }
        _score += 20;
      }
    } else {
      _wrongGuesses += letter;
      if (_word.length <= 8) {
        _score -= 5;
      } else {
        _score -= 2;
      }
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

import 'package:test/test.dart';
import 'package:password_generate/password_generate.dart';

void main() {
  group('Password Generator Tests', () {
    test('Generated password has the correct length', () {
      String password = generatePassword(length: 12);
      expect(password.length, equals(12));
    });

    test('Generated password contains only allowed characters', () {
      String password = generatePassword(
        length: 16,
        hasLowerCase: true,
        hasNumbers: true,
        hasSpecials: true,
        hasUpperCase: true,
      );
      // Need create a better regex?
      final validChars =
          RegExp(r'^[a-zA-Z0-9!@#\$%^&*()_+\-=\[\]{}|;:,.<>?]+$');
      expect(password, matches(validChars));
    });

    test('Generated password contains at least one uppercase letter', () {
      String password = generatePassword(
        length: 16,
        hasUpperCase: true,
        hasLowerCase: false,
        hasNumbers: false,
        hasSpecials: false,
      );

      final uppercaseLetters = RegExp(r'[A-Z]');
      expect(password, matches(uppercaseLetters));
    });

    test('Generated password contains at least one lowercase letter', () {
      String password = generatePassword(
        length: 16,
        hasUpperCase: false,
        hasLowerCase: true,
        hasNumbers: false,
        hasSpecials: false,
      );

      final lowercaseLetters = RegExp(r'[a-z]');
      expect(password, matches(lowercaseLetters));
    });

    test('Generated password contains at least one number', () {
      String password = generatePassword(
        length: 16,
        hasUpperCase: false,
        hasLowerCase: false,
        hasNumbers: true,
        hasSpecials: false,
      );

      final numbers = RegExp(r'[0-9]');
      expect(password, matches(numbers));
    });

    test('Generated password contains at least one symbol', () {
      String password = generatePassword(
        length: 16,
        hasUpperCase: false,
        hasLowerCase: false,
        hasNumbers: false,
        hasSpecials: true,
      );
      // Need create a better regex?
      final symbols = RegExp(r'[!@#\$%^&*()_+\-=\[\]{}|;:,.<>?]');
      expect(password, matches(symbols));
    });
    test('Throws an error when no character types are selected', () {
      expect(
        () => generatePassword(
          length: 16,
          hasUpperCase: false,
          hasLowerCase: false,
          hasNumbers: false,
          hasSpecials: false,
        ),
        throwsA(isA<ArgumentError>().having((e) => e.message, 'message',
            contains('At least one character set must be selected'))),
      );
    });
    test('Throw an error when lenght is null', () {
      expect(
        () => generatePassword(
          length: null,
          hasUpperCase: true,
          hasLowerCase: true,
          hasNumbers: true,
          hasSpecials: true,
        ),
        throwsA(isA<ArgumentError>().having((e) => e.message, 'message',
            contains('Password length must be specified'))),
      );
    });
  });
}

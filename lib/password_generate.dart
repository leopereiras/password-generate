import 'dart:math';

String generatePassword({
  int? length,
  bool hasLowerCase = true,
  bool hasNumbers = true,
  bool hasSpecials = true,
  bool hasUpperCase = true,
}) {
  const lowerCase = 'abcdefghijklmnopqrstuvwxyz';
  const numbers = '0123456789';
  const specials = '!@#%^&*()_+';
  const upperCase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  final random = Random.secure();
  final password = StringBuffer();

  String allowedChars = '';
  if (hasLowerCase) allowedChars += lowerCase;
  if (hasNumbers) allowedChars += numbers;
  if (hasSpecials) allowedChars += specials;
  if (hasUpperCase) allowedChars += upperCase;

  if (allowedChars.isEmpty) {
    throw ArgumentError('At least one character set must be selected');
  }

  if (length == null) {
    throw ArgumentError('Password length must be specified');
  }

  for (var i = 0; i < length; i++) {
    final index = random.nextInt(allowedChars.length);
    password.write(allowedChars[index]);
  }
  return password.toString();
}

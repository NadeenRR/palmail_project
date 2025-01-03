
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Archive Number Validation', () {

    test('Invalid mail number (wrong format) should fail', () {
      const mailNumber = '2024-1234';
      final isValidMailNumber = RegExp(r'^\d{4}/\d{4}$').hasMatch(mailNumber);
      expect(isValidMailNumber, false);
    });

    test('Invalid mail number (missing year) should fail', () {
      const mailNumber = '/1234';
      final isValidMailNumber = RegExp(r'^\d{4}/\d{4}$').hasMatch(mailNumber);
      expect(isValidMailNumber, false);
    });

    test('Invalid mail number (less than 4 digits after /) should fail', () {
      const mailNumber = '2024/123';
      final isValidMailNumber = RegExp(r'^\d{4}/\d{4}$').hasMatch(mailNumber);
      expect(isValidMailNumber, false);
    });

    test('Invalid mail number (extra characters) should fail', () {
      const mailNumber = '2024/12345';
      final isValidMailNumber = RegExp(r'^\d{4}/\d{4}$').hasMatch(mailNumber);
      expect(isValidMailNumber, false);
    });
  });
}



// void main() {
//   group('Password Validation', () {
//     test('Name with less than 3 letters should fail', () {
//       const name = 'Nr';
//       expect(name.length > 3, false);
//     });

//     test('Name with 3 or more letters should pass', () {
//       const name = 'Nadeen';
//       expect(name.length >= 3, true);
//     });
//   });
// }


/*

    test('Valid email should pass', () {
      const email = 'nadeen@gmail.com';
      final isValidEmail =
          RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
              .hasMatch(email);
      expect(isValidEmail, true);
    });

    test('Invalid email should fail', () {
      const email = 'nadeengmail.com';
      final isValidEmail =
          RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
              .hasMatch(email);
      expect(isValidEmail, false);
    });

    test('Name with less than 3 letters should fail', () {
      const name = 'Nr';
      expect(name.length > 3, false);
    });

    test('Name with 3 or more letters should pass', () {
      const name = 'Nadeen';
      expect(name.length > 3, true);
    });

    test('Password and confirm password should match', () {
      const password = 'nadeen1234';
      const confirmPassword = 'nadeen1234';
      expect(password == confirmPassword, true);
    });

    test('Password and confirm password mismatch should fail', () {
      const password = '123456n';
      const confirmPassword = '123456a';
      expect(password == confirmPassword, false);
    });
*/
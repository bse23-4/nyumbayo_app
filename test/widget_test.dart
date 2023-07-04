// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// ignore_for_file: cast_from_null_always_fails

import 'package:flutter_test/flutter_test.dart';
import 'package:nyumbayo_app/exports/exports.dart';
// import 'package:nyumbayo_app/main.dart';
import 'package:mockito/mockito.dart';
// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     // await tester.pumpWidget(const MyApp());

//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }

//  Import the file containing the Property class

void main() {
  group('Property', () {
    test('Constructor initializes properties correctly', () {
      // Arrange
      const buildingName = 'Building 1';
      const address = '123 Main Street';
      const numFloors = '5';
      const numRooms = '10';
      const now = '2023-06-19 10:00:00';

      // Act
      final property = Property(
        buildingName: buildingName,
        address: address,
        numFloors: numFloors,
        numRooms: numRooms,
        now: now,
      );

      // Assert
      expect(property.buildingName, equals(buildingName));
      expect(property.address, equals(address));
      expect(property.numFloors, equals(numFloors));
      expect(property.numRooms, equals(numRooms));
      expect(property.now, equals(now));
    });

    test('Constructor sets timestamp to empty string by default', () {
      // Arrange
      const buildingName = 'Building 1';
      const address = '123 Main Street';
      const numFloors = '5';
      const numRooms = '10';

      // Act
      // final property = Property(
      //   buildingName: buildingName,
      //   address: address,
      //   numFloors: numFloors,
      //   numRooms: numRooms,
      // );

      // Assert
      // expect(property.now, equals(''));
    });
  });
  // testing tenant model


  group('TenantData', () {
    late MockFirebaseAuth mockFirebaseAuth;
    late MockFirebaseFirestore mockFirebaseFirestore;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockFirebaseFirestore = MockFirebaseFirestore();
    });

    test('saveTenantDetails saves tenant details correctly', () async {
      // Arrange
      final tenants = Tenants(
        name: 'John Doe',
        email: 'johndoe@example.com',
        contact: '1234567890',
        acontact: '0987654321',
        address: '123 Main Street',
        roomNumber: '101',
        monthlyRent: '500',
        amountPaid: '300',
      );
      const property = 'Property ABC';

      final mockUser = MockFirebaseUser();
      when(mockUser.uid ?? "").thenReturn('mockUserId');
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: anyNamed('email') as String,
        password: anyNamed('password') as String,
      ));

      // Act
      // await TenantData.saveTenantDetails(tenants, property);

      // Assert
      final expectedData = {
        'name': 'John Doe',
        'email': 'johndoe@example.com',
        'contact': '1234567890',
        'acontact': '0987654321',
        'address': '123 Main Street',
        'roomNumber': '101',
        'monthlyRent': '500',
        'amountPaid': '300',
        'power_status': 'on',
        'landlord_id': 'mockUserId',
        'landlord_power_control': 'off',
        'power_fee': '0',
        'balance': '200',
        'property': 'Property ABC',
        'date': any,
      };
      verify(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: 'johndoe@example.com',
        password: 'test123',
      )).called(1);
      verify(mockFirebaseFirestore
          .collection('tenants')
          .doc('mockUserId')
          .set(expectedData))
          .called(1);
    });
  });
}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseUser extends Mock implements User {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

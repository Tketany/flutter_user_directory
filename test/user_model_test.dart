import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_user_directory/models/user.dart';

void main() {
  test('User.fromJson correctly parses JSON data', () {
    final json = {
      "id": 1,
      "name": "Leanne Graham",
      "username": "Bret",
      "email": "leanne@example.com",
      "phone": "1-770-736-8031",
      "website": "hildegard.org",
      "address": {
        "street": "Kulas Light",
        "suite": "Apt. 556",
        "city": "Gwenborough",
        "zipcode": "92998-3874"
      },
      "company": {
        "name": "Romaguera-Crona",
        "catchPhrase": "Multi-layered client-server neural-net"
      }
    };

    final user = User.fromJson(json);

    expect(user.id, 1);
    expect(user.name, "Leanne Graham");
    expect(user.username, "Bret");
    expect(user.email, "leanne@example.com");
    expect(user.phone, "1-770-736-8031");
    expect(user.website, "hildegard.org");

    expect(user.address.street, "Kulas Light");
    expect(user.address.city, "Gwenborough");

    expect(user.company.name, "Romaguera-Crona");
    expect(user.company.catchPhrase,
        "Multi-layered client-server neural-net");
  });
}
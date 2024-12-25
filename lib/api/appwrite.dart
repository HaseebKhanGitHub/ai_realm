import 'package:appwrite/appwrite.dart';

class appwrite {
  late Client client;
  late Account account;

  appwrite() {
    client = Client()
        .setEndpoint(
            'https://cloud.appwrite.io/v1') // Replace with your endpoint
        .setProject('67684a330021be360801'); // Replace with your project ID

    account = Account(client);
  }
}

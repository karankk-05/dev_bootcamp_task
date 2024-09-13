import 'dart:convert';
import 'package:http/http.dart' as http;

// Company model class
class Company {
  final String name;
  final String country;
  final String email;

  Company({required this.name, required this.country, required this.email});

  // Factory method to create a Company instance from JSON data
  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'],
      country: json['country'],
      email: json['email'],
    );
  }
}

class CompanyService {
  // Fetch the list of companies from the API
  Future<List<Company>> fetchCompanies() async {
    final response = await http.get(
      Uri.parse('https://fakerapi.it/api/v1/companies?_seed=12456'),
    );

    if (response.statusCode == 200) {
      // Parse the JSON response
      final data = jsonDecode(response.body);
      List<Company> companies = (data['data'] as List)
          .map((company) => Company.fromJson(company))
          .toList();
      return companies;
    } else {
      throw Exception('Failed to load companies');
    }
  }
}

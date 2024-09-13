
import 'package:flutter/material.dart';

import 'service.dart';

class ListAllPage extends StatefulWidget {
  const ListAllPage({super.key});

  @override
  State<ListAllPage> createState() => _ListAllPageState();
}

class _ListAllPageState extends State<ListAllPage> {
  late Future<List<Company>> _companyList; // Future to hold company data

  @override
  void initState() {
    super.initState();
    // Fetch the list of companies on page load
    _companyList = CompanyService().fetchCompanies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Companies List',
        ),
      ),
      body: FutureBuilder<List<Company>>(
        future: _companyList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load companies.'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final companies = snapshot.data!;
            return ListView.builder(
              itemCount: companies.length,
              itemBuilder: (context, index) {
                final company = companies[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: colorScheme.primary.withOpacity(0.8),
                      child: Text(
                        company.name[
                            0], // Display the first letter of the company name
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      company.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    subtitle: Text(
                      '${company.country} • ${company.email}',
                      style: TextStyle(
                        color: colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No companies found.'));
          }
        },
      ),
    );
  }
}

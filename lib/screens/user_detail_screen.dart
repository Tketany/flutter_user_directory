import 'package:flutter/material.dart';

import '../models/user.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const UserDetailScreen({
    super.key,
    required this.user,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final address =
        '${user.address.street}, ${user.address.suite}\n${user.address.city}, ${user.address.zipcode}';

    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        actions: [
          IconButton(
            tooltip: isFavorite ? 'Unfavorite' : 'Favorite',
            onPressed: onToggleFavorite,
            icon: Icon(isFavorite ? Icons.star : Icons.star_border),
          ),
        ],
    ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionTitle('Basic Info'),
          _InfoRow(label: 'Name', value: user.name, icon: Icons.person_outline),
          _InfoRow(
            label: 'Username',
            value: user.username,
            icon: Icons.alternate_email,
          ),
          _InfoRow(label: 'Email', value: user.email, icon: Icons.email_outlined),

          const SizedBox(height: 16),
          _SectionTitle('Contact'),
          _InfoRow(label: 'Phone', value: user.phone, icon: Icons.phone_outlined),
          _InfoRow(label: 'Website', value: user.website, icon: Icons.public),

          const SizedBox(height: 16),
          _SectionTitle('Company'),
          _InfoRow(
            label: 'Name',
            value: user.company.name,
            icon: Icons.business_outlined,
          ),
          _InfoRow(
            label: 'Catch phrase',
            value: user.company.catchPhrase,
            icon: Icons.format_quote_outlined,
          ),

          const SizedBox(height: 16),
          _SectionTitle('Address'),
          _InfoRow(
            label: 'Full address',
            value: address,
            icon: Icons.location_on_outlined,
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;

  const _InfoRow({required this.label, required this.value, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Padding(
              padding: const EdgeInsets.only(top: 2, right: 8),
              child: Icon(icon, size: 18, color: Colors.blueGrey),
            ),
          ],
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(value.isEmpty ? '-' : value),
          ),
        ],
      ),
    );
  }
}

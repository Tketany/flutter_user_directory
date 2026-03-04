import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/user_service.dart';
import 'user_detail_screen.dart';

class UserListScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;
  final Set<int> favoriteUserIds;
  final void Function(int userId) onToggleFavorite;

 const UserListScreen({
  super.key,
  required this.isDarkMode,
  required this.onToggleTheme,
  required this.favoriteUserIds,
  required this.onToggleFavorite,
});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  String _query = '';
  final TextEditingController _searchController = TextEditingController();

  final UserService _service = UserService();

  bool _showFavoritesOnly = false;

  bool _isLoading = false;
  String? _error;
  List<User> _users = const [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadUsers() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final users = await _service.fetchUsers();
      setState(() {
        _users = users;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _openDetails(User user) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => UserDetailScreen(
        user: user,
        isFavorite: widget.favoriteUserIds.contains(user.id),
        onToggleFavorite: () => widget.onToggleFavorite(user.id),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    final q = _query.trim().toLowerCase();
    final filteredUsers = _users.where((u) {
      if (_showFavoritesOnly && !widget.favoriteUserIds.contains(u.id)) {
        return false;
      }

      if (q.isEmpty) return true;
        return u.name.toLowerCase().contains(q) ||
            u.email.toLowerCase().contains(q) ||
            u.company.name.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search name, email, company...',
            border: InputBorder.none,
          ),
          textInputAction: TextInputAction.search,
          onChanged: (value) {
            setState(() => _query = value);
          },
        ),
        actions: [
          IconButton(
            tooltip: 'Clear',
            onPressed: () {
              _searchController.clear();
              setState(() => _query = '');
            },
            icon: const Icon(Icons.clear),
          ),
          IconButton(
            tooltip: widget.isDarkMode ? 'Light mode' : 'Dark mode',
            onPressed: widget.onToggleTheme,
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
          ),
          IconButton(
            tooltip: _showFavoritesOnly ? 'Show all' : 'Show favorites',
            onPressed: () {
              setState(() => _showFavoritesOnly = !_showFavoritesOnly);
            },
            icon: Icon(_showFavoritesOnly ? Icons.star : Icons.star_border),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _ErrorState(
                  message: _error!,
                  onRetry: _loadUsers,
                )
              : filteredUsers.isEmpty
                  ? RefreshIndicator(
                      onRefresh: _loadUsers,
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: const [
                          SizedBox(height: 200),
                          Center(child: Text('No users found')),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _loadUsers,
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: filteredUsers.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final user = filteredUsers[index];
                          return ListTile(
                            title: Text(user.name),
                            subtitle:
                                Text('${user.email}\n${user.company.name}'),
                            isThreeLine: true,
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => _openDetails(user),
                            leading: IconButton(
                                onPressed: () => widget.onToggleFavorite(user.id),
                                icon: Icon(
                                  widget.favoriteUserIds.contains(user.id)
                                      ? Icons.star
                                      : Icons.star_border,
                                ),
                              ),
                          );
                        },
                      ),
                    ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 12),
            const Text(
              'Something went wrong',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
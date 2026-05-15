import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Directory'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => userProvider.fetchUsers(),
          ),
        ],
      ),
      body: _buildBody(userProvider),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddUserDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(UserProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage.isNotEmpty) {
      return Center(child: Text('Error: ${provider.errorMessage}'));
    }

    if (provider.users.isEmpty) {
      return const Center(child: Text('No users found. Press + to add.'));
    }

    return ListView.builder(
      itemCount: provider.users.length,
      itemBuilder: (context, index) {
        final user = provider.users[index];

        return Dismissible(
          key: ValueKey(user.id),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            context.read<UserProvider>().removeUser(user.id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${user.first_Name} deleted')),
            );
          },
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.avatar),
            ),
            title: Text('${user.first_Name} ${user.last_Name}'),
            subtitle: Text(user.email),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showActionMenu(context, user),
          ),
        );
      },
    );
  }
  
/* Action Menu for Edit/Delete */
  void _showActionMenu(BuildContext context, user) {
    showDialog(
      context: context, 
      builder: (context) => SimpleDialog(
        title: Text('Edit ${user.first_Name}'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              _showEditDialog(context, user);
            },
            child: const ListTile(
              leading: Icon(Icons.edit, color: Colors.blue),
              title: Text('Edit User'),
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              _showDeleteConfirmation(context, user);
            },
            child: const ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text('Delete User'),
            ),
          ),
        ],
      )
    );
  }

  /* Edit User Dialog */
  void _showEditDialog(BuildContext context, user) {
  final firstNameController = TextEditingController(text: user.first_Name);
  final lastNameController = TextEditingController(text: user.last_Name);
  final emailController = TextEditingController(text: user.email);
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Edit User Profile'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: "First Name"),
            ),
      TextField(
        controller: lastNameController,
        decoration: const InputDecoration(labelText: "Last Name"),
      ),
      TextField(
        controller: emailController,
        decoration: const InputDecoration(labelText: "Email"),
      ),
      ],
    ),
    ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            context.read<UserProvider>().updateUserName(
              user.id, 
              firstNameController.text, 
              lastNameController.text, 
              emailController.text
            );
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}

/* Delete Confirmation Dialog */
void _showDeleteConfirmation(BuildContext context, user) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Confirm Delete'),
      content: Text('Are you sure you want to remove ${user.first_Name}?'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        TextButton(
          onPressed: () {
            context.read<UserProvider>().removeUser(user.id);
            Navigator.pop(context);
          },
          child: const Text('Delete', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}

  /* Create User Dialog */
  void _showAddUserDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New User'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<UserProvider>().addUser(controller.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
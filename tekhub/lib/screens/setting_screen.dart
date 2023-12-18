import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekhub/Firebase/actions/result.dart';
import 'package:tekhub/Firebase/actions/user_service.dart';
import 'package:tekhub/Firebase/models/users.dart';
import 'package:tekhub/provider/provider_listener.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  final bool isAdmin = false;

  Future<void> showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 39, 39, 39),
          title: const Text('Logout',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,),),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(fontFamily: 'Raleway', color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialogue
              },
              child: const Text(
                'Cancel',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialogue
                Navigator.pushNamed(context, 'login');
              },
              child: const Text(
                'Confirm',
                style: TextStyle(
                    color: Color.fromARGB(255, 126, 217, 87),
                    fontWeight: FontWeight.bold,),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> showDeleteDialog(
      BuildContext context, UserService userService, MyUser user,) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 39, 39, 39),
          title: const Text('Delete account',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,),),
          content: const Text(
            'Are you sure you want to delete your account?',
            style: TextStyle(fontFamily: 'Raleway', color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialogue
              },
              child: const Text(
                'Cancel',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () async {
                final Result<dynamic> result = await userService.deleteUser(
                  user.uid,
                );
                if (result.success) {
                  if (!context.mounted) return;
                  // Registration successful, navigate to another screen or perform actions accordingly
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Account deleted!'),
                    ),
                  );
                Navigator.of(context).pop(); // Ferme le dialogue
                await Navigator.pushNamed(context, 'login');
                } else {
                  if (!context.mounted) return;
                  // Registration failed, show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result.message.toString()),
                    ),
                  );
                }
              },
              child: const Text(
                'Confirm',
                style: TextStyle(
                    color: Color.fromARGB(255, 126, 217, 87),
                    fontWeight: FontWeight.bold,),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> handleProfileClick(BuildContext context) async {
    // Action à exécuter lors du clic sur Profile
    // Par exemple, naviguer vers la page de profil
    await Navigator.pushNamed(context, 'profile');
  }

  Future<void> handleCardClick(BuildContext context) async {
    // Action à exécuter lors du clic sur Profile
    // Par exemple, naviguer vers la page de profil
    await Navigator.pushNamed(context, 'card-information');
  }

  Future<void> handleResetClick(BuildContext context) async {
    // Action à exécuter lors du clic sur Profile
    // Par exemple, naviguer vers la page de profil
    await Navigator.pushNamed(context, 'forget-password');
  }

  void handleDeleteClick(BuildContext context) {
    // Action à exécuter lors du clic sur Profile
    // Par exemple, naviguer vers la page de profil
  }

  @override
  Widget build(BuildContext context) {
    final UserService userService = UserService();
    final MyUser user = Provider.of<ProviderListener>(context).user;
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: user.role == 'user'
            ? <Widget>[
                _SectionCard(
                  title: 'Settings',
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/images/avatar.png'),),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _SectionCard(
                  title: 'General',
                  children: <Widget>[
                    _CustomListTile(
                      title: 'Profile',
                      icon: Icons.person,
                      onTap: () async => handleProfileClick(context),
                    ),
                    _CustomListTile(
                      title: 'Card information',
                      icon: Icons.credit_card,
                      onTap: () async => handleCardClick(context),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _SectionCard(
                  title: 'Privacy and Security',
                  children: <Widget>[
                    _CustomListTile(
                      title: 'Reset password',
                      icon: Icons.security,
                      onTap: () async => handleResetClick(context),
                    ),
                    _CustomListTile(
                      title: 'Log out',
                      icon: Icons.lock,
                      onTap: () async => showLogoutDialog(context),
                    ),
                    _CustomListTile(
                      title: 'Delete account',
                      icon: Icons.delete,
                      onTap: () async => showDeleteDialog(context, userService, user),
                    ),
                  ],
                ),
              ]
            : <Widget>[
                _SectionCard(
                  title: 'Settings',
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',),),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _SectionCard(
                  title: 'General',
                  children: <Widget>[
                    _CustomListTile(
                      title: 'Profile',
                      icon: Icons.person,
                      onTap: () async => handleProfileClick(context),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _SectionCard(
                  title: 'Privacy and Security',
                  children: <Widget>[
                    _CustomListTile(
                      title: 'Reset password',
                      icon: Icons.security,
                      onTap: () async => handleResetClick(context),
                    ),
                    _CustomListTile(
                      title: 'Log out',
                      icon: Icons.lock,
                      onTap: () async => showLogoutDialog(context),
                    ),
                    _CustomListTile(
                      title: 'Delete account',
                      icon: Icons.delete,
                      onTap: () async => showDeleteDialog(context, userService, user),
                    ),
                  ],
                ),
              ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 39, 39, 39),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors
                    .white, // Choisis une couleur qui correspond à ton thème
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  _SingleSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway',),
          ),
        ),
        ...children,
      ],
    );
  }
}

class _CustomListTile extends StatelessWidget {

  const _CustomListTile(
      {required this.title, required this.icon, required this.onTap,});
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white, // Couleur de la bordure
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        iconColor: const Color.fromARGB(255, 126, 217, 87),
        textColor: Colors.white,
        leading: Icon(icon),
        trailing: const Icon(CupertinoIcons.forward, size: 18),
        title: Text(
          title,
          style: const TextStyle(fontFamily: 'Raleway'),
        ),
        onTap: onTap,
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  Future<void> showDeleteDialog(BuildContext context) async {
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

  void handleProfileClick(BuildContext context) {
    // Action à exécuter lors du clic sur Profile
    // Par exemple, naviguer vers la page de profil
    Navigator.pushNamed(context, 'profile');
  }

  void handleCardClick(BuildContext context) {
    // Action à exécuter lors du clic sur Profile
    // Par exemple, naviguer vers la page de profil
    Navigator.pushNamed(context, 'card-information');
  }

  void handleResetClick(BuildContext context) {
    // Action à exécuter lors du clic sur Profile
    // Par exemple, naviguer vers la page de profil
    Navigator.pushNamed(context, 'forget-password');
  }

  void handleDeleteClick(BuildContext context) {
    // Action à exécuter lors du clic sur Profile
    // Par exemple, naviguer vers la page de profil
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: isAdmin == false
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
                      onTap: () => handleProfileClick(context),
                    ),
                    _CustomListTile(
                      title: 'Card information',
                      icon: Icons.credit_card,
                      onTap: () => handleCardClick(context),
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
                      onTap: () => handleResetClick(context),
                    ),
                    _CustomListTile(
                      title: 'Log out',
                      icon: Icons.lock,
                      onTap: () => showLogoutDialog(context),
                    ),
                    _CustomListTile(
                      title: 'Delete account',
                      icon: Icons.delete,
                      onTap: () => showDeleteDialog(context),
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
                      onTap: () => handleProfileClick(context),
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
                      onTap: () => handleResetClick(context),
                    ),
                    _CustomListTile(
                      title: 'Log out',
                      icon: Icons.lock,
                      onTap: () => showLogoutDialog(context),
                    ),
                    _CustomListTile(
                      title: 'Delete account',
                      icon: Icons.delete,
                      onTap: () => showDeleteDialog(context),
                    ),
                  ],
                ),
              ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {

  const _SectionCard({required this.title, required this.children});
  final String title;
  final List<Widget> children;

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

  const _SingleSection({required this.title, required this.children});
  final String title;
  final List<Widget> children;

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

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import '../screens/routes/routes.dart';

/// Classe che builda il widget per mostrare una [AppBar].
class CaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;

  /// Costruttore per [CaAppBar].
  CaAppBar({super.key, required this.showBackButton});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF80DEEA),
      automaticallyImplyLeading: showBackButton,
      title: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.homeCA,
          );
        },
        child: Image.asset(
          "images/restart.png",
          width: 150,
        ),
      ),
      titleSpacing: 10,
      elevation: 10,
      shadowColor: Colors.grey,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Color(0xFFCE93D8),
              Color(0xFF80DEEA),
            ],
          ),
        ),
      ),
    );
  }

  /// Costruisce un [Drawer] che contiene varie opzioni di navigazione.
  static Widget buildDrawer(BuildContext context) {
     return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Color(0xFFCE93D8),
              Color(0xFF80DEEA),
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'SCEGLI IL SERVIZIO CHE FA PER TE',
                style: TextStyle(
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 2.0,
                      color: Color(0xFFB4B1B1),
                    ),
                  ],
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                ListTile(
                  title: const Text(
                    'Home',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.homeCA,
                    );
                  },
                ),
                ListTile(
                  title: const Text(
                    'Community Events Pubblicati',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.eventipubblicati,
                    );
                  },
                ),
                ListTile(
                  title: const Text(
                    'Annunci di lavoro Pubblicati',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.annuncipubblicati,
                    );
                  },
                ),
                ListTile(
                  title: const Text(
                    'Aggiungi Evento',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.addevento,
                    );
                  },
                ),
                ListTile(
                  title: const Text(
                    'Aggiungi Offerta di Lavoro',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.addannuncio,
                    );
                  },
                ),
              ],
            ),
          ),
          // Two additional ListTiles at the bottom
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: ListTile(
              title: const Text(
                'Logout',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'PoppinsMedium',
                  fontWeight: FontWeight.bold,
                ),
              ),

              ///metodo onTap gestisce il logout dall'applicazione.
              onTap: () {
                SessionManager().remove("token");
                SessionManager().destroy();
                Navigator.pushNamed(
                  context,
                  AppRoutes.home,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Logout effettuato',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    backgroundColor: Colors.lightBlue,
                    duration: Duration(seconds: 3),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

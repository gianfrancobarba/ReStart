import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

/// Funzione principale per eseguire i test dell'app Flutter.
void main() {
  group('App Flutter', () {
    late FlutterDriver driver;

    /// Imposta il driver Flutter prima dell'esecuzione dei test.
    ///
    /// Questa funzione viene eseguita una volta all'inizio dell'esecuzione del gruppo di test.
    setUpAll(() async {
      // Stabilisce una connessione con il driver Flutter.
      driver = await FlutterDriver.connect();
    });

    /// Chiude la connessione con il driver Flutter dopo i test.
    ///
    /// Questa funzione viene eseguita una volta alla fine dell'esecuzione del gruppo di test.
    tearDownAll(() async {
      // Chiude la connessione se esiste.
      driver.close();
    });

    /// Test per verificare la navigazione alla pagina di login.
    ///
    /// Verifica che il pulsante di login sia presente e cliccabile,
    /// e che i campi email e password siano visibili dopo il clic.
    test('navigazione alla pagina di login', () async {
      final loginButtonFinder = find.byValueKey('loginButton');
      await driver.tap(loginButtonFinder);

      final emailFieldFinder = find.byValueKey('usernameField');
      final passwordFieldFinder = find.byValueKey('passwordField');

      await driver.waitFor(emailFieldFinder);
      await driver.waitFor(passwordFieldFinder);
    });

    /// Test per inserimento e verifica del processo di login.
    ///
    /// Verifica che l'inserimento di username e password funzioni correttamente
    /// e che l'accesso porti alla visualizzazione di un elemento specifico post-login.
    test('Inserimento e test di login', () async {
      final usernameFieldFinder = find.byValueKey('usernameField');
      final passwordFieldFinder = find.byValueKey('passwordField');
      final loginButtonFinder = find.byValueKey('loginButton');

      await driver.tap(usernameFieldFinder);
      await driver.enterText('azienday');
      await driver.tap(passwordFieldFinder);
      await driver.enterText('password2');

      await driver.tap(loginButtonFinder);
      await driver.waitFor(find.byValueKey('homeCa'));
    });

    /// Test per l'inserimento di un annuncio.
    ///
    /// Verifica la possibilità di inserire un nuovo annuncio nella piattaforma,
    /// compresa la compilazione di tutti i campi necessari e l'invio del modulo.
    test('Inserimento annuncio', () async {
      // Trova e clicca sul pulsante di aggiuingi Annuncio
      await driver.tap(find.byValueKey('addAnnuncioContainer'));
      // Trova i campi di testo e il pulsante
      final scrollable = find.byValueKey('inserisciAnnuncio');
      final nomeAnnuncioFinder = find.byValueKey('nomeAnnuncio');
      final descrizioneFinder = find.byValueKey('descrizione');
      final cittaFinder = find.byValueKey('citta');
      final viaFinder = find.byValueKey('via');
      final provinciaFinder = find.byValueKey('provincia');
      final emailFinder = find.byValueKey('email');
      final numTelefonoFinder = find.byValueKey('numTelefono');
      final buttonFinder = find.byValueKey('inserisciAnnuncioButton');

      // Inserisci l'username e la password
      await driver.tap(nomeAnnuncioFinder);
      await driver.enterText('Software Developer in Tecnologie Avanzate');
      await driver.tap(descrizioneFinder);
      await driver.enterText(
          'Sviluppatore Software Senior per progetti innovativi. Esperienza nella progettazione e sviluppo software. Capacità di leadership e collaborazione. Ambiente stimolante, pacchetto retributivo competitivo.');
      await driver.tap(cittaFinder);
      await driver.enterText('Roma');
      await driver.tap(viaFinder);
      await driver.enterText('Via delle Acacie, 56');
      await driver.tap(provinciaFinder);
      await driver.enterText('RM');
      await driver.scroll(
        scrollable,
        0.0, // Distanza di scroll sull'asse X
        -900.0,
        // Distanza di scroll sull'asse Y (negativo per scroll verso il basso)
        Duration(milliseconds: 900), // Durata dello scroll
      );
      await driver.tap(emailFinder);
      await driver.enterText('techforgesolution@gmail.com');
      await driver.tap(numTelefonoFinder);
      await driver.enterText("+393572850945");

      await driver.tap(buttonFinder);
      await driver.waitFor(find.text('Richiesta inviata con successo'));
    });
  });
}
// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'BlueSpeak AI';

  @override
  String get cancel => 'Annuler';

  @override
  String get save => 'Enregistrer';

  @override
  String get retry => 'Réessayer';

  @override
  String get ok => 'OK';

  @override
  String get done => 'Terminé';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get delete => 'Supprimer';

  @override
  String get leave => 'Quitter';

  @override
  String get stay => 'Rester';

  @override
  String get start => 'Commencer';

  @override
  String get or => 'ou';

  @override
  String get onb1Title => 'Parlez avec confiance';

  @override
  String get onb1Body =>
      'Entraînez-vous à de vraies conversations à voix haute avec un coach IA qui ne se fatigue jamais et ne vous juge pas.';

  @override
  String get onb2Title => 'Choisissez une situation réelle';

  @override
  String get onb2Body =>
      'Entretiens d\'embauche, voyages, conversations quotidiennes et pitchs. Choisissez une salle et lancez-vous.';

  @override
  String get onb3Title => 'Progressez à chaque phrase';

  @override
  String get onb3Body =>
      'Recevez des corrections, des conseils et une note après chaque message, et regardez votre série grandir.';

  @override
  String get startPractising => 'Commencer à s\'entraîner';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get logIn => 'Se connecter';

  @override
  String get guestNameTitle => 'Comment doit-on vous appeler ?';

  @override
  String get guestNameHint => 'Votre prénom (facultatif)';

  @override
  String get guestNote =>
      'Aucun compte requis. Votre progression est enregistrée sur cet appareil.';

  @override
  String get loginTitle => 'Bon retour';

  @override
  String get loginSubtitle =>
      'Connectez-vous pour garder votre progression avec vous.';

  @override
  String get signupTitle => 'Créez votre compte';

  @override
  String get signupSubtitle => 'C\'est gratuit et ça prend une minute.';

  @override
  String get nameLabel => 'Nom';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get passwordLabel => 'Mot de passe';

  @override
  String get confirmPasswordLabel => 'Confirmer le mot de passe';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get continueWithGoogle => 'Continuer avec Google';

  @override
  String get continueAsGuest => 'Continuer en tant qu\'invité';

  @override
  String get noAccountYet => 'Pas encore de compte ?';

  @override
  String get haveAccountAlready => 'Vous avez déjà un compte ?';

  @override
  String get signUp => 'S\'inscrire';

  @override
  String get errEmailRequired => 'L\'e-mail est obligatoire';

  @override
  String get errEmailInvalid => 'Saisissez une adresse e-mail valide';

  @override
  String get errPasswordRequired => 'Le mot de passe est obligatoire';

  @override
  String get errNameRequired => 'Le nom est obligatoire';

  @override
  String get errPasswordShort => 'Utilisez au moins 6 caractères';

  @override
  String get errPasswordMismatch => 'Les mots de passe ne correspondent pas';

  @override
  String get enterEmailFirst =>
      'Saisissez d\'abord votre e-mail ci-dessus, puis réessayez.';

  @override
  String resetEmailSent(String email) {
    return 'E-mail de réinitialisation envoyé à $email.';
  }

  @override
  String get authInvalidEmail => 'Cette adresse e-mail semble invalide.';

  @override
  String get authWrongCredentials => 'E-mail ou mot de passe incorrect.';

  @override
  String get authDisabled => 'Ce compte a été désactivé.';

  @override
  String get authEmailInUse =>
      'Un compte existe déjà avec cet e-mail. Essayez de vous connecter.';

  @override
  String get authWeakPassword =>
      'Mot de passe trop faible. Utilisez au moins 6 caractères.';

  @override
  String get authDifferentMethod =>
      'Cet e-mail est associé à une autre méthode de connexion.';

  @override
  String get authTooMany =>
      'Trop de tentatives. Patientez un instant puis réessayez.';

  @override
  String get authNetwork =>
      'Erreur réseau. Vérifiez votre connexion et réessayez.';

  @override
  String get authNotEnabled =>
      'Cette méthode de connexion n\'est pas encore activée.';

  @override
  String get authGoogleFailed =>
      'Échec de la connexion Google. Veuillez réessayer.';

  @override
  String get authUnavailable =>
      'La connexion n\'est pas encore disponible ici. Continuez en invité pour commencer à vous entraîner.';

  @override
  String get authGeneric => 'Un problème est survenu. Veuillez réessayer.';

  @override
  String get navPractice => 'S\'entraîner';

  @override
  String get navProgress => 'Progrès';

  @override
  String get navProfile => 'Profil';

  @override
  String homeGreeting(String name) {
    return 'Salut, $name';
  }

  @override
  String get homeGreetingGuest => 'Salut !';

  @override
  String get homeSubtitle => 'Prêt à vous entraîner à parler ?';

  @override
  String streakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours',
      one: '1 jour',
    );
    return '$_temp0';
  }

  @override
  String get todayChallenge => 'Défi du jour';

  @override
  String get startNow => 'Commencer';

  @override
  String get practiceRooms => 'Salles d\'entraînement';

  @override
  String get thisWeek => 'Cette semaine';

  @override
  String get practisedToday => 'Vous vous êtes entraîné aujourd\'hui. Bravo !';

  @override
  String get keepStreak =>
      'Entraînez-vous aujourd\'hui pour garder votre série.';

  @override
  String get roomInterview => 'Préparation d\'entretien';

  @override
  String get roomInterviewDesc => 'Répétez vos réponses face à un recruteur.';

  @override
  String get roomTravel => 'Voyage';

  @override
  String get roomTravelDesc => 'Aéroports, hôtels, restaurants et plus.';

  @override
  String get roomDaily => 'Vie quotidienne';

  @override
  String get roomDailyDesc => 'Conversation légère, appels et nouveaux amis.';

  @override
  String get roomPitch => 'Pitch & présentation';

  @override
  String get roomPitchDesc => 'Travaillez un pitch clair de 30 secondes.';

  @override
  String get roomFree => 'Discussion libre';

  @override
  String get roomFreeDesc => 'Parlez de ce que vous voulez.';

  @override
  String get roomPicture => 'Parler d\'une photo';

  @override
  String get roomPictureDesc => 'Décrivez une photo à voix haute.';

  @override
  String get setupChooseSituation => 'Choisissez une situation';

  @override
  String get setupRoleLabel => 'Le poste visé';

  @override
  String get setupRoleHint => 'p. ex. Product Manager';

  @override
  String get setupLevel => 'Votre niveau';

  @override
  String get levelBeginner => 'Débutant';

  @override
  String get levelIntermediate => 'Intermédiaire';

  @override
  String get levelAdvanced => 'Avancé';

  @override
  String get setupPracticeIn => 'S\'entraîner en';

  @override
  String get setupStart => 'Démarrer la session';

  @override
  String get setupAddPhoto => 'Ajoutez une photo à décrire';

  @override
  String get setupTakePhoto => 'Prendre une photo';

  @override
  String get setupFromGallery => 'Choisir dans la galerie';

  @override
  String get setupPhotoAdded => 'Photo ajoutée';

  @override
  String get setupNeedPhoto => 'Ajoutez une photo pour commencer.';

  @override
  String get scRolePm => 'Product Manager';

  @override
  String get scRoleSwe => 'Ingénieur logiciel';

  @override
  String get scRoleMarketing => 'Chargé de marketing';

  @override
  String get scRoleSupport => 'Support client';

  @override
  String get scRoleFresher => 'Premier emploi';

  @override
  String get scTravelAirport => 'Enregistrement à l\'aéroport';

  @override
  String get scTravelHotel => 'Arrivée à l\'hôtel';

  @override
  String get scTravelRestaurant => 'Commander au restaurant';

  @override
  String get scTravelDirections => 'Demander son chemin';

  @override
  String get scTravelMarket => 'Faire les courses au marché';

  @override
  String get scTravelPharmacy => 'À la pharmacie';

  @override
  String get scDailyIntro => 'Se présenter';

  @override
  String get scDailySmalltalk => 'Discuter avec un voisin';

  @override
  String get scDailyPhone => 'Réserver par téléphone';

  @override
  String get scDailyFriend => 'Se faire un ami';

  @override
  String get scDailyLandlord => 'Parler à son propriétaire';

  @override
  String get scPitchIntro => 'Présentation en 30 secondes';

  @override
  String get scPitchProduct => 'Pitcher un produit ou une idée';

  @override
  String get scPitchTalk => 'Un court exposé sur votre passion';

  @override
  String get scFreeDay => 'Ma journée';

  @override
  String get scFreeHobbies => 'Loisirs et centres d\'intérêt';

  @override
  String get scFreePlans => 'Projets pour le week-end et l\'avenir';

  @override
  String get scFreeOpinions => 'Donner son avis';

  @override
  String get practiceHint => 'Écrivez ou touchez le micro…';

  @override
  String get practiceListening => 'J\'écoute… parlez maintenant';

  @override
  String get practiceSettingUp => 'Préparation de votre salle…';

  @override
  String get practiceFinish => 'Terminer';

  @override
  String get finishTitle => 'Terminer cette session ?';

  @override
  String get finishBody => 'Je vais analyser votre performance.';

  @override
  String get finishNeedMessage =>
      'Dites ou écrivez d\'abord au moins une phrase.';

  @override
  String get leaveTitle => 'Quitter cette session ?';

  @override
  String get leaveBody => 'Votre conversation ne sera pas enregistrée.';

  @override
  String get coachTranslate => 'Traduire';

  @override
  String get coachHideTranslation => 'Masquer la traduction';

  @override
  String get coachListen => 'Écouter';

  @override
  String get voiceOn => 'Réponses vocales activées';

  @override
  String get voiceOff => 'Réponses vocales désactivées';

  @override
  String get feedbackGreat => 'Belle phrase !';

  @override
  String get feedbackSayIt => 'Essayez de le dire ainsi';

  @override
  String get feedbackWhy => 'Pourquoi';

  @override
  String get feedbackTip => 'Astuce';

  @override
  String get youCouldSay => 'Vous pourriez dire';

  @override
  String get micUnavailable =>
      'La reconnaissance vocale n\'est pas disponible ici. Vous pouvez écrire.';

  @override
  String get errNetwork =>
      'Impossible de joindre le coach. Vérifiez votre connexion.';

  @override
  String get errBusy => 'Le coach est occupé. Réessayez dans un instant.';

  @override
  String get errTimeout => 'C\'était trop long. Veuillez réessayer.';

  @override
  String get errServer =>
      'Un problème est survenu de notre côté. Veuillez réessayer.';

  @override
  String get errTooLarge =>
      'Cette photo est trop grande. Essayez-en une plus petite.';

  @override
  String get messageFailed => 'Non envoyé. Touchez pour réessayer.';

  @override
  String get summaryTitle => 'Bilan de la session';

  @override
  String get summaryLoading => 'Analyse de votre session…';

  @override
  String get summaryFailed => 'Impossible de charger le bilan.';

  @override
  String get summaryYourScore => 'Votre note';

  @override
  String get summaryStrengths => 'Ce qui s\'est bien passé';

  @override
  String get summaryImprove => 'À travailler';

  @override
  String get summaryVocab => 'Mots à retenir';

  @override
  String get summaryNextGoal => 'Votre prochain objectif';

  @override
  String get summaryAgain => 'S\'entraîner à nouveau';

  @override
  String get summaryBack => 'Retour à l\'entraînement';

  @override
  String get progressTitle => 'Votre progression';

  @override
  String get statStreak => 'Série de jours';

  @override
  String get statBestStreak => 'Meilleure série';

  @override
  String get statSessions => 'Sessions';

  @override
  String get statAverage => 'Note moyenne';

  @override
  String get statBest => 'Meilleure note';

  @override
  String get statMessages => 'Messages';

  @override
  String get recentSessions => 'Sessions récentes';

  @override
  String get noSessions =>
      'Pas encore de session. Lancez votre premier entraînement !';

  @override
  String get clearHistory => 'Effacer l\'historique';

  @override
  String get clearHistoryBody =>
      'Cela supprime vos sessions et votre série de cet appareil.';

  @override
  String messagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count messages',
      one: '1 message',
    );
    return '$_temp0';
  }

  @override
  String get profileGuest => 'Invité';

  @override
  String get profileGuestCta =>
      'Créez un compte gratuit pour garder votre progression.';

  @override
  String get editProfile => 'Modifier le profil';

  @override
  String get preferences => 'Préférences';

  @override
  String get feedback => 'Envoyer un avis';

  @override
  String get aboutApp => 'À propos de BlueSpeak AI';

  @override
  String get whatsNew => 'Nouveautés';

  @override
  String get supportHelp => 'Aide et assistance';

  @override
  String supportContact(String email) {
    return 'Contact : $email';
  }

  @override
  String get logout => 'Se déconnecter';

  @override
  String get logoutConfirm => 'Voulez-vous vraiment vous déconnecter ?';

  @override
  String get saveChanges => 'Enregistrer';

  @override
  String get sendResetEmail => 'Envoyer l\'e-mail de réinitialisation';

  @override
  String get emailCannotChange =>
      'Votre e-mail de connexion ne peut pas être modifié';

  @override
  String get profileUpdated => 'Profil mis à jour';

  @override
  String get profileUpdateFailed => 'Impossible de mettre à jour votre nom.';

  @override
  String get prefsAppearance => 'Apparence';

  @override
  String get prefsTheme => 'Thème';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get prefsAccent => 'Couleur d\'accent';

  @override
  String get accentIndigo => 'Indigo';

  @override
  String get accentOcean => 'Océan';

  @override
  String get accentTeal => 'Sarcelle';

  @override
  String get accentSunset => 'Coucher de soleil';

  @override
  String get accentRose => 'Rose';

  @override
  String get prefsLanguage => 'Langue';

  @override
  String get prefsAppLanguage => 'Langue de l\'app';

  @override
  String get prefsAppLanguageHelp =>
      'Les menus, corrections et astuces s\'affichent dans cette langue.';

  @override
  String get prefsPracticeLanguage => 'Langue d\'entraînement';

  @override
  String get prefsPracticeHelp => 'La langue que vous voulez mieux parler.';

  @override
  String get prefsDefaultLevel => 'Niveau par défaut';

  @override
  String get prefsVoice => 'Voix';

  @override
  String get prefsAutoSpeak => 'Lire les réponses du coach à voix haute';

  @override
  String get prefsAutoSpeakHelp =>
      'Le coach prononce chaque réponse automatiquement.';

  @override
  String get fbSentTitle => 'Avis envoyé !';

  @override
  String get fbThanks => 'Merci pour votre avis !';

  @override
  String get fbThanksBody => 'Votre avis nous aide à améliorer BlueSpeak AI.';

  @override
  String get fbDescribe => 'Décrivez votre avis';

  @override
  String get fbHint => 'Dites-nous ce qui motive cet avis…';

  @override
  String get fbNoSensitive => 'N\'incluez aucune information sensible';

  @override
  String get fbScreenshotHelp =>
      'Une capture d\'écran nous aide à comprendre. (facultatif)';

  @override
  String get fbUpload => 'Ajouter une capture';

  @override
  String get fbMaxTwo => 'Vous pouvez ajouter jusqu\'à 2 captures.';

  @override
  String get fbMayEmail =>
      'Nous pouvons vous écrire pour plus d\'informations ou des nouveautés';

  @override
  String get fbEmpty => 'Saisissez votre avis avant d\'envoyer.';

  @override
  String get fbSend => 'Envoyer';

  @override
  String get fbOpening => 'Ouverture de votre application e-mail…';

  @override
  String fbCouldNotOpen(String email) {
    return 'Impossible d\'ouvrir une application e-mail. Écrivez-nous à $email.';
  }

  @override
  String get fbPrivacyNote =>
      'Certaines informations de compte et système peuvent être envoyées à BlueSpeak pour corriger des problèmes et améliorer l\'application.';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get termsOfService => 'Conditions d\'utilisation';

  @override
  String get legalEnglishNote =>
      'Ce document n\'est disponible qu\'en anglais.';

  @override
  String get aboutVersion => 'Version';

  @override
  String get wn1 =>
      'Coach d\'expression orale : entraînez-vous aux entretiens, aux voyages et aux conversations quotidiennes.';

  @override
  String get wn2 =>
      'Corrections, astuces et note instantanées après chaque message.';

  @override
  String get wn3 =>
      'Séries quotidiennes et page de progression pour rester motivé.';

  @override
  String get wn4 => 'Thèmes clair et sombre, couleurs d\'accent et 5 langues.';

  @override
  String get wn5 =>
      'Aucune clé API nécessaire : ouvrez l\'application et lancez-vous.';
}

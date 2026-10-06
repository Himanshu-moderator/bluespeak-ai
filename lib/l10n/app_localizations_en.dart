// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'BlueSpeak AI';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get retry => 'Try again';

  @override
  String get ok => 'OK';

  @override
  String get done => 'Done';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get delete => 'Delete';

  @override
  String get leave => 'Leave';

  @override
  String get stay => 'Stay';

  @override
  String get start => 'Start';

  @override
  String get or => 'or';

  @override
  String get onb1Title => 'Speak with confidence';

  @override
  String get onb1Body =>
      'Practise real conversations out loud with an AI coach that never gets tired or judges you.';

  @override
  String get onb2Title => 'Pick a real-life situation';

  @override
  String get onb2Body =>
      'Job interviews, travel, everyday chats and pitches. Choose a room and start talking.';

  @override
  String get onb3Title => 'Improve with every sentence';

  @override
  String get onb3Body =>
      'Get instant corrections, tips and a score after each message, and watch your streak grow.';

  @override
  String get startPractising => 'Start practising';

  @override
  String get createAccount => 'Create account';

  @override
  String get logIn => 'Log in';

  @override
  String get guestNameTitle => 'What should we call you?';

  @override
  String get guestNameHint => 'Your name (optional)';

  @override
  String get guestNote =>
      'No account needed. Your progress is saved on this device.';

  @override
  String get loginTitle => 'Welcome back';

  @override
  String get loginSubtitle => 'Log in to keep your progress with you.';

  @override
  String get signupTitle => 'Create your account';

  @override
  String get signupSubtitle => 'It\'s free and takes a minute.';

  @override
  String get nameLabel => 'Name';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get confirmPasswordLabel => 'Confirm password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueAsGuest => 'Continue as guest';

  @override
  String get noAccountYet => 'Don\'t have an account?';

  @override
  String get haveAccountAlready => 'Already have an account?';

  @override
  String get signUp => 'Sign up';

  @override
  String get errEmailRequired => 'Email is required';

  @override
  String get errEmailInvalid => 'Enter a valid email address';

  @override
  String get errPasswordRequired => 'Password is required';

  @override
  String get errNameRequired => 'Name is required';

  @override
  String get errPasswordShort => 'Use at least 6 characters';

  @override
  String get errPasswordMismatch => 'Passwords don\'t match';

  @override
  String get enterEmailFirst => 'Enter your email above first, then tap again.';

  @override
  String resetEmailSent(String email) {
    return 'Password reset email sent to $email.';
  }

  @override
  String get authInvalidEmail => 'That email address looks invalid.';

  @override
  String get authWrongCredentials => 'Incorrect email or password.';

  @override
  String get authDisabled => 'This account has been disabled.';

  @override
  String get authEmailInUse =>
      'An account with this email already exists. Try logging in.';

  @override
  String get authWeakPassword =>
      'Password is too weak. Use at least 6 characters.';

  @override
  String get authDifferentMethod =>
      'This email is registered with a different sign-in method.';

  @override
  String get authTooMany =>
      'Too many attempts. Please wait a moment and try again.';

  @override
  String get authNetwork =>
      'Network error. Check your connection and try again.';

  @override
  String get authNotEnabled => 'This sign-in method is not enabled yet.';

  @override
  String get authGoogleFailed => 'Google sign-in failed. Please try again.';

  @override
  String get authUnavailable =>
      'Sign-in isn\'t available here yet. Continue as a guest to start practising.';

  @override
  String get authGeneric => 'Something went wrong. Please try again.';

  @override
  String get navPractice => 'Practice';

  @override
  String get navProgress => 'Progress';

  @override
  String get navProfile => 'Profile';

  @override
  String homeGreeting(String name) {
    return 'Hi, $name';
  }

  @override
  String get homeGreetingGuest => 'Hi there';

  @override
  String get homeSubtitle => 'Ready to practise speaking?';

  @override
  String streakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '1 day',
    );
    return '$_temp0';
  }

  @override
  String get todayChallenge => 'Today\'s challenge';

  @override
  String get startNow => 'Start now';

  @override
  String get practiceRooms => 'Practice rooms';

  @override
  String get thisWeek => 'This week';

  @override
  String get practisedToday => 'You\'ve practised today. Great job!';

  @override
  String get keepStreak => 'Practise today to keep your streak alive.';

  @override
  String get roomInterview => 'Interview Prep';

  @override
  String get roomInterviewDesc => 'Rehearse answers with a hiring manager.';

  @override
  String get roomTravel => 'Travel Talk';

  @override
  String get roomTravelDesc => 'Airports, hotels, restaurants and more.';

  @override
  String get roomDaily => 'Everyday Life';

  @override
  String get roomDailyDesc => 'Small talk, phone calls and new friends.';

  @override
  String get roomPitch => 'Pitch & Present';

  @override
  String get roomPitchDesc => 'Practise a clear 30-second pitch.';

  @override
  String get roomFree => 'Free Talk';

  @override
  String get roomFreeDesc => 'Chat about anything you like.';

  @override
  String get roomPicture => 'Picture Talk';

  @override
  String get roomPictureDesc => 'Describe a photo out loud.';

  @override
  String get setupChooseSituation => 'Choose a situation';

  @override
  String get setupRoleLabel => 'The role you\'re interviewing for';

  @override
  String get setupRoleHint => 'e.g. Product Manager';

  @override
  String get setupLevel => 'Your level';

  @override
  String get levelBeginner => 'Beginner';

  @override
  String get levelIntermediate => 'Intermediate';

  @override
  String get levelAdvanced => 'Advanced';

  @override
  String get setupPracticeIn => 'Practise in';

  @override
  String get setupStart => 'Start session';

  @override
  String get setupAddPhoto => 'Add a photo to describe';

  @override
  String get setupTakePhoto => 'Take a photo';

  @override
  String get setupFromGallery => 'Choose from gallery';

  @override
  String get setupPhotoAdded => 'Photo added';

  @override
  String get setupNeedPhoto => 'Add a photo to start Picture Talk.';

  @override
  String get scRolePm => 'Product Manager';

  @override
  String get scRoleSwe => 'Software Engineer';

  @override
  String get scRoleMarketing => 'Marketing Executive';

  @override
  String get scRoleSupport => 'Customer Support';

  @override
  String get scRoleFresher => 'First job (fresher)';

  @override
  String get scTravelAirport => 'Airport check-in';

  @override
  String get scTravelHotel => 'Hotel check-in';

  @override
  String get scTravelRestaurant => 'Ordering food';

  @override
  String get scTravelDirections => 'Asking for directions';

  @override
  String get scTravelMarket => 'Shopping at a market';

  @override
  String get scTravelPharmacy => 'At the pharmacy';

  @override
  String get scDailyIntro => 'Introducing yourself';

  @override
  String get scDailySmalltalk => 'Small talk with a neighbour';

  @override
  String get scDailyPhone => 'Booking by phone';

  @override
  String get scDailyFriend => 'Making a new friend';

  @override
  String get scDailyLandlord => 'Talking to your landlord';

  @override
  String get scPitchIntro => '30-second self-introduction';

  @override
  String get scPitchProduct => 'Pitch a product or idea';

  @override
  String get scPitchTalk => 'A short talk on what you love';

  @override
  String get scFreeDay => 'My day';

  @override
  String get scFreeHobbies => 'Hobbies and interests';

  @override
  String get scFreePlans => 'Weekend and future plans';

  @override
  String get scFreeOpinions => 'Sharing opinions';

  @override
  String get practiceHint => 'Type or tap the mic…';

  @override
  String get practiceListening => 'Listening… speak now';

  @override
  String get practiceSettingUp => 'Setting up your room…';

  @override
  String get practiceFinish => 'Finish';

  @override
  String get finishTitle => 'Finish this session?';

  @override
  String get finishBody => 'I\'ll review how you did.';

  @override
  String get finishNeedMessage => 'Say or type at least one thing first.';

  @override
  String get leaveTitle => 'Leave this session?';

  @override
  String get leaveBody => 'Your conversation won\'t be saved.';

  @override
  String get coachTranslate => 'Translate';

  @override
  String get coachHideTranslation => 'Hide translation';

  @override
  String get coachListen => 'Listen';

  @override
  String get voiceOn => 'Voice replies on';

  @override
  String get voiceOff => 'Voice replies off';

  @override
  String get feedbackGreat => 'Great sentence!';

  @override
  String get feedbackSayIt => 'Try saying it like this';

  @override
  String get feedbackWhy => 'Why';

  @override
  String get feedbackTip => 'Tip';

  @override
  String get youCouldSay => 'You could say';

  @override
  String get micUnavailable =>
      'Speech recognition isn\'t available here. You can type instead.';

  @override
  String get errNetwork => 'Can\'t reach the coach. Check your connection.';

  @override
  String get errBusy => 'The coach is busy. Try again in a moment.';

  @override
  String get errTimeout => 'That took too long. Please try again.';

  @override
  String get errServer => 'Something went wrong on our side. Please try again.';

  @override
  String get errTooLarge => 'That photo is too large. Try a smaller one.';

  @override
  String get messageFailed => 'Not sent. Tap to retry.';

  @override
  String get summaryTitle => 'Session summary';

  @override
  String get summaryLoading => 'Reviewing your session…';

  @override
  String get summaryFailed => 'Couldn\'t load the review.';

  @override
  String get summaryYourScore => 'Your score';

  @override
  String get summaryStrengths => 'What went well';

  @override
  String get summaryImprove => 'Work on next';

  @override
  String get summaryVocab => 'Words to remember';

  @override
  String get summaryNextGoal => 'Your next goal';

  @override
  String get summaryAgain => 'Practise again';

  @override
  String get summaryBack => 'Back to practice';

  @override
  String get progressTitle => 'Your progress';

  @override
  String get statStreak => 'Day streak';

  @override
  String get statBestStreak => 'Best streak';

  @override
  String get statSessions => 'Sessions';

  @override
  String get statAverage => 'Average score';

  @override
  String get statBest => 'Best score';

  @override
  String get statMessages => 'Messages';

  @override
  String get recentSessions => 'Recent sessions';

  @override
  String get noSessions => 'No sessions yet. Start your first practice!';

  @override
  String get clearHistory => 'Clear history';

  @override
  String get clearHistoryBody =>
      'This removes your sessions and streak from this device.';

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
  String get profileGuest => 'Guest';

  @override
  String get profileGuestCta =>
      'Create a free account to keep your progress safe.';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get preferences => 'Preferences';

  @override
  String get feedback => 'Send feedback';

  @override
  String get aboutApp => 'About BlueSpeak AI';

  @override
  String get whatsNew => 'What\'s new';

  @override
  String get supportHelp => 'Support and help';

  @override
  String supportContact(String email) {
    return 'Contact: $email';
  }

  @override
  String get logout => 'Log out';

  @override
  String get logoutConfirm => 'Are you sure you want to log out?';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get sendResetEmail => 'Send password reset email';

  @override
  String get emailCannotChange => 'Your sign-in email can\'t be changed';

  @override
  String get profileUpdated => 'Profile updated';

  @override
  String get profileUpdateFailed => 'Could not update your name.';

  @override
  String get prefsAppearance => 'Appearance';

  @override
  String get prefsTheme => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get prefsAccent => 'Accent colour';

  @override
  String get accentIndigo => 'Indigo';

  @override
  String get accentOcean => 'Ocean';

  @override
  String get accentTeal => 'Teal';

  @override
  String get accentSunset => 'Sunset';

  @override
  String get accentRose => 'Rose';

  @override
  String get prefsLanguage => 'Language';

  @override
  String get prefsAppLanguage => 'App language';

  @override
  String get prefsAppLanguageHelp =>
      'Menus, corrections and tips are shown in this language.';

  @override
  String get prefsPracticeLanguage => 'Practice language';

  @override
  String get prefsPracticeHelp =>
      'The language you want to get better at speaking.';

  @override
  String get prefsDefaultLevel => 'Default level';

  @override
  String get prefsVoice => 'Voice';

  @override
  String get prefsAutoSpeak => 'Read coach replies aloud';

  @override
  String get prefsAutoSpeakHelp => 'The coach speaks each reply automatically.';

  @override
  String get fbSentTitle => 'Feedback sent!';

  @override
  String get fbThanks => 'Thank you for sending the feedback!';

  @override
  String get fbThanksBody => 'Your input helps us improve BlueSpeak AI.';

  @override
  String get fbDescribe => 'Describe your feedback';

  @override
  String get fbHint => 'Tell us what prompted this feedback…';

  @override
  String get fbNoSensitive => 'Please don\'t include any sensitive information';

  @override
  String get fbScreenshotHelp =>
      'A screenshot helps us understand your feedback. (optional)';

  @override
  String get fbUpload => 'Upload screenshot';

  @override
  String get fbMaxTwo => 'You can add up to 2 screenshots.';

  @override
  String get fbMayEmail => 'We may email you for more information or updates';

  @override
  String get fbEmpty => 'Please enter your feedback before sending.';

  @override
  String get fbSend => 'Send';

  @override
  String get fbOpening => 'Opening your email app…';

  @override
  String fbCouldNotOpen(String email) {
    return 'Could not open an email app. Please email us at $email.';
  }

  @override
  String get fbPrivacyNote =>
      'Some account and system information may be sent to BlueSpeak to fix problems and improve the app.';

  @override
  String get privacyPolicy => 'Privacy policy';

  @override
  String get termsOfService => 'Terms of service';

  @override
  String get legalEnglishNote => 'This document is available in English only.';

  @override
  String get aboutVersion => 'Version';

  @override
  String get wn1 =>
      'Speaking coach: practise interviews, travel talk and everyday chats out loud.';

  @override
  String get wn2 =>
      'Instant corrections, tips and a score after every message.';

  @override
  String get wn3 => 'Daily streaks and a progress page to keep you motivated.';

  @override
  String get wn4 => 'Light and dark themes, accent colours and 5 languages.';

  @override
  String get wn5 => 'No API key needed: just open the app and start talking.';
}

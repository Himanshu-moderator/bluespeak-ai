import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('zh'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'BlueSpeak AI'**
  String get appName;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @leave.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get leave;

  /// No description provided for @stay.
  ///
  /// In en, this message translates to:
  /// **'Stay'**
  String get stay;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @onb1Title.
  ///
  /// In en, this message translates to:
  /// **'Speak with confidence'**
  String get onb1Title;

  /// No description provided for @onb1Body.
  ///
  /// In en, this message translates to:
  /// **'Practise real conversations out loud with an AI coach that never gets tired or judges you.'**
  String get onb1Body;

  /// No description provided for @onb2Title.
  ///
  /// In en, this message translates to:
  /// **'Pick a real-life situation'**
  String get onb2Title;

  /// No description provided for @onb2Body.
  ///
  /// In en, this message translates to:
  /// **'Job interviews, travel, everyday chats and pitches. Choose a room and start talking.'**
  String get onb2Body;

  /// No description provided for @onb3Title.
  ///
  /// In en, this message translates to:
  /// **'Improve with every sentence'**
  String get onb3Title;

  /// No description provided for @onb3Body.
  ///
  /// In en, this message translates to:
  /// **'Get instant corrections, tips and a score after each message, and watch your streak grow.'**
  String get onb3Body;

  /// No description provided for @startPractising.
  ///
  /// In en, this message translates to:
  /// **'Start practising'**
  String get startPractising;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get logIn;

  /// No description provided for @guestNameTitle.
  ///
  /// In en, this message translates to:
  /// **'What should we call you?'**
  String get guestNameTitle;

  /// No description provided for @guestNameHint.
  ///
  /// In en, this message translates to:
  /// **'Your name (optional)'**
  String get guestNameHint;

  /// No description provided for @guestNote.
  ///
  /// In en, this message translates to:
  /// **'No account needed. Your progress is saved on this device.'**
  String get guestNote;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Log in to keep your progress with you.'**
  String get loginSubtitle;

  /// No description provided for @signupTitle.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get signupTitle;

  /// No description provided for @signupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'It\'s free and takes a minute.'**
  String get signupSubtitle;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPasswordLabel;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as guest'**
  String get continueAsGuest;

  /// No description provided for @noAccountYet.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccountYet;

  /// No description provided for @haveAccountAlready.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get haveAccountAlready;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @errEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get errEmailRequired;

  /// No description provided for @errEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get errEmailInvalid;

  /// No description provided for @errPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get errPasswordRequired;

  /// No description provided for @errNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get errNameRequired;

  /// No description provided for @errPasswordShort.
  ///
  /// In en, this message translates to:
  /// **'Use at least 6 characters'**
  String get errPasswordShort;

  /// No description provided for @errPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get errPasswordMismatch;

  /// No description provided for @enterEmailFirst.
  ///
  /// In en, this message translates to:
  /// **'Enter your email above first, then tap again.'**
  String get enterEmailFirst;

  /// No description provided for @resetEmailSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent to {email}.'**
  String resetEmailSent(String email);

  /// No description provided for @authInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'That email address looks invalid.'**
  String get authInvalidEmail;

  /// No description provided for @authWrongCredentials.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password.'**
  String get authWrongCredentials;

  /// No description provided for @authDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled.'**
  String get authDisabled;

  /// No description provided for @authEmailInUse.
  ///
  /// In en, this message translates to:
  /// **'An account with this email already exists. Try logging in.'**
  String get authEmailInUse;

  /// No description provided for @authWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak. Use at least 6 characters.'**
  String get authWeakPassword;

  /// No description provided for @authDifferentMethod.
  ///
  /// In en, this message translates to:
  /// **'This email is registered with a different sign-in method.'**
  String get authDifferentMethod;

  /// No description provided for @authTooMany.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please wait a moment and try again.'**
  String get authTooMany;

  /// No description provided for @authNetwork.
  ///
  /// In en, this message translates to:
  /// **'Network error. Check your connection and try again.'**
  String get authNetwork;

  /// No description provided for @authNotEnabled.
  ///
  /// In en, this message translates to:
  /// **'This sign-in method is not enabled yet.'**
  String get authNotEnabled;

  /// No description provided for @authGoogleFailed.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in failed. Please try again.'**
  String get authGoogleFailed;

  /// No description provided for @authUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Sign-in isn\'t available here yet. Continue as a guest to start practising.'**
  String get authUnavailable;

  /// No description provided for @authGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get authGeneric;

  /// No description provided for @navPractice.
  ///
  /// In en, this message translates to:
  /// **'Practice'**
  String get navPractice;

  /// No description provided for @navProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get navProgress;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hi, {name}'**
  String homeGreeting(String name);

  /// No description provided for @homeGreetingGuest.
  ///
  /// In en, this message translates to:
  /// **'Hi there'**
  String get homeGreetingGuest;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ready to practise speaking?'**
  String get homeSubtitle;

  /// No description provided for @streakDays.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day} other{{count} days}}'**
  String streakDays(int count);

  /// No description provided for @todayChallenge.
  ///
  /// In en, this message translates to:
  /// **'Today\'s challenge'**
  String get todayChallenge;

  /// No description provided for @startNow.
  ///
  /// In en, this message translates to:
  /// **'Start now'**
  String get startNow;

  /// No description provided for @practiceRooms.
  ///
  /// In en, this message translates to:
  /// **'Practice rooms'**
  String get practiceRooms;

  /// No description provided for @thisWeek.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get thisWeek;

  /// No description provided for @practisedToday.
  ///
  /// In en, this message translates to:
  /// **'You\'ve practised today. Great job!'**
  String get practisedToday;

  /// No description provided for @keepStreak.
  ///
  /// In en, this message translates to:
  /// **'Practise today to keep your streak alive.'**
  String get keepStreak;

  /// No description provided for @roomInterview.
  ///
  /// In en, this message translates to:
  /// **'Interview Prep'**
  String get roomInterview;

  /// No description provided for @roomInterviewDesc.
  ///
  /// In en, this message translates to:
  /// **'Rehearse answers with a hiring manager.'**
  String get roomInterviewDesc;

  /// No description provided for @roomTravel.
  ///
  /// In en, this message translates to:
  /// **'Travel Talk'**
  String get roomTravel;

  /// No description provided for @roomTravelDesc.
  ///
  /// In en, this message translates to:
  /// **'Airports, hotels, restaurants and more.'**
  String get roomTravelDesc;

  /// No description provided for @roomDaily.
  ///
  /// In en, this message translates to:
  /// **'Everyday Life'**
  String get roomDaily;

  /// No description provided for @roomDailyDesc.
  ///
  /// In en, this message translates to:
  /// **'Small talk, phone calls and new friends.'**
  String get roomDailyDesc;

  /// No description provided for @roomPitch.
  ///
  /// In en, this message translates to:
  /// **'Pitch & Present'**
  String get roomPitch;

  /// No description provided for @roomPitchDesc.
  ///
  /// In en, this message translates to:
  /// **'Practise a clear 30-second pitch.'**
  String get roomPitchDesc;

  /// No description provided for @roomFree.
  ///
  /// In en, this message translates to:
  /// **'Free Talk'**
  String get roomFree;

  /// No description provided for @roomFreeDesc.
  ///
  /// In en, this message translates to:
  /// **'Chat about anything you like.'**
  String get roomFreeDesc;

  /// No description provided for @roomPicture.
  ///
  /// In en, this message translates to:
  /// **'Picture Talk'**
  String get roomPicture;

  /// No description provided for @roomPictureDesc.
  ///
  /// In en, this message translates to:
  /// **'Describe a photo out loud.'**
  String get roomPictureDesc;

  /// No description provided for @setupChooseSituation.
  ///
  /// In en, this message translates to:
  /// **'Choose a situation'**
  String get setupChooseSituation;

  /// No description provided for @setupRoleLabel.
  ///
  /// In en, this message translates to:
  /// **'The role you\'re interviewing for'**
  String get setupRoleLabel;

  /// No description provided for @setupRoleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Product Manager'**
  String get setupRoleHint;

  /// No description provided for @setupLevel.
  ///
  /// In en, this message translates to:
  /// **'Your level'**
  String get setupLevel;

  /// No description provided for @levelBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get levelBeginner;

  /// No description provided for @levelIntermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get levelIntermediate;

  /// No description provided for @levelAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get levelAdvanced;

  /// No description provided for @setupPracticeIn.
  ///
  /// In en, this message translates to:
  /// **'Practise in'**
  String get setupPracticeIn;

  /// No description provided for @setupStart.
  ///
  /// In en, this message translates to:
  /// **'Start session'**
  String get setupStart;

  /// No description provided for @setupAddPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add a photo to describe'**
  String get setupAddPhoto;

  /// No description provided for @setupTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get setupTakePhoto;

  /// No description provided for @setupFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get setupFromGallery;

  /// No description provided for @setupPhotoAdded.
  ///
  /// In en, this message translates to:
  /// **'Photo added'**
  String get setupPhotoAdded;

  /// No description provided for @setupNeedPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add a photo to start Picture Talk.'**
  String get setupNeedPhoto;

  /// No description provided for @scRolePm.
  ///
  /// In en, this message translates to:
  /// **'Product Manager'**
  String get scRolePm;

  /// No description provided for @scRoleSwe.
  ///
  /// In en, this message translates to:
  /// **'Software Engineer'**
  String get scRoleSwe;

  /// No description provided for @scRoleMarketing.
  ///
  /// In en, this message translates to:
  /// **'Marketing Executive'**
  String get scRoleMarketing;

  /// No description provided for @scRoleSupport.
  ///
  /// In en, this message translates to:
  /// **'Customer Support'**
  String get scRoleSupport;

  /// No description provided for @scRoleFresher.
  ///
  /// In en, this message translates to:
  /// **'First job (fresher)'**
  String get scRoleFresher;

  /// No description provided for @scTravelAirport.
  ///
  /// In en, this message translates to:
  /// **'Airport check-in'**
  String get scTravelAirport;

  /// No description provided for @scTravelHotel.
  ///
  /// In en, this message translates to:
  /// **'Hotel check-in'**
  String get scTravelHotel;

  /// No description provided for @scTravelRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Ordering food'**
  String get scTravelRestaurant;

  /// No description provided for @scTravelDirections.
  ///
  /// In en, this message translates to:
  /// **'Asking for directions'**
  String get scTravelDirections;

  /// No description provided for @scTravelMarket.
  ///
  /// In en, this message translates to:
  /// **'Shopping at a market'**
  String get scTravelMarket;

  /// No description provided for @scTravelPharmacy.
  ///
  /// In en, this message translates to:
  /// **'At the pharmacy'**
  String get scTravelPharmacy;

  /// No description provided for @scDailyIntro.
  ///
  /// In en, this message translates to:
  /// **'Introducing yourself'**
  String get scDailyIntro;

  /// No description provided for @scDailySmalltalk.
  ///
  /// In en, this message translates to:
  /// **'Small talk with a neighbour'**
  String get scDailySmalltalk;

  /// No description provided for @scDailyPhone.
  ///
  /// In en, this message translates to:
  /// **'Booking by phone'**
  String get scDailyPhone;

  /// No description provided for @scDailyFriend.
  ///
  /// In en, this message translates to:
  /// **'Making a new friend'**
  String get scDailyFriend;

  /// No description provided for @scDailyLandlord.
  ///
  /// In en, this message translates to:
  /// **'Talking to your landlord'**
  String get scDailyLandlord;

  /// No description provided for @scPitchIntro.
  ///
  /// In en, this message translates to:
  /// **'30-second self-introduction'**
  String get scPitchIntro;

  /// No description provided for @scPitchProduct.
  ///
  /// In en, this message translates to:
  /// **'Pitch a product or idea'**
  String get scPitchProduct;

  /// No description provided for @scPitchTalk.
  ///
  /// In en, this message translates to:
  /// **'A short talk on what you love'**
  String get scPitchTalk;

  /// No description provided for @scFreeDay.
  ///
  /// In en, this message translates to:
  /// **'My day'**
  String get scFreeDay;

  /// No description provided for @scFreeHobbies.
  ///
  /// In en, this message translates to:
  /// **'Hobbies and interests'**
  String get scFreeHobbies;

  /// No description provided for @scFreePlans.
  ///
  /// In en, this message translates to:
  /// **'Weekend and future plans'**
  String get scFreePlans;

  /// No description provided for @scFreeOpinions.
  ///
  /// In en, this message translates to:
  /// **'Sharing opinions'**
  String get scFreeOpinions;

  /// No description provided for @practiceHint.
  ///
  /// In en, this message translates to:
  /// **'Type or tap the mic…'**
  String get practiceHint;

  /// No description provided for @practiceListening.
  ///
  /// In en, this message translates to:
  /// **'Listening… speak now'**
  String get practiceListening;

  /// No description provided for @practiceSettingUp.
  ///
  /// In en, this message translates to:
  /// **'Setting up your room…'**
  String get practiceSettingUp;

  /// No description provided for @practiceFinish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get practiceFinish;

  /// No description provided for @finishTitle.
  ///
  /// In en, this message translates to:
  /// **'Finish this session?'**
  String get finishTitle;

  /// No description provided for @finishBody.
  ///
  /// In en, this message translates to:
  /// **'I\'ll review how you did.'**
  String get finishBody;

  /// No description provided for @finishNeedMessage.
  ///
  /// In en, this message translates to:
  /// **'Say or type at least one thing first.'**
  String get finishNeedMessage;

  /// No description provided for @leaveTitle.
  ///
  /// In en, this message translates to:
  /// **'Leave this session?'**
  String get leaveTitle;

  /// No description provided for @leaveBody.
  ///
  /// In en, this message translates to:
  /// **'Your conversation won\'t be saved.'**
  String get leaveBody;

  /// No description provided for @coachTranslate.
  ///
  /// In en, this message translates to:
  /// **'Translate'**
  String get coachTranslate;

  /// No description provided for @coachHideTranslation.
  ///
  /// In en, this message translates to:
  /// **'Hide translation'**
  String get coachHideTranslation;

  /// No description provided for @coachListen.
  ///
  /// In en, this message translates to:
  /// **'Listen'**
  String get coachListen;

  /// No description provided for @voiceOn.
  ///
  /// In en, this message translates to:
  /// **'Voice replies on'**
  String get voiceOn;

  /// No description provided for @voiceOff.
  ///
  /// In en, this message translates to:
  /// **'Voice replies off'**
  String get voiceOff;

  /// No description provided for @feedbackGreat.
  ///
  /// In en, this message translates to:
  /// **'Great sentence!'**
  String get feedbackGreat;

  /// No description provided for @feedbackSayIt.
  ///
  /// In en, this message translates to:
  /// **'Try saying it like this'**
  String get feedbackSayIt;

  /// No description provided for @feedbackWhy.
  ///
  /// In en, this message translates to:
  /// **'Why'**
  String get feedbackWhy;

  /// No description provided for @feedbackTip.
  ///
  /// In en, this message translates to:
  /// **'Tip'**
  String get feedbackTip;

  /// No description provided for @youCouldSay.
  ///
  /// In en, this message translates to:
  /// **'You could say'**
  String get youCouldSay;

  /// No description provided for @micUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Speech recognition isn\'t available here. You can type instead.'**
  String get micUnavailable;

  /// No description provided for @errNetwork.
  ///
  /// In en, this message translates to:
  /// **'Can\'t reach the coach. Check your connection.'**
  String get errNetwork;

  /// No description provided for @errBusy.
  ///
  /// In en, this message translates to:
  /// **'The coach is busy. Try again in a moment.'**
  String get errBusy;

  /// No description provided for @errTimeout.
  ///
  /// In en, this message translates to:
  /// **'That took too long. Please try again.'**
  String get errTimeout;

  /// No description provided for @errServer.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong on our side. Please try again.'**
  String get errServer;

  /// No description provided for @errTooLarge.
  ///
  /// In en, this message translates to:
  /// **'That photo is too large. Try a smaller one.'**
  String get errTooLarge;

  /// No description provided for @messageFailed.
  ///
  /// In en, this message translates to:
  /// **'Not sent. Tap to retry.'**
  String get messageFailed;

  /// No description provided for @summaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Session summary'**
  String get summaryTitle;

  /// No description provided for @summaryLoading.
  ///
  /// In en, this message translates to:
  /// **'Reviewing your session…'**
  String get summaryLoading;

  /// No description provided for @summaryFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load the review.'**
  String get summaryFailed;

  /// No description provided for @summaryYourScore.
  ///
  /// In en, this message translates to:
  /// **'Your score'**
  String get summaryYourScore;

  /// No description provided for @summaryStrengths.
  ///
  /// In en, this message translates to:
  /// **'What went well'**
  String get summaryStrengths;

  /// No description provided for @summaryImprove.
  ///
  /// In en, this message translates to:
  /// **'Work on next'**
  String get summaryImprove;

  /// No description provided for @summaryVocab.
  ///
  /// In en, this message translates to:
  /// **'Words to remember'**
  String get summaryVocab;

  /// No description provided for @summaryNextGoal.
  ///
  /// In en, this message translates to:
  /// **'Your next goal'**
  String get summaryNextGoal;

  /// No description provided for @summaryAgain.
  ///
  /// In en, this message translates to:
  /// **'Practise again'**
  String get summaryAgain;

  /// No description provided for @summaryBack.
  ///
  /// In en, this message translates to:
  /// **'Back to practice'**
  String get summaryBack;

  /// No description provided for @progressTitle.
  ///
  /// In en, this message translates to:
  /// **'Your progress'**
  String get progressTitle;

  /// No description provided for @statStreak.
  ///
  /// In en, this message translates to:
  /// **'Day streak'**
  String get statStreak;

  /// No description provided for @statBestStreak.
  ///
  /// In en, this message translates to:
  /// **'Best streak'**
  String get statBestStreak;

  /// No description provided for @statSessions.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get statSessions;

  /// No description provided for @statAverage.
  ///
  /// In en, this message translates to:
  /// **'Average score'**
  String get statAverage;

  /// No description provided for @statBest.
  ///
  /// In en, this message translates to:
  /// **'Best score'**
  String get statBest;

  /// No description provided for @statMessages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get statMessages;

  /// No description provided for @recentSessions.
  ///
  /// In en, this message translates to:
  /// **'Recent sessions'**
  String get recentSessions;

  /// No description provided for @noSessions.
  ///
  /// In en, this message translates to:
  /// **'No sessions yet. Start your first practice!'**
  String get noSessions;

  /// No description provided for @clearHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear history'**
  String get clearHistory;

  /// No description provided for @clearHistoryBody.
  ///
  /// In en, this message translates to:
  /// **'This removes your sessions and streak from this device.'**
  String get clearHistoryBody;

  /// No description provided for @messagesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 message} other{{count} messages}}'**
  String messagesCount(int count);

  /// No description provided for @profileGuest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get profileGuest;

  /// No description provided for @profileGuestCta.
  ///
  /// In en, this message translates to:
  /// **'Create a free account to keep your progress safe.'**
  String get profileGuestCta;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Send feedback'**
  String get feedback;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About BlueSpeak AI'**
  String get aboutApp;

  /// No description provided for @whatsNew.
  ///
  /// In en, this message translates to:
  /// **'What\'s new'**
  String get whatsNew;

  /// No description provided for @supportHelp.
  ///
  /// In en, this message translates to:
  /// **'Support and help'**
  String get supportHelp;

  /// No description provided for @supportContact.
  ///
  /// In en, this message translates to:
  /// **'Contact: {email}'**
  String supportContact(String email);

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @logoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logoutConfirm;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @sendResetEmail.
  ///
  /// In en, this message translates to:
  /// **'Send password reset email'**
  String get sendResetEmail;

  /// No description provided for @emailCannotChange.
  ///
  /// In en, this message translates to:
  /// **'Your sign-in email can\'t be changed'**
  String get emailCannotChange;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated'**
  String get profileUpdated;

  /// No description provided for @profileUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not update your name.'**
  String get profileUpdateFailed;

  /// No description provided for @prefsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get prefsAppearance;

  /// No description provided for @prefsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get prefsTheme;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @prefsAccent.
  ///
  /// In en, this message translates to:
  /// **'Accent colour'**
  String get prefsAccent;

  /// No description provided for @accentIndigo.
  ///
  /// In en, this message translates to:
  /// **'Indigo'**
  String get accentIndigo;

  /// No description provided for @accentOcean.
  ///
  /// In en, this message translates to:
  /// **'Ocean'**
  String get accentOcean;

  /// No description provided for @accentTeal.
  ///
  /// In en, this message translates to:
  /// **'Teal'**
  String get accentTeal;

  /// No description provided for @accentSunset.
  ///
  /// In en, this message translates to:
  /// **'Sunset'**
  String get accentSunset;

  /// No description provided for @accentRose.
  ///
  /// In en, this message translates to:
  /// **'Rose'**
  String get accentRose;

  /// No description provided for @prefsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get prefsLanguage;

  /// No description provided for @prefsAppLanguage.
  ///
  /// In en, this message translates to:
  /// **'App language'**
  String get prefsAppLanguage;

  /// No description provided for @prefsAppLanguageHelp.
  ///
  /// In en, this message translates to:
  /// **'Menus, corrections and tips are shown in this language.'**
  String get prefsAppLanguageHelp;

  /// No description provided for @prefsPracticeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Practice language'**
  String get prefsPracticeLanguage;

  /// No description provided for @prefsPracticeHelp.
  ///
  /// In en, this message translates to:
  /// **'The language you want to get better at speaking.'**
  String get prefsPracticeHelp;

  /// No description provided for @prefsDefaultLevel.
  ///
  /// In en, this message translates to:
  /// **'Default level'**
  String get prefsDefaultLevel;

  /// No description provided for @prefsVoice.
  ///
  /// In en, this message translates to:
  /// **'Voice'**
  String get prefsVoice;

  /// No description provided for @prefsAutoSpeak.
  ///
  /// In en, this message translates to:
  /// **'Read coach replies aloud'**
  String get prefsAutoSpeak;

  /// No description provided for @prefsAutoSpeakHelp.
  ///
  /// In en, this message translates to:
  /// **'The coach speaks each reply automatically.'**
  String get prefsAutoSpeakHelp;

  /// No description provided for @fbSentTitle.
  ///
  /// In en, this message translates to:
  /// **'Feedback sent!'**
  String get fbSentTitle;

  /// No description provided for @fbThanks.
  ///
  /// In en, this message translates to:
  /// **'Thank you for sending the feedback!'**
  String get fbThanks;

  /// No description provided for @fbThanksBody.
  ///
  /// In en, this message translates to:
  /// **'Your input helps us improve BlueSpeak AI.'**
  String get fbThanksBody;

  /// No description provided for @fbDescribe.
  ///
  /// In en, this message translates to:
  /// **'Describe your feedback'**
  String get fbDescribe;

  /// No description provided for @fbHint.
  ///
  /// In en, this message translates to:
  /// **'Tell us what prompted this feedback…'**
  String get fbHint;

  /// No description provided for @fbNoSensitive.
  ///
  /// In en, this message translates to:
  /// **'Please don\'t include any sensitive information'**
  String get fbNoSensitive;

  /// No description provided for @fbScreenshotHelp.
  ///
  /// In en, this message translates to:
  /// **'A screenshot helps us understand your feedback. (optional)'**
  String get fbScreenshotHelp;

  /// No description provided for @fbUpload.
  ///
  /// In en, this message translates to:
  /// **'Upload screenshot'**
  String get fbUpload;

  /// No description provided for @fbMaxTwo.
  ///
  /// In en, this message translates to:
  /// **'You can add up to 2 screenshots.'**
  String get fbMaxTwo;

  /// No description provided for @fbMayEmail.
  ///
  /// In en, this message translates to:
  /// **'We may email you for more information or updates'**
  String get fbMayEmail;

  /// No description provided for @fbEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter your feedback before sending.'**
  String get fbEmpty;

  /// No description provided for @fbSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get fbSend;

  /// No description provided for @fbOpening.
  ///
  /// In en, this message translates to:
  /// **'Opening your email app…'**
  String get fbOpening;

  /// No description provided for @fbCouldNotOpen.
  ///
  /// In en, this message translates to:
  /// **'Could not open an email app. Please email us at {email}.'**
  String fbCouldNotOpen(String email);

  /// No description provided for @fbPrivacyNote.
  ///
  /// In en, this message translates to:
  /// **'Some account and system information may be sent to BlueSpeak to fix problems and improve the app.'**
  String get fbPrivacyNote;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of service'**
  String get termsOfService;

  /// No description provided for @legalEnglishNote.
  ///
  /// In en, this message translates to:
  /// **'This document is available in English only.'**
  String get legalEnglishNote;

  /// No description provided for @aboutVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get aboutVersion;

  /// No description provided for @wn1.
  ///
  /// In en, this message translates to:
  /// **'Speaking coach: practise interviews, travel talk and everyday chats out loud.'**
  String get wn1;

  /// No description provided for @wn2.
  ///
  /// In en, this message translates to:
  /// **'Instant corrections, tips and a score after every message.'**
  String get wn2;

  /// No description provided for @wn3.
  ///
  /// In en, this message translates to:
  /// **'Daily streaks and a progress page to keep you motivated.'**
  String get wn3;

  /// No description provided for @wn4.
  ///
  /// In en, this message translates to:
  /// **'Light and dark themes, accent colours and 5 languages.'**
  String get wn4;

  /// No description provided for @wn5.
  ///
  /// In en, this message translates to:
  /// **'No API key needed: just open the app and start talking.'**
  String get wn5;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr', 'hi', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

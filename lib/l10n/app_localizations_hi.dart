// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appName => 'BlueSpeak AI';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get save => 'सहेजें';

  @override
  String get retry => 'फिर कोशिश करें';

  @override
  String get ok => 'ठीक है';

  @override
  String get done => 'हो गया';

  @override
  String get yes => 'हाँ';

  @override
  String get no => 'नहीं';

  @override
  String get delete => 'मिटाएँ';

  @override
  String get leave => 'छोड़ें';

  @override
  String get stay => 'रुकें';

  @override
  String get start => 'शुरू करें';

  @override
  String get or => 'या';

  @override
  String get onb1Title => 'आत्मविश्वास से बोलें';

  @override
  String get onb1Body =>
      'ऐसे AI कोच के साथ असली बातचीत का अभ्यास करें जो न कभी थकता है और न आपको आँकता है।';

  @override
  String get onb2Title => 'कोई असली स्थिति चुनें';

  @override
  String get onb2Body =>
      'जॉब इंटरव्यू, यात्रा, रोज़मर्रा की बातचीत और पिच। एक रूम चुनें और बोलना शुरू करें।';

  @override
  String get onb3Title => 'हर वाक्य के साथ बेहतर बनें';

  @override
  String get onb3Body =>
      'हर संदेश के बाद तुरंत सुधार, टिप्स और स्कोर पाएँ, और अपनी स्ट्रीक बढ़ते देखें।';

  @override
  String get startPractising => 'अभ्यास शुरू करें';

  @override
  String get createAccount => 'खाता बनाएँ';

  @override
  String get logIn => 'लॉग इन करें';

  @override
  String get guestNameTitle => 'हम आपको क्या कहकर बुलाएँ?';

  @override
  String get guestNameHint => 'आपका नाम (वैकल्पिक)';

  @override
  String get guestNote =>
      'खाता ज़रूरी नहीं। आपकी प्रगति इसी डिवाइस पर सहेजी जाती है।';

  @override
  String get loginTitle => 'वापसी पर स्वागत है';

  @override
  String get loginSubtitle => 'अपनी प्रगति अपने साथ रखने के लिए लॉग इन करें।';

  @override
  String get signupTitle => 'अपना खाता बनाएँ';

  @override
  String get signupSubtitle => 'यह मुफ़्त है और बस एक मिनट लगता है।';

  @override
  String get nameLabel => 'नाम';

  @override
  String get emailLabel => 'ईमेल';

  @override
  String get passwordLabel => 'पासवर्ड';

  @override
  String get confirmPasswordLabel => 'पासवर्ड की पुष्टि करें';

  @override
  String get forgotPassword => 'पासवर्ड भूल गए?';

  @override
  String get continueWithGoogle => 'Google के साथ जारी रखें';

  @override
  String get continueAsGuest => 'अतिथि के रूप में जारी रखें';

  @override
  String get noAccountYet => 'खाता नहीं है?';

  @override
  String get haveAccountAlready => 'पहले से खाता है?';

  @override
  String get signUp => 'साइन अप करें';

  @override
  String get errEmailRequired => 'ईमेल आवश्यक है';

  @override
  String get errEmailInvalid => 'मान्य ईमेल पता दर्ज करें';

  @override
  String get errPasswordRequired => 'पासवर्ड आवश्यक है';

  @override
  String get errNameRequired => 'नाम आवश्यक है';

  @override
  String get errPasswordShort => 'कम से कम 6 अक्षर रखें';

  @override
  String get errPasswordMismatch => 'पासवर्ड मेल नहीं खाते';

  @override
  String get enterEmailFirst =>
      'पहले ऊपर अपना ईमेल दर्ज करें, फिर दोबारा टैप करें।';

  @override
  String resetEmailSent(String email) {
    return '$email पर पासवर्ड रीसेट ईमेल भेज दिया गया है।';
  }

  @override
  String get authInvalidEmail => 'यह ईमेल पता मान्य नहीं लगता।';

  @override
  String get authWrongCredentials => 'ईमेल या पासवर्ड ग़लत है।';

  @override
  String get authDisabled => 'यह खाता अक्षम कर दिया गया है।';

  @override
  String get authEmailInUse =>
      'इस ईमेल से खाता पहले से मौजूद है। लॉग इन करके देखें।';

  @override
  String get authWeakPassword =>
      'पासवर्ड बहुत कमज़ोर है। कम से कम 6 अक्षर रखें।';

  @override
  String get authDifferentMethod =>
      'यह ईमेल किसी अलग साइन-इन तरीके से पंजीकृत है।';

  @override
  String get authTooMany =>
      'बहुत ज़्यादा प्रयास हुए। कृपया थोड़ी देर रुककर फिर कोशिश करें।';

  @override
  String get authNetwork =>
      'नेटवर्क त्रुटि। अपना कनेक्शन जाँचें और फिर कोशिश करें।';

  @override
  String get authNotEnabled => 'यह साइन-इन तरीका अभी चालू नहीं है।';

  @override
  String get authGoogleFailed =>
      'Google साइन-इन विफल रहा। कृपया फिर कोशिश करें।';

  @override
  String get authUnavailable =>
      'यहाँ साइन-इन अभी उपलब्ध नहीं है। अभ्यास शुरू करने के लिए अतिथि के रूप में जारी रखें।';

  @override
  String get authGeneric => 'कुछ गड़बड़ हो गई। कृपया फिर कोशिश करें।';

  @override
  String get navPractice => 'अभ्यास';

  @override
  String get navProgress => 'प्रगति';

  @override
  String get navProfile => 'प्रोफ़ाइल';

  @override
  String homeGreeting(String name) {
    return 'नमस्ते, $name';
  }

  @override
  String get homeGreetingGuest => 'नमस्ते';

  @override
  String get homeSubtitle => 'बोलने का अभ्यास करने के लिए तैयार?';

  @override
  String streakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count दिन',
      one: '1 दिन',
    );
    return '$_temp0';
  }

  @override
  String get todayChallenge => 'आज की चुनौती';

  @override
  String get startNow => 'अभी शुरू करें';

  @override
  String get practiceRooms => 'अभ्यास रूम';

  @override
  String get thisWeek => 'इस सप्ताह';

  @override
  String get practisedToday => 'आपने आज अभ्यास कर लिया। बहुत बढ़िया!';

  @override
  String get keepStreak => 'अपनी स्ट्रीक बनाए रखने के लिए आज अभ्यास करें।';

  @override
  String get roomInterview => 'इंटरव्यू तैयारी';

  @override
  String get roomInterviewDesc =>
      'हायरिंग मैनेजर के साथ जवाबों का रिहर्सल करें।';

  @override
  String get roomTravel => 'यात्रा बातचीत';

  @override
  String get roomTravelDesc => 'हवाई अड्डे, होटल, रेस्तरां और बहुत कुछ।';

  @override
  String get roomDaily => 'रोज़मर्रा की ज़िंदगी';

  @override
  String get roomDailyDesc => 'छोटी-मोटी बातचीत, फ़ोन कॉल और नए दोस्त।';

  @override
  String get roomPitch => 'पिच और प्रस्तुति';

  @override
  String get roomPitchDesc => '30 सेकंड की स्पष्ट पिच का अभ्यास करें।';

  @override
  String get roomFree => 'खुली बातचीत';

  @override
  String get roomFreeDesc => 'जिस भी विषय पर चाहें बात करें।';

  @override
  String get roomPicture => 'तस्वीर पर बातचीत';

  @override
  String get roomPictureDesc => 'किसी फ़ोटो का वर्णन ज़ोर से करें।';

  @override
  String get setupChooseSituation => 'कोई स्थिति चुनें';

  @override
  String get setupRoleLabel => 'जिस भूमिका के लिए इंटरव्यू दे रहे हैं';

  @override
  String get setupRoleHint => 'जैसे प्रोडक्ट मैनेजर';

  @override
  String get setupLevel => 'आपका स्तर';

  @override
  String get levelBeginner => 'शुरुआती';

  @override
  String get levelIntermediate => 'मध्यम';

  @override
  String get levelAdvanced => 'उन्नत';

  @override
  String get setupPracticeIn => 'अभ्यास की भाषा';

  @override
  String get setupStart => 'सत्र शुरू करें';

  @override
  String get setupAddPhoto => 'वर्णन के लिए फ़ोटो जोड़ें';

  @override
  String get setupTakePhoto => 'फ़ोटो लें';

  @override
  String get setupFromGallery => 'गैलरी से चुनें';

  @override
  String get setupPhotoAdded => 'फ़ोटो जोड़ी गई';

  @override
  String get setupNeedPhoto =>
      'तस्वीर पर बातचीत शुरू करने के लिए फ़ोटो जोड़ें।';

  @override
  String get scRolePm => 'प्रोडक्ट मैनेजर';

  @override
  String get scRoleSwe => 'सॉफ़्टवेयर इंजीनियर';

  @override
  String get scRoleMarketing => 'मार्केटिंग एक्ज़िक्यूटिव';

  @override
  String get scRoleSupport => 'कस्टमर सपोर्ट';

  @override
  String get scRoleFresher => 'पहली नौकरी (फ्रेशर)';

  @override
  String get scTravelAirport => 'एयरपोर्ट चेक-इन';

  @override
  String get scTravelHotel => 'होटल चेक-इन';

  @override
  String get scTravelRestaurant => 'खाना ऑर्डर करना';

  @override
  String get scTravelDirections => 'रास्ता पूछना';

  @override
  String get scTravelMarket => 'बाज़ार में खरीदारी';

  @override
  String get scTravelPharmacy => 'फ़ार्मेसी में';

  @override
  String get scDailyIntro => 'अपना परिचय देना';

  @override
  String get scDailySmalltalk => 'पड़ोसी से हल्की बातचीत';

  @override
  String get scDailyPhone => 'फ़ोन पर बुकिंग';

  @override
  String get scDailyFriend => 'नया दोस्त बनाना';

  @override
  String get scDailyLandlord => 'मकान मालिक से बात';

  @override
  String get scPitchIntro => '30 सेकंड का परिचय';

  @override
  String get scPitchProduct => 'किसी प्रोडक्ट या आइडिया की पिच';

  @override
  String get scPitchTalk => 'अपनी पसंद पर छोटा भाषण';

  @override
  String get scFreeDay => 'मेरा दिन';

  @override
  String get scFreeHobbies => 'शौक और रुचियाँ';

  @override
  String get scFreePlans => 'वीकेंड और भविष्य की योजनाएँ';

  @override
  String get scFreeOpinions => 'अपनी राय रखना';

  @override
  String get practiceHint => 'टाइप करें या माइक दबाएँ…';

  @override
  String get practiceListening => 'सुन रहा हूँ… अब बोलें';

  @override
  String get practiceSettingUp => 'आपका रूम तैयार हो रहा है…';

  @override
  String get practiceFinish => 'समाप्त करें';

  @override
  String get finishTitle => 'इस सत्र को समाप्त करें?';

  @override
  String get finishBody => 'मैं देखूँगा कि आपने कैसा किया।';

  @override
  String get finishNeedMessage => 'पहले कम से कम एक बात बोलें या लिखें।';

  @override
  String get leaveTitle => 'इस सत्र को छोड़ें?';

  @override
  String get leaveBody => 'आपकी बातचीत सहेजी नहीं जाएगी।';

  @override
  String get coachTranslate => 'अनुवाद';

  @override
  String get coachHideTranslation => 'अनुवाद छिपाएँ';

  @override
  String get coachListen => 'सुनें';

  @override
  String get voiceOn => 'आवाज़ वाले जवाब चालू';

  @override
  String get voiceOff => 'आवाज़ वाले जवाब बंद';

  @override
  String get feedbackGreat => 'बहुत बढ़िया वाक्य!';

  @override
  String get feedbackSayIt => 'इसे ऐसे कहकर देखें';

  @override
  String get feedbackWhy => 'क्यों';

  @override
  String get feedbackTip => 'टिप';

  @override
  String get youCouldSay => 'आप यह कह सकते हैं';

  @override
  String get micUnavailable =>
      'यहाँ वॉइस रिकग्निशन उपलब्ध नहीं है। आप टाइप कर सकते हैं।';

  @override
  String get errNetwork => 'कोच से संपर्क नहीं हो पा रहा। अपना कनेक्शन जाँचें।';

  @override
  String get errBusy => 'कोच अभी व्यस्त है। थोड़ी देर में फिर कोशिश करें।';

  @override
  String get errTimeout => 'इसमें बहुत समय लग गया। कृपया फिर कोशिश करें।';

  @override
  String get errServer =>
      'हमारी तरफ़ से कुछ गड़बड़ हो गई। कृपया फिर कोशिश करें।';

  @override
  String get errTooLarge => 'यह फ़ोटो बहुत बड़ी है। छोटी फ़ोटो आज़माएँ।';

  @override
  String get messageFailed => 'भेजा नहीं गया। फिर कोशिश करने के लिए टैप करें।';

  @override
  String get summaryTitle => 'सत्र का सारांश';

  @override
  String get summaryLoading => 'आपके सत्र की समीक्षा हो रही है…';

  @override
  String get summaryFailed => 'समीक्षा लोड नहीं हो सकी।';

  @override
  String get summaryYourScore => 'आपका स्कोर';

  @override
  String get summaryStrengths => 'क्या अच्छा रहा';

  @override
  String get summaryImprove => 'आगे किस पर काम करें';

  @override
  String get summaryVocab => 'याद रखने लायक शब्द';

  @override
  String get summaryNextGoal => 'आपका अगला लक्ष्य';

  @override
  String get summaryAgain => 'फिर अभ्यास करें';

  @override
  String get summaryBack => 'अभ्यास पर वापस';

  @override
  String get progressTitle => 'आपकी प्रगति';

  @override
  String get statStreak => 'दिनों की स्ट्रीक';

  @override
  String get statBestStreak => 'सबसे लंबी स्ट्रीक';

  @override
  String get statSessions => 'सत्र';

  @override
  String get statAverage => 'औसत स्कोर';

  @override
  String get statBest => 'सर्वश्रेष्ठ स्कोर';

  @override
  String get statMessages => 'संदेश';

  @override
  String get recentSessions => 'हाल के सत्र';

  @override
  String get noSessions => 'अभी कोई सत्र नहीं। अपना पहला अभ्यास शुरू करें!';

  @override
  String get clearHistory => 'इतिहास मिटाएँ';

  @override
  String get clearHistoryBody =>
      'इससे इस डिवाइस से आपके सत्र और स्ट्रीक हट जाएँगे।';

  @override
  String messagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count संदेश',
      one: '1 संदेश',
    );
    return '$_temp0';
  }

  @override
  String get profileGuest => 'अतिथि';

  @override
  String get profileGuestCta =>
      'अपनी प्रगति सुरक्षित रखने के लिए मुफ़्त खाता बनाएँ।';

  @override
  String get editProfile => 'प्रोफ़ाइल संपादित करें';

  @override
  String get preferences => 'प्राथमिकताएँ';

  @override
  String get feedback => 'फ़ीडबैक भेजें';

  @override
  String get aboutApp => 'BlueSpeak AI के बारे में';

  @override
  String get whatsNew => 'नया क्या है';

  @override
  String get supportHelp => 'सहायता';

  @override
  String supportContact(String email) {
    return 'संपर्क: $email';
  }

  @override
  String get logout => 'लॉग आउट';

  @override
  String get logoutConfirm => 'क्या आप वाकई लॉग आउट करना चाहते हैं?';

  @override
  String get saveChanges => 'बदलाव सहेजें';

  @override
  String get sendResetEmail => 'पासवर्ड रीसेट ईमेल भेजें';

  @override
  String get emailCannotChange => 'आपका साइन-इन ईमेल बदला नहीं जा सकता';

  @override
  String get profileUpdated => 'प्रोफ़ाइल अपडेट हो गई';

  @override
  String get profileUpdateFailed => 'आपका नाम अपडेट नहीं हो सका।';

  @override
  String get prefsAppearance => 'दिखावट';

  @override
  String get prefsTheme => 'थीम';

  @override
  String get themeSystem => 'सिस्टम';

  @override
  String get themeLight => 'लाइट';

  @override
  String get themeDark => 'डार्क';

  @override
  String get prefsAccent => 'एक्सेंट रंग';

  @override
  String get accentIndigo => 'इंडिगो';

  @override
  String get accentOcean => 'ओशन';

  @override
  String get accentTeal => 'टील';

  @override
  String get accentSunset => 'सनसेट';

  @override
  String get accentRose => 'रोज़';

  @override
  String get prefsLanguage => 'भाषा';

  @override
  String get prefsAppLanguage => 'ऐप की भाषा';

  @override
  String get prefsAppLanguageHelp =>
      'मेनू, सुधार और टिप्स इसी भाषा में दिखाए जाएँगे।';

  @override
  String get prefsPracticeLanguage => 'अभ्यास की भाषा';

  @override
  String get prefsPracticeHelp =>
      'वह भाषा जिसे बोलने में आप बेहतर होना चाहते हैं।';

  @override
  String get prefsDefaultLevel => 'डिफ़ॉल्ट स्तर';

  @override
  String get prefsVoice => 'आवाज़';

  @override
  String get prefsAutoSpeak => 'कोच के जवाब ज़ोर से पढ़ें';

  @override
  String get prefsAutoSpeakHelp => 'कोच हर जवाब अपने आप बोलेगा।';

  @override
  String get fbSentTitle => 'फ़ीडबैक भेज दिया गया!';

  @override
  String get fbThanks => 'फ़ीडबैक भेजने के लिए धन्यवाद!';

  @override
  String get fbThanksBody =>
      'आपकी राय BlueSpeak AI को बेहतर बनाने में मदद करती है।';

  @override
  String get fbDescribe => 'अपना फ़ीडबैक लिखें';

  @override
  String get fbHint => 'बताएँ कि यह फ़ीडबैक क्यों दे रहे हैं…';

  @override
  String get fbNoSensitive => 'कृपया कोई संवेदनशील जानकारी न लिखें';

  @override
  String get fbScreenshotHelp =>
      'स्क्रीनशॉट से हमें आपकी बात समझने में मदद मिलती है। (वैकल्पिक)';

  @override
  String get fbUpload => 'स्क्रीनशॉट अपलोड करें';

  @override
  String get fbMaxTwo => 'आप अधिकतम 2 स्क्रीनशॉट जोड़ सकते हैं।';

  @override
  String get fbMayEmail =>
      'हम अधिक जानकारी या अपडेट के लिए आपको ईमेल कर सकते हैं';

  @override
  String get fbEmpty => 'भेजने से पहले अपना फ़ीडबैक लिखें।';

  @override
  String get fbSend => 'भेजें';

  @override
  String get fbOpening => 'आपका ईमेल ऐप खुल रहा है…';

  @override
  String fbCouldNotOpen(String email) {
    return 'ईमेल ऐप नहीं खुल सका। कृपया हमें $email पर ईमेल करें।';
  }

  @override
  String get fbPrivacyNote =>
      'समस्याएँ ठीक करने और ऐप बेहतर बनाने के लिए कुछ खाता और सिस्टम जानकारी BlueSpeak को भेजी जा सकती है।';

  @override
  String get privacyPolicy => 'गोपनीयता नीति';

  @override
  String get termsOfService => 'सेवा की शर्तें';

  @override
  String get legalEnglishNote => 'यह दस्तावेज़ केवल अंग्रेज़ी में उपलब्ध है।';

  @override
  String get aboutVersion => 'संस्करण';

  @override
  String get wn1 =>
      'स्पीकिंग कोच: इंटरव्यू, यात्रा और रोज़मर्रा की बातचीत ज़ोर से बोलकर अभ्यास करें।';

  @override
  String get wn2 => 'हर संदेश के बाद तुरंत सुधार, टिप्स और स्कोर।';

  @override
  String get wn3 => 'प्रेरित रहने के लिए रोज़ की स्ट्रीक और प्रगति पेज।';

  @override
  String get wn4 => 'लाइट और डार्क थीम, एक्सेंट रंग और 5 भाषाएँ।';

  @override
  String get wn5 =>
      'किसी API कुंजी की ज़रूरत नहीं: बस ऐप खोलें और बोलना शुरू करें।';
}

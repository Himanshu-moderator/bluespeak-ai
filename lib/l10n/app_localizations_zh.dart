// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => 'BlueSpeak AI';

  @override
  String get cancel => '取消';

  @override
  String get save => '保存';

  @override
  String get retry => '重试';

  @override
  String get ok => '好的';

  @override
  String get done => '完成';

  @override
  String get yes => '是';

  @override
  String get no => '否';

  @override
  String get delete => '删除';

  @override
  String get leave => '离开';

  @override
  String get stay => '留下';

  @override
  String get start => '开始';

  @override
  String get or => '或';

  @override
  String get onb1Title => '自信开口说';

  @override
  String get onb1Body => '与从不疲倦、从不评判你的 AI 教练一起，大声练习真实对话。';

  @override
  String get onb2Title => '选择真实场景';

  @override
  String get onb2Body => '求职面试、旅行、日常聊天和演讲。选一个房间，开始说吧。';

  @override
  String get onb3Title => '每一句都在进步';

  @override
  String get onb3Body => '每条消息后即时获得纠正、提示和评分，看着你的连续练习天数不断增长。';

  @override
  String get startPractising => '开始练习';

  @override
  String get createAccount => '创建账户';

  @override
  String get logIn => '登录';

  @override
  String get guestNameTitle => '我们该怎么称呼你？';

  @override
  String get guestNameHint => '你的名字（可选）';

  @override
  String get guestNote => '无需账户。你的进度保存在此设备上。';

  @override
  String get loginTitle => '欢迎回来';

  @override
  String get loginSubtitle => '登录后即可随身保存你的进度。';

  @override
  String get signupTitle => '创建你的账户';

  @override
  String get signupSubtitle => '免费，只需一分钟。';

  @override
  String get nameLabel => '姓名';

  @override
  String get emailLabel => '邮箱';

  @override
  String get passwordLabel => '密码';

  @override
  String get confirmPasswordLabel => '确认密码';

  @override
  String get forgotPassword => '忘记密码？';

  @override
  String get continueWithGoogle => '使用 Google 继续';

  @override
  String get continueAsGuest => '以访客身份继续';

  @override
  String get noAccountYet => '还没有账户？';

  @override
  String get haveAccountAlready => '已有账户？';

  @override
  String get signUp => '注册';

  @override
  String get errEmailRequired => '请输入邮箱';

  @override
  String get errEmailInvalid => '请输入有效的邮箱地址';

  @override
  String get errPasswordRequired => '请输入密码';

  @override
  String get errNameRequired => '请输入姓名';

  @override
  String get errPasswordShort => '密码至少需要 6 位';

  @override
  String get errPasswordMismatch => '两次输入的密码不一致';

  @override
  String get enterEmailFirst => '请先在上方输入邮箱，然后再点一次。';

  @override
  String resetEmailSent(String email) {
    return '重置密码的邮件已发送至 $email。';
  }

  @override
  String get authInvalidEmail => '这个邮箱地址似乎无效。';

  @override
  String get authWrongCredentials => '邮箱或密码不正确。';

  @override
  String get authDisabled => '此账户已被停用。';

  @override
  String get authEmailInUse => '该邮箱已注册，请尝试登录。';

  @override
  String get authWeakPassword => '密码太弱，请至少使用 6 位。';

  @override
  String get authDifferentMethod => '此邮箱已通过其他登录方式注册。';

  @override
  String get authTooMany => '尝试次数过多，请稍后再试。';

  @override
  String get authNetwork => '网络错误，请检查连接后重试。';

  @override
  String get authNotEnabled => '此登录方式尚未启用。';

  @override
  String get authGoogleFailed => 'Google 登录失败，请重试。';

  @override
  String get authUnavailable => '此处暂不支持登录。请以访客身份继续开始练习。';

  @override
  String get authGeneric => '出了点问题，请重试。';

  @override
  String get navPractice => '练习';

  @override
  String get navProgress => '进度';

  @override
  String get navProfile => '我的';

  @override
  String homeGreeting(String name) {
    return '你好，$name';
  }

  @override
  String get homeGreetingGuest => '你好';

  @override
  String get homeSubtitle => '准备好练习口语了吗？';

  @override
  String streakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 天',
    );
    return '$_temp0';
  }

  @override
  String get todayChallenge => '今日挑战';

  @override
  String get startNow => '立即开始';

  @override
  String get practiceRooms => '练习房间';

  @override
  String get thisWeek => '本周';

  @override
  String get practisedToday => '今天已经练习过了，太棒了！';

  @override
  String get keepStreak => '今天练习一下，保持连续天数。';

  @override
  String get roomInterview => '面试准备';

  @override
  String get roomInterviewDesc => '与招聘经理一起演练回答。';

  @override
  String get roomTravel => '旅行对话';

  @override
  String get roomTravelDesc => '机场、酒店、餐厅等场景。';

  @override
  String get roomDaily => '日常生活';

  @override
  String get roomDailyDesc => '闲聊、打电话和结交新朋友。';

  @override
  String get roomPitch => '演讲与路演';

  @override
  String get roomPitchDesc => '练习清晰的 30 秒演讲。';

  @override
  String get roomFree => '自由交谈';

  @override
  String get roomFreeDesc => '想聊什么就聊什么。';

  @override
  String get roomPicture => '看图说话';

  @override
  String get roomPictureDesc => '大声描述一张照片。';

  @override
  String get setupChooseSituation => '选择场景';

  @override
  String get setupRoleLabel => '你应聘的职位';

  @override
  String get setupRoleHint => '例如：产品经理';

  @override
  String get setupLevel => '你的水平';

  @override
  String get levelBeginner => '初级';

  @override
  String get levelIntermediate => '中级';

  @override
  String get levelAdvanced => '高级';

  @override
  String get setupPracticeIn => '练习语言';

  @override
  String get setupStart => '开始练习';

  @override
  String get setupAddPhoto => '添加一张要描述的照片';

  @override
  String get setupTakePhoto => '拍照';

  @override
  String get setupFromGallery => '从相册选择';

  @override
  String get setupPhotoAdded => '已添加照片';

  @override
  String get setupNeedPhoto => '请先添加照片再开始。';

  @override
  String get scRolePm => '产品经理';

  @override
  String get scRoleSwe => '软件工程师';

  @override
  String get scRoleMarketing => '市场专员';

  @override
  String get scRoleSupport => '客户支持';

  @override
  String get scRoleFresher => '第一份工作';

  @override
  String get scTravelAirport => '机场值机';

  @override
  String get scTravelHotel => '酒店入住';

  @override
  String get scTravelRestaurant => '餐厅点餐';

  @override
  String get scTravelDirections => '问路';

  @override
  String get scTravelMarket => '逛市场购物';

  @override
  String get scTravelPharmacy => '在药店';

  @override
  String get scDailyIntro => '自我介绍';

  @override
  String get scDailySmalltalk => '和邻居闲聊';

  @override
  String get scDailyPhone => '电话预约';

  @override
  String get scDailyFriend => '结交新朋友';

  @override
  String get scDailyLandlord => '和房东沟通';

  @override
  String get scPitchIntro => '30 秒自我介绍';

  @override
  String get scPitchProduct => '推介产品或创意';

  @override
  String get scPitchTalk => '谈谈你热爱的事';

  @override
  String get scFreeDay => '我的一天';

  @override
  String get scFreeHobbies => '爱好与兴趣';

  @override
  String get scFreePlans => '周末与未来计划';

  @override
  String get scFreeOpinions => '分享观点';

  @override
  String get practiceHint => '输入或点按麦克风…';

  @override
  String get practiceListening => '正在聆听…请说话';

  @override
  String get practiceSettingUp => '正在准备你的房间…';

  @override
  String get practiceFinish => '结束';

  @override
  String get finishTitle => '结束本次练习？';

  @override
  String get finishBody => '我会回顾你的表现。';

  @override
  String get finishNeedMessage => '请先说或输入至少一句话。';

  @override
  String get leaveTitle => '离开本次练习？';

  @override
  String get leaveBody => '你的对话不会被保存。';

  @override
  String get coachTranslate => '翻译';

  @override
  String get coachHideTranslation => '隐藏翻译';

  @override
  String get coachListen => '朗读';

  @override
  String get voiceOn => '语音回复已开启';

  @override
  String get voiceOff => '语音回复已关闭';

  @override
  String get feedbackGreat => '这句说得很棒！';

  @override
  String get feedbackSayIt => '试试这样说';

  @override
  String get feedbackWhy => '原因';

  @override
  String get feedbackTip => '小提示';

  @override
  String get youCouldSay => '你可以这样说';

  @override
  String get micUnavailable => '此处无法使用语音识别，请改用键盘输入。';

  @override
  String get errNetwork => '无法连接到教练，请检查网络。';

  @override
  String get errBusy => '教练正忙，请稍后再试。';

  @override
  String get errTimeout => '耗时过长，请重试。';

  @override
  String get errServer => '我们这边出了点问题，请重试。';

  @override
  String get errTooLarge => '照片太大了，请换一张小一点的。';

  @override
  String get messageFailed => '未发送，点按重试。';

  @override
  String get summaryTitle => '练习总结';

  @override
  String get summaryLoading => '正在回顾你的练习…';

  @override
  String get summaryFailed => '无法加载总结。';

  @override
  String get summaryYourScore => '你的得分';

  @override
  String get summaryStrengths => '做得好的地方';

  @override
  String get summaryImprove => '接下来要改进';

  @override
  String get summaryVocab => '值得记住的词';

  @override
  String get summaryNextGoal => '你的下一个目标';

  @override
  String get summaryAgain => '再练一次';

  @override
  String get summaryBack => '返回练习';

  @override
  String get progressTitle => '你的进度';

  @override
  String get statStreak => '连续天数';

  @override
  String get statBestStreak => '最长连续';

  @override
  String get statSessions => '练习次数';

  @override
  String get statAverage => '平均得分';

  @override
  String get statBest => '最高得分';

  @override
  String get statMessages => '发言数';

  @override
  String get recentSessions => '最近的练习';

  @override
  String get noSessions => '还没有练习记录，开始你的第一次练习吧！';

  @override
  String get clearHistory => '清除记录';

  @override
  String get clearHistoryBody => '这将从此设备删除你的练习记录和连续天数。';

  @override
  String messagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 条发言',
    );
    return '$_temp0';
  }

  @override
  String get profileGuest => '访客';

  @override
  String get profileGuestCta => '创建免费账户，保护你的进度。';

  @override
  String get editProfile => '编辑资料';

  @override
  String get preferences => '偏好设置';

  @override
  String get feedback => '发送反馈';

  @override
  String get aboutApp => '关于 BlueSpeak AI';

  @override
  String get whatsNew => '新功能';

  @override
  String get supportHelp => '支持与帮助';

  @override
  String supportContact(String email) {
    return '联系邮箱：$email';
  }

  @override
  String get logout => '退出登录';

  @override
  String get logoutConfirm => '确定要退出登录吗？';

  @override
  String get saveChanges => '保存更改';

  @override
  String get sendResetEmail => '发送重置密码邮件';

  @override
  String get emailCannotChange => '登录邮箱无法修改';

  @override
  String get profileUpdated => '资料已更新';

  @override
  String get profileUpdateFailed => '无法更新你的名字。';

  @override
  String get prefsAppearance => '外观';

  @override
  String get prefsTheme => '主题';

  @override
  String get themeSystem => '跟随系统';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get prefsAccent => '主题色';

  @override
  String get accentIndigo => '靛蓝';

  @override
  String get accentOcean => '海洋蓝';

  @override
  String get accentTeal => '青绿';

  @override
  String get accentSunset => '日落橙';

  @override
  String get accentRose => '玫红';

  @override
  String get prefsLanguage => '语言';

  @override
  String get prefsAppLanguage => '应用语言';

  @override
  String get prefsAppLanguageHelp => '菜单、纠正和提示将以此语言显示。';

  @override
  String get prefsPracticeLanguage => '练习语言';

  @override
  String get prefsPracticeHelp => '你想提高口语的语言。';

  @override
  String get prefsDefaultLevel => '默认水平';

  @override
  String get prefsVoice => '语音';

  @override
  String get prefsAutoSpeak => '朗读教练的回复';

  @override
  String get prefsAutoSpeakHelp => '教练会自动朗读每条回复。';

  @override
  String get fbSentTitle => '反馈已发送！';

  @override
  String get fbThanks => '感谢你的反馈！';

  @override
  String get fbThanksBody => '你的意见将帮助我们改进 BlueSpeak AI。';

  @override
  String get fbDescribe => '请描述你的反馈';

  @override
  String get fbHint => '告诉我们你为什么要反馈…';

  @override
  String get fbNoSensitive => '请勿包含任何敏感信息';

  @override
  String get fbScreenshotHelp => '截图有助于我们理解你的反馈（可选）。';

  @override
  String get fbUpload => '上传截图';

  @override
  String get fbMaxTwo => '最多可添加 2 张截图。';

  @override
  String get fbMayEmail => '我们可能会就更多信息或更新通过邮件联系你';

  @override
  String get fbEmpty => '发送前请先填写反馈。';

  @override
  String get fbSend => '发送';

  @override
  String get fbOpening => '正在打开邮件应用…';

  @override
  String fbCouldNotOpen(String email) {
    return '无法打开邮件应用，请发送邮件至 $email。';
  }

  @override
  String get fbPrivacyNote => '部分账户和系统信息可能会发送给 BlueSpeak，用于修复问题和改进应用。';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get termsOfService => '服务条款';

  @override
  String get legalEnglishNote => '本文档仅提供英文版本。';

  @override
  String get aboutVersion => '版本';

  @override
  String get wn1 => '口语教练：大声练习面试、旅行和日常对话。';

  @override
  String get wn2 => '每条消息后即时获得纠正、提示和评分。';

  @override
  String get wn3 => '每日连续练习和进度页面，让你保持动力。';

  @override
  String get wn4 => '浅色和深色主题、主题色和 5 种语言。';

  @override
  String get wn5 => '无需 API 密钥：打开应用就能开口练习。';
}

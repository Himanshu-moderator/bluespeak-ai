import 'package:flutter/material.dart';

import '../coach/coach_models.dart';
import '../services/auth_service.dart';
import 'app_localizations.dart';

export 'app_localizations.dart';

extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

String roomName(AppLocalizations l, CoachRoom room) => switch (room) {
  CoachRoom.interview => l.roomInterview,
  CoachRoom.travel => l.roomTravel,
  CoachRoom.daily => l.roomDaily,
  CoachRoom.pitch => l.roomPitch,
  CoachRoom.free => l.roomFree,
  CoachRoom.picture => l.roomPicture,
};

String roomDescription(AppLocalizations l, CoachRoom room) => switch (room) {
  CoachRoom.interview => l.roomInterviewDesc,
  CoachRoom.travel => l.roomTravelDesc,
  CoachRoom.daily => l.roomDailyDesc,
  CoachRoom.pitch => l.roomPitchDesc,
  CoachRoom.free => l.roomFreeDesc,
  CoachRoom.picture => l.roomPictureDesc,
};

String scenarioLabel(AppLocalizations l, String id) => switch (id) {
  'role_pm' => l.scRolePm,
  'role_swe' => l.scRoleSwe,
  'role_marketing' => l.scRoleMarketing,
  'role_support' => l.scRoleSupport,
  'role_fresher' => l.scRoleFresher,
  'travel_airport' => l.scTravelAirport,
  'travel_hotel' => l.scTravelHotel,
  'travel_restaurant' => l.scTravelRestaurant,
  'travel_directions' => l.scTravelDirections,
  'travel_market' => l.scTravelMarket,
  'travel_pharmacy' => l.scTravelPharmacy,
  'daily_intro' => l.scDailyIntro,
  'daily_smalltalk' => l.scDailySmalltalk,
  'daily_phone' => l.scDailyPhone,
  'daily_friend' => l.scDailyFriend,
  'daily_landlord' => l.scDailyLandlord,
  'pitch_intro' => l.scPitchIntro,
  'pitch_product' => l.scPitchProduct,
  'pitch_talk' => l.scPitchTalk,
  'free_day' => l.scFreeDay,
  'free_hobbies' => l.scFreeHobbies,
  'free_plans' => l.scFreePlans,
  'free_opinions' => l.scFreeOpinions,
  _ => id,
};

String levelLabel(AppLocalizations l, String level) => switch (level) {
  'beginner' => l.levelBeginner,
  'advanced' => l.levelAdvanced,
  _ => l.levelIntermediate,
};

String accentLabel(AppLocalizations l, String id) => switch (id) {
  'ocean' => l.accentOcean,
  'teal' => l.accentTeal,
  'sunset' => l.accentSunset,
  'rose' => l.accentRose,
  _ => l.accentIndigo,
};

String coachErrorText(AppLocalizations l, CoachErrorKind kind) => switch (kind) {
  CoachErrorKind.network => l.errNetwork,
  CoachErrorKind.busy => l.errBusy,
  CoachErrorKind.timeout => l.errTimeout,
  CoachErrorKind.tooLarge => l.errTooLarge,
  CoachErrorKind.server => l.errServer,
};

String authErrorText(AppLocalizations l, AuthException e) => switch (e.code) {
  'invalidEmail' => l.authInvalidEmail,
  'wrongCredentials' => l.authWrongCredentials,
  'disabled' => l.authDisabled,
  'emailInUse' => l.authEmailInUse,
  'weakPassword' => l.authWeakPassword,
  'differentMethod' => l.authDifferentMethod,
  'tooMany' => l.authTooMany,
  'network' => l.authNetwork,
  'notEnabled' => l.authNotEnabled,
  'googleFailed' => l.authGoogleFailed,
  'unavailable' => l.authUnavailable,
  _ => l.authGeneric,
};

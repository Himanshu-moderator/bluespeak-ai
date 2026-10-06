// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'BlueSpeak AI';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get retry => 'Reintentar';

  @override
  String get ok => 'Aceptar';

  @override
  String get done => 'Listo';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get delete => 'Eliminar';

  @override
  String get leave => 'Salir';

  @override
  String get stay => 'Quedarme';

  @override
  String get start => 'Empezar';

  @override
  String get or => 'o';

  @override
  String get onb1Title => 'Habla con confianza';

  @override
  String get onb1Body =>
      'Practica conversaciones reales en voz alta con un coach de IA que nunca se cansa ni te juzga.';

  @override
  String get onb2Title => 'Elige una situación real';

  @override
  String get onb2Body =>
      'Entrevistas de trabajo, viajes, charlas cotidianas y presentaciones. Elige una sala y empieza a hablar.';

  @override
  String get onb3Title => 'Mejora con cada frase';

  @override
  String get onb3Body =>
      'Recibe correcciones, consejos y una puntuación al instante tras cada mensaje y mira crecer tu racha.';

  @override
  String get startPractising => 'Empezar a practicar';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get logIn => 'Iniciar sesión';

  @override
  String get guestNameTitle => '¿Cómo quieres que te llamemos?';

  @override
  String get guestNameHint => 'Tu nombre (opcional)';

  @override
  String get guestNote =>
      'No necesitas cuenta. Tu progreso se guarda en este dispositivo.';

  @override
  String get loginTitle => 'Te damos la bienvenida';

  @override
  String get loginSubtitle => 'Inicia sesión para llevar tu progreso contigo.';

  @override
  String get signupTitle => 'Crea tu cuenta';

  @override
  String get signupSubtitle => 'Es gratis y solo toma un minuto.';

  @override
  String get nameLabel => 'Nombre';

  @override
  String get emailLabel => 'Correo electrónico';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get confirmPasswordLabel => 'Confirmar contraseña';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get continueWithGoogle => 'Continuar con Google';

  @override
  String get continueAsGuest => 'Continuar como invitado';

  @override
  String get noAccountYet => '¿No tienes cuenta?';

  @override
  String get haveAccountAlready => '¿Ya tienes cuenta?';

  @override
  String get signUp => 'Registrarse';

  @override
  String get errEmailRequired => 'El correo es obligatorio';

  @override
  String get errEmailInvalid => 'Introduce un correo válido';

  @override
  String get errPasswordRequired => 'La contraseña es obligatoria';

  @override
  String get errNameRequired => 'El nombre es obligatorio';

  @override
  String get errPasswordShort => 'Usa al menos 6 caracteres';

  @override
  String get errPasswordMismatch => 'Las contraseñas no coinciden';

  @override
  String get enterEmailFirst =>
      'Escribe primero tu correo arriba y vuelve a pulsar.';

  @override
  String resetEmailSent(String email) {
    return 'Enviamos un correo de restablecimiento a $email.';
  }

  @override
  String get authInvalidEmail => 'Ese correo no parece válido.';

  @override
  String get authWrongCredentials => 'Correo o contraseña incorrectos.';

  @override
  String get authDisabled => 'Esta cuenta ha sido desactivada.';

  @override
  String get authEmailInUse =>
      'Ya existe una cuenta con este correo. Prueba a iniciar sesión.';

  @override
  String get authWeakPassword =>
      'La contraseña es demasiado débil. Usa al menos 6 caracteres.';

  @override
  String get authDifferentMethod =>
      'Este correo está registrado con otro método de acceso.';

  @override
  String get authTooMany =>
      'Demasiados intentos. Espera un momento e inténtalo de nuevo.';

  @override
  String get authNetwork =>
      'Error de red. Revisa tu conexión e inténtalo de nuevo.';

  @override
  String get authNotEnabled => 'Este método de acceso aún no está activado.';

  @override
  String get authGoogleFailed =>
      'Falló el acceso con Google. Inténtalo de nuevo.';

  @override
  String get authUnavailable =>
      'El inicio de sesión aún no está disponible aquí. Continúa como invitado para empezar a practicar.';

  @override
  String get authGeneric => 'Algo salió mal. Inténtalo de nuevo.';

  @override
  String get navPractice => 'Practicar';

  @override
  String get navProgress => 'Progreso';

  @override
  String get navProfile => 'Perfil';

  @override
  String homeGreeting(String name) {
    return 'Hola, $name';
  }

  @override
  String get homeGreetingGuest => '¡Hola!';

  @override
  String get homeSubtitle => '¿Listo para practicar?';

  @override
  String streakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count días',
      one: '1 día',
    );
    return '$_temp0';
  }

  @override
  String get todayChallenge => 'Reto de hoy';

  @override
  String get startNow => 'Empezar ahora';

  @override
  String get practiceRooms => 'Salas de práctica';

  @override
  String get thisWeek => 'Esta semana';

  @override
  String get practisedToday => '¡Hoy ya practicaste! ¡Buen trabajo!';

  @override
  String get keepStreak => 'Practica hoy para mantener tu racha.';

  @override
  String get roomInterview => 'Entrevista de trabajo';

  @override
  String get roomInterviewDesc => 'Ensaya tus respuestas con un reclutador.';

  @override
  String get roomTravel => 'Viajes';

  @override
  String get roomTravelDesc => 'Aeropuertos, hoteles, restaurantes y más.';

  @override
  String get roomDaily => 'Vida cotidiana';

  @override
  String get roomDailyDesc => 'Charla informal, llamadas y nuevos amigos.';

  @override
  String get roomPitch => 'Presentar y convencer';

  @override
  String get roomPitchDesc => 'Practica un pitch claro de 30 segundos.';

  @override
  String get roomFree => 'Charla libre';

  @override
  String get roomFreeDesc => 'Habla de lo que quieras.';

  @override
  String get roomPicture => 'Habla sobre una foto';

  @override
  String get roomPictureDesc => 'Describe una foto en voz alta.';

  @override
  String get setupChooseSituation => 'Elige una situación';

  @override
  String get setupRoleLabel => 'El puesto al que te presentas';

  @override
  String get setupRoleHint => 'p. ej. Product Manager';

  @override
  String get setupLevel => 'Tu nivel';

  @override
  String get levelBeginner => 'Principiante';

  @override
  String get levelIntermediate => 'Intermedio';

  @override
  String get levelAdvanced => 'Avanzado';

  @override
  String get setupPracticeIn => 'Practicar en';

  @override
  String get setupStart => 'Empezar sesión';

  @override
  String get setupAddPhoto => 'Añade una foto para describir';

  @override
  String get setupTakePhoto => 'Hacer una foto';

  @override
  String get setupFromGallery => 'Elegir de la galería';

  @override
  String get setupPhotoAdded => 'Foto añadida';

  @override
  String get setupNeedPhoto => 'Añade una foto para empezar.';

  @override
  String get scRolePm => 'Product Manager';

  @override
  String get scRoleSwe => 'Ingeniero de software';

  @override
  String get scRoleMarketing => 'Ejecutivo de marketing';

  @override
  String get scRoleSupport => 'Atención al cliente';

  @override
  String get scRoleFresher => 'Primer empleo';

  @override
  String get scTravelAirport => 'Facturación en el aeropuerto';

  @override
  String get scTravelHotel => 'Registro en el hotel';

  @override
  String get scTravelRestaurant => 'Pedir en un restaurante';

  @override
  String get scTravelDirections => 'Pedir indicaciones';

  @override
  String get scTravelMarket => 'Comprar en un mercado';

  @override
  String get scTravelPharmacy => 'En la farmacia';

  @override
  String get scDailyIntro => 'Presentarte';

  @override
  String get scDailySmalltalk => 'Charla con un vecino';

  @override
  String get scDailyPhone => 'Reservar por teléfono';

  @override
  String get scDailyFriend => 'Hacer un nuevo amigo';

  @override
  String get scDailyLandlord => 'Hablar con tu casero';

  @override
  String get scPitchIntro => 'Presentación de 30 segundos';

  @override
  String get scPitchProduct => 'Presentar un producto o idea';

  @override
  String get scPitchTalk => 'Una charla corta sobre lo que amas';

  @override
  String get scFreeDay => 'Mi día';

  @override
  String get scFreeHobbies => 'Aficiones e intereses';

  @override
  String get scFreePlans => 'Planes para el fin de semana y el futuro';

  @override
  String get scFreeOpinions => 'Dar tu opinión';

  @override
  String get practiceHint => 'Escribe o toca el micrófono…';

  @override
  String get practiceListening => 'Escuchando… habla ahora';

  @override
  String get practiceSettingUp => 'Preparando tu sala…';

  @override
  String get practiceFinish => 'Terminar';

  @override
  String get finishTitle => '¿Terminar esta sesión?';

  @override
  String get finishBody => 'Revisaré cómo te fue.';

  @override
  String get finishNeedMessage => 'Primero di o escribe al menos una frase.';

  @override
  String get leaveTitle => '¿Salir de esta sesión?';

  @override
  String get leaveBody => 'Tu conversación no se guardará.';

  @override
  String get coachTranslate => 'Traducir';

  @override
  String get coachHideTranslation => 'Ocultar traducción';

  @override
  String get coachListen => 'Escuchar';

  @override
  String get voiceOn => 'Respuestas por voz activadas';

  @override
  String get voiceOff => 'Respuestas por voz desactivadas';

  @override
  String get feedbackGreat => '¡Gran frase!';

  @override
  String get feedbackSayIt => 'Prueba a decirlo así';

  @override
  String get feedbackWhy => 'Por qué';

  @override
  String get feedbackTip => 'Consejo';

  @override
  String get youCouldSay => 'Podrías decir';

  @override
  String get micUnavailable =>
      'El reconocimiento de voz no está disponible aquí. Puedes escribir.';

  @override
  String get errNetwork =>
      'No se puede contactar con el coach. Revisa tu conexión.';

  @override
  String get errBusy =>
      'El coach está ocupado. Inténtalo de nuevo en un momento.';

  @override
  String get errTimeout => 'Tardó demasiado. Inténtalo de nuevo.';

  @override
  String get errServer =>
      'Algo salió mal por nuestra parte. Inténtalo de nuevo.';

  @override
  String get errTooLarge =>
      'Esa foto es demasiado grande. Prueba con una más pequeña.';

  @override
  String get messageFailed => 'No enviado. Toca para reintentar.';

  @override
  String get summaryTitle => 'Resumen de la sesión';

  @override
  String get summaryLoading => 'Revisando tu sesión…';

  @override
  String get summaryFailed => 'No se pudo cargar la revisión.';

  @override
  String get summaryYourScore => 'Tu puntuación';

  @override
  String get summaryStrengths => 'Lo que salió bien';

  @override
  String get summaryImprove => 'Para mejorar';

  @override
  String get summaryVocab => 'Palabras para recordar';

  @override
  String get summaryNextGoal => 'Tu próximo objetivo';

  @override
  String get summaryAgain => 'Practicar otra vez';

  @override
  String get summaryBack => 'Volver a practicar';

  @override
  String get progressTitle => 'Tu progreso';

  @override
  String get statStreak => 'Racha de días';

  @override
  String get statBestStreak => 'Mejor racha';

  @override
  String get statSessions => 'Sesiones';

  @override
  String get statAverage => 'Puntuación media';

  @override
  String get statBest => 'Mejor puntuación';

  @override
  String get statMessages => 'Mensajes';

  @override
  String get recentSessions => 'Sesiones recientes';

  @override
  String get noSessions => 'Aún no hay sesiones. ¡Empieza tu primera práctica!';

  @override
  String get clearHistory => 'Borrar historial';

  @override
  String get clearHistoryBody =>
      'Esto elimina tus sesiones y tu racha de este dispositivo.';

  @override
  String messagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mensajes',
      one: '1 mensaje',
    );
    return '$_temp0';
  }

  @override
  String get profileGuest => 'Invitado';

  @override
  String get profileGuestCta =>
      'Crea una cuenta gratis para guardar tu progreso.';

  @override
  String get editProfile => 'Editar perfil';

  @override
  String get preferences => 'Preferencias';

  @override
  String get feedback => 'Enviar comentarios';

  @override
  String get aboutApp => 'Acerca de BlueSpeak AI';

  @override
  String get whatsNew => 'Novedades';

  @override
  String get supportHelp => 'Soporte y ayuda';

  @override
  String supportContact(String email) {
    return 'Contacto: $email';
  }

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get logoutConfirm => '¿Seguro que quieres cerrar sesión?';

  @override
  String get saveChanges => 'Guardar cambios';

  @override
  String get sendResetEmail => 'Enviar correo de restablecimiento';

  @override
  String get emailCannotChange => 'Tu correo de acceso no se puede cambiar';

  @override
  String get profileUpdated => 'Perfil actualizado';

  @override
  String get profileUpdateFailed => 'No se pudo actualizar tu nombre.';

  @override
  String get prefsAppearance => 'Apariencia';

  @override
  String get prefsTheme => 'Tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get prefsAccent => 'Color de acento';

  @override
  String get accentIndigo => 'Índigo';

  @override
  String get accentOcean => 'Océano';

  @override
  String get accentTeal => 'Turquesa';

  @override
  String get accentSunset => 'Atardecer';

  @override
  String get accentRose => 'Rosa';

  @override
  String get prefsLanguage => 'Idioma';

  @override
  String get prefsAppLanguage => 'Idioma de la app';

  @override
  String get prefsAppLanguageHelp =>
      'Los menús, correcciones y consejos se muestran en este idioma.';

  @override
  String get prefsPracticeLanguage => 'Idioma de práctica';

  @override
  String get prefsPracticeHelp => 'El idioma que quieres hablar mejor.';

  @override
  String get prefsDefaultLevel => 'Nivel predeterminado';

  @override
  String get prefsVoice => 'Voz';

  @override
  String get prefsAutoSpeak => 'Leer en voz alta las respuestas del coach';

  @override
  String get prefsAutoSpeakHelp =>
      'El coach dice cada respuesta automáticamente.';

  @override
  String get fbSentTitle => '¡Comentarios enviados!';

  @override
  String get fbThanks => '¡Gracias por tus comentarios!';

  @override
  String get fbThanksBody => 'Tu opinión nos ayuda a mejorar BlueSpeak AI.';

  @override
  String get fbDescribe => 'Describe tus comentarios';

  @override
  String get fbHint => 'Cuéntanos qué te llevó a escribirnos…';

  @override
  String get fbNoSensitive => 'No incluyas información sensible';

  @override
  String get fbScreenshotHelp =>
      'Una captura nos ayuda a entenderte. (opcional)';

  @override
  String get fbUpload => 'Subir captura';

  @override
  String get fbMaxTwo => 'Puedes añadir hasta 2 capturas.';

  @override
  String get fbMayEmail =>
      'Podemos escribirte para pedir más información o enviarte novedades';

  @override
  String get fbEmpty => 'Escribe tus comentarios antes de enviar.';

  @override
  String get fbSend => 'Enviar';

  @override
  String get fbOpening => 'Abriendo tu app de correo…';

  @override
  String fbCouldNotOpen(String email) {
    return 'No se pudo abrir una app de correo. Escríbenos a $email.';
  }

  @override
  String get fbPrivacyNote =>
      'Parte de la información de la cuenta y del sistema puede enviarse a BlueSpeak para corregir problemas y mejorar la app.';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get termsOfService => 'Términos del servicio';

  @override
  String get legalEnglishNote =>
      'Este documento solo está disponible en inglés.';

  @override
  String get aboutVersion => 'Versión';

  @override
  String get wn1 =>
      'Coach de conversación: practica entrevistas, viajes y charlas cotidianas en voz alta.';

  @override
  String get wn2 =>
      'Correcciones, consejos y puntuación al instante tras cada mensaje.';

  @override
  String get wn3 =>
      'Rachas diarias y una página de progreso para mantenerte motivado.';

  @override
  String get wn4 => 'Temas claro y oscuro, colores de acento y 5 idiomas.';

  @override
  String get wn5 =>
      'No necesitas clave de API: abre la app y empieza a hablar.';
}

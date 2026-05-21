class AppStrings {
  // Aktif dili uygulamanın her yerinden ortak okumak için statik tutuyoruz
  static String currentLanguage = 'tr'; 

  static const Map<String, Map<String, String>> _localizedValues = {
    'tr': {
      'settings': 'Ayarlar',
      'notifications': 'Bildirimler',
      'general_notif': 'Genel bildirimler',
      'general_notif_sub': 'Uygulama uyarılarını aç veya kapat',
      'med_reminders': 'İlaç hatırlatmaları',
      'med_reminders_sub': 'İlaç saatlerinde bildirim göster',
      'appearance': 'Görünüm',
      'dark_mode': 'Koyu tema',
      'dark_mode_sub': 'Tema tercihini değiştir',
      'app': 'Uygulama',
      'language': 'Dil',
      'privacy': 'Gizlilik ve güvenlik',
      'privacy_sub': 'Parola ve oturum ayarları',
      'about': 'Uygulama hakkında',
      'about_sub': 'Sürüm ve yasal bilgiler',
      'account': 'Hesap',
      'logout': 'Çıkış yap',
      'logout_sub': 'Oturumu sonlandır',
      
      // Ana Sayfa Kelimeleri
      'welcome': 'Merhaba Dilara',
      'how_is_day': 'Günün nasıl geçiyor?',
      'streak_title': '12 Günlük Seri',
      'streak_sub': 'Mükemmel gidiyorsun! 🔥',
      'meds': 'İlaçlar',
      'appointments': 'Randevular',
    },
    'en': {
      'settings': 'Settings',
      'notifications': 'Notifications',
      'general_notif': 'General Notifications',
      'general_notif_sub': 'Turn app alerts on or off',
      'med_reminders': 'Medication Reminders',
      'med_reminders_sub': 'Show notifications at medication times',
      'appearance': 'Appearance',
      'dark_mode': 'Dark Mode',
      'dark_mode_sub': 'Change theme preference',
      'app': 'Application',
      'language': 'Language',
      'privacy': 'Privacy & Security',
      'privacy_sub': 'Password and session settings',
      'about': 'About Application',
      'about_sub': 'Version and legal info',
      'account': 'Account',
      'logout': 'Log Out',
      'logout_sub': 'Terminate session',
      
      // Ana Sayfa Kelimeleri
      'welcome': 'Hello Dilara',
      'how_is_day': 'How is your day going?',
      'streak_title': '12-Day Streak',
      'streak_sub': 'You are doing great! 🔥',
      'meds': 'Medications',
      'appointments': 'Appointments',
    },
    'ar': {
      'settings': 'الإعدادات',
      'notifications': 'الإشعارات',
      'general_notif': 'الإشعارات العامة',
      'general_notif_sub': 'تفعيل أو تعطيل تنبيهات التطبيق',
      'med_reminders': 'تذكير المواعيد الدوائية',
      'med_reminders_sub': 'إظهار الإشعارات في مواعيد الدواء',
      'appearance': 'المظهر',
      'dark_mode': 'الوضع الداكن',
      'dark_mode_sub': 'تغيير خيارات المظهر',
      'app': 'التطبيق',
      'language': 'اللغة',
      'privacy': 'الخصوصية والأمان',
      'privacy_sub': 'إعدادات كلمة المرور والجلسة',
      'about': 'حول التطبيق',
      'about_sub': 'الإصدار والمعلومات القانونية',
      'account': 'الحساب',
      'logout': 'تسجيل الخروج',
      'logout_sub': 'إنهاء الجلسة',
      
      // Ana Sayfa Kelimeleri
      'welcome': 'مرحباً ديلارا',
      'how_is_day': 'كيف حالك اليوم؟',
      'streak_title': 'سلسلة ١٢ يوماً',
      'streak_sub': 'أنت تبلي بلاءً حسناً! 🔥',
      'meds': 'الأدوية',
      'appointments': 'المواعيد',
    }
  };

  static String get(String key) {
    return _localizedValues[currentLanguage]?[key] ?? key;
  }
}
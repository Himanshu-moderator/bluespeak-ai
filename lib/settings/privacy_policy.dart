import 'package:flutter/material.dart';

import '../l10n/l10n_helpers.dart';
import 'legal_page.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  static const String _content = """
**Privacy Policy for BlueSpeak AI**

**Last Updated:** October 6, 2026

BlueSpeak AI is a speaking-practice app created by Himanshu Chatterjee. You talk (or type) to an AI coach, and it replies and gives you feedback. This policy explains what happens to your information when you do that.

### 1. What stays on your device

Your settings (theme, language), your guest name, and your practice history (sessions, scores and streaks) are saved **on your device only**. We do not receive them. You can remove them any time with *Progress > Clear history*, by logging out, or by clearing the app's data.

### 2. Your conversations

When you send a message, its **text** is sent to a small server function that forwards it to Google's Gemini AI, which writes the coach's reply and feedback. We do not intentionally store your conversations, we do not build profiles from them, and we do not sell or share them.

* **Photos (Picture Talk):** a photo you choose is sent to Gemini for that session so the coach can talk about it. BlueSpeak does not keep it.
* **Voice:** when you tap the microphone, speech recognition is done by your device or browser's speech service (for example, Chrome may process audio with Google). BlueSpeak only receives the recognised **text**. Spoken replies are generated on your device.
* **Please don't share** sensitive information (health, financial, passwords, ID numbers) in a practice conversation.

### 3. Google's Gemini AI

Because replies come from Google's Gemini AI, your messages are processed on Google's infrastructure under Google's own terms. Google may use data to operate and improve its services, with the safeguards described in its policy. See [https://policies.google.com/privacy](https://policies.google.com/privacy).

### 4. Accounts (optional)

You can use BlueSpeak as a guest, with no account. If you create an account, your **name and email address** are handled by Firebase Authentication (a Google service) so you can log in. We use them only to run your account.

### 5. How information is used

* To write the coach's replies and your feedback.
* To show your progress and streaks on your device.
* To keep the service working and safe.

### 6. Security

Messages travel over encrypted connections (HTTPS). The AI key is kept on the server and is never inside the app. No system is perfectly secure, so please use the app sensibly.

### 7. Children's Privacy

BlueSpeak AI is intended for users aged 9 years and older. We do not knowingly collect personal information from children under 9. If we learn that we have, we will remove it promptly.

### 8. Changes to This Policy

We may update this policy from time to time. The latest version is always in the app, and the *Last Updated* date above will change.

### 9. Contact Us

Questions about this policy? Write to:

* bluespeak.assistant@gmail.com
* himanshu.work.io2@gmail.com
""";

  @override
  Widget build(BuildContext context) =>
      LegalPage(title: context.l10n.privacyPolicy, markdown: _content);
}

import 'package:flutter/material.dart';

import '../l10n/l10n_helpers.dart';
import 'legal_page.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  static const String _content = """
**Terms of Service for BlueSpeak AI**

**Last Updated:** October 6, 2026

Welcome to BlueSpeak AI! These Terms of Service ("Terms") govern your use of the BlueSpeak AI speaking-coach app, powered by Google's Gemini AI. By using BlueSpeak AI, you agree to these Terms. If you don't agree with any part of them, please do not use the app.

---

### 1. Acceptance of Terms

By using BlueSpeak AI, you confirm that you are at least 9 years old and agree to be bound by these Terms and our Privacy Policy. If you use BlueSpeak AI on behalf of an organization, you confirm you have the authority to accept these Terms for it.

---

### 2. What BlueSpeak AI is

BlueSpeak AI helps you practise speaking a language. You hold practice conversations with an AI coach and receive corrections, tips and scores. It is a practice tool: the AI is not a certified teacher, examiner or interviewer, and its feedback is a guide, not a guarantee.

---

### 3. User Conduct and Prohibited Uses

You agree to use BlueSpeak AI responsibly and lawfully. You **must not** use it to:

* **Generate or promote illegal activities,** including violence, drug use, terrorism, or other unlawful acts.
* **Create hate speech or discriminatory content** or harass, threaten, abuse or defame anyone.
* **Produce sexually explicit material** or anything that exploits children.
* **Generate spam** or unsolicited commercial content.
* **Impersonate others** or misrepresent your affiliation with any person or entity.
* **Introduce malware** or any harmful code, or overload or attack the service.
* **Try to "jailbreak"** or circumvent the safety features of BlueSpeak AI.
* **Violate any applicable laws or regulations.**

We may suspend or end your access immediately if you break these Terms.

---

### 4. Intellectual Property

* **Your input:** you keep ownership of the text and photos you provide.
* **AI output:** replies and feedback are produced by an AI model. You may use them for personal, non-commercial purposes. We give no guarantee of any intellectual property rights in the output, and similar output may be produced for other users.
* **BlueSpeak AI itself:** the app, its design and underlying technology belong to us and, for the Gemini model, to Google.

---

### 5. Limitations and Disclaimers

You acknowledge and agree that:

* **AI can be wrong.** Corrections, explanations, translations and scores may be inaccurate, incomplete or biased. Check anything important with a qualified teacher or a trusted source.
* **Not professional advice.** Interview practice, travel phrases and other content are for learning only and are **not a substitute for professional advice** (for example legal, medical or financial).
* **No warranties.** BlueSpeak AI is provided "as is" and "as available", without warranties of any kind, and we do not promise it will be error-free, secure or always available.
* **No liability.** To the maximum extent permitted by law, we are not liable for indirect, incidental, special, consequential or punitive damages, or for loss of data, profits or goodwill, arising from your use of (or inability to use) BlueSpeak AI.

---

### 6. Feedback

We welcome your feedback. By sending it you agree that we may use it to improve BlueSpeak AI without any obligation to you.

---

### 7. Changes to These Terms

We may update these Terms from time to time. Continuing to use BlueSpeak AI after a change means you accept the updated Terms.

---

### 8. Contact Us

* bluespeak.assistant@gmail.com
* himanshu.work.io2@gmail.com
""";

  @override
  Widget build(BuildContext context) =>
      LegalPage(title: context.l10n.termsOfService, markdown: _content);
}

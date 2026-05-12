---
name: zabon-kabul-dari-dialect
description: Afghan Kabul Dari dialect romanization rules and curriculum structure decisions for the Zabon app
metadata:
  type: project
---

Romanizations are localized to **Kabul Afghan Dari** (not Iranian Persian). Key differences:

| Word | Afghan Kabul | Iranian (avoid) |
|------|-------------|-----------------|
| شش (6) | shash | shesh |
| نه (9) | no | noh |
| یک (1) | yak | yek |
| چهار (4) | châr | chahâr |
| سفید | safed | sefid |
| قرمز | qermez (q) | ghermez |
| گرسنه | gershna | gersone |
| خوشمزه | khoshmaza | khoshamze |
| صبح | sob | sobh |
| دقیقه | daqiqa | daghighe |
| تشکر | tashakor | متشکرم (motashakkeram) |
| جمعه | joma | jome |
| صفر | sifr | sefr |

**Why:** User explicitly asked for Kabul dialect, NOT Iranian Persian. These changes were applied to `dari_phrases.dart`, `dari_units.dart`, and `exercise_session_screen.dart`.

**Curriculum structure:**
- `dari_l2` (Unit 1, Lesson 2) = Numbers 0–10 with NUMBERS_TILES_PAGE intro — merged from old l2 (0-5) and u8
- `dari_u8` (old Numbers & Counting unit) was removed
- `از_u4` Numbers 1-10 lesson (dari_l9) was also removed to avoid duplication; unit 4 is now Time & Calendar only
- In family vocabulary, كاكا (kâkâ) used for uncle and پسرکاکا for male cousin (Kabul colloquial)

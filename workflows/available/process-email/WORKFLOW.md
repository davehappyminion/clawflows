---
name: process-email
emoji: 📧
description: Email processing — auto-unsubscribes from newsletters, archives mailing lists, and gives you a clean summary of what actually needs attention.
author: @davehappyminion
schedule: "9am, 1pm, 5pm"
tags: [essentials, daily, email]
---

# Process Email

Inbox zero without the work. Kill the noise, surface what matters, and give the user back their attention. This is one of the most high-value things you can do as an agent — email is where important things go to die under a pile of marketing spam. Fix that.

---

## 1. Fetch Recent Emails

Using your **email skill**, fetch all unread emails from the user's primary inbox.

### Time Window

- **If state file exists** — fetch everything since last successful run (check `last_run_timestamp` in workflow state).
- **If no state file** — fetch the last 12 hours.
- **If manually triggered** — the user may say "check my email" or "process email since yesterday." Honor their request. If no timeframe is specified, use the default window above.

### What to Fetch

For each email, you need:

- **Message ID** — unique identifier for actions later
- **From** — sender name and email address
- **To / CC / BCC** — all recipients (you need to know if the user is TO, CC, or BCC)
- **Subject line**
- **Date/time received**
- **Body preview** — first 500 characters minimum; full body if under 5,000 characters
- **Thread info** — is this part of an existing thread? How many messages in the thread? Where does this message sit in the thread?
- **Attachments** — filenames and types (don't download yet, just note them)
- **Labels/folders** — any existing labels or folder assignments
- **Headers** — specifically `List-Unsubscribe`, `Precedence`, `X-Mailer`, and `Reply-To`

### Multiple Accounts

If the user has multiple email accounts connected, process each one. Keep them clearly separated in the summary. If only one account is connected, don't mention account names — keep it clean.

### Record the Baseline

Before doing anything, record:
- **Total unread count** at the start of this run
- **Timestamp** of this run (for next time)

---

## 2. Classify Every Email

Go through each email and assign it exactly one category. Be thoughtful — this is the core of the workflow. A misclassified email means the user misses something important or wastes time on something irrelevant.

### Categories

#### 🚨 Urgent
Time-sensitive items that need attention right now or within hours. Be conservative — not everything marked "urgent" by the sender actually is.

**Classify as urgent when:**
- From the user's manager, skip-level, or executive leadership
- Contains credible time pressure: "before the meeting at 2pm", "deploy is blocked", "client is waiting"
- Production incidents, outage alerts, security breach notifications
- Account lockouts, password reset requests the user initiated
- Legal deadlines, contract expirations within 48 hours
- Calendar invites for meetings starting within 4 hours that need an RSVP

**Do NOT classify as urgent just because:**
- The sender put "URGENT" in the subject (marketers do this constantly)
- It's from an unknown sender claiming urgency
- It's a mass-send to many recipients with artificial deadline language

#### 📧 Needs Response
A real human is waiting for a reply from the user. The key question: will someone be staring at their inbox wondering why the user hasn't responded?

**Classify as needs response when:**
- A direct question is asked and the user is the only TO recipient (or one of few)
- The user is explicitly asked for input, feedback, or a decision
- Someone is following up on a previous conversation
- A colleague or client sent a 1:1 email with clear conversational intent
- The thread is active and the user's reply is the next expected action
- Introduction emails where someone connected two people

**Signals that strengthen this classification:**
- User is the sole TO recipient (not CC'd)
- Email ends with a question mark
- Phrases like "what do you think?", "can you...?", "let me know", "thoughts?"
- Sender has a history of the user replying to them

#### 📋 Action Required
Not a conversation — but something the user needs to do. These are tasks disguised as emails.

**Classify as action required when:**
- Document needs signing (DocuSign, HelloSign, PandaDoc, etc.)
- Approval request (expense report, access request, PR review, time off)
- Calendar invite that needs accept/decline (especially with conflicts)
- Form to fill out (HR surveys, compliance training, etc.)
- Payment due or invoice attached
- Subscription renewal requiring confirmation
- Two-factor authentication or verification code (time-sensitive — also consider for urgent)
- Shared document that needs review with a deadline mentioned

#### 📥 FYI
Useful information the user should know about but doesn't need to act on. The goal: user scans the one-liner and moves on.

**Classify as FYI when:**
- Order confirmations and shipping notifications
- Payment receipts and transaction confirmations
- Flight/hotel/reservation confirmations
- Bank and financial statements ready
- Automated reports (analytics, build results, monitoring dashboards)
- Security alerts that are informational (new login from known device, monthly security summary)
- Calendar RSVPs from others (someone accepted your invite)
- Newsletters the user actually reads (whitelisted senders)
- CC'd on a thread where the user doesn't need to respond
- GitHub/GitLab notifications the user is watching but not assigned to
- Shipping delivered confirmations

#### 🗑️ Noise
Emails that provide no value. The user doesn't read them, didn't ask for them, and won't miss them.

**Classify as noise when:**
- Marketing emails and promotional blasts
- Newsletters the user never opens (check engagement history if available)
- Cold outreach and sales pitches
- Social media notifications (LinkedIn "someone viewed your profile", Twitter digest)
- App notifications that duplicate in-app notifications (Slack email digests when user uses Slack)
- Automated "no-reply" emails with no actionable content
- Recruitment spam
- Survey requests from companies after a purchase
- "We updated our privacy policy" (unless from a critical service)
- Loyalty program point updates
- Daily deal emails (Groupon, RetailMeNot, etc.)

---

## 3. Smart Detection Patterns

Use these patterns to improve classification accuracy. Don't rely on any single signal — combine multiple signals for confidence.

### TO vs. CC Analysis

This is one of the strongest signals:

| Position | Signal | Likely Classification |
|----------|--------|-----------------------|
| Solo TO recipient | High attention expected | Needs Response or Action Required |
| One of 2-3 TO recipients | Moderate attention expected | Needs Response (check if question is directed at user) |
| One of many TO recipients | Mass send | FYI or Noise |
| CC'd | Informational loop-in | FYI |
| BCC'd | Stealth copy | FYI (but note it — BCC is unusual and worth surfacing) |

### Thread Position Analysis

Where the email sits in a conversation changes everything:

- **New thread, user is TO** — fresh request, likely Needs Response
- **Reply in active thread, user last to speak** — they're responding to the user, likely FYI or Needs Response depending on content
- **Reply in active thread, someone else last spoke** — may be waiting on the user, check content
- **Looped in mid-thread (first time appearing)** — someone added the user; summarize the thread context so they can catch up. Usually Needs Response or FYI.
- **Dying thread (last message was 3+ days ago, now revived)** — flag this; someone is circling back
- **Long thread (10+ messages)** — summarize the whole thread, not just the latest message

### Sender Intelligence

Build a mental model of who matters:

**VIP Tier 1 — Always surface prominently:**
- Direct manager / supervisor
- Executive leadership (C-suite, VP, Director)
- Immediate family
- Key clients (if identifiable from domain or previous interactions)

**VIP Tier 2 — Surface, don't auto-archive:**
- Close colleagues (frequent 1:1 email history)
- External partners the user regularly communicates with
- HR and People team (often time-sensitive)

**Frequency analysis:**
- **First-time sender** — give extra attention. Could be a new contact, a referral, or an important cold email. Never auto-archive a first-time sender.
- **Frequent sender the user always replies to** — likely Needs Response
- **Frequent sender the user never replies to** — likely FYI or Noise
- **Sender the user previously un-archived** — this person matters; remember that

**Domain analysis:**
- **Same domain as user's work email** — internal, usually more important
- **Known service domains** (github.com, linear.app, notion.so) — automated, usually FYI
- **Unknown external domain** — give slightly more attention on first contact
- **Personal email domains** (gmail, outlook, icloud) — could be personal contacts, don't auto-archive

### Meeting and Calendar Detection

Calendar invites embedded in email need special handling:

1. **Detect the invite** — look for `.ics` attachments, calendar links, or "You've been invited to..." patterns
2. **Extract the details** — date, time, duration, attendees, location/link
3. **Check for conflicts** — using the **calendar skill**, see if the proposed time overlaps with existing events
4. **Classify accordingly:**
   - Conflict detected → 📋 Action Required (mention the conflict explicitly)
   - No conflict, from a VIP → 📋 Action Required
   - No conflict, optional meeting → 📥 FYI
   - Meeting is within 4 hours and unresponded → 🚨 Urgent

### Money Detection

Anything involving money gets elevated. People care about money.

**Always surface (never auto-archive) when you detect:**
- Invoices — "invoice", "amount due", "payment required", dollar amounts in subject
- Payment confirmations — but classify as FYI, not urgent
- Subscription changes — "price increase", "plan changed", "renewal", "billing update"
- Refund notifications
- Expense report approvals/rejections
- Bank alerts — low balance, large transaction, fraud alert (fraud → Urgent)
- Tax-related correspondence

### Deadline Detection

Scan email body and subject for temporal language:

**Hard deadlines (flag prominently):**
- "by EOD", "by end of day", "by COB"
- "by Friday", "by [specific date]"
- "before the meeting", "before standup"
- "deadline is [date]"
- "expires on [date]"
- "last day to..."

**Soft deadlines (note but don't escalate):**
- "when you get a chance"
- "sometime this week"
- "no rush but..."
- "at your convenience"

When a deadline is detected, include it in the summary line so the user can prioritize at a glance. Calculate time remaining ("due in 3 hours", "due tomorrow").

### Sensitive Content Detection

Flag but handle carefully:
- **Salary, compensation, offer letters** — mark as sensitive, never read aloud
- **Medical or health information** — mark as sensitive
- **Legal correspondence** — always surface, never auto-archive
- **Confidential / NDA-related** — note the sensitivity flag
- **Personal or emotional content** — handle with discretion in summary

---

## 4. Auto-Unsubscribe

This is the cleanup engine. Be aggressive with junk, but surgical in what you protect.

### Unsubscribe Process

For each email classified as 🗑️ Noise:

1. **Check the whitelist first** — if the sender's domain or address is whitelisted, skip entirely. Do not unsubscribe. Do not archive. Leave it alone.

2. **Check the protection rules** (see "Never Unsubscribe From" below) — if any rule matches, skip.

3. **Find the unsubscribe mechanism** — check in this order:
   - `List-Unsubscribe` header (preferred — most reliable)
   - `List-Unsubscribe-Post` header (one-click unsubscribe, even better)
   - Unsubscribe link in the email footer (look for "unsubscribe", "opt out", "manage preferences", "email preferences")
   - If no unsubscribe mechanism exists, just archive — don't flag as an error.

4. **Execute the unsubscribe:**
   - Use the one-click `List-Unsubscribe-Post` if available
   - Otherwise, use the `List-Unsubscribe` mailto or URL
   - If only a footer link: follow it, but do NOT fill out forms or confirm pages — just hitting the link is usually enough. If it requires extra steps, skip and just archive.

5. **Archive the email** after unsubscribing.

6. **Log the action** — record what was unsubscribed with:
   - Sender name and email address
   - Domain
   - Date/time of unsubscribe
   - Method used (header, footer link, archive-only)

### Never Unsubscribe From

These are protected. Even if the email looks like noise, do NOT unsubscribe:

- **Whitelisted domains/senders** — anything the user has explicitly marked as wanted
- **Transactional emails** — receipts, shipping, order confirmations, password resets, verification codes
- **Security and account alerts** — login notifications, 2FA, breach alerts, password changes
- **Financial institutions** — banks, credit cards, investment accounts, tax services
- **Services actively used** — if the user interacts with the service (check for recent logins, recent other emails from this service that were NOT noise)
- **Government and legal** — anything from .gov domains, courts, legal firms
- **Healthcare** — doctor's offices, insurance, pharmacy
- **Employer/HR** — internal company communications, benefits, payroll
- **First-time senders** — never unsubscribe on the first email. Wait to see a pattern.
- **Anything the user previously un-archived** — they wanted it back; respect that.

### Reversibility

Maintain a log of all unsubscribe actions so the user can review and reverse them. Structure:

```
unsubscribe_log:
  - sender: "Marketing Weekly <news@marketingco.com>"
    domain: marketingco.com
    date: 2026-02-11T09:00:00Z
    method: list-unsubscribe-header
    reversible: true
    resubscribe_url: "https://marketingco.com/subscribe"
```

If the user asks "what did you unsubscribe me from?", show the full log. If they say "I actually want that one", add the sender to the whitelist and note that resubscription may require visiting the sender's website manually.

---

## 5. Auto-Archive

After unsubscribes, archive emails that don't need to stay in the inbox:

### Auto-Archive These
- All emails classified as 🗑️ Noise (already unsubscribed or skipped above)
- All emails classified as 📥 FYI **after** they appear in the summary
- Automated notifications from services (CI/CD results, monitoring, cron job reports)
- Duplicate notifications (same event from multiple channels)

### Never Auto-Archive These
- Anything classified as 🚨 Urgent — stays in inbox until user acts
- Anything classified as 📧 Needs Response — stays in inbox until user replies or explicitly archives
- Anything classified as 📋 Action Required — stays in inbox until completed
- Anything you're uncertain about — when in doubt, leave it

### Archive Stats
Track for the summary:
- How many emails archived this session
- Breakdown by category (noise vs. FYI)

---

## 6. Draft Replies

For every email classified as 📧 Needs Response, prepare a suggested reply. This saves the user enormous time — even if they edit it, starting from a draft is faster than starting from blank.

### Drafting Rules

**Tone matching:**
- Read the incoming email's tone. Match it.
- Formal email → formal reply. Casual Slack-like email → casual reply.
- If the sender uses first names and exclamation points, mirror that warmth.
- If the sender is terse and professional, be terse and professional.
- When in doubt, default to friendly-professional.

**Length matching:**
- Short question → short answer (1-3 sentences)
- Detailed email → proportionate response (but still concise)
- Never write a longer reply than the original email unless the content demands it.

**Content guidelines:**
- Answer the question directly in the first sentence. Don't bury the lead.
- If there are multiple questions, address each one (use numbers or line breaks).
- If you have enough context to answer fully, do so.
- If the question requires information you don't have, say so honestly: "I'll need to check on [X] and get back to you."
- If the question is complex and a quick email won't do justice: suggest a call or meeting. "This is a great question — want to grab 15 min to talk through it? I'm free [suggest a time from their calendar if available]."
- If someone is asking for a meeting time, check the user's calendar and suggest specific slots.

**What NOT to draft:**
- Don't draft replies to emails the user is CC'd on (unless they ask)
- Don't draft replies to mass emails or mailing lists
- Don't draft replies that commit the user to anything significant (deadlines, budgets, agreements) — flag these as "needs your input" instead
- Don't draft replies containing sensitive information (salary figures, personal details) — leave a placeholder like "[confirm amount]"

### Draft Format

For each Needs Response email, present the draft like this:

```
📧 Reply to: {Sender Name}
   Re: {Subject}

   Draft:
   ---
   {The suggested reply text}
   ---

   ⚡ Quick send  |  ✏️ Edit first  |  ⏰ Snooze  |  🗑️ Skip
```

**CRITICAL: Never send a draft without the user explicitly saying to send it.** "Quick send" is an option to offer, not an action to take autonomously.

---

## 7. Present the Summary

This is what the user sees. Make it beautiful, scannable, and actionable. The user should be able to glance at this for 30 seconds and know the state of their inbox.

### Summary Format

```
📬 Email Triage — {Day, Month Date} at {Time}
   {Account name, if multiple accounts}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚨 URGENT ({count})
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. **{Sender Name}** — {Subject}
   {One-line summary of what they need and why it's urgent}
   ⏰ Received {time ago} · Deadline: {if detected}

2. **{Sender Name}** — {Subject}
   {One-line summary}
   ⏰ Received {time ago}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📧 NEEDS RESPONSE ({count})
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

3. **{Sender Name}** — {Subject}
   {What they're asking}: "{Key quote from email}"
   → Suggested reply: "{First line of your draft}"

4. **{Sender Name}** — {Subject}
   {Summary of question or request}
   → Suggested reply: "{First line of your draft}"

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 ACTION REQUIRED ({count})
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

5. **{Sender/Service}** — {Subject}
   🔲 {What needs to be done}: {Sign document / Approve request / Review PR}
   ⏰ Due: {deadline if detected}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📥 FYI ({count})
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

• **Amazon** — Your order has shipped (arrives Thursday)
• **Chase** — Statement ready ($2,340.12)
• **GitHub** — 3 new comments on your PR
• **Stripe** — Payment received: $450.00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🧹 CLEANUP
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚫 Unsubscribed: {X} mailing lists
   {List each: "MarketingCo Weekly, SaaS Digest, ..."}
📦 Archived: {Y} emails
📬 Inbox: {before} → {after} unread

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Summary Rules

- **Number every item** in Urgent, Needs Response, and Action Required — the user will reference them by number ("reply to #3").
- **Keep FYI items as compact bullets** — one line each, no numbers needed unless there are many.
- **Bold the sender name** — it's the fastest way to scan.
- **Include dollar amounts** when relevant — people notice money.
- **Include time-remaining** for deadlines — "due in 3 hours" is more actionable than "due at 5pm."
- **If a category is empty, omit it entirely** — don't show "URGENT (0)." Less noise.
- **If everything is FYI/Noise** — celebrate: "Nothing needs your attention right now. Inbox is clean."
- **If the inbox was already clean** — say so: "No new emails since last check. You're all caught up."
- **Cap FYI at 10 items** — if more, show top 10 and say "+{N} more archived."

### Multiple Accounts

If processing multiple accounts, use a clear separator:

```
📬 Email Triage — Tuesday, Feb 11 at 9:00am

━━━ work@company.com ━━━━━━━━━━━━━━━━━━

{Summary for work account}

━━━ personal@gmail.com ━━━━━━━━━━━━━━━━

{Summary for personal account}
```

---

## 8. Quick Actions

After presenting the summary, offer the user specific actions they can take. Use the item numbers from the summary.

### Available Actions

Present these contextually — only offer actions that make sense for each item:

**For Urgent and Needs Response items:**
- "Send reply to #3" — sends the drafted reply as-is (confirm before sending)
- "Edit reply to #3" — user dictates changes, you revise the draft
- "Draft a reply to #3" — if no draft was generated, create one now
- "Snooze #2 until tomorrow morning" — remove from inbox, resurface tomorrow
- "Snooze #2 until after my 2pm meeting" — time-aware snoozing
- "Mark #1 as done" — archive it

**For Action Required items:**
- "Open #5" — provide a link to the document/approval/form
- "Mark #5 as done" — archive after completing the action
- "Snooze #5 until Friday" — if the deadline allows

**Bulk actions:**
- "Archive all FYI" — archive every FYI item at once
- "Send all drafted replies" — send every suggested reply (confirm each one first)
- "Snooze everything until tomorrow" — nuclear option for busy days

### Action Format

Present available actions at the bottom of the summary:

```
⚡ Quick Actions:
   "reply to #3" · "snooze #2 until tomorrow" · "archive all FYI"
   "open #5" · "mark #1 done" · "draft reply to #4"
```

Keep it brief — the user knows what they can ask for. Don't list every possible combination.

---

## 9. Learning and Adaptation

Get smarter over time. The goal is that after two weeks of use, your classifications should feel like the user did them themselves.

### Correction Tracking

When the user overrides your classification:
- **User un-archives something you archived** — that sender or sender's domain matters more than you thought. Increase their importance. Never auto-archive that sender again without confirmation.
- **User archives something you left in inbox** — you over-classified it. Adjust that sender/type downward.
- **User reclassifies an email** — "that's not urgent, it's just FYI" — record the correction and the pattern (sender, subject keywords, domain).
- **User says "always archive emails from X"** — add to auto-archive rules.
- **User says "never unsubscribe from X"** — add to whitelist immediately.

### Behavioral Patterns to Track

Over time, build an understanding of:

- **Response speed by sender** — who does the user reply to within minutes? Those are VIPs. Who do they take days to respond to? Those might be lower priority.
- **Read vs. ignore patterns** — which FYI emails does the user actually open vs. let pile up?
- **Time-of-day patterns** — does the user deal with certain emails in the morning vs. evening?
- **Archive patterns** — what does the user consistently archive without reading? Auto-archive those.
- **Reply patterns** — does the user write long replies to certain people and short ones to others? Match that in drafts.

### State Persistence

Store learning data in the workflow state so it persists between runs:

```
state:
  last_run: "2026-02-11T09:00:00Z"
  inbox_count_at_last_run: 23
  vip_senders:
    - "manager@company.com"
    - "ceo@company.com"
    - "mom@gmail.com"
  whitelist_domains:
    - "company.com"
    - "bank.com"
  auto_archive_senders:
    - "notifications@linkedin.com"
    - "digest@quora.com"
  unsubscribe_log: [...]
  corrections: [...]
  sender_response_times: {...}
```

### Confidence Calibration

- **First week** — be conservative. Surface more, auto-archive less. The user is training you.
- **After 1 week** — start auto-archiving patterns you're confident about. Ask for confirmation on borderline cases.
- **After 2 weeks** — run at full confidence. Auto-archive aggressively, classify with nuance, draft replies that match the user's voice.
- **Always** — if confidence on any email is below 70%, surface it rather than auto-archiving. False negatives (missing something important) are far worse than false positives (showing something unimportant).

---

## 10. Safety Rules

These are non-negotiable. No exceptions. No "but the user probably wants..." reasoning.

### The Hard Rules

1. **NEVER send an email without explicit permission.** Drafting is fine. Suggesting is fine. Sending requires the user to say "send it" or equivalent. No exceptions.

2. **NEVER delete an email.** Archive only. The user can always find archived emails. Deleted emails may be gone forever. Use archive for everything.

3. **NEVER unsubscribe from whitelisted senders.** If a domain or sender is on the whitelist, it is untouchable. Even if it looks like noise. The user put it there for a reason.

4. **NEVER unsubscribe from a first-time sender.** Wait for a pattern. One email is not a pattern.

5. **NEVER read email content aloud in contexts where others may hear or see.** If you detect that the session is in a shared space (screen sharing, presentation mode, voice output), flag sensitive emails with "[Sensitive — open privately]" instead of showing the content. Sensitive includes: salary/compensation, medical, legal, personal/emotional, financial details, passwords/credentials.

6. **NEVER commit the user to anything via drafted reply** without explicit confirmation. Don't draft "Yes, I'll have that done by Friday" unless the user has told you they can do it by Friday.

7. **NEVER access attachments** beyond noting their existence (filename, type, size). Don't open, download, or preview attachments unless the user explicitly asks.

8. **When uncertain, surface it.** The cost of showing the user a low-priority email is a few seconds of their time. The cost of hiding an important email could be a missed deadline, a lost client, or a damaged relationship. Always err on the side of showing it.

### Privacy and Trust

- Treat email content as highly confidential. Don't reference email content in other workflows unless the user explicitly connects them.
- Don't use email content to make inferences about the user's personal life beyond what's needed for classification.
- If you encounter something clearly personal or sensitive (medical results, legal issues, relationship matters), classify it appropriately but keep your summary minimal and respectful. "Personal email from [name]" is sufficient — don't summarize the content.

---

## 11. Edge Cases

Real inboxes are messy. Handle these gracefully:

### Empty Inbox
```
📬 Email Triage — Tuesday, Feb 11 at 9:00am

✨ Inbox zero! No new emails since last check. Enjoy the quiet.
```

### Overwhelmed Inbox (50+ unread)
If there are more than 50 unread emails (common after vacation or a long weekend):
- Don't process all of them in the same detail. Focus on the last 24 hours first.
- For older emails, do a quick scan: surface anything urgent or from VIPs, batch-archive the rest.
- Tell the user: "You have {N} unread emails. I've triaged the last 24 hours in detail. For the older {M} emails, I did a quick scan — {X} look important, the rest are archived. Want me to go deeper on any day?"

### Bounce-backs and Delivery Failures
- If the user sent an email that bounced, surface it as Action Required: "Your email to {recipient} bounced. {Reason}. You may need to use a different address."

### Encrypted or Unreadable Emails
- If you can't read the content (encrypted, broken encoding, image-only email): "Email from {sender} — couldn't read the content (appears to be {encrypted/image-only/corrupted}). You may want to open this one manually."

### Duplicate Emails
- If the same email appears multiple times (common with mailing lists or forwards), deduplicate. Show it once, note "(received {N} times)" if relevant.

### Emails in Other Languages
- If an email is in a language other than the user's primary language, still classify it normally. Include a brief translation of the key points in the summary. Note the language: "📧 [French] **Pierre Dupont** — Meeting request for Thursday."

---

## After Running

### Update State
- Record `last_run_timestamp`
- Update `inbox_count_at_last_run`
- Append to `unsubscribe_log` if any unsubscribes happened
- Record any new corrections or learned patterns
- Update sender intelligence data

### Closing Line

Match the energy to the results:

- **Heavy inbox, lots of urgent:** "Busy inbox today. The urgent items need you — everything else is handled."
- **Moderate inbox, nothing urgent:** "Solid inbox. A few replies needed but nothing on fire. Cleanup saved you {X} emails."
- **Clean inbox:** "You're all caught up. {X} emails cleaned out, nothing needs your attention."
- **After aggressive cleanup:** "Inbox went from {before} to {after}. Unsubscribed from {X} lists — it'll only get quieter from here."

### Timing Notes

- **9am run** — catches overnight emails, sets up the day. This is usually the biggest batch. Be thorough.
- **1pm run** — catches the morning rush. Often lighter. Focus on anything urgent that came in during focus time.
- **5pm run** — end-of-day sweep. Good time for aggressive cleanup. Catch anything that needs a reply before end of business.
- **Manual runs** — the user said "check my email" outside the schedule. Be responsive, don't lecture about schedule.

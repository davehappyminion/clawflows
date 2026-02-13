---
name: prep-interview
emoji: 💼
description: Research a company before a job interview. Pull recent news, company info, interviewer profiles, and common questions for the role. Delivers a complete prep packet.
author: @davehappyminion
---

# Prep Interview

Build a comprehensive interview prep packet so the user walks in confident, informed, and ready with smart questions. This workflow gathers company intel, interviewer backgrounds, and role-specific preparation material.

## 1. Collect Interview Details

Ask the user for the following:
- **Company name** (required)
- **Role/position title** (required)
- **Interview date and time** (optional, for urgency context)
- **Interviewer names and titles** (optional, but highly valuable if known)
- **Interview format** (phone screen, technical, behavioral, panel, take-home, etc.)
- **Job description URL or text** (optional, but helps tailor preparation)
- **Any specific concerns** ("I'm weak on system design", "I've never used their tech stack", etc.)

Proceed with whatever the user provides. Fill in gaps through research.

## 2. Research the Company

Gather the following information:
1. **Company overview** — What they do, founding year, headquarters, size, funding stage
2. **Recent news** — Last 3-6 months of press coverage, product launches, funding rounds, leadership changes
3. **Products and services** — What they sell, who their customers are, competitive landscape
4. **Tech stack** — If a tech role, identify their known technology choices (check job postings, engineering blog, GitHub)
5. **Culture signals** — Glassdoor reviews summary, company values page, notable public statements
6. **Financial health** — Public company: stock performance and recent earnings. Private: last funding round, growth signals
7. **Challenges** — Any known difficulties (layoffs, controversies, competitive pressure, market shifts)

Use public sources only. Do not access anything requiring authentication.

## 3. Research Interviewers

For each interviewer name provided:
1. Find their LinkedIn profile summary (title, tenure at company, career history)
2. Look for public talks, blog posts, tweets, or open source contributions
3. Identify shared connections or interests with the user
4. Note their likely role in the interview (hiring manager, peer, skip-level, recruiter)

If interviewer names are not provided, skip this section and note it in the report.

## 4. Analyze the Role

Based on the job description and company research:
1. **Key requirements** — The 3-5 most critical skills or experiences they are looking for
2. **User's strengths** — Where the user's background aligns well (ask the user or check their resume if available)
3. **Potential gaps** — Areas where the user may need to address concerns or reframe experience
4. **Why this role exists** — Is it a backfill, new headcount, team expansion? (infer from context)

## 5. Prepare Questions and Answers

Generate preparation material in three categories:

### Likely Questions They Will Ask
- 8-10 probable interview questions based on the role and interview format
- For each question, provide a brief framework for answering (not a script — talking points)
- Include both behavioral ("Tell me about a time...") and role-specific questions

### Questions the User Should Ask Them
- 5-7 thoughtful questions that demonstrate research and genuine interest
- Avoid generic questions that could apply to any company
- Include at least one question about the team, one about the product, and one about growth

### Tough Questions to Prepare For
- 3-5 questions the user might find difficult based on potential gaps
- Brief strategies for handling each one honestly and confidently

## 6. Deliver Prep Packet

Present the complete packet using this template:

```
# Interview Prep Packet
**Company:** [Name]
**Role:** [Title]
**Interview Date:** [Date or "Not specified"]
**Format:** [Type]

---

## Company Snapshot
- **What they do:** [1-2 sentences]
- **Founded:** [Year] | **HQ:** [Location] | **Size:** [employees]
- **Stage/Funding:** [Series X / Public / Bootstrapped]
- **Key products:** [list]

## Recent News
1. [Headline] — [Source, Date] — [One-line summary]
2. [Headline] — [Source, Date] — [One-line summary]
3. [Headline] — [Source, Date] — [One-line summary]

## Tech Stack (if applicable)
- Languages: [...]
- Frameworks: [...]
- Infrastructure: [...]
- Source: [engineering blog / job postings / GitHub]

## Your Interviewers
### [Name] — [Title]
- At [Company] for [N] years
- Background: [Brief career summary]
- Notable: [Public talks, blog posts, shared interests]
- Likely role in interview: [Hiring manager / Peer / Technical evaluator]

[...repeat for each interviewer...]

## Role Analysis
### What They Need
1. [Key requirement] — [why it matters for this role]
2. [Key requirement] — [why it matters]
3. [Key requirement] — [why it matters]

### Your Strengths to Highlight
- [Strength] — connects to [requirement]
- [Strength] — connects to [requirement]

### Gaps to Address
- [Gap] — suggested framing: [how to address it positively]

## Questions They May Ask
1. [Question]
   **Framework:** [Brief talking points]
2. [Question]
   **Framework:** [Brief talking points]
[...8-10 questions...]

## Questions You Should Ask
1. [Question] — *shows you researched [topic]*
2. [Question] — *demonstrates interest in [topic]*
[...5-7 questions...]

## Tough Questions to Prep
1. [Question]
   **Strategy:** [How to handle this]
[...3-5 questions...]

## Final Reminders
- [Key talking point to remember]
- [Company-specific detail to reference]
- [Anything time-sensitive, like recent news to mention]

---
Researched from [N] public sources | Generated [DATE]
```

## 7. Offer Follow-ups

After delivering the packet, offer:
- Mock interview practice on specific questions
- Deeper research into any section
- A one-page cheat sheet version for quick review before the interview
- Post-interview follow-up email draft (after the interview happens)

## Safety Rules

- **Use only publicly available information.** Do not access private databases, paid services, or anything behind authentication.
- **Do not fabricate company details, news, or interviewer information.** If something cannot be verified, say so.
- **Do not make assumptions about the user's qualifications.** Ask if unsure.
- **Clearly label any inferences or speculation** (e.g., "Based on recent job postings, they likely use...").

## Notes

- This workflow is on-demand only. No schedule.
- The quality of interviewer research depends heavily on what names the user provides. Encourage them to share whatever they have.
- For technical interviews, offer to focus a separate session on coding practice or system design prep specific to the company's domain.
- Prep packets work best when generated 2-3 days before the interview, giving the user time to review and follow up on specific areas.
- If the user provides a job description, it dramatically improves the quality of the question preparation. Always ask for it.

---
name: summarize-podcasts
emoji: "\U0001F3A7"
description: Transcribe a podcast episode and deliver key takeaways with timestamps for the interesting parts. Paste a URL or provide an audio file.
---

# Summarize Podcasts

Take a podcast episode, transcribe it, extract the most valuable insights, and deliver a structured summary the user can scan in 2 minutes instead of listening for 60.

## 1. Receive Input

Accept one of the following from the user:
- **Podcast URL** — A direct link to an episode page (Apple Podcasts, Spotify, YouTube, podcast website, or direct MP3/audio URL)
- **Audio file path** — A local file (mp3, m4a, wav, etc.)
- **Episode name + show name** — If provided without a URL, search for the episode and confirm with the user before proceeding

Validate the input:
- Confirm the episode exists and is accessible
- Check audio duration — warn the user if the episode is over 3 hours (transcription will take longer)
- Display the episode title, show name, and duration for confirmation

## 2. Transcribe Audio

Transcribe the full episode using the best available method:
1. Check if a transcript is already published (many podcasts provide them on their website or via RSS)
2. If not, use a speech-to-text service or local transcription tool
3. Preserve speaker labels where possible (e.g., "Host:", "Guest:")
4. Include timestamps at regular intervals (at minimum every 2-3 minutes)

If transcription fails, report the error clearly and suggest alternatives (e.g., trying a different URL format, or providing the audio file directly).

## 3. Identify Speakers

- Determine how many speakers are in the episode
- Label them by name if identifiable from the episode intro, show notes, or context
- If names cannot be determined, use "Speaker 1", "Speaker 2", etc.
- Note any guest introductions with their title/role if mentioned

## 4. Extract Key Segments

Analyze the transcript and identify:
- **Key insights** — Novel ideas, surprising facts, actionable advice
- **Notable quotes** — Memorable or shareable statements
- **Disagreements or debates** — Points where speakers diverge
- **Recommendations** — Books, tools, people, or resources mentioned
- **Action items** — Anything the listener is encouraged to do

For each segment, record the timestamp so the user can jump directly to it.

## 5. Generate Summary

Produce a structured summary at three levels of detail:
1. **One-liner** — A single sentence capturing the episode's core message
2. **Key takeaways** — 5-8 bullet points covering the most important ideas
3. **Detailed notes** — Section-by-section breakdown with timestamps

## 6. Present Summary

Deliver the summary using this template:

```
# Podcast Summary

**Show:** [Show Name]
**Episode:** [Episode Title]
**Date:** [Publication Date]
**Duration:** [HH:MM:SS]
**Speakers:** [Speaker 1 (role)], [Speaker 2 (role)]

## TL;DR
[One sentence summary of the episode]

## Key Takeaways
1. [Takeaway with brief context] — [TIMESTAMP]
2. [Takeaway] — [TIMESTAMP]
3. [Takeaway] — [TIMESTAMP]
[...up to 8]

## Notable Quotes
> "[Quote]" — [Speaker], [TIMESTAMP]
> "[Quote]" — [Speaker], [TIMESTAMP]

## Detailed Notes

### [Topic/Segment 1] — [START TIMESTAMP]
[2-4 sentence summary of this segment]

### [Topic/Segment 2] — [START TIMESTAMP]
[2-4 sentence summary]

[...continue for each major segment...]

## Mentioned Resources
- [Book/Tool/Person/Link] — mentioned at [TIMESTAMP]
- [Book/Tool/Person/Link] — mentioned at [TIMESTAMP]

## Worth a Full Listen?
[Brief honest assessment: is this episode worth listening to in full, or are the notes sufficient?
Note which segments are worth listening to directly if only parts are strong.]
```

## 7. Save and Offer Extras

- Save the summary to the user's configured output location
- Offer to save the full transcript as a separate file
- Offer to add any mentioned books/resources to the user's reading list

## Safety Rules

- **Never redistribute or publish the full transcript.** It is for personal use only.
- **Never fabricate quotes or timestamps.** If a timestamp is uncertain, mark it as approximate with "~".
- **Never editorialize the speakers' views.** Summarize what was said, not what you think about it.

## Notes

- This workflow is on-demand only. No schedule.
- Transcription quality varies by audio quality. If the source has heavy background music or crosstalk, note this in the summary.
- For video podcasts (YouTube), extract the audio track only. Do not attempt to describe visual content unless the user requests it.
- If the podcast has show notes with timestamps already, use those as a starting scaffold and enrich from there.
- Long episodes (2+ hours) may benefit from a "chapters" approach — break the summary into logical sections with clear timestamp ranges.

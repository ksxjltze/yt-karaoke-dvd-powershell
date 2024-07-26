Youtube to Karaoke DVD Powershell Scripts

Downloads a youtube video and converts it into a .mpeg file suitable for modern DVD playback.

Vocals are removed from the original audio and then panned to the right channel.
The original audio is panned to the left channel.

Final Format properties:
|  Property            | Value   |
| --------             | ------- |
| Container            | MPEG-PS |
| Video Encoding       | MPEG-2  |
| Audio Encoding       | AC3     |
| Video Dimensions     | 720x352 |
| Original Audio Channel    | L  |
| Karaoke Audio Channel     | R  |

Pipeline: 
yt-dlp: Download files from youtube link -> demucs: remove vocals -> ffmpeg: pan audio and combine original audio with the minused verison -> avidemux_cli: replace audio track of orignal video with karaoke version and convert to DVD compatible format

Dependencies:
- yt-dlp: https://github.com/yt-dlp/yt-dlp
- demucs: https://github.com/adefossez/demucs
- ffmpeg: https://www.ffmpeg.org/
- avidemux: https://avidemux.sourceforge.net/

$OutputFormat = $VideoDirectory + "\%(title)s.f%(format_id)s.%(ext)s"
yt-dlp -f "bv*[ext=mp4],ba[ext=m4a],ba[ext=opus]" -o $OutputFormat $SourceURL
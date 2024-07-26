import os

adm=Avidemux()

audio_path = os.environ("audio_path")
adm.audioClearTracks()
adm.audioAddExternal(audio_path)
adm.audioAddTrack(1)
adm.audioCodec(0, "LavAC3", "bitrate=224")
adm.setSourceTrackLanguage(0,"cn")
adm.audioSetResample(0, 48000)

adm.addVideoFilter("swscale", "width=720", "height=352", "algo=1", "sourceAR=0", "targetAR=0", "lockAR=True", "roundup=0")
adm.addVideoFilter("addBorder", "left=0", "right=0", "top=64", "bottom=64")
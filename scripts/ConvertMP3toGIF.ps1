Get-ChildItem .\ -Filter *.mp4 | ForEach-Object {
  ffmpeg -i $_.FullName -i "C:\ffmpeg\palette.png" -filter_complex "[0:v]fps=15,scale=iw:ih:neighbor,split[s0][s1];[s0]palettegen=max_colors=256:reserve_transparent=1:stats_mode=full[p];[s1][p]paletteuse=dither=bayer" -t 00:00:10 ".\$($_.BaseName).gif"
  Remove-Item $_.FullName
}

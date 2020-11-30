
' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********

Function loadConfig() as Object
    arr = [
'##### Format for inputting stream info #####
'## For each channel, enclose in brackets ## 
'{
'   Title: NEGAH TV
'   streamFormat: Channel stream type (ex. "hls", "ism", "mp4", etc..)
'   Logo: Channel Logo (ex. "http://Roku.com/Roku.jpg)
'   Stream: URL to stream (ex. http://hls.Roku.com/talks/xxx.m3u8)
'}
    
{
    Title: "NEGAH TV"
    streamFormat: "mp4"
    Logo: "pkg:/images/Logo PNG.png"
    Stream: "http://iptv.negahtv.com/negahtv/playlist.m3u8"
}


    
    
    
'##### Make sure all Channel content is above this line #####    
    ] 
    return arr
End Function

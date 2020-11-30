
'********** Copyright 2016 Roku Corp.  All Rights Reserved. **********

Library "Roku_Ads.brs"

sub Main()
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    
    m.adUrl = "https://iptv.negahtv.com/negahtv/playlist.m3u8"
    
    m.global = screen.getGlobalNode()
    m.global.addField("Model", "int", true)
    m.global.Model = 0
    m.global.addField("Options", "int", true)
    m.global.Options = 2
    m.global.addField("adTracker", "int", true)
    m.global.adTracker =0
    
    dev = createObject("roDeviceInfo")
    model = (Left(dev.GetModel(),1)).toInt()
    if model < 4
        m.global.Model = 1
    end if
    
    scene = screen.CreateScene("HomeScene")
    screen.show()
    
    m.RowList = scene.findNode("RowList")
    m.RowList.observeField("rowItemSelected", m.port)
    
    m.AdTimer = scene.findNode("AdTimer")
    m.AdTimer.observeField("fire", m.port)
    
    m.global.observeField("AdTracker", m.port)
    
    m.Video = scene.findNode("Video")
    RAF()

    while(true)
       msg = wait(0, m.port)
	   msgType = type(msg)
	   if m.global.AdTracker = 0
	       if msg.GetField() = "rowItemSelected" or msg.GetField() = "fire"
                RAF()
           end if
       end if
       if msgType = "roSGScreenEvent"
            print msg
            if msg.isScreenClosed() then return
       end if
    end while
end sub

Sub RAF()
    curPos = m.Video.position
    m.Video.control = "stop"
    adIface = Roku_Ads()
    adIface.setDebugOutput(true)
    adIface.setAdUrl(m.adUrl)
    adIface.setAdPrefs(true,2)
    adPods = adIface.getAds()
    playContent = true
    'render pre-roll ads
    if adPods <> invalid and adPods.count() > 0 then
        playContent = adIface.showAds(adPods)
        print playContent
    endif

    if playContent then 
        m.video.visible = true
        'stop
        m.video.content.PlayStart = curPos
        m.video.control = "play"
        m.global.AdTracker = 1
        m.AdTimer.control = "start"
    end if
End Sub

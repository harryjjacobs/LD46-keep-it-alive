local sounds = { }

function sounds:load()
    self.powerups = {
        slowMotionActivate = love.audio.newSource("assets/audio/SlowDown.mp3", "static"),
        slowMotionDectivate = love.audio.newSource("assets/audio/SpeedUp.mp3", "static"),
        groundAppear = love.audio.newSource("assets/audio/GroundAppear.mp3", "static")
    }
    self.ball = {
        bounce = love.audio.newSource("assets/audio/Bounce.mp3", "static")
    }
    self.ui = {
        click = love.audio.newSource("assets/audio/Click.mp3", "static")
    }
    self.music = {
        title = love.audio.newSource("assets/audio/Main Music.mp3", "stream"),
        main = love.audio.newSource("assets/audio/ShortMainMusic.mp3", "stream")
    }
    self.general = {
        yeah = love.audio.newSource("assets/audio/Yeah.mp3", "static"),
        hmmm = love.audio.newSource("assets/audio/1in1000.mp3", "static")
    }

    self.music.title:isLooping(true)
    self.music.main:isLooping(true)
    self.general.yeah:setVolume(0.07)
end

return sounds
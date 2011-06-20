#rem
'/*
'* Copyright (c) 2011, Damian Sinclair
'*
'* This is a port of Box2D by Erin Catto (box2d.org).
'* It is translated from the Flash port: Box2DFlash, by BorisTheBrave (http://www.box2dflash.org/).
'* Box2DFlash also credits Matt Bush and John Nesky as contributors.
'*
'* All rights reserved.
'* Redistribution and use in source and binary forms, with or without
'* modification, are permitted provided that the following conditions are met:
'*
'*   - Redistributions of source code must retain the above copyright
'*     notice, this list of conditions and the following disclaimer.
'*   - Redistributions in binary form must reproduce the above copyright
'*     notice, this list of conditions and the following disclaimer in the
'*     documentation and/or other materials provided with the distribution.
'*
'* THIS SOFTWARE IS PROVIDED BY THE MONKEYBOX2D PROJECT CONTRIBUTORS "AS IS" AND
'* ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
'* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
'* DISCLAIMED. IN NO EVENT SHALL THE MONKEYBOX2D PROJECT CONTRIBUTORS BE LIABLE
'* FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
'* DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
'* SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
'* CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
'* LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
'* OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
'* DAMAGE.
'*/
#end
Import box2d.collision
Import box2d.collision.shapes
Import box2d.dynamics.joints
Import box2d.common.math
Import box2d.dynamics.contacts
Import box2d.dynamics
Import box2d.demo.tests
Import box2d.flash.flashtypes
Import box2d.demo


Class MainDemo Extends App
    Const VersionString:String = "1.0.5"

    Const frameRate:Int = 30
    Const physicsRate:Int = 60
    Const physicsFrameMS:Float = 1000.0/physicsRate
    Field nextFrame:Float = 0.0

    Global m_display:FlashSprite = New FlashSprite()
    Global m_currTest:Test
    Global m_sprite:FlashSprite
    Global m_aboutText:TextField
    Global m_fpsCounter:FpsCounter
    Field m_currId :Int = 0
    Field m_input :Input
    Field tests : String[]
    
    Method OnRender()
        
        If ( m_currTest <> Null)
            m_currTest.OnRender()
        Else
            Cls()
        End
        m_display.OnRender(0,0)
    End
    
    Method OnCreate()
        tests = [
        "TestDominoStack", 
        "TestStack",
        "TestRagdoll",
        "TestCompound",
        "TestCrankGearsPulley",
        "TestBridge",
        "TestCCD",
        "TestTheoJansen",
        "TestBuoyancy",
        "TestOneSidedPlatform",
        "TestBreakable",
        "TestRaycast"]
        
        
        m_fpsCounter = New FpsCounter()
        m_fpsCounter.x = 7
        m_fpsCounter.y = 60
        m_display.AddChildAt(m_fpsCounter, 0)
        m_sprite = New FlashSprite()
        m_display.AddChild(m_sprite)
        
        '//Instructions Text
        Local instructions_text :TextField = New TextField()
        instructions_text.x = 7
        instructions_text.y = 5
        instructions_text.width = 495
        instructions_text.height = 61
        instructions_text.text = "Box2DMonkey " + VersionString + " - Left/Right arrows go to previous/next example. R to reset."
        m_display.AddChild(instructions_text)
        Local instructions_text2 :TextField = New TextField()
        instructions_text2.x = 7
        instructions_text2.y = 20
        instructions_text2.width = 495
        instructions_text2.height = 61
        instructions_text2.text = "Use the mouse to grab objects. Press D to delete the object under the pointer."
        m_display.AddChild(instructions_text2)
        
        m_aboutText = New TextField()
        m_aboutText.x = 7
        m_aboutText.y = 45
        m_aboutText.width = 300
        m_aboutText.height = 30
        m_display.AddChild(m_aboutText)
        
        SetUpdateRate(frameRate)
    End
    
    Method InitTest:Test( testName:String )
        Local ret:Test
        Select(testName)
            Case "TestDominoStack"
                ret = New TestDominoStack()
            Case "TestStack"
                ret = New TestStack()
            Case "TestRagdoll"
                ret = New TestRagdoll()
            Case "TestCompound"
                ret = New TestCompound()
            Case "TestCrankGearsPulley"
                ret = New TestCrankGearsPulley()
            Case "TestBridge"
                ret = New TestBridge()
            Case "TestCCD"
                ret = New TestCCD()
            Case "TestTheoJansen"
                ret = New TestTheoJansen()
            Case "TestBuoyancy"
                ret = New TestBuoyancy()
            Case "TestOneSidedPlatform"
                ret = New TestOneSidedPlatform()
            Case "TestBreakable"
                ret = New TestBreakable()
            Case "TestRaycast"
                ret = New TestRaycast()
            End
            Return ret
        End
        Method OnUpdate ()
            '// toggle between tests
            If ( KeyHit(39))
                '// Right Arrow
                m_currId += 1
                m_currTest = null
            Else If ( KeyHit(37))
                '// Left Arrow
                m_currId -= 1
                m_currTest = null
            Else If ( KeyHit(82))
                '// R
                m_currTest = null
            End
            
            If m_currId < 0
                m_currId = tests.Length - 1
            End
            If m_currId >= tests.Length
                m_currId = 0
            End
            
            '// if null, set New test
            If ( m_currTest = Null)
                m_currTest = InitTest(tests[m_currId])
                m_aboutText.text = m_currTest.name
            End
            
            Local ms = Millisecs()
            If nextFrame = 0.0
                nextFrame = Float(ms)
            End
            
            While nextFrame < ms 
	            '// update current test
	            m_currTest.Update()
	            '// update counter
	            m_fpsCounter.Update()
	            nextFrame += physicsFrameMS
            End
        End
        
        
    End
    
    
    
    
    
    
    
    
    
    
    
    
    
    

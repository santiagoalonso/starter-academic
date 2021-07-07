#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
This experiment was created using PsychoPy3 Experiment Builder (v2021.1.4),
    on July 07, 2021, at 16:25
If you publish work using this script the most relevant publication is:

    Peirce J, Gray JR, Simpson S, MacAskill M, Höchenberger R, Sogo H, Kastman E, Lindeløv JK. (2019) 
        PsychoPy2: Experiments in behavior made easy Behav Res 51: 195. 
        https://doi.org/10.3758/s13428-018-01193-y

"""

from __future__ import absolute_import, division

from psychopy import locale_setup
from psychopy import prefs
from psychopy import sound, gui, visual, core, data, event, logging, clock, colors
from psychopy.constants import (NOT_STARTED, STARTED, PLAYING, PAUSED,
                                STOPPED, FINISHED, PRESSED, RELEASED, FOREVER)

import numpy as np  # whole numpy lib is available, prepend 'np.'
from numpy import (sin, cos, tan, log, log10, pi, average,
                   sqrt, std, deg2rad, rad2deg, linspace, asarray)
from numpy.random import random, randint, normal, shuffle, choice as randchoice
import os  # handy system and path functions
import sys  # to get file system encoding

from psychopy.hardware import keyboard



# Ensure that relative paths start from the same directory as this script
_thisDir = os.path.dirname(os.path.abspath(__file__))
os.chdir(_thisDir)

# Store info about the experiment session
psychopyVersion = '2021.1.4'
expName = 'YOUNSTE'  # from the Builder filename that created this script
expInfo = {'Cedula': ''}
dlg = gui.DlgFromDict(dictionary=expInfo, sortKeys=False, title=expName)
if dlg.OK == False:
    core.quit()  # user pressed cancel
expInfo['date'] = data.getDateStr()  # add a simple timestamp
expInfo['expName'] = expName
expInfo['psychopyVersion'] = psychopyVersion

# Data file name stem = absolute path + name; later add .psyexp, .csv, .log, etc
filename = _thisDir + os.sep + u'data/%s_%s_%s' % (expInfo['Cedula'], expName, expInfo['date'])

# An ExperimentHandler isn't essential but helps with data saving
thisExp = data.ExperimentHandler(name=expName, version='',
    extraInfo=expInfo, runtimeInfo=None,
    originPath='E:\\Github Repos\\starter-academic\\content\\post\\Psychopy_Trajectories\\Ppy\\Example_Traj_lastrun.py',
    savePickle=True, saveWideText=True,
    dataFileName=filename)
# save a log file for detail verbose info
logFile = logging.LogFile(filename+'.log', level=logging.EXP)
logging.console.setLevel(logging.WARNING)  # this outputs to the screen, not a file

endExpNow = False  # flag for 'escape' or other condition => quit the exp
frameTolerance = 0.001  # how close to onset before 'same' frame

# Start Code - component code to be run after the window creation

# Setup the Window
win = visual.Window(
    size=[1900, 1060], fullscr=False, screen=0, 
    winType='pyglet', allowGUI=True, allowStencil=False,
    monitor='testMonitor', color=[0,0,0], colorSpace='rgb',
    blendMode='avg', useFBO=True, 
    units='norm')
# store frame rate of monitor if we can measure it
expInfo['frameRate'] = win.getActualFrameRate()
if expInfo['frameRate'] != None:
    frameDur = 1.0 / round(expInfo['frameRate'])
else:
    frameDur = 1.0 / 60.0  # could not measure, so guess

# create a default keyboard (e.g. to check for escape)
defaultKeyboard = keyboard.Keyboard()

# Initialize components for Routine "Instructions"
InstructionsClock = core.Clock()
Instr_CategCaras_text = visual.TextStim(win=win, name='Instr_CategCaras_text',
    text='',
    font='Open Sans',
    pos=(0, 0), height=0.06, wrapWidth=None, ori=0.0, 
    color='white', colorSpace='rgb', opacity=None, 
    languageStyle='LTR',
    depth=0.0);
wind = Instr_CategCaras_text.win
stf = wind.size[1]/wind.size[0]
Next_button_CategCaras_image = visual.ImageStim(
    win=win,
    name='Next_button_CategCaras_image', 
    image='Images/next_button.png', mask=None,
    ori=0.0, pos=(0.8, -0.8), size=(0.25*stf, 0.25),
    color=[1,1,1], colorSpace='rgb', opacity=None,
    flipHoriz=False, flipVert=False,
    texRes=128.0, interpolate=True, depth=-2.0)
Instr_CategCaras_mouse = event.Mouse(win=win)
x, y = [None, None]
Instr_CategCaras_mouse.mouseClock = core.Clock()

# Initialize components for Routine "Train_Img_CategCaras"
Train_Img_CategCarasClock = core.Clock()
FruitVeg_image = visual.ImageStim(
    win=win,
    name='FruitVeg_image', 
    image='sin', mask=None,
    ori=0.0, pos=(0, 0), size=(0.5*stf, 0.5),
    color=[1,1,1], colorSpace='rgb', opacity=None,
    flipHoriz=False, flipVert=False,
    texRes=128.0, interpolate=True, depth=0.0)

# Initialize components for Routine "Train_CategCaras"
Train_CategCarasClock = core.Clock()
FingerLift_penalty = 5 #(seconds)
Mouse_tol = 0.5 #to detect finger jumps (norm. units) 
Train_CategCaras_mouse = event.Mouse(win=win)
x, y = [None, None]
Train_CategCaras_mouse.mouseClock = core.Clock()
Train_CategCaras_Beh_mouse = event.Mouse(win=win)
x, y = [None, None]
Train_CategCaras_Beh_mouse.mouseClock = core.Clock()
Train_CategCaras_Izq_polygon = visual.Rect(
    win=win, name='Train_CategCaras_Izq_polygon',
    width=(0.25*stf, 0.25)[0], height=(0.25*stf, 0.25)[1],
    ori=0.0, pos=(-0.75, 0.75),
    lineWidth=1.0,     colorSpace='rgb',  lineColor=(-1.0000, -1.0000, -1.0000), fillColor='white',
    opacity=None, depth=-3.0, interpolate=True)
Train_CategCaras_Der_polygon = visual.Rect(
    win=win, name='Train_CategCaras_Der_polygon',
    width=(0.25*stf, 0.25)[0], height=(0.25*stf, 0.25)[1],
    ori=0.0, pos=(0.75, 0.75),
    lineWidth=1.0,     colorSpace='rgb',  lineColor=(-1.0000, -1.0000, -1.0000), fillColor='white',
    opacity=None, depth=-4.0, interpolate=True)
Train_CategCaras_Inferior_polygon = visual.Rect(
    win=win, name='Train_CategCaras_Inferior_polygon',
    width=(0.25*stf, 0.25)[0], height=(0.25*stf, 0.25)[1],
    ori=0.0, pos=(0, -0.8),
    lineWidth=1.0,     colorSpace='rgb',  lineColor=(-1.0000, -1.0000, -1.0000), fillColor='white',
    opacity=None, depth=-5.0, interpolate=True)
Train_CategCaras_Male_text = visual.TextStim(win=win, name='Train_CategCaras_Male_text',
    text='Fruta',
    font='Open Sans',
    pos=(-0.75, 0.5), height=0.08, wrapWidth=None, ori=0.0, 
    color='white', colorSpace='rgb', opacity=None, 
    languageStyle='LTR',
    depth=-6.0);
Train_CategCaras_Female_text = visual.TextStim(win=win, name='Train_CategCaras_Female_text',
    text='Verdura',
    font='Open Sans',
    pos=(0.75, 0.5), height=0.08, wrapWidth=None, ori=0.0, 
    color='white', colorSpace='rgb', opacity=None, 
    languageStyle='LTR',
    depth=-7.0);

# Initialize components for Routine "NoLiftFinger_Warning"
NoLiftFinger_WarningClock = core.Clock()
NoLiftFinger_Warning_text = visual.TextStim(win=win, name='NoLiftFinger_Warning_text',
    text='Cuando escoja no levante el dedo. ',
    font='Open Sans',
    pos=(0, 0), height=0.1, wrapWidth=None, ori=0.0, 
    color='white', colorSpace='rgb', opacity=None, 
    languageStyle='LTR',
    depth=0.0);

# Initialize components for Routine "Thanks"
ThanksClock = core.Clock()
Thanks_text = visual.TextStim(win=win, name='Thanks_text',
    text='Gracias por su participación. ',
    font='Open Sans',
    pos=(0, 0), height=0.1, wrapWidth=None, ori=0.0, 
    color='white', colorSpace='rgb', opacity=None, 
    languageStyle='LTR',
    depth=0.0);

# Create some handy timers
globalClock = core.Clock()  # to track the time since experiment started
routineTimer = core.CountdownTimer()  # to track time remaining of each (non-slip) routine 

# set up handler to look after randomisation of conditions etc
Trials_Instr_CategCaras = data.TrialHandler(nReps=1.0, method='sequential', 
    extraInfo=expInfo, originPath=-1,
    trialList=data.importConditions('CategCaras_instr.xlsx'),
    seed=None, name='Trials_Instr_CategCaras')
thisExp.addLoop(Trials_Instr_CategCaras)  # add the loop to the experiment
thisTrials_Instr_CategCara = Trials_Instr_CategCaras.trialList[0]  # so we can initialise stimuli with some values
# abbreviate parameter names if possible (e.g. rgb = thisTrials_Instr_CategCara.rgb)
if thisTrials_Instr_CategCara != None:
    for paramName in thisTrials_Instr_CategCara:
        exec('{} = thisTrials_Instr_CategCara[paramName]'.format(paramName))

for thisTrials_Instr_CategCara in Trials_Instr_CategCaras:
    currentLoop = Trials_Instr_CategCaras
    # abbreviate parameter names if possible (e.g. rgb = thisTrials_Instr_CategCara.rgb)
    if thisTrials_Instr_CategCara != None:
        for paramName in thisTrials_Instr_CategCara:
            exec('{} = thisTrials_Instr_CategCara[paramName]'.format(paramName))
    
    # ------Prepare to start Routine "Instructions"-------
    continueRoutine = True
    # update component parameters for each repeat
    Instr_CategCaras_text.setText(I_CategCaras)
    wind = Instr_CategCaras_text.win
    stf = wind.size[1]/wind.size[0]
    # setup some python lists for storing info about the Instr_CategCaras_mouse
    Instr_CategCaras_mouse.clicked_name = []
    gotValidClick = False  # until a click is received
    # keep track of which components have finished
    InstructionsComponents = [Instr_CategCaras_text, Next_button_CategCaras_image, Instr_CategCaras_mouse]
    for thisComponent in InstructionsComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    InstructionsClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "Instructions"-------
    while continueRoutine:
        # get current time
        t = InstructionsClock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=InstructionsClock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *Instr_CategCaras_text* updates
        if Instr_CategCaras_text.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            Instr_CategCaras_text.frameNStart = frameN  # exact frame index
            Instr_CategCaras_text.tStart = t  # local t and not account for scr refresh
            Instr_CategCaras_text.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(Instr_CategCaras_text, 'tStartRefresh')  # time at next scr refresh
            Instr_CategCaras_text.setAutoDraw(True)
        wind = Instr_CategCaras_text.win
        stf = wind.size[1]/wind.size[0]
        
        # *Next_button_CategCaras_image* updates
        if Next_button_CategCaras_image.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            Next_button_CategCaras_image.frameNStart = frameN  # exact frame index
            Next_button_CategCaras_image.tStart = t  # local t and not account for scr refresh
            Next_button_CategCaras_image.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(Next_button_CategCaras_image, 'tStartRefresh')  # time at next scr refresh
            Next_button_CategCaras_image.setAutoDraw(True)
        # *Instr_CategCaras_mouse* updates
        if Instr_CategCaras_mouse.status == NOT_STARTED and t >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            Instr_CategCaras_mouse.frameNStart = frameN  # exact frame index
            Instr_CategCaras_mouse.tStart = t  # local t and not account for scr refresh
            Instr_CategCaras_mouse.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(Instr_CategCaras_mouse, 'tStartRefresh')  # time at next scr refresh
            Instr_CategCaras_mouse.status = STARTED
            Instr_CategCaras_mouse.mouseClock.reset()
            prevButtonState = Instr_CategCaras_mouse.getPressed()  # if button is down already this ISN'T a new click
        if Instr_CategCaras_mouse.status == STARTED:  # only update if started and not finished!
            buttons = Instr_CategCaras_mouse.getPressed()
            if buttons != prevButtonState:  # button state changed?
                prevButtonState = buttons
                if sum(buttons) > 0:  # state changed to a new click
                    # check if the mouse was inside our 'clickable' objects
                    gotValidClick = False
                    for obj in [Next_button_CategCaras_image,]:
                        if obj.contains(Instr_CategCaras_mouse):
                            gotValidClick = True
                            Instr_CategCaras_mouse.clicked_name.append(obj.name)
                    if gotValidClick:  # abort routine on response
                        continueRoutine = False
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in InstructionsComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "Instructions"-------
    for thisComponent in InstructionsComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    Trials_Instr_CategCaras.addData('Instr_CategCaras_text.started', Instr_CategCaras_text.tStartRefresh)
    Trials_Instr_CategCaras.addData('Instr_CategCaras_text.stopped', Instr_CategCaras_text.tStopRefresh)
    wind = Instr_CategCaras_text.win
    stf = wind.size[1]/wind.size[0]
    Trials_Instr_CategCaras.addData('Next_button_CategCaras_image.started', Next_button_CategCaras_image.tStartRefresh)
    Trials_Instr_CategCaras.addData('Next_button_CategCaras_image.stopped', Next_button_CategCaras_image.tStopRefresh)
    # store data for Trials_Instr_CategCaras (TrialHandler)
    x, y = Instr_CategCaras_mouse.getPos()
    buttons = Instr_CategCaras_mouse.getPressed()
    if sum(buttons):
        # check if the mouse was inside our 'clickable' objects
        gotValidClick = False
        for obj in [Next_button_CategCaras_image,]:
            if obj.contains(Instr_CategCaras_mouse):
                gotValidClick = True
                Instr_CategCaras_mouse.clicked_name.append(obj.name)
    Trials_Instr_CategCaras.addData('Instr_CategCaras_mouse.x', x)
    Trials_Instr_CategCaras.addData('Instr_CategCaras_mouse.y', y)
    Trials_Instr_CategCaras.addData('Instr_CategCaras_mouse.leftButton', buttons[0])
    Trials_Instr_CategCaras.addData('Instr_CategCaras_mouse.midButton', buttons[1])
    Trials_Instr_CategCaras.addData('Instr_CategCaras_mouse.rightButton', buttons[2])
    if len(Instr_CategCaras_mouse.clicked_name):
        Trials_Instr_CategCaras.addData('Instr_CategCaras_mouse.clicked_name', Instr_CategCaras_mouse.clicked_name[0])
    Trials_Instr_CategCaras.addData('Instr_CategCaras_mouse.started', Instr_CategCaras_mouse.tStart)
    Trials_Instr_CategCaras.addData('Instr_CategCaras_mouse.stopped', Instr_CategCaras_mouse.tStop)
    # the Routine "Instructions" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    thisExp.nextEntry()
    
# completed 1.0 repeats of 'Trials_Instr_CategCaras'


# set up handler to look after randomisation of conditions etc
Trials_Train_CategCaras = data.TrialHandler(nReps=1.0, method='random', 
    extraInfo=expInfo, originPath=-1,
    trialList=data.importConditions('CategCaras_Train_imgs.xlsx'),
    seed=None, name='Trials_Train_CategCaras')
thisExp.addLoop(Trials_Train_CategCaras)  # add the loop to the experiment
thisTrials_Train_CategCara = Trials_Train_CategCaras.trialList[0]  # so we can initialise stimuli with some values
# abbreviate parameter names if possible (e.g. rgb = thisTrials_Train_CategCara.rgb)
if thisTrials_Train_CategCara != None:
    for paramName in thisTrials_Train_CategCara:
        exec('{} = thisTrials_Train_CategCara[paramName]'.format(paramName))

for thisTrials_Train_CategCara in Trials_Train_CategCaras:
    currentLoop = Trials_Train_CategCaras
    # abbreviate parameter names if possible (e.g. rgb = thisTrials_Train_CategCara.rgb)
    if thisTrials_Train_CategCara != None:
        for paramName in thisTrials_Train_CategCara:
            exec('{} = thisTrials_Train_CategCara[paramName]'.format(paramName))
    
    # ------Prepare to start Routine "Train_Img_CategCaras"-------
    continueRoutine = True
    routineTimer.add(1.000000)
    # update component parameters for each repeat
    FruitVeg_image.setImage(Train_CategCaras_img_file)
    # keep track of which components have finished
    Train_Img_CategCarasComponents = [FruitVeg_image]
    for thisComponent in Train_Img_CategCarasComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    Train_Img_CategCarasClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "Train_Img_CategCaras"-------
    while continueRoutine and routineTimer.getTime() > 0:
        # get current time
        t = Train_Img_CategCarasClock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=Train_Img_CategCarasClock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *FruitVeg_image* updates
        if FruitVeg_image.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            FruitVeg_image.frameNStart = frameN  # exact frame index
            FruitVeg_image.tStart = t  # local t and not account for scr refresh
            FruitVeg_image.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(FruitVeg_image, 'tStartRefresh')  # time at next scr refresh
            FruitVeg_image.setAutoDraw(True)
        if FruitVeg_image.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > FruitVeg_image.tStartRefresh + 1.0-frameTolerance:
                # keep track of stop time/frame for later
                FruitVeg_image.tStop = t  # not accounting for scr refresh
                FruitVeg_image.frameNStop = frameN  # exact frame index
                win.timeOnFlip(FruitVeg_image, 'tStopRefresh')  # time at next scr refresh
                FruitVeg_image.setAutoDraw(False)
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in Train_Img_CategCarasComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "Train_Img_CategCaras"-------
    for thisComponent in Train_Img_CategCarasComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    Trials_Train_CategCaras.addData('FruitVeg_image.started', FruitVeg_image.tStartRefresh)
    Trials_Train_CategCaras.addData('FruitVeg_image.stopped', FruitVeg_image.tStopRefresh)
    
    # ------Prepare to start Routine "Train_CategCaras"-------
    continueRoutine = True
    # update component parameters for each repeat
    Options_Appear = False
    RT = -999999 #response time (no longer in bottom square - time finger arrived to bottom square)
    Finger_Jump = -1
    penalty = 0
    x0 = 999 #Initialize
    y0 = 9999
    x1 = 999
    y1 = 999
    # setup some python lists for storing info about the Train_CategCaras_mouse
    Train_CategCaras_mouse.x = []
    Train_CategCaras_mouse.y = []
    Train_CategCaras_mouse.leftButton = []
    Train_CategCaras_mouse.midButton = []
    Train_CategCaras_mouse.rightButton = []
    Train_CategCaras_mouse.time = []
    gotValidClick = False  # until a click is received
    # setup some python lists for storing info about the Train_CategCaras_Beh_mouse
    Train_CategCaras_Beh_mouse.x = []
    Train_CategCaras_Beh_mouse.y = []
    Train_CategCaras_Beh_mouse.leftButton = []
    Train_CategCaras_Beh_mouse.midButton = []
    Train_CategCaras_Beh_mouse.rightButton = []
    Train_CategCaras_Beh_mouse.time = []
    gotValidClick = False  # until a click is received
    # keep track of which components have finished
    Train_CategCarasComponents = [Train_CategCaras_mouse, Train_CategCaras_Beh_mouse, Train_CategCaras_Izq_polygon, Train_CategCaras_Der_polygon, Train_CategCaras_Inferior_polygon, Train_CategCaras_Male_text, Train_CategCaras_Female_text]
    for thisComponent in Train_CategCarasComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    Train_CategCarasClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "Train_CategCaras"-------
    while continueRoutine:
        # get current time
        t = Train_CategCarasClock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=Train_CategCarasClock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        if Train_CategCaras_Inferior_polygon.contains(Train_CategCaras_mouse):
            Options_Appear = True
        
        if (RT < 0 ) & (Options_Appear==True) & (not Train_CategCaras_Inferior_polygon.contains(Train_CategCaras_mouse)):
            RT = Train_CategCaras_Beh_mouse.mouseClock.getTime()
            Trials_Train_CategCaras.addData('Train_CategCaras.RT', RT)
        
        if Options_Appear & Train_CategCaras_Izq_polygon.contains(Train_CategCaras_mouse):
            Trials_Train_CategCaras.addData('Train_CategCaras.Response', "Fruta")
            continueRoutine = False
        
        if Options_Appear & Train_CategCaras_Der_polygon.contains(Train_CategCaras_mouse):
            Trials_Train_CategCaras.addData('Train_CategCaras.Response', "Verdura")
            continueRoutine = False
        
        if Options_Appear == True:
            if Finger_Jump < 0:
                x0, y0 = Train_CategCaras_mouse.getPos()
                Finger_Jump = 0
            elif Finger_Jump == 0:
                x1, y1 = Train_CategCaras_mouse.getPos()
                if abs(y1-y0) > Mouse_tol or abs(x1-x0) > Mouse_tol:
                    Finger_Jump = 1
                    penalty = FingerLift_penalty
                    Trials_Train_CategCaras.addData('Train_CategCaras.FingerJump', Finger_Jump)
                    continueRoutine = False
                else:
                   x0, y0 = Train_CategCaras_mouse.getPos() 
        
        
        
        
        # *Train_CategCaras_mouse* updates
        if Train_CategCaras_mouse.status == NOT_STARTED and t >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            Train_CategCaras_mouse.frameNStart = frameN  # exact frame index
            Train_CategCaras_mouse.tStart = t  # local t and not account for scr refresh
            Train_CategCaras_mouse.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(Train_CategCaras_mouse, 'tStartRefresh')  # time at next scr refresh
            Train_CategCaras_mouse.status = STARTED
            Train_CategCaras_mouse.mouseClock.reset()
            prevButtonState = Train_CategCaras_mouse.getPressed()  # if button is down already this ISN'T a new click
        if Train_CategCaras_mouse.status == STARTED:  # only update if started and not finished!
            x, y = Train_CategCaras_mouse.getPos()
            Train_CategCaras_mouse.x.append(x)
            Train_CategCaras_mouse.y.append(y)
            buttons = Train_CategCaras_mouse.getPressed()
            Train_CategCaras_mouse.leftButton.append(buttons[0])
            Train_CategCaras_mouse.midButton.append(buttons[1])
            Train_CategCaras_mouse.rightButton.append(buttons[2])
            Train_CategCaras_mouse.time.append(Train_CategCaras_mouse.mouseClock.getTime())
        # *Train_CategCaras_Beh_mouse* updates
        if Train_CategCaras_Beh_mouse.status == NOT_STARTED and Options_Appear:
            # keep track of start time/frame for later
            Train_CategCaras_Beh_mouse.frameNStart = frameN  # exact frame index
            Train_CategCaras_Beh_mouse.tStart = t  # local t and not account for scr refresh
            Train_CategCaras_Beh_mouse.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(Train_CategCaras_Beh_mouse, 'tStartRefresh')  # time at next scr refresh
            Train_CategCaras_Beh_mouse.status = STARTED
            Train_CategCaras_Beh_mouse.mouseClock.reset()
            prevButtonState = Train_CategCaras_Beh_mouse.getPressed()  # if button is down already this ISN'T a new click
        if Train_CategCaras_Beh_mouse.status == STARTED:  # only update if started and not finished!
            x, y = Train_CategCaras_Beh_mouse.getPos()
            Train_CategCaras_Beh_mouse.x.append(x)
            Train_CategCaras_Beh_mouse.y.append(y)
            buttons = Train_CategCaras_Beh_mouse.getPressed()
            Train_CategCaras_Beh_mouse.leftButton.append(buttons[0])
            Train_CategCaras_Beh_mouse.midButton.append(buttons[1])
            Train_CategCaras_Beh_mouse.rightButton.append(buttons[2])
            Train_CategCaras_Beh_mouse.time.append(Train_CategCaras_Beh_mouse.mouseClock.getTime())
        
        # *Train_CategCaras_Izq_polygon* updates
        if Train_CategCaras_Izq_polygon.status == NOT_STARTED and Options_Appear:
            # keep track of start time/frame for later
            Train_CategCaras_Izq_polygon.frameNStart = frameN  # exact frame index
            Train_CategCaras_Izq_polygon.tStart = t  # local t and not account for scr refresh
            Train_CategCaras_Izq_polygon.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(Train_CategCaras_Izq_polygon, 'tStartRefresh')  # time at next scr refresh
            Train_CategCaras_Izq_polygon.setAutoDraw(True)
        
        # *Train_CategCaras_Der_polygon* updates
        if Train_CategCaras_Der_polygon.status == NOT_STARTED and Options_Appear:
            # keep track of start time/frame for later
            Train_CategCaras_Der_polygon.frameNStart = frameN  # exact frame index
            Train_CategCaras_Der_polygon.tStart = t  # local t and not account for scr refresh
            Train_CategCaras_Der_polygon.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(Train_CategCaras_Der_polygon, 'tStartRefresh')  # time at next scr refresh
            Train_CategCaras_Der_polygon.setAutoDraw(True)
        
        # *Train_CategCaras_Inferior_polygon* updates
        if Train_CategCaras_Inferior_polygon.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            Train_CategCaras_Inferior_polygon.frameNStart = frameN  # exact frame index
            Train_CategCaras_Inferior_polygon.tStart = t  # local t and not account for scr refresh
            Train_CategCaras_Inferior_polygon.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(Train_CategCaras_Inferior_polygon, 'tStartRefresh')  # time at next scr refresh
            Train_CategCaras_Inferior_polygon.setAutoDraw(True)
        
        # *Train_CategCaras_Male_text* updates
        if Train_CategCaras_Male_text.status == NOT_STARTED and Options_Appear:
            # keep track of start time/frame for later
            Train_CategCaras_Male_text.frameNStart = frameN  # exact frame index
            Train_CategCaras_Male_text.tStart = t  # local t and not account for scr refresh
            Train_CategCaras_Male_text.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(Train_CategCaras_Male_text, 'tStartRefresh')  # time at next scr refresh
            Train_CategCaras_Male_text.setAutoDraw(True)
        
        # *Train_CategCaras_Female_text* updates
        if Train_CategCaras_Female_text.status == NOT_STARTED and Options_Appear:
            # keep track of start time/frame for later
            Train_CategCaras_Female_text.frameNStart = frameN  # exact frame index
            Train_CategCaras_Female_text.tStart = t  # local t and not account for scr refresh
            Train_CategCaras_Female_text.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(Train_CategCaras_Female_text, 'tStartRefresh')  # time at next scr refresh
            Train_CategCaras_Female_text.setAutoDraw(True)
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in Train_CategCarasComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "Train_CategCaras"-------
    for thisComponent in Train_CategCarasComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    MT = Train_CategCaras_Beh_mouse.mouseClock.getTime() - RT
    Trials_Train_CategCaras.addData('Train_CategCaras.MT', MT)
    # store data for Trials_Train_CategCaras (TrialHandler)
    Trials_Train_CategCaras.addData('Train_CategCaras_mouse.x', Train_CategCaras_mouse.x)
    Trials_Train_CategCaras.addData('Train_CategCaras_mouse.y', Train_CategCaras_mouse.y)
    Trials_Train_CategCaras.addData('Train_CategCaras_mouse.leftButton', Train_CategCaras_mouse.leftButton)
    Trials_Train_CategCaras.addData('Train_CategCaras_mouse.midButton', Train_CategCaras_mouse.midButton)
    Trials_Train_CategCaras.addData('Train_CategCaras_mouse.rightButton', Train_CategCaras_mouse.rightButton)
    Trials_Train_CategCaras.addData('Train_CategCaras_mouse.time', Train_CategCaras_mouse.time)
    Trials_Train_CategCaras.addData('Train_CategCaras_mouse.started', Train_CategCaras_mouse.tStart)
    Trials_Train_CategCaras.addData('Train_CategCaras_mouse.stopped', Train_CategCaras_mouse.tStop)
    # store data for Trials_Train_CategCaras (TrialHandler)
    Trials_Train_CategCaras.addData('Train_CategCaras_Beh_mouse.x', Train_CategCaras_Beh_mouse.x)
    Trials_Train_CategCaras.addData('Train_CategCaras_Beh_mouse.y', Train_CategCaras_Beh_mouse.y)
    Trials_Train_CategCaras.addData('Train_CategCaras_Beh_mouse.leftButton', Train_CategCaras_Beh_mouse.leftButton)
    Trials_Train_CategCaras.addData('Train_CategCaras_Beh_mouse.midButton', Train_CategCaras_Beh_mouse.midButton)
    Trials_Train_CategCaras.addData('Train_CategCaras_Beh_mouse.rightButton', Train_CategCaras_Beh_mouse.rightButton)
    Trials_Train_CategCaras.addData('Train_CategCaras_Beh_mouse.time', Train_CategCaras_Beh_mouse.time)
    Trials_Train_CategCaras.addData('Train_CategCaras_Beh_mouse.started', Train_CategCaras_Beh_mouse.tStart)
    Trials_Train_CategCaras.addData('Train_CategCaras_Beh_mouse.stopped', Train_CategCaras_Beh_mouse.tStop)
    Trials_Train_CategCaras.addData('Train_CategCaras_Izq_polygon.started', Train_CategCaras_Izq_polygon.tStartRefresh)
    Trials_Train_CategCaras.addData('Train_CategCaras_Izq_polygon.stopped', Train_CategCaras_Izq_polygon.tStopRefresh)
    Trials_Train_CategCaras.addData('Train_CategCaras_Der_polygon.started', Train_CategCaras_Der_polygon.tStartRefresh)
    Trials_Train_CategCaras.addData('Train_CategCaras_Der_polygon.stopped', Train_CategCaras_Der_polygon.tStopRefresh)
    Trials_Train_CategCaras.addData('Train_CategCaras_Inferior_polygon.started', Train_CategCaras_Inferior_polygon.tStartRefresh)
    Trials_Train_CategCaras.addData('Train_CategCaras_Inferior_polygon.stopped', Train_CategCaras_Inferior_polygon.tStopRefresh)
    Trials_Train_CategCaras.addData('Train_CategCaras_Male_text.started', Train_CategCaras_Male_text.tStartRefresh)
    Trials_Train_CategCaras.addData('Train_CategCaras_Male_text.stopped', Train_CategCaras_Male_text.tStopRefresh)
    Trials_Train_CategCaras.addData('Train_CategCaras_Female_text.started', Train_CategCaras_Female_text.tStartRefresh)
    Trials_Train_CategCaras.addData('Train_CategCaras_Female_text.stopped', Train_CategCaras_Female_text.tStopRefresh)
    # the Routine "Train_CategCaras" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    
    # ------Prepare to start Routine "NoLiftFinger_Warning"-------
    continueRoutine = True
    # update component parameters for each repeat
    # keep track of which components have finished
    NoLiftFinger_WarningComponents = [NoLiftFinger_Warning_text]
    for thisComponent in NoLiftFinger_WarningComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    # reset timers
    t = 0
    _timeToFirstFrame = win.getFutureFlipTime(clock="now")
    NoLiftFinger_WarningClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
    frameN = -1
    
    # -------Run Routine "NoLiftFinger_Warning"-------
    while continueRoutine:
        # get current time
        t = NoLiftFinger_WarningClock.getTime()
        tThisFlip = win.getFutureFlipTime(clock=NoLiftFinger_WarningClock)
        tThisFlipGlobal = win.getFutureFlipTime(clock=None)
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *NoLiftFinger_Warning_text* updates
        if NoLiftFinger_Warning_text.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
            # keep track of start time/frame for later
            NoLiftFinger_Warning_text.frameNStart = frameN  # exact frame index
            NoLiftFinger_Warning_text.tStart = t  # local t and not account for scr refresh
            NoLiftFinger_Warning_text.tStartRefresh = tThisFlipGlobal  # on global time
            win.timeOnFlip(NoLiftFinger_Warning_text, 'tStartRefresh')  # time at next scr refresh
            NoLiftFinger_Warning_text.setAutoDraw(True)
        if NoLiftFinger_Warning_text.status == STARTED:
            # is it time to stop? (based on global clock, using actual start)
            if tThisFlipGlobal > NoLiftFinger_Warning_text.tStartRefresh + penalty-frameTolerance:
                # keep track of stop time/frame for later
                NoLiftFinger_Warning_text.tStop = t  # not accounting for scr refresh
                NoLiftFinger_Warning_text.frameNStop = frameN  # exact frame index
                win.timeOnFlip(NoLiftFinger_Warning_text, 'tStopRefresh')  # time at next scr refresh
                NoLiftFinger_Warning_text.setAutoDraw(False)
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in NoLiftFinger_WarningComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "NoLiftFinger_Warning"-------
    for thisComponent in NoLiftFinger_WarningComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    Trials_Train_CategCaras.addData('NoLiftFinger_Warning_text.started', NoLiftFinger_Warning_text.tStartRefresh)
    Trials_Train_CategCaras.addData('NoLiftFinger_Warning_text.stopped', NoLiftFinger_Warning_text.tStopRefresh)
    # the Routine "NoLiftFinger_Warning" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    thisExp.nextEntry()
    
# completed 1.0 repeats of 'Trials_Train_CategCaras'


# ------Prepare to start Routine "Thanks"-------
continueRoutine = True
routineTimer.add(4.000000)
# update component parameters for each repeat
# keep track of which components have finished
ThanksComponents = [Thanks_text]
for thisComponent in ThanksComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED
# reset timers
t = 0
_timeToFirstFrame = win.getFutureFlipTime(clock="now")
ThanksClock.reset(-_timeToFirstFrame)  # t0 is time of first possible flip
frameN = -1

# -------Run Routine "Thanks"-------
while continueRoutine and routineTimer.getTime() > 0:
    # get current time
    t = ThanksClock.getTime()
    tThisFlip = win.getFutureFlipTime(clock=ThanksClock)
    tThisFlipGlobal = win.getFutureFlipTime(clock=None)
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *Thanks_text* updates
    if Thanks_text.status == NOT_STARTED and tThisFlip >= 0.0-frameTolerance:
        # keep track of start time/frame for later
        Thanks_text.frameNStart = frameN  # exact frame index
        Thanks_text.tStart = t  # local t and not account for scr refresh
        Thanks_text.tStartRefresh = tThisFlipGlobal  # on global time
        win.timeOnFlip(Thanks_text, 'tStartRefresh')  # time at next scr refresh
        Thanks_text.setAutoDraw(True)
    if Thanks_text.status == STARTED:
        # is it time to stop? (based on global clock, using actual start)
        if tThisFlipGlobal > Thanks_text.tStartRefresh + 4.0-frameTolerance:
            # keep track of stop time/frame for later
            Thanks_text.tStop = t  # not accounting for scr refresh
            Thanks_text.frameNStop = frameN  # exact frame index
            win.timeOnFlip(Thanks_text, 'tStopRefresh')  # time at next scr refresh
            Thanks_text.setAutoDraw(False)
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in ThanksComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "Thanks"-------
for thisComponent in ThanksComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
thisExp.addData('Thanks_text.started', Thanks_text.tStartRefresh)
thisExp.addData('Thanks_text.stopped', Thanks_text.tStopRefresh)

# Flip one final time so any remaining win.callOnFlip() 
# and win.timeOnFlip() tasks get executed before quitting
win.flip()

# these shouldn't be strictly necessary (should auto-save)
thisExp.saveAsWideText(filename+'.csv', delim='auto')
thisExp.saveAsPickle(filename)
logging.flush()
# make sure everything is closed down
thisExp.abort()  # or data files will save again on exit
win.close()
core.quit()

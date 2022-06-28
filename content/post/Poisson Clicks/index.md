---
# Documentation: https://wowchemy.com/docs/managing-content/

title: "Poisson Clicks (Python)"
subtitle: ""
summary: ""
authors: []
tags: []
categories: []
date: 2022-06-24T08:51:25-05:00
lastmod: 2022-06-24T08:51:25-05:00
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: ""
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
---

# Español (English below; by Google translate)

Es usual estudiar cognición numérica con estimulos visuales. Hay excepciones claro está, pero es usual. Los estimulos sonoros también se pueden usar para estudiar cognición numérica. Este post provee el código para generar clicks sonoros Poisson independientes en Python, siguiendo lo hecho por [Brunton, et al, 2013](https://www.science.org/doi/abs/10.1126/science.1233912).



# English (by Google translate with some edits)

It is usual to study numerical cognition with visual stimuli. There are exceptions of course, but it is usual. Sound stimuli can also be used to study numerical cognition. This post provides the code to generate independent Poisson click sounds in Python, following what was done by [Brunton, et al, 2013](https://www.science.org/doi/abs/10.1126/science.1233912).



```python
import numpy as np
import pandas as pd
import sounddevice as sd



def frames_to_samples(frames, *, hop_length=512, n_fft=None):
    """Converts frame indices to audio sample indices.
    NOTE: TAKEN FROM LIBROSA TO BE ABLE TO BE USED IN PSYCHOPY
    """

    offset = 0
    if n_fft is not None:
        offset = int(n_fft // 2)

    return (np.asanyarray(frames) * hop_length + offset).astype(int)

def time_to_samples(times, *, sr=22050):
    """Convert timestamps (in seconds) to sample indices.
    NOTE: TAKEN FROM LIBROSA TO BE ABLE TO BE USED IN PSYCHOPY
    """

    return (np.asanyarray(times) * sr).astype(int)

def clicks(
    *,
    times=None,
    frames=None,
    sr=22050,
    hop_length=512,
    click_freq=1000.0,
    click_duration=0.1,
    click=None,
    length=None,
):
    """Construct a "click track".
    NOTE: TAKEN FROM LIBROSA TO BE ABLE TO BE USED IN PSYCHOPY
    This returns a signal with the signal ``click`` sound placed at
    each specified time.
    """

    # Compute sample positions from time or frames
    if times is None:
        if frames is None:
            raise ValueError('either "times" or "frames" must be provided')
            
        positions = frames_to_samples(frames, hop_length=hop_length)
    else:
        # Convert times to positions
        positions = time_to_samples(times, sr=sr)

    if click is not None:
        # Check that we have a well-formed audio buffer
        util.valid_audio(click, mono=False)

    else:
        # Create default click signal
        if click_duration <= 0:
            raise ValueError("click_duration must be strictly positive")

        if click_freq <= 0:
            raise ValueError("click_freq must be strictly positive")

        angular_freq = 2 * np.pi * click_freq / float(sr)

        click = np.logspace(0, -10, num=int(np.round(sr * click_duration)), base=2.0)

        click *= np.sin(angular_freq * np.arange(len(click)))

    # Set default length
    if length is None:
        length = positions.max() + click.shape[-1]
    else:
        if length < 1:
            raise ValueError("length must be a positive integer")

        # Filter out any positions past the length boundary
        positions = positions[positions < length]

    # Pre-allocate click signal
    shape = list(click.shape)
    shape[-1] = length
    click_signal = np.zeros(shape, dtype=np.float32)

    # Place clicks
    for start in positions:
        # Compute the end-point of this click
        end = start + click.shape[-1]

        if end >= length:
            click_signal[..., start:] += click[..., : length - start]
        else:
            # Normally, just add a click here
            click_signal[..., start:end] += click

    return click_signal


def click_trains_brunton_et_al(poisson_max, poisson_left, duration_clicks): 
    #INPUTS:
        #poisson_max, poisson_left: positive scalar; parameters for the poissons (poisson_right is the complement)
        #duration_clicks: float in secs e.g. 3.4 would be an approximately 3.4 second click train (it will be longer because of the tail of zeros; see explanation below)
        
    #OUTPUTS:
        #number of clicks to the left and right
        #2D array with sinusoidal values for clicks, each column is a channel.
    
    sampling_rate = 44100
    click_dur = 0.01 #in seconds
    click_freq = 0.01*sampling_rate #1000 #in Hz
    alpha = 0.8 #Brunton et al 2013 supplemental used 0.8 i.e.: they wanted a distribution with 0.8 variance of poisson_max_actual (see normal below) (to make the task a bit harder)
    T = duration_clicks #desired duration of trials in seconds    
    poisson_right = poisson_max - poisson_left
    n_right = -1 #number of clicks
    n_left = -1
    while n_right<=0 or n_left<=0: #number of clicks can't be negative
        poisson_max_actual = np.max([1, np.random.poisson(T*poisson_max,1)[0]]) #random poisson number of clicks
        nR_minus_nL = np.random.normal(loc=T*(poisson_right-poisson_left), 
                                       scale=np.sqrt(alpha*T*(poisson_max)), size=1)
        n_right = (nR_minus_nL+poisson_max_actual)/2 #this is the solution for NR+NL = poisson_max_actual and NR-NL = nR_minus_nL
        n_left = poisson_max_actual - n_right 
    
    n_right = int(np.round(n_right))
    n_left = int(np.round(n_left))
    
    clicks_left = np.concatenate((np.ones(n_left), np.zeros(poisson_max_actual-n_left)))
    np.random.shuffle(clicks_left) #this mutates the actual array, so no update of the array is necessary
    clicks_right = np.concatenate((np.ones(n_right), np.zeros(poisson_max_actual-n_right)))
    np.random.shuffle(clicks_right)

    clicks_left_times = T*np.where(clicks_left==1)[0]/poisson_max_actual #in secs
    clicks_right_times = T*np.where(clicks_right==1)[0]/poisson_max_actual
    clicks_left_sound = clicks(times = clicks_left_times, sr = sampling_rate, 
                               click_duration = click_dur, click_freq = click_freq)
    clicks_right_sound = clicks(times = clicks_right_times, sr = sampling_rate, 
                                click_duration = click_dur, click_freq = click_freq)
    if clicks_left_sound.shape[0]>clicks_right_sound.shape[0]: 
        #equate size by appending zeros to the shortest array    
        clicks_right_sound = np.append(clicks_right_sound, np.zeros(clicks_left_sound.shape[0]-clicks_right_sound.shape[0])) 
    else:
        #equate size by appending zeros to the shortest array
        clicks_left_sound = np.append(clicks_left_sound, np.zeros(clicks_right_sound.shape[0]-clicks_left_sound.shape[0]))

    tail_zeros = np.zeros(np.array(np.round(0.05*sampling_rate), dtype = int))
    clicks_left_sound_A = np.append(clicks_left_sound, tail_zeros) #zeros at the end so that the clicks don't end abruptly
    clicks_right_sound_A = np.append(clicks_right_sound, tail_zeros) 
    clicks_stereo_sound_A = np.concatenate((np.reshape(clicks_left_sound, (clicks_left_sound.shape[0],1)), 
                                            np.reshape(clicks_right_sound, (clicks_right_sound.shape[0],1))), 
                                           axis=1)
    clicks_left_A = clicks_left.sum()
    clicks_right_A = clicks_right.sum()
    poisson_max_actual_A = poisson_max_actual
    
     
    return clicks_left_A, clicks_right_A, clicks_stereo_sound_A

#Example usage
pm = 20 #poisson_max clicks per second through both ears; not an actual max, it is the mean of a poisson; Brunton, et al, (2013) used 20 for humans, 40 for rats.
pl = 0.5*pm #poisson clicks that sound on the left speaker/headphone (Brunton et al 2013 use a 1:1 ratio for pl and pr)
dur = 3 #duration of the soundbit (in secs)
NL, NR, clicksLR = click_trains_brunton_et_al(pm, pl, dur) #NL: number of clicks on the left (not the same as pl), NR: clicks on the right, clicksLR: the array with the soundbit of right and left clicks
sd.play(clicksLR) #these should play the sound
```


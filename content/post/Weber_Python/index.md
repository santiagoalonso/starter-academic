---
# Documentation: https://wowchemy.com/docs/managing-content/

title: "Recording trajectories with Qualtrics"
subtitle: ""
summary: ""
authors: []
tags: []
categories: []
date: 2021-09-06T08:51:25-05:00
lastmod: 2021-09-06T08:51:25-05:00
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

En una [entrada anterior](https://santiago-alonso-diaz.netlify.app/post/psychopy_trajectories/) hice un pequeño ejemplo sobre cómo grabar trayectorias del mouse o en una superficie touch con Pavlovia. En esta entrada es el turno para software propietario, en particular Qualtrics. El esfuerzo es inspirado por lo hecho por [Mathur & Reichling](https://link.springer.com/article/10.3758/s13428-019-01258-6) quienes proveen su código de forma abierta para recoger trayectorias de mouse en Qualtrics. Acá extiendo ese esfuerzo para que se pueda hacer también en touch-screen y además que la decisión final no requiera clics, lo que hace la experiencia más fluida para el usuario.

El código es para una tarea sencilla: mover el dedo (o cursor) desde una posición inicial en la parte inferior de la pantalla a una línea numérica ubicada en la parte superior. A la persona se le indica el número que debe moverse. Es una tarea similar a la propuesta por Dror Dotan en este [paper](https://www.sciencedirect.com/science/article/abs/pii/S0010027713001406). 

<center><img src="Survey_2.png" width = "597" height = '364'></center>

Lo primero es bajar el archivo qsf que pongo en mi [github](https://github.com/santiagoalonso/starter-academic/tree/master/content/post/Qualtrics_Trajectories). Asumo conocimiento previo de Qualtrics. Lo siguiente es empezar un nuevo proyecto con el archivo qsf. Una vez cargado debe verse algo así:

<center><img src="Survey_1.png" width = "762" height = '351'></center>



El bloque "Instrucciones_slider" tiene las instrucciones. Hay algunas [imágenes](https://github.com/santiagoalonso/starter-academic/tree/master/content/post/Qualtrics_Trajectories) que si quieren ver deben cargar en su libreria de gráficas de Qualtrics. Una pregunta tiene código Javascript para que cada vez que la persona avance en la encuesta se ponga el navegador en pantalla completa.  

El bloque "Entrenamiento_slider" tiene el loop principal. En el "loop & merge", el Field 2 tiene los números que se preguntan. Se pueden cambiar pero también hay que cambiar en el slider (a la izquierda Qualtrics pone las opciones del slider, y los limites se pueden cambiar en "Scale Points"). La primera pregunta del bloque es donde esta el Javascript que controla la recolección de coordenadas y la interacción con el usuario y la pantalla. Esta basado en lo hecho por [Mathur & Reichling](https://link.springer.com/article/10.3758/s13428-019-01258-6) pero con cambios sustanciales para que la persona no tenga que dar clics para confirmar su respuesta lo que permite que el código sirva tanto para desktops con mouse o dispositivos mobiles con touch-screens (el de Mathur solo sirve si la persona usa un mouse). 

Como es usual en Qualtrics, la recolección de data requiere definir embedded data. Lo primero es crear un contact list nuevo. Se puede hacer cargando a contact lists el archivo de excel en mi [github](https://github.com/santiagoalonso/starter-academic/tree/master/content/post/Qualtrics_Trajectories). Luego en el survey flow añadir de primero la embedded data via una lista de contactos y seleccionar el nombre dado a la lista de contactos que se creo con el excel.

<center><img src="Survey_Flow_5.png" width = "670" height = '326'></center>

Es un ejemplo que se puede extender para que solo se muestren dos targets, uno a la izquierda y otro a la derecha, lo que es usual en estudios de mouse. Tan solo hay que modificar el Javascript. La función "update_slider" tiene el color de los números cuando se tocan. La función "color_slider" colorea los bordes de la barra superior que contiene los números. Con el siguiente comando se puede acceder a celdas individuales: var lis = document.getElementsByClassName("numbers")[0].getElementsByTagName("li"). La variable lis contiene cada una de las celdas de la barra. Con ella se puede cambiar el borde a blanco de las que no se quiere que aparezcan (con algo así: jQuery("li").css({ "border": "0px"}); aunque este comando cambia todas las celdas, habría que hacerlo celda por celda y dejar 1px solid black en la celda izquierda y derecha que se deseen dejar).



 

# English (by Google translate with some edits)



In a [previous entry](https://santiago-alonso-diaz.netlify.app/post/psychopy_rajectories/) I wrote a small example on how to record trajectories of the mouse or on a touch surface with Pavlovia. In this post it is the turn for proprietary software, in particular Qualtrics. The effort is inspired by what has been done by [Mathur & Reichling](https://link.springer.com/article/10.3758/s13428-019-01258-6) who provide their code openly to collect mouse trajectories in Qualtrics . Here I extend that effort so that it can also be done on touch-screen and also that the final decision does not require clicks, which makes the experience more fluid for the user.

The code is for a simple task: move your finger (or cursor) from a starting position at the bottom of the screen to a number line located at the top. The person is told the number to move. It is a task similar to the one proposed by Dror Dotan in this [paper](https://www.sciencedirect.com/science/article/abs/pii/S0010027713001406).



<center><img src="Survey_2.png" width = "597" height = '364'></center>

The first thing is to download the qsf file that I put in my [github](https://github.com/santiagoalonso/starter-academic/tree/master/content/post/Qualtrics_Trajectories). I assume prior knowledge of Qualtrics. The next thing is to start a new project with the qsf file. Once loaded it should look something like this:

<center><img src="Survey_1.png" width = "762" height = '351'></center>



The "Instructions_slider" block has the instructions. There are some [images](https://github.com/santiagoalonso/starter-academic/tree/master/content/post/Qualtrics_Trajectories) that if you want to see you should upload to your Qualtrics graphics library. The question has Javascript code so that each time the person advances in the survey, the browser is placed in full screen.

The "Training_slider" block has the main loop. In the "loop & merge", Field 2 has the numbers that are asked. They can be changed but also must be changed in the slider (Qualtrics puts the slider options on the left, and the limits can be changed in "Scale Points"). The first question of the block has the Javascript that controls the collection of coordinates and the interaction with the user and the screen. It is based on what was done by [Mathur & Reichling](https://link.springer.com/article/10.3758/s13428-019-01258-6) but with substantial changes so that the person does not have to click to confirm their answer which allows the code to work both for desktops with mouse or mobile devices with touch-screens (Mathur's only works if the person uses a mouse).

As usual in Qualtrics, data collection requires defining embedded data. The first thing is to create a new contact list. It can be done by uploading to contact lists the excel file in my [github](https://github.com/santiagoalonso/starter-academic/tree/master/content/post/Qualtrics_Trajectories). Then, in the survey flow, add the embedded data via a contact list i.e. select the name given to the contact list that was created with the excel file.

<center><img src="Survey_Flow_5.png" width = "670" height = '326'></center>

It is an example that can be extended so that only two targets are shown, one on the left and one on the right, which is usual in mouse studies. You just have to modify the Javascript. The "update_slider" function has the color of the numbers when they are touched. The "color_slider" function colors the borders of the top bar that contains the numbers. With the following command, individual cells can be accessed: var lis = document.getElementsByClassName ("numbers") [0] .getElementsByTagName ("li"). The variable lis contains each of the cells in the bar. With it you can change the border to white of the ones you don't want to appear (with something like this: jQuery ("li"). Css ({"border": "0px"}); although this command changes all cells; it should be done cell by cell and leave 1px solid black in the left and right cell that you want to show on-screen).

# Ejemplo de estimación de la fracción de Weber

# Weber fraction estimation example

```python
def Weber_Estimate(W): 
    #Based on Piantadosi's "Efficient estimation of Weber’s W"; Behav Res (2016) 48:42–52
    #This uses a 1/W prior for weber fraction (W) i.e. larger W become less likely a priori
    #In fact, the -log(W) comes from that prior after taking the log(posterior) (see paper)
    #A large W is bad acuity (larger standard deviation); a small W is good number acuity
    
    #p_correct = scipy.stats.norm.cdf(np.abs(n1-n2)/(W*np.sqrt(n1**2+n2**2))) #number version
    p_correct = scipy.stats.norm.cdf(np.abs(ratio-1)/(W*np.sqrt(ratio**2+1))) #ratio version i.e. number version with ratio = n2/n1
    
    val = -np.log(W) + np.sum(np.log(np.where(correct, p_correct, 1-p_correct))) 
    
    return -val 

dataT = pd.read_csv('4th_grade_non_symbolic_task.csv')
n1 = dataT['n1']
n2 = dataT['n2']
ratio = dataT['ratio']
correct = dataT['correct']

optim = scipy.optimize.minimize_scalar(Weber_Estimate, bounds=(0, 3), method='bounded')
Weber = optim.x #Weber fraction

#plot of mean data points and the fitted model 
data_group = dataT.groupby(['ratio']).mean().reset_index()
x_data = data_group['ratio']
y_data = data_group['correct']
y = scipy.stats.norm.cdf(np.abs(data_group['ratio']-1)/(Weber*np.sqrt(data_group['ratio']**2+1)))

fig, ax = plt.subplots(1,2,figsize=(14,6))
ax[0].plot(x_data, y, label = 'Fit (Weber Fraction = ' + str(np.round(Weber,3)) + ')')
ax[0].scatter(x_data, y_data, label = 'Child Behavior')
ax[0].set_xlabel('Trial difficulty (easy to hard) \nsmall num / large num')
ax[0].set_ylabel('Proportion correct')
ax[0].set_ylim(0.475,1.025)
ax[0].set_title('Dot number comparison task')
ax[0].legend();
```


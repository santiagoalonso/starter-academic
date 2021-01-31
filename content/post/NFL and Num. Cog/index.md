---
# Documentation: https://wowchemy.com/docs/managing-content/

title: "No free lunch theorem & number cognition"
subtitle: ""
summary: ""
authors: []
tags: []
categories: []
date: 2020-10-03T08:51:25-05:00
lastmod: 2020-10-03T08:51:25-05:00
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

Hace poco me enteré de un teorema en ciencias computacionales llamado el no free lunch theorem (Wolpert, quien lo demostró lo explica intuitivamente en esta [entrevista](https://complexity.simplecast.com/episodes/45). En palabras de Wolpert: "... si el algoritmo A es mejor al B en algunas funciones de costo, entonces de alguna forma debe existir otras funciones de costo donde el algoritmo B es mejor ... " Wolpert and Macready (1995) (traducción propia). 

En esta nota extiendo la idea de que esto es relevante para ciencia cognitiva de numéros. 

Pero primero, un ejemplo de Wikipedia que me pareció bueno para generar una intuición del no free lunch theorem (de ahora en adelante NFL). Imagine un universo con dos resultados posibles (cuadrado y triangulo) y que solo ha durado dos días:

1. (cuadrado, triangulo): el universo es cuadrado en día 1 y triangulo en día 2
2. (cuadrado, cuadrado)
3. (triangulo, triangulo)
4. (triangulo, triangulo)

Un algoritmo A que prediga cuadrado si ocurrió cuadrado, en la historía 2 será mejor que uno B que prediga triangulo. Sin embargo, si las historias 1 a 4 son igual de probables ambos algoritmos son iguales de buenos en promedio (e.g. el algoritmo B es mejor en la historia 1).  

El NFL ha intrigado y generado acalorados debates en la comunidad de machine learning e inteligencia artificial por sus implicaciones en el esfuerzo por encontrar los mejores algoritmos. 

En cognición numérica, mi área de experticia, hasta donde sé, no hay discusiones al respecto. En general, hay dos visiones sobre las capacidades algorítmicas del cerebro y animales (incluyendo humanos) para representar numéros. Para aclarar, me centró en numerosidad como propiedad de la realidad. Por ejemplo, 3 nueces o 22 pájaros. 

* [Algoritmo](http://dx.doi.org/10.1016/j.actpsy.2016.09.003) A: usar características sensoriales para estimar numerosidad. 
* [Algoritmo](https://doi.org/10.1162/jocn.1993.5.4.390) B: normalizar características sensoriales y estimar numerosidad abstracta.

¿Suenan parecidos? La diferencia clave es que algoritmo A considera que el cerebro no representa numéros en abstracto, simplemente usa propiedades sensoriales como área cubierta o densidad de las 3 nueces o los 22 pajaros. Si un animal parece actuar sobre los numéros, es simplemente eso, *parece actuar sobre numéros* pero simplemente usa propiedades sensoriales, no usa numéros. En cambio, el algoritmo B, aunque también puede que use input sensorial, de alguna forma logra abstraerlas para llegar a un estimativo abstracto de numéro. Es decir, el animal en efecto *actua sobre numéros*. 

Los debates entre ambos bandos, aquellos que defienden algoritmo A vs algoritmo B, son intensos y los papers en journals usualmente tratan de ver cuál predice mejor el comportamiento. Sin embargo, luego de leer sobre el NFL propongo que la discusión es estéril. Mi intuición cientifíca me sugiere que es demostrable que ambos algorítmos en promedio son igual de buenos, tal como indica NFL. 



# English (by Google translate)

I recently learned of a theorem in computer science called the no free lunch theorem (Wolpert, who proved it, explains it intuitively in this [interview](https://complexity.simplecast.com/episodes/45). In Wolpert's words : "... if algorithm A is better than B in some cost functions, then somehow there must be other cost functions where algorithm B is better ..." Wolpert and Macready (1995) (own translation).

In this note I extend the idea that this is relevant to cognitive science of numbers.

But first, an example from Wikipedia that seemed good to me to generate an intuition of the no free lunch theorem (from now on NFL). Imagine a universe with two possible outcomes (square and triangle) that only lasted two days:

1. (square, triangle): the universe is square on day 1 and triangle on day 2
2. (square, square)
3. (triangle, triangle)
4. (triangle, triangle)

An algorithm A that predicts square if square occurred, in history 2 will be better than one B that predicts triangle. However, if stories 1 to 4 are equally likely both algorithms are equally good on average (e.g. algorithm B is better on story 1).

The NFL has intrigued and sparked heated debates in the machine learning and artificial intelligence community for its implications in the effort to find the best algorithms.

In numerical cognition, my area of expertise, as far as I know, there are no discussions about it. In general, there are two views on the algorithmic abilities of the brain and animals (including humans) to represent numbers. To clarify, I focused on numerousness as a property of reality. For example, 3 nuts or 22 birds.

* [Algorithm]( http://dx.doi.org/10.1016/j.actpsy.2016.09.003) A: use sensory characteristics to estimate numbers.
* [Algorithm](https://doi.org/10.1162/jocn.1993.5.4.390) B: normalize sensory characteristics and estimate abstract numbers.

Sound alike? The key difference is that algorithm A considers that the brain does not represent numbers in the abstract, it simply uses sensory properties such as covered area or density of the 3 nuts or the 22 birds. If an animal appears to act on numbers, it is just that, *it appears to act on numbers* but it just uses sensory properties, it doesn't use numbers. In contrast, algorithm B, although it may also use sensory input, somehow manages to abstract them to arrive at an abstract number estimate. That is, the animal actually *acts on numbers*.

The debates between both sides, those who defend algorithm A vs algorithm B, are intense and the papers in journals usually try to see which one best predicts behavior. However, after reading about the NFL I propose that the discussion is sterile. My scientific intuition suggests that it is demonstrable that both algorithms are equally good on average, as indicated by the NFL.
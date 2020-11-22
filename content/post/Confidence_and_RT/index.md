---
# Documentation: https://wowchemy.com/docs/managing-content/

title: "Confidence and response times"
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

# Español (English below)

Imagine dos estudiantes que presentan el mismo parcial. Uno acaba más rápido. ¿Cuál cree ud. que tiene más confianza en sacar una nota alta? El que acaba más rápido, claramente ... o tal vez el más lento ... o tal vez no tiene nada que ver la rapidez con la confianza. 

La confianza es un tema complicado y en particular su relación con tiempos de respuesta es poco clara en ciencia cognitiva. En esta entrada exploraré suscintamente el por qué, con la ayuda de cognición numérica.  

Tal vez el marco teórico más influyente para modelar y explicar tiempos de reacción en neurociencias cognitivas es la idea de que el cerebro acumula información cada X milisegundos. Tan pronto se acumula suficiente información se emite un juicio, una palabra, una decisión, un concepto que responda a la tarea a la que se enfrenta. Por ejemplo, determinar mentalmente si 45 es mayor a 47. Aún cuando parezca que solucionamos el problema instantaneamente, al cerebro le toma tiempo (~500 ms si se es rápido). Este tiempo se da por que el cerebro hace repetidamente la comparación ¿45>47? y cada vez obtiene una respuesta estocástica diferente: es decir el output del cerebro es ruidoso. Por eso, para la mayoría de tareas parece ser que se acumula señales/evidencia/muestras estocásticas para reducir probabilidades de error (remito al lector a papers teóricos de [Ratcliff](https://u.osu.edu/ratcliffmckoon/) para mayores detalles).

Bajo este marco, la confianza puede derivarse del tren de evidencia estocástica. Una posibilidad, es usar la desviación estandar de la evidencia en el momento que se tomó la decisión: desviaciones estándar altas-poca confianza; desviaciones bajas-alta confianza. Además, si la evidencia se produce con una desviación estandar fija (el proceso es estacionario), con  tiempo infinito (o lo suficientemente largo) la confianza debe llegar a una asintota pues el proceso que genera evidencia tiene una desviación fija.  Se complica cuando el tiempo no es infinito pues el estimativo de desviación estandar va a depender de la calidad de las muestras/evidencia y de la distribución subyacente que las produce. Así, la relación entre tiempo de respuesta y confianza es complicada bajo esta posibilidad. No es tan simple como decir mayor rapidez en la tarea mayor confianza. Tiempo de respuesta no es confianza.

Otra posibilidad es pensar confianza bajo un marco [Bayesiano](https://www.nature.com/articles/nn.4240). Por ejemplo, con un prior y un likelihood normal, la comparación 45>47 se vuelve más precisa con más muestras (como se mencionó arriba, el cerebro repite la comparación varias veces pues sus señales son ruidosas/estocásticas y las acumula hasta un umbral) . Es similar a cualquier inferencia estadística gaussiana: más datos mejor. Al ser más preciso, se esperaria que haya más confianza. Así, la relación entre tiempo de respuesta y confianza debería ser positiva (asumiendo que más muestras toma tiempo; si se toman muestras en paralelo no). En este marco, tiempo de respuesta demorado sería un proxy de confianza alta.

Pero no es tan simple. Ahora imaginemos de nuevo nuestros dos estudiantes, ambos comparando 45 y 47.    El cerebro de ambos produce señales estocasticas a la misma velocidad e idéntica desviación estandar. Sin embargo, encontramos que uno tiene más confianza que otro a pesar de que dan su respuesta al mismo tiempo; es decir tenían la misma información. ¿Puede esto pasar? Sí. Pudo pasar que los parametros de la inferencia Bayesiana sean diferentes en ambos. En este escenario, se complica la relación entre tiempo de respuesta y confianza. La variabilidad en como se usa la información puede, en principio, ahogar cualquier correlación.

Esta entrada no busca ser exhaustiva sobre el tema. Tan solo subrayar que confianza y tiempo de reacción no son lo mismo aún si se correlacionan. No es recomendable usar tiempo de reacción como proxy de confianza.



# English (by Google translate with edits)

Imagine two students presenting the same exam. One finishes faster. Who is most confident in getting a high grade? The one who finishes faster, clearly ... or maybe the slowest ... or maybe speed has nothing to do with confidence.

Confidence is a tricky subject. Its relationship to response times in particular is unclear in cognitive science. In this post I will succinctly explore why, with the help of number cognition.

Perhaps the most influential theoretical framework for modeling and explaining reaction times in cognitive neuroscience is the idea that the brain accumulates information every X milliseconds. As soon as enough information is accumulated, a judgment, a word, a decision, a concept is issued that responds to the task at hand. For example, mentally determining if 45 is greater than 47. Even though we seem to solve the problem instantly, it takes time (~ 500 ms if fast). This time occurs because the brain repeatedly makes the comparison 45> 47 and each time it obtains a different stochastic response: that is, the output of the brain is noisy. Therefore, for most tasks it seems that stochastic signals / evidence / samples are accumulated to reduce the probability of error (see theoretical papers by [Ratcliff](https://u.osu.edu/ratcliffmckoon/) for more details).

Under this framework, confidence can be derived from the train of stochastic evidence. One possibility is to use the standard deviation of the evidence at the time of the decision: high standard deviations-low confidence; low standard deviations-high confidence. Furthermore, if the evidence is produced with a fixed standard deviation (the process is stationary), with infinite time (or long enough)  confidence must reach an asymptote since the process that generates evidence has a fixed deviation. However, it gets complicated when the time is not infinite because the standard deviation estimate will depend on the quality of the samples / evidence and the underlying distribution that produces them. Thus, the relationship between response time and confidence is not clear under this possibility. It is not as simple as saying faster in the task greater confidence. Response time is not confidence.

Another possibility is to think of confidence under a [Bayesian](https://www.nature.com/articles/nn.4240) framework. For example, with a prior and a normal likelihood, the comparison 45> 47 becomes more accurate with more samples (as mentioned above, the brain repeats the comparison several times as its signals are noisy / stochastic and accumulates them up to a threshold) . It is similar to any Gaussian statistical inference: more data the better. By being more precise, it would be expected that there is more confidence. Thus, the relationship between response time and confidence should be positive (assuming that more samples take time). In this framework, long response times would be a high-confidence proxy.

But it's not that simple. Now let's imagine our two students again, both comparing 45 and 47. Their brains produce stochastic signals at the same speed and identical standard deviation. However, we find that one is more confident than the other even though they give their answer at the same time; that is, they had the same information. Can this happen? Yes. It could happen that the parameters of the Bayesian inference are different in both. In this scenario, the relationship between response time and confidence is complicated. Variability in how information is used can, in principle, drown out any correlation.

This post does not seek to be exhaustive on the subject. Just underline that confidence and reaction time are not the same even if they correlate. Using reaction time as a proxy for confidence is not recommended.
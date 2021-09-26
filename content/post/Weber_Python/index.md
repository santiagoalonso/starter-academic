---
# Documentation: https://wowchemy.com/docs/managing-content/

title: "Weber fraction (Python)"
subtitle: ""
summary: ""
authors: []
tags: []
categories: []
date: 2021-09-24T08:51:25-05:00
lastmod: 2021-09-24T08:51:25-05:00
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

La habilidad de comparar objetos visuales en su dimensión numérica es esencial. Por ejemplo, un depredador (leon) que ve subgrupos de presas (zebras) con diferentes individuos podría preferir perseguir al subgrupo menos numeroso para evitar contra ataques. Hay debates interminables en cognición numérica si en efecto nuestro cerebro, y el de otras muchas especies, compara basado en números o en otra propiedad sensorial que se correlaciona con número. Siguiendo con el anterior ejemplo, el subgrupo menos numeroso también es el que ocupa menos espacio. En general, ha sido difícil confirmar que estrategia usa nuestra cognición pues puede ser sensorial o puede abstraer todo lo sensorial y usar números en abstracto. En mi opinión, y sin entrar en toda la literatura, consideró que hay suficiente evidencia que confirma que nuestro cerebro puede usar propiedades abstractas, en especifico, números. 

Las personas difieren en su habilidad para manipular números. Experimentalmente y en las aulas se popularizó el uso de puntos para medir la hábilidad de estimar números, sin contar. Por ejemplo, la persona tiene que decir si vio más puntos a la izquierda o a la derecha de la pantalla.  

Una medida para cuantificar las habilidades de estimación se llama [fracción de Weber](https://www.unicog.org/publications/Dehaene_SymbolsQuantitiesMathematicalTheory_ChapterAttPerf2007.pdf). De manera intuitiva, mide que tan imprecisa es una persona en estimar rápidamente, sin contar, cantidades numéricas. Fracciones de Weber altas indican mayor imprecisión, y fracciones de Weber bajas una mejor habilidad de estimación. En la figura  de abajo se ven dos estudiantes de 4to grado que hicieron una tarea de comparar dos nubes de puntos y decir cuál era más numerosa. Esto lo hicieron por 120 turnos, y cada turno variaba en su dificultad (distancia numérica entre las nubes). El niño de la izquierda tiene mejor desempeño y menor fracción de Weber que el de la derecha. 

<center><img src="Weber Fractions.png" width = "856" height = '367'></center>



Una manera eficiente de calcular la fracción de Weber se propuso por [Steven Piantadosi](https://link.springer.com/article/10.3758/s13428-014-0558-8). En su articulo implementa la estimación con R. Acá traduzco esa implementación a Python. Lo único que se necesita es data que tenga los números que vio el niño en cada turno y si contestó bien o mal.  

El interés por la fracción de Weber es por un lado que es una medida de precisión del sistema visual para estimar números. Por otro lado, se ha relacionado con desempeño en matemáticas formales (aunque aún con mucho debate). De cualquier manera, tener una implementación en Python para estimar la fracción puede ser de utilidad.

Ver al final el código.



# English (by Google translate with some edits)

The ability to compare visual objects in their numerical dimension is essential. For example, a predator (lion) that sees subgroups of prey (zebras) with different individuals might prefer to chase the less numerous subgroup to avoid counter attacks. There are endless debates in number cognition whether in fact our brain, and that of many other species, compares based on numbers or some other sensory property that correlates with number. Continuing with the previous example, the least numerous subgroup is also the one that occupies the least space. In general, it has been difficult to confirm which strategy our cognition uses, since it can be sensory or it can abstract everything sensory and use numbers in the abstract. In my opinion, and without going into all the literature,  there is enough evidence that confirms that our brain can use abstract properties, specifically, numbers.

People differ in their ability to manipulate numbers. Experimentally and in the classrooms, the use of dots became popular to measure fast estimation. For example, the person has to say whether she saw more dots on the left or right of the screen.

One measurement to determine number abilities is called the [Weber fraction](https://www.unicog.org/publications/Dehaene_SymbolsQuantitiesMathematicalTheory_ChapterAttPerf2007.pdf). Intuitively, it measures how imprecise a person is in quickly estimating, without counting, numerical quantities. High Weber fractions indicate greater imprecision, and low Weber fractions a better estimation ability. In the figure below you can see two 4th graders who did a task comparing two clouds of dots and tell which was more numerous. They did this for 120 turns, with each turn varying in difficulty (numerical distance between the clouds). The child on the left has a better performance and a lower Weber fraction than the child on the right.



<center><img src="Weber Fractions.png" width = "856" height = '367'></center>

An efficient way to calculate the Weber fraction was proposed by [Steven Piantadosi](https://link.springer.com/article/10.3758/s13428-014-0558-8). In his article he implements the estimation with R. Here I translate that implementation to Python. All that is needed is data that has the numbers that the child saw each turn and if they answered correctly.

The interest in the Weber fraction is on the one hand that it is a measure of precision of the visual system to estimate numbers. On the other hand, it has been related to performance in formal mathematics (although still with much debate). Either way, having a Python implementation to estimate the fraction can help.

See the end for the code.



# Ejemplo de estimación de la fracción de Weber

Los datos pueden encontrarse en mi [github](https://github.com/santiagoalonso/starter-academic/tree/master/content/post/Weber_Python), en un archivo de un estudiante de 4to grado que hizo una tarea de comparación de puntos. El nombre del archivo es 4th_grade_non_symbolic_task.csv. Las columnas son n1 (número más pequeño), n2 (número más grande), ratio (n1/n2), correct (0 error pues escogió el número más pequeño, 1 correcto). Los números n1 y n2 podían aparecer a la izquierda o derecha aleatoriamente. 

# Weber fraction estimation example

The data can be found on my [github](https://github.com/santiagoalonso/starter-academic/tree/master/content/post/Weber_Python), in a file from a 4th grader who did a dot comparison task. The file name is 4th_grade_non_symbolic_task.csv. The columns are n1 (smallest number), n2 (largest number), ratio (n1 / n2), correct (0 error because you chose the smallest number, 1 correct). The numbers n1 and n2 could appear to the left or right randomly.



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


## Tips

- To upload blog posts write in terminal: hugo new --kind post post/my-article-name
- To add new publication: hugo new --kind publication publication/my-article-1 
- to add new navigation link: 
	* create a new .md in content/home e.g. mynuevolink.md. Use one of the templates in that folder.
	* add the new .md name in config/_default/menus.toml
	* if it is a content link, create folder in content/


## Markdown tips

	# Mermaid
	## Pie charts

	```mermaid
	pie title Users
	"Mobile": 50
	"Desktop": 40
	"Tablet": 10
	```

	## Graphs
	### Directions
	1. Top Down
	```mermaid
	graph TD
	A --> B
	```

	2. Bottom Top
	```mermaid
	graph BT
	A --> B 
	```

	3. Left to Right
	```mermaid
	graph LR
	A --> B
	```
	4. Right to Left
	```mermaid
	graph RL
	A --> B
	```
	### Shapes
	1. Normal box
	```mermaid
	graph TD
	box[Normal box with text]
	```

	2. Pill Shaped box
	```mermaid
	graph TD
	box([Normal box with text])
	```

	3. Box with rounded edges
	```mermaid
	graph TD
	box(Normal box with text)
	```

	4.  A node in a subroutine shape
	```mermaid
	graph LR
	id1[[This is the text in the box]]
	```

	5. A node in a cylindrical shape
	```mermaid
	graph LR
	    id1[(Database)]
	```

	6. A node in the form of a circle
	```mermaid
	graph LR
	    id1((This is the text in the circle))
	```

	7. A node in an asymetric shape
	```mermaid
	graph LR
	    id1>This is the text in the box]
	```

	8. A node (rhombus)
	```mermaid
	graph LR
	    id1{This is the text in the box}
	```

	9. A hexagon node
	```mermaid
	graph LR
	   id1{{A}}
	```

	10. others in https://mermaid-js.github.io/mermaid/#/flowchart

	### Links between nodes

	1. A link with arrow head
	```mermaid
	graph LR
	    A-->B
	```
	2. An open link
	```mermaid
	graph LR
	    A --- B
	```
	3. Dotted link
	```mermaid
	graph LR;
	   A-.->B;
	```

	4. Thick link
	```mermaid
	graph LR
	   A ==> B
	```
   
	5. Text on links
	```mermaid
	graph LR
	    A--  text ---B
	```

	```mermaid
	graph LR
	    A-- text -->B
	```

	```mermaid
	graph LR
	   A-. text .-> B
	```

	```mermaid
	graph LR
	   A == text ==> B
	```

	6. Chaining of links
	It is possible declare many links in the same line as per below:
	```mermaid
	graph LR
	   A -- text --> B -- text2 --> C
	```

	It is also possible to declare multiple nodes links in the same line as per below:
	```mermaid
	graph LR
	   a --> b & c--> d
	```

	You can then describe dependencies in a very expressive way. Like the oneliner below:
	```mermaid
	graph TB
	    A & B--> C & D
	```

	7. Other types of arrows with flowchart:
	```mermaid
	flowchart LR
	    A --o B
	    B --x C
	```

	When using flowchart instead of graph there is the possibility to use multidirectional arrows.

	```mermaid
	flowchart LR
	    A o--o B
	    B <--> C
	    C x--x D
	```

	### Subgraphs
	```mermaid
	graph TB
	    c1-->a2
	    subgraph A
	    a1-->a2
	    end
	    subgraph B
	    b1-->b2
	    end
	    subgraph C
	    c1-->c2
	    end
	```

	You can also set an explicit id for the subgraph.
	```mermaid
	graph TB
	    c1-->a2
	    subgraph ide1 [one]
	    a1-->a2
	    end
	```

	With the graphtype flowcharts it is also possible to set edges to and from subgraphs as in the graph below.
	```mermaid
	flowchart TB
	    c1-->a2
	    subgraph one
	    a1-->a2
	    end
	    subgraph two
	    b1-->b2
	    end
	    subgraph three
	    c1-->c2
	    end
	    one --> two
	    three --> two
	    two --> c2
	```
	## Comments
	```mermaid
	graph LR
	%% this is a comment 
	   A -- text --> B -- text2 --> C
	```

	## Styling a node
	It is possible to apply specific styles such as a thicker border or a different background color to a node.
	```mermaid
	graph LR
	    id1(Start)-->id2(Stop)
	    style id1 fill:#09f,stroke:#333,stroke-width:4px
	    style id2 fill:#bbf,stroke:#f66,stroke-width:2px,color:#fff,stroke-dasharray: 5 5
	```

	## Links 
	Se puede hacer links a attachments
	[[CoM_task.gif|mi imagen]]

	A notas
	[[Research (Ideas) Notas]]

	O a headings dentro de notas
	[[Research (Ideas) Notas#Changes of mind|nombre de link]]

	## Embeding
	![[CoM_task.gif]]
	![[Research (Ideas) Notas]]

	## Quotes
	> A nice quote from Nier Automata
	Anonymous Robot

	## Code blocks
	``` Python
	for i in range(20):
		do this
	```

	``` R
	for i in 1:10 {
		do this and this
	}
	```

	## Todo
	- [x] Task 1
	- [x] Task 2

	~~212~~

	## Maths
	$$
	\begin{align}
		3+3 &= 3+3\\
		&= 6
	\end{align}
	$$

	$\alpha + \beta$

	$$\omega |\mu\sigma$$

---
# Documentation: https://wowchemy.com/docs/managing-content/

title: "Model Name"
subtitle: ""
summary: ""
authors: [Author 1, Author 2]
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

# Diagram 1
```mermaid
graph TD
A --> B
```

# Diagram 2

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

# Diagram 3

```mermaid
	graph TB
	    A & B--> C & D
```

# Diagram 4
```mermaid
	graph LR
	   a --> b & c--> d
```

# Charts

```mermaid
	pie title Choices
	"Risky": 50
	"Save": 40
	"Indifferent": 10
```

# Python Code

```python
for i in range(8):
	print(i)
```
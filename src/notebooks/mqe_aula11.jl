### A Pluto.jl notebook ###
# v0.19.26

using Markdown
using InteractiveUtils

# ╔═╡ 7f29d240-ff05-11ed-1edf-319c2734a159
begin
	using PlutoUI
	using Plots
	using LaTeXStrings
	using Measures	
	import PlutoUI: combine	
	theme(:ggplot2)
	gr(size=(800,600), lw = 2, fontfamily = "Computer Modern", grid=true, tickfontsize = 12, guidefontsize=16, framestyle=:box, margin=3mm, right_margin=7mm, guidefonthalign=:right, guidefontvalign=:top)	
end

# ╔═╡ fb858d8b-6eda-4ec4-9d48-372580c49b5c
PlutoUI.TableOfContents(title="Sumário", indent=true)

# ╔═╡ 5640ba98-e38f-4332-8241-73f140e5a6f5
html"<button onclick=present()>Apresentação</button>"

# ╔═╡ ddcc10ca-ca6d-4ebe-a3ea-43bc15e9e971
md"""
# Quase-concavidade e quase-convexidade $~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ $(Resource("https://www1.udesc.br/imagens/id_submenu/899/cor_horizontal_rgb.jpg", :width => 150))
"""

# ╔═╡ a2508380-19f0-430c-b4ee-c755c095ca95
md"
* **Disciplina:** 33MQEI - Métodos Quantitativos em Economia I
* **Docente:** [Paulo Victor da Fonseca](https://pvfonseca.github.io)
* **Contato:** [paulo.fonseca@udesc.br](mailto:paulo.fonseca@udesc.br)
"

# ╔═╡ b7a6c990-1d77-4f21-860c-a0caaef123e3
md"""
!!! danger "Aviso"
	O texto que segue não tem a menor pretensão de originalidade. Ele serve apenas como registro dos principais princípios, conceitos e técnicas analíticas que são trabalhados em sala de aula.
"""

# ╔═╡ 781c02d5-6427-4a1d-8869-c8a5d6e12b06
md"
## Introdução
"

# ╔═╡ f8c142c9-ab5d-42d0-809d-730d1fa1e3a5
md"
* Para um problema de extremo livre, saber se a função objetivo é côncava ou convexa pode prescindir a verificação das condições de segunda ordem
* No contexto de problemas de otimização estática com restrições, novamente isso será possível se a superfície ou hipersuperfície da função objetivo tiver o tipo adequado de configuração
* Dessa vez, a configuração desejada é a **quase-concavidade** (ao invés de concavidade) para um máximo restrito, e a **quase-convexidade** (ao invés de convexidade) para um mínimo restrito
* Propriedades de funções convexas ou côncavas facilitam análise mas, por vezes, podem ser muito restritivas:
1. Não permitem a presença de porções planas nas curvas ou superfícies de uma função
    - Razões tecnológicas ou determinações institucionais, em economia, podem fazer com que a função seja não-crescente ou não-decrescente em segmentos de seu domínio
    - Em problemas de estimações estatísticas ou econométricas, é comum encontrarmos funções de verossimilhança que sejam planas para um certo intervalo do espaço de parâmetros
2. Para que a função seja côncava ou convexa, ela deve ser contínua (mas existem situações em que podemos querer permitir a existência de descontinuidades na função objetivo ou, ao menos, não descartar essa possibilidade)

* Para levar em conta tais eventualidades e, também, analisar os problemas de otimização restrita, definiremos os conceitos de funções **quase-côncavas** e **quase-convexas**
"

# ╔═╡ c85ba728-946f-4193-ab91-fffaf765536f
md"""
!!! warning "Quase-concavidade x concavidade"
	Veremos que quase-concavidade (quase-convexidade) é uma condição **mais fraca** que concavidade (convexidade)

	O que era de se esperar, visto que a CSO também é mais fraca para o problema restrito ($d^2z$ definida em sinal apenas para os $dx_i$ que satisfazem $dg = 0$) do que para o de otimização livre ($d^2z$ definida em sinal para todos $dx_i$)
"""

# ╔═╡ 95b68669-66b5-4abb-b24c-987cd3c3ceec
md"
## Funções quase-côncavas e quase-convexas
"

# ╔═╡ 8365b3ac-6c9f-402c-ab02-58a6a4e8042b
md"""
Função quase-côncava com segmento plano e descontinuidade. Fonte: Dadkhah (2011)
$(Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula11_fig1.PNG", :width=>600))
"""

# ╔═╡ 8cbe2135-0422-4c4d-8b48-46a179aa43c6
md"""
!!! correct "Definição - Função quase-côncava"
	A função de valores reais $f: D \to \mathbb{R}$, onde $D\subset \mathbb{R}^n$ é um conjunto convexo, é uma **função quase-côncava** se, e somente se, para quaisquer $x_1, x_2 \in D$:

	$$f(\lambda x_1 + (1-\lambda) x_2) \geq \min\{f(x_1), f(x_2)\}$$
"""

# ╔═╡ 7887ceea-f792-4cf6-8df0-7a530063eb81
md"
* Em outras palavras, se tomarmos dois pontos quaisquer no domínio da função e formarmos qualquer combinação convexa entre eles, então, o valor da função não pode estar abaixo do menor valor destes dois pontos
"

# ╔═╡ 8dfc87a5-5c39-40bc-9058-6ffa93726a57
md"""
Função quase-côncava. Fonte: Chiang e Wainwright (2006)
$(Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula11_fig2.PNG", :width=>500))
"""

# ╔═╡ 418c5858-586e-40b1-a779-a95efbd492fb
md"""
!!! correct "Definição - Função estritamente quase-côncava"
	A função de valores reais $f: D \to \mathbb{R}$, onde $D\subset \mathbb{R}^n$ é um conjunto convexo, é uma **função estritamente quase-côncava** se, e somente se, para quaisquer $x_1, x_2 \in D$:

	$$f(\lambda x_1 + (1-\lambda) x_2) > \min\{f(x_1), f(x_2)\}$$
"""

# ╔═╡ feb5ac97-bb80-441e-9b40-232a2a4dc792
md"""
Função quase-côncava mas não estritamente. Fonte: Chiang e Wainwright (2006)
$(Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula11_fig3.PNG", :width=>500))
"""

# ╔═╡ 8ff2871b-4344-41ab-b874-46211f2bf0db
md"""
!!! correct "Definição - Função quase-convexa"
	A função de valores reais $f: D \to \mathbb{R}$, onde $D\subset \mathbb{R}^n$ é um conjunto convexo, é uma **função quase-convexa** se, e somente se, para quaisquer $x_1, x_2 \in D$:

	$$f(\lambda x_1 + (1-\lambda) x_2) \leq \max\{f(x_1), f(x_2)\}$$
"""

# ╔═╡ 9d4bdfb9-d594-477e-8030-77e9adc83e23
md"
* Em outras palavras, suponha $f(x_2) \geq f(x_1)$, então, $f(x_2)$ está acima ou sobre qualquer ponto do gráfico da função $f$ que seja uma combinação convexa entre $x_1$ e $x_2$
"

# ╔═╡ 86768e7d-4a79-4b96-8180-6270c18cc433
md"""
Função quase-convexa. Fonte: Chiang e Wainwright (2006)
$(Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula11_fig4.PNG", :width=>500))
"""

# ╔═╡ 771137f2-3297-4cea-b604-33e7d81667d6
md"""
!!! correct "Definição - Função estritamente quase-convexa"
	A função de valores reais $f: D \to \mathbb{R}$, onde $D\subset \mathbb{R}^n$ é um conjunto convexo, é uma **função estritamente quase-convexa** se, e somente se, para quaisquer $x_1, x_2 \in D$:

	$$f(\lambda x_1 + (1-\lambda) x_2) < \max\{f(x_1), f(x_2)\}$$
"""

# ╔═╡ 4c44d6d5-813c-403a-816f-2659516c4849
md"""
!!! info "Teorema - Negativa de uma função"
	Seja $f$ uma função quase-côncava (estritamente quase-côncava), então, $-f$ é uma função quase-convexa (estritamente quase-convexa)
"""

# ╔═╡ 30ad6069-238e-4ce5-b779-3f0d5f818fa1
md"""
!!! info "Teorema - Concavidade x quase-concavidade"
	Qualquer função côncava (convexa) é quase-côncava (quase-convexa), mas **a recíproca não é verdadeira** ⚠️⚠️

	Analogamente, qualquer função estritamente côncava (estritamente convexa) é estritamente quase-côncava (estritamente quase-convexa), mas **a recíproca não é verdadeira** ⚠️⚠️
"""

# ╔═╡ 4736d046-010a-4960-94c7-1dcb245b8930
md"""
!!! info "Teorema - Função linear"
	Seja $f$ uma função linear, então, ela é uma função quase-côncava e, também, uma função quase-convexa
"""

# ╔═╡ 6ccf2778-87cb-43c5-8fb7-09dc3d074457
md"
* Em algumas situações, pode ser mais simples verificar quase-concavidade e quase-convexidade de uma função utilizando uma definição alternativa que usa as noções de **conjuntos superiores** e **conjuntos inferiores**
"

# ╔═╡ bfb3d900-bcc2-41e1-b32b-0720de3c7e64
md"""
!!! correct "Definição - Conjuntos superiores e conjuntos inferiores"
	**Conjunto superior**. O conjunto superior para o nível $k$, denotado por $S(k)$, é definido por:

	$$S(k) \equiv \{x|x\in D, f(x) \geq k\}$$

	**Conjunto inferior**. O conjunto inferior para o nível $k$, denotado por $I(k)$, é definido por:

	$$I(k) \equiv \{x|x\in D, f(x) \leq k\}$$
"""

# ╔═╡ 9a4d0695-b8fb-4ce3-b061-cccf4a17a553
md"""
!!! correct "Definição - Função quase-côncava"
	A função $f: D \to \mathbb{R}$ é quase-côncava se, e somente se, o conjunto superior de nível $k$, $S(k)$, é um conjunto convexo para todo $k\in\mathbb{R}$
"""

# ╔═╡ a5bea4e1-5893-4cc8-847f-568193ff9b27
md"""
Função quase-côncava e conjunto superior. Fonte: Chiang e Wainwright (2006)
$(Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula11_fig5.PNG", :width=>500))
"""

# ╔═╡ 62aadd5c-c5af-4fa6-8aa8-80373abec1f8
md"""
!!! correct "Definição - Função quase-convexa"
	A função $f: D \to \mathbb{R}$ é quase-convexa se, e somente se, o conjunto inferior de nível $k$, $I(k)$, é um conjunto convexo para todo $k\in\mathbb{R}$
"""

# ╔═╡ 3da97618-bf63-43b8-b1a8-5ed235bf8d9e
md"""
Função quase-convexa e conjunto inferior. Fonte: Chiang e Wainwright (2006)
$(Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula11_fig6.PNG", :width=>500))
"""

# ╔═╡ 17627d01-95bd-4762-a02d-f5e4a129d131
md"""
Função quase-côncava e quase-convexa. Fonte: Chiang e Wainwright (2006)
$(Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula11_fig7.PNG", :width=>500))
"""

# ╔═╡ 23c9a2ba-4b95-4c20-a9c3-8a126449d923
md"""
!!! warning "Observações sobre definição alternativa"
	* A definição alternativa para verificar quase-concavidade e quase-convexidade é incapaz de distinguir entre variedades estritas e não-estritas

	* As propriedades definidoras utilizando conjuntos superiores e inferiores não são, em si, suficientes para concavidade e convexidade, respectivamente

	* Em particular, se $f$ é uma função côncava que deve, obrigatoriamente, ser quase-côncava, podemos concluir que o conjunto superior de nível $k$, $S(k)$, é um conjunto convexo

	* No entanto, dado que o conjunto superior de nível $k$, $S(k)$, é convexo, podemos apenas concluir que a função $f$ é quase-côncava (mas não necessariamente côncava) - ver [Figura](https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula11_fig7.PNG) acima novamente
"""

# ╔═╡ 0dc86cfc-ca10-4fe4-87c4-7fcf8cc6d443
md"""
!!! danger "Resumo"
	Podemos sumarizar várias das mais importantes relações entre as funções de valores reais que estudamos:

	|  |  |  |
	| :--- | :---: | ---: |
	| $f$ côncava | $\iff$ | o hipografo de $f$ é convexo |
	| $f$ convexa | $\iff$ | o epigrafo de $f$ é convexo |
	| $f$ quase-côncava | $\iff$ | conjuntos superiores são conjuntos convexos |
	| $f$ quase-convexa | $\iff$ | conjuntos inferiores são conjuntos convexos |
	| $f$ côncava | $\implies$ | $f$ é quase-côncava |
	| $f$ convexa | $\implies$ | $f$ é quase-convexa |
	| $f$ (estritamente) côncava | $\iff$ | $-f$ (estritamente) convexa |
	| $f$ (estritamente) quase-côncava | $\iff$ | $-f$ (estritamente) quase-convexa |
"""

# ╔═╡ f76fa0d3-edf0-4771-afab-e08bc11df9e9
md"""
!!! warning "Hipografo e epigrafo"
	Dado o gráfico de uma função $f$, o **hipografo** de $f$, denotado por $\text{hip} f$, é o conjunto de pontos que estão sobre ou abaixo do gráfico de $f$

	O **epigrafo** de $f$, denotado por $\text{epi} f$, é o conjunto de pontos que estão sobre ou acima do gráfico de $f$

	Formalmente:

	$$\begin{align}\text{epi} f &\equiv \{(x,y)\in\mathbb{R}^{n+1}| y \geq f(x)\}, \\
	\text{hip} f &\equiv \{(x,y)\in\mathbb{R}^{n+1}| y \leq f(x)\}
	\end{align}$$
"""

# ╔═╡ 749a1381-2dfd-43c9-be8b-7ab5e456603f
md"
> **Exercício.** Verifique a quase-concavidade e quase-convexidade da função $f(x) = x^2$ definida no domínio $\mathbb{R}_+$
"

# ╔═╡ 934e863d-c1d6-4725-be96-8483ee1ad788
md"
> **Exercício.** Mostre que a função $f(x,y) = xy$ definida no $\mathbb{R}_+^2$ é quase-côncava
"

# ╔═╡ 347925e4-9efe-4772-840d-2ad8dcfaac2e
md"
> **Exercício.** Mostre que a função $f(x,y) = (x-a)^2 + (y-b)^2$ é quase-convexa
"

# ╔═╡ 86bc3895-90ed-4756-b1c6-2390a355879a
md"
## Funções diferenciáveis
"

# ╔═╡ 6eb8548e-d073-489f-8133-b4b2e2945875
md"
* As definições de quase-concavidade e quase-convexidade apresentadas anteriormente não requerem diferenciabilidade da função $f$
* Se $f$ for uma função diferenciável, a quase-concavidade e a quase-convexidade podem ser definidas, de forma alternativa, em termos de suas derivadas primeiras
"

# ╔═╡ 7a40f589-f5a5-4ec6-bc37-0f66a7ba95a3
md"
### Funções univariadas
"

# ╔═╡ b9aba487-0d9b-46be-a86d-b37a44063853
md"""
!!! correct "Definição - Funções quase-côncavas e quase-convexas"
	Seja $f: D\to\mathbb{R}$, $D\subset \mathbb{R}$ um conjunto convexo, se $f$ é uma função diferenciável e, para quaisquer dois pontos $u, v \in D$ tais que, sem perda de generalidade, $f(v) \geq f(u)$, então:

	$$\begin{align}
	\text{f é uma função quase-côncava} &\iff f'(u)(v-u) \geq 0 \\
	\text{f é uma função quase-convexa} &\iff f'(v)(v-u) \geq 0
	\end{align}$$
"""

# ╔═╡ 01490ae4-11e6-4376-8227-c10e64912151
md"""
!!! correct "Definição - Funções estritamente quase-côncavas e estritamente quase-convexas"
	Seja $f: D\to\mathbb{R}$, $D\subset \mathbb{R}$ um conjunto convexo, se $f$ é uma função diferenciável e, para quaisquer dois pontos $u, v \in D$ tais que, sem perda de generalidade, $f(v) \geq f(u)$, então:

	$$\begin{align}
	\text{f é estritamente quase-côncava} &\iff f'(u)(v-u) > 0 \\
	\text{f é estritamente quase-convexa} &\iff f'(v)(v-u) > 0
	\end{align}$$
"""

# ╔═╡ 3ac9276d-e753-4aa9-9be0-6844efe9407a
md"
### Funções multivariadas
"

# ╔═╡ e261e91d-2902-40c8-bef0-721280a2f305
md"""
!!! correct "Definição - Funções quase-côncavas e quase-convexas"
	Seja $f: D\to\mathbb{R}$, $D\subset \mathbb{R}^n$ um conjunto convexo, se $f$ é uma função diferenciável e, para quaisquer dois pontos $u, v \in D$ tais que, sem perda de generalidade, $f(v) \geq f(u)$, então:

	$$\begin{align}
	\text{f é uma função quase-côncava} &\iff \sum_{j=1}^n f_j(u)(v_j-u_j) \geq 0 \\
	\text{f é uma função quase-convexa} &\iff \sum_{j=1}^nf_j(v)(v_j-u_j) \geq 0
	\end{align}$$
"""

# ╔═╡ 7f35085e-9704-4f34-855e-2c66c35f614b
md"""
!!! correct "Definição - Funções estritamente quase-côncavas e estritamente quase-convexas"
	Seja $f: D\to\mathbb{R}$, $D\subset \mathbb{R}^n$ um conjunto convexo, se $f$ é uma função diferenciável e, para quaisquer dois pontos $u, v \in D$ tais que, sem perda de generalidade, $f(v) \geq f(u)$, então:

	$$\begin{align}
	\text{f é estritamente quase-côncava} &\iff \sum_{j=1}^n f_j(u)(v_j-u_j) > 0 \\
	\text{f é estritamente quase-convexa} &\iff \sum_{j=1}^nf_j(v)(v_j-u_j) > 0
	\end{align}$$
"""

# ╔═╡ 89ec9922-de97-4595-bf05-dfebc16d72c9
md"
### Funções da classe $\mathcal{C}^2(D, \mathbb{R})$
"

# ╔═╡ 6996d075-4260-4bc2-a1bc-942ea49576ec
md"
* Se uma função $f: D\to\mathbb{R}$ ($D\subset \mathbb{R}^n$ convexo) for continuamente diferenciável duas vezes, então, as propriedades de quase-concavidade e quase-convexidade podem ser verificadas por meio das derivadas paricias de primeira e segunda ordem da função, arranjadas no seguinte determinante aumentado:

$$|B| = \begin{vmatrix} 0 & f_1 & f_2 & \dots & f_n \\ f_1 & f_{11} & f_{12} & \dots & f_{1n} \\ f_{2} & f_{21} & f_{22} & \dots & f_{2n} \\ \vdots & \vdots & \vdots & \ddots & \vdots \\ f_n & f_{n1} & f_{n2} & \dots & f_{nn}\end{vmatrix}$$

* Esse determinante aumentado é similar ao Hessiano aumentado $|H|$ que vimos anteriormente

* No entanto, o acréscimo em $|B|$ é composto das derivadas de primeira ordem da própria função $f$, ao invés de conter elementos relacionados à condição de restrição

* Dado que $|B|$ depende exclusivamente das derivadas da função $f$ em si, podemos usar $|B|$, juntamente com seus principais líderes, para caracterizar a configuração desta função

* Os menores principais líderes, neste caso, serão dados por:

$$|B_1| = \begin{vmatrix} 0 & f_1 \\ f_1 & f_{11} \end{vmatrix}, \quad |B_2| = \begin{vmatrix} 0 & f_1 & f_2 \\ f_1 & f_{11} & f_{12} \\ f_{2} & f_{21} & f_{22} \end{vmatrix}, \quad \dots, \quad |B_n| = |B|$$

"

# ╔═╡ 0772b9c6-d995-4b33-ab57-62da6049884c
md"""
!!! warning "Observações"
	* Enunciaremos, aqui, duas condições - uma necessária e uma suficiente

	* Ambas estão relacionadas com a quase-concavidade em um domínio que consiste apenas no **ortante não-negativo**, i.e., $x_1, \dots, x_n \geq 0$
"""

# ╔═╡ 13932017-1d95-4957-9413-90920c121487
md"""
!!! info "Condição necessária para quase-concavidade"
	Para que a função $f(x_1, \dots, x_n)$ seja quase-côncava no ortante não-negativo, é **necessário** que:

	$$|B_1| \leq 0, \quad |B_2| \geq 0, \quad \dots, \quad (-1)^n|B_n|\geq 0,$$

	onde quer que as derivadas parciais sejam calculadas no ortante não-negativo
"""

# ╔═╡ b2784ef9-cb11-4ce9-9869-00ea4c002390
md"""
!!! info "Condição suficiente para quase-concavidade"
	Para que a função $f(x_1, \dots, x_n)$ seja quase-côncava no ortante não-negativo, é **suficiente** que:

	$$|B_1| < 0, \quad |B_2| > 0, \quad \dots, \quad (-1)^n|B_n|> 0,$$

	onde quer que as derivadas parciais sejam calculadas no ortante não-negativo
"""

# ╔═╡ e0b3b61f-f6fa-43df-a756-5442f0893a81
md"
> **Exercício.** Mostre que a condição necessária (suficiente) para a quase-convexidade de uma função $f$ no ortante não-negativo é que os menores principais líderes sejam sempre não-positivos (negativos)
"

# ╔═╡ eb68c85f-f21c-4f46-8e09-f5beca37f111
md"
> **Exercício.** Verifique a quase-concavidade e quase-convexidade da função $f(x) = x^2$ definida no domínio $\mathbb{R}_+$
"

# ╔═╡ 37995ce7-c044-43dc-91bf-79a511a0366d
md"
> **Exercício.** Mostre que $f(x,y) = xy$ definida no $\mathbb{R}_+^2$ é quase-côncava
"

# ╔═╡ 74fe5d05-95e1-40f8-b4f3-48245094defb
md"""
!!! warning "Determinante aumentado x Hessiano aumentado"
	* Lembrando que, anteriormente, vimos que o Hessiano aumentado associado ao problema de otimização com restrição de igualdade é dado por:

	$$|\bar{H}| = \begin{vmatrix}0 & g_1 & g_2 & \dots & g_n \\
		g_1 & \mathcal{L}_{11} & \mathcal{L}_{12} & \dots & \mathcal{L}_{1n} \\
		g_2 & \mathcal{L}_{21} & \mathcal{L}_{22} & \dots & \mathcal{L}_{2n} \\
		\vdots & \vdots & \vdots & \ddots & \vdots \\
		g_n & \mathcal{L}_{n1} & \mathcal{L}_{n2} & \dots & \mathcal{L}_{nn}\end{vmatrix}$$
	
	* Note, portanto, que o determinante aumentado $|B|$ que definimos acima difere do Hessiano aumentado $|\bar{H}|$ em duas maneiras:
	    1. Os elementos acrescidos em $|B|$ são as derivadas parciais de primeira ordem da função $f$, e não da função $g$
	    2. Os elementos restantes em $|B|$ são as derivadas parciais de segunda ordem da função $f$, ao invés de estarem associados à função Lagrangeana $\mathcal{L}$
"""

# ╔═╡ 877bb8bc-b3e1-4807-9f1c-1774f6671b2f
md"
* Considere, no entanto, o caso especial de uma equação linear de restrição:

$$g(x_1, \dots, x_n) = \sum_{j=1}^n a_j x_j = c$$

* Neste caso, a função Lagrangeana será dada por:

$$\mathcal{L} = f(x_1, \dots, x_n) + \lambda\left(c - \sum_{j=1}^n a_jx_j\right)$$

* De modo que:

$$\mathcal{L}_i = f_i - \lambda a_i \Rightarrow \mathcal{L}_{ij} = f_{ij}, \qquad i, j \in \{1, \dots, n\}$$

* Examinando os elementos acrescidos ao determinante aumentado, notamos que a função linear de restrição resulta em derivadas primeiras dadas por: $g_i = a_i$

* Além disso, quando as condições necessárias de primeira ordem são satisfeitas temos que:

$$\mathcal{L}_i = f_i - \lambda a_i = 0 \Rightarrow f_i = \lambda a_i = \lambda g_i$$

* Portanto, temos o seguinte resultado:

$$|B| = \begin{vmatrix} 0 & \lambda g_1 & \lambda g_2 & \dots & \lambda g_n \\ \lambda g_1 & \mathcal{L}_{11} & \mathcal{L}_{12} & \dots & \mathcal{L}_{1n} \\ \lambda g_2 & \mathcal{L}_{21} & \mathcal{L}_{22} & \dots & \mathcal{L}_{2n} \\ \vdots & \vdots & \vdots & \ddots & \vdots \\ \lambda g_n & \mathcal{L}_{n1} & \mathcal{L}_{n2} & \dots & \mathcal{L}_{nn}\end{vmatrix} = \lambda^2 \begin{vmatrix} 0 & g_1 &  g_2 & \dots &  g_n \\  g_1 & \mathcal{L}_{11} & \mathcal{L}_{12} & \dots & \mathcal{L}_{1n} \\  g_2 & \mathcal{L}_{21} & \mathcal{L}_{22} & \dots & \mathcal{L}_{2n} \\ \vdots & \vdots & \vdots & \ddots & \vdots \\  g_n & \mathcal{L}_{n1} & \mathcal{L}_{n2} & \dots & \mathcal{L}_{nn}\end{vmatrix}$$

* Temos, então, que para o caso de restrições lineares o seguinte resultado é válido:

$$|B| = \lambda^2 |\bar{H}|$$

* Consequentemente, no caso de restrições lineares, **os dois determinantes aumentados sempre possuem o mesmo sinal algébrico quando avaliados no ponto estacionário de $\mathcal{L}$**

* Pelo mesmo critério, os menores principais líderes $|B_i|$ e $\bar{H}_i$ ($i \in \{1, \dots, n\}$) também devem compartilhar o mesmo sinal naquele ponto
"

# ╔═╡ 1b329446-7e98-473d-b07d-8a37a43f6351
md"""
!!! info "Quase-concavidade e condições de segunda ordem"
	Portanto, se o determinante aumentado $|B|$ satisfizer a condição suficiente para quase-concavidade estrita, o Hessiano aumentado $|\bar{H}|$ deve, então, satisfazer a condição suficiente de segunda ordem para o problema de maximização restrita

	Lembrando que a condição suficiente de segunda ordem para um máximo restrito é: $|\bar{H}_1| < 0, |\bar{H}_2| > 0, \dots, (-1)^n|\bar{H}_n|>0$
"""

# ╔═╡ 4dbdb8be-db39-4ef0-8b60-6deb170f9336
md"""
Quase-concavidade e condições de segunda ordem. Fonte: Chiang e Wainwright (2006)
$(Resource("https://raw.githubusercontent.com/gist/fonsp/9a36c183e2cad7c8fc30290ec95eb104/raw/ca3a38a61f95cd58d79d00b663a3c114d21e284e/cute.svg"))
"""

# ╔═╡ 6bc3325e-90e7-4113-9c00-d6b9d8fc6939
md"""
!!! warning "Quase-convexidade"
	O diagrama acima pode ser adaptado para o caso de quase-convexidade
"""

# ╔═╡ 377e653d-45c1-488b-91d7-862de8917e0f
md"
* Parte esquerda do diagrama:
$$\left.\begin{array}{l} \text{- $x^*$ é um extremo relativo restrito} \\ \text{- $f$ explicitamente quase-côncava} \\ \text{- conjunto restrição convexo}\end{array}\right\} \Rightarrow \text{$x^*$ é um máximo absoluto restrito}$$

"

# ╔═╡ 8f85106e-ebd8-4900-862e-582bba8ad9b0
md"""
!!! correct "Função explicitamente quase-côncava"
	Uma função $f$ quase-côncava é **explicitamente quase-côncava** se satisfizer a seguinte propriedade adicional:

	$$f(x_2) > f(x_1) \Rightarrow f\left(\lambda x_1 + (1-\lambda)x_2\right) > f(x_1)$$

	* Sempre que um determinado ponto sobre a superfície da função, $f(x_2)$, for mais alto que um outro, $f(x_1)$, então, todos os pontos intermediários também devem ser mais altos que $f(x_1)$

	* Essa condição exclui quaisquer segmentos de planos horizontais sobre a superfície da função, exceto um possível platô no topo
"""

# ╔═╡ 72dfd952-7905-49f2-a35f-83cc29bc4fcb
md"
* Note que a condição para quase-concavidade explícita é mais fraca que a condição para quase-concavidade estrita

* Quase-concavidade estrita requer que $f\left(\lambda x_1 + (1-\lambda)x_2\right) > f(x_1)$, mesmo quando $f(x_1) = f(x_2)$, implicando que segmentos de planos não horizontais também não são permitidos
"

# ╔═╡ ae925b24-ed95-42e9-bd2a-a0cd64294ab8
md"""
!!! danger "Máximo absoluto restrito"
	* Quando $f$ é uma função explicitamente quase-côncava e o conjunto restrição é convexo, então, o valor estacionário encontrado nas CPOs do problema restrito será um máximo absoluto restrito

	* Portanto, o máximo local encontrado sobre o subconjunto convexo da superfície será um máximo global restrito. Neste caso, estamos tratando com a porção de uma superfície (ou hipersuperfície) em formato de sino, livre de segmentos horizontais, que está diretamente acima de um conjunto convexo estabelecido no domínio
"""

# ╔═╡ f6304c43-9d2b-4a58-9794-00442971f6b2
md"""
!!! danger "Unicidade do máximo absoluto restrito"
	* A porção direita do diagrama envolve a condição mais forte de quase-concavidade estrita
	* Uma função estritamente quase-côncava deve ser explicitamente quase-côncava, embora a recíproca não seja verdadeira
	* Portanto, quando quase-concavidade estrita substitui a quase-concavidade explícita, ainda assim, a condição de um máximo absoluto restrito está assegurada
	* Mas, desta vez, o máximo absoluto restrito será, também, **único**, visto que a ausência de qualquer segmento plano em qualquer parte sobre a superfície exclui, definitivamente, a possibilidade de vários máximos restritos
"""

# ╔═╡ 77cc00b7-e2a7-4f15-8a35-cb9682a8b33b
md"
> **Exercício.** Considere o seguinte problema primal de maximização de utilidade do consumidor:
>
> $$\begin{align}\max_{x,y} \quad & \quad Ax^\alpha y^\beta, \qquad x, y > 0, \quad 0<\alpha, \beta < 1\\ \text{s.r.} \quad & \quad p_x x + p_y y = I\end{align}$$
>
> 1. Mostre que a função utilidade deste consumidor é estritamente quase-côncava
>
> 2. Mostre que a reta orçamentária forma um conjunto convexo
>
> 3. O que podemos concluir sobre o problema primal de maximização de utilidade sujeito à restrição orçamentária?
"

# ╔═╡ 0329b1e6-7e40-4f86-b3a2-a30875af12a2
md"
## 📚 Bibliografia

CHIANG, A.C.; WAINWRIGHT, K. Matemática para economistas.
Rio de Janeiro: Elsevier, 2006.

DADKHAH, K. Foundations of Mathematical and Computational Economics. Boston: Springer, 2011.

JEHLE, G. A.; RENY, P. J. Advanced Microeconomic Theory. 3rd.ed. Essex: Pearson Education Limited, 2011.

SYDSÆTER, K.; HAMMOND, P.J.; STRØM, A.; CARVAJAL, A.
Essential mathematics for economic analysis. 5th.ed. Harlow, UK:
Pearson Education Limited, 2016.
"

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Measures = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
LaTeXStrings = "~1.3.0"
Measures = "~0.3.2"
Plots = "~1.38.14"
PlutoUI = "~0.7.51"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.0"
manifest_format = "2.0"
project_hash = "4ef839c502a3f45a4cd42573219646d9b1a97b15"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BitFlags]]
git-tree-sha1 = "43b1a4a8f797c1cddadf60499a8a077d4af2cd2d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.7"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "e30f2f4e20f7f186dc36529910beaedc60cfa644"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.16.0"

[[deps.ChangesOfVariables]]
deps = ["LinearAlgebra", "Test"]
git-tree-sha1 = "f84967c4497e0e1955f9a582c232b02847c5f589"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.7"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "9c209fb7536406834aa938fb149964b985de6c83"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.1"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "be6ab11021cd29f0344d5c4357b163af05a48cba"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.21.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "SpecialFunctions", "Statistics", "TensorCore"]
git-tree-sha1 = "600cc5508d66b78aae350f7accdb58763ac18589"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.9.10"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.Compat]]
deps = ["UUIDs"]
git-tree-sha1 = "7a60c856b9fa189eb34f5f8a6f6b5529b7942957"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.6.1"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.2+0"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "96d823b94ba8d187a6d8f0826e731195a74b90e9"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.2.0"

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "738fec4d684a9a6ee9598a8bfee305b26831f28c"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.2"

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseStaticArraysExt = "StaticArrays"

    [deps.ConstructionBase.weakdeps]
    IntervalSets = "8197267c-284f-5f27-9208-e0e47529a953"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.DataAPI]]
git-tree-sha1 = "8da84edb865b0b5b0100c0666a9bc9a0b71c553c"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.15.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bad72f730e9e91c08d9427d5e8db95478a3c323d"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.8+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Pkg", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "74faea50c1d007c85837327f6775bea60b5492dd"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.2+2"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "d972031d28c8c8d9d7b41a536ad7bb0c2579caca"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.8+0"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Preferences", "Printf", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "UUIDs", "p7zip_jll"]
git-tree-sha1 = "8b8a2fd4536ece6e554168c21860b6820a8a83db"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.72.7"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "19fad9cd9ae44847fe842558a744748084a722d1"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.72.7+0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "d3b3624125c1474292d0d8ed0f65554ac37ddb23"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.74.0+2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "5e77dbf117412d4f164a464d610ee6050cc75272"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.9.6"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "d75853a0bdbfb1ac815478bacd89cd27b550ace6"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.3"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "6667aadd1cdee2c6cd068128b3d226ebc4fb0c67"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.9"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "f377670cda23b6b7c1c0b3893e37451c5c1a2185"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.5"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6f2675ef130a300a112286de91973805fcc5ffbc"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.91+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Printf", "Requires"]
git-tree-sha1 = "099e356f267354f46ba65087981a77da23a279b7"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.0"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c7cb1f5d892775ba13767a87c7ada0b980ea0a71"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+2"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "3eb79b0ca5764d4799c06699573fd8f533259713"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.4.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "0a1b7c2863e44523180fdb3146534e265a91870b"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.23"
weakdeps = ["ChainRulesCore", "ChangesOfVariables", "InverseFunctions"]

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "cedb76b37bc5a6c702ade66be44f831fa23c681e"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.0"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "42324d08725e200c23d4dfb549e0d5d89dede2d2"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.10"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "Random", "Sockets"]
git-tree-sha1 = "03a9b9718f5682ecb107ac9f7308991db4ce395b"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.7"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+0"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "f66bdc5de519e8f8ae43bdc598782d35a25b1272"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.1.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.10.11"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.21+4"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+0"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "51901a49222b09e3743c65b8847687ae5fc78eb2"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.1"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9ff31d101d987eb9d66bd8b176ac7c277beccd09"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.20+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "d321bf2de576bf25ec4d3e4360faca399afca282"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.0"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "a5aef8d4a6e8d81f171b2bd4be5265b01384c74c"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.10"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.9.0"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "1f03a2d339f42dca4a4da149c7e15e9b896ad899"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.1.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "f92e1315dadf8c46561fb9396e525f7200cdc227"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.3.5"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Preferences", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "ad59edfb711a4751e0b8271454df47f84a47a29e"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.38.14"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "b478a748be27bd2f2c73a7690da219d0844db305"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.51"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "259e206946c293698122f63e2b513a7c99a244e8"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.1.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "7eb1686b4f04b82f96ed7a4ea5890a4f0c7a09f1"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "0c03844e2231e12fda4d0086fd7cbe4098ee8dc5"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+2"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "90bc7a7c96410424509e4263e277e43250c05691"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.0"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "30449ee12237627992a99d5e30ae63e4d78cd24a"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "a4ada03f999bd01b3a25dcaa30b2d929fe537e00"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.1.0"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "ef28127915f4229c971eb43f3fc075dd3fe91880"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.2.0"
weakdeps = ["ChainRulesCore"]

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.9.0"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "45a7769a04a3cf80da1c1c7c60caf932e6f4c9f7"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.6.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "75ebe04c5bed70b91614d684259b661c9e6274a4"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "Pkg", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "5.10.1+6"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "9a6ae7ed916312b41236fcef7e0af564ef934769"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.13"

[[deps.Tricks]]
git-tree-sha1 = "aadb748be58b492045b4f56166b5188aa63ce549"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.7"

[[deps.URIs]]
git-tree-sha1 = "074f993b0ca030848b897beff716d93aca60f06a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.2"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["ConstructionBase", "Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "ba4aa36b2d5c98d6ed1f149da916b3ba46527b2b"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.14.0"
weakdeps = ["InverseFunctions"]

    [deps.Unitful.extensions]
    InverseFunctionsUnitfulExt = "InverseFunctions"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "e2d817cc500e960fdbafcf988ac8436ba3208bfd"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.6.3"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "ed8d92d9774b077c53e1da50fd81a36af3744c1c"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+0"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4528479aa01ee1b3b4cd0e6faef0e04cf16466da"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.25.0+0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "93c41695bc1c08c46c5899f4fe06d6ead504bb73"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.10.3+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "926af861744212db0eb001d9e40b5d16292080b2"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.0+4"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "4bcbf660f6c2e714f87e960a171b119d06ee163b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.2+4"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "5c8424f8a67c3f2209646d4425f3d415fee5931d"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.27.0+4"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+0"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "49ce682769cd5de6c72dcf1b94ed7790cd08974c"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.5+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "868e669ccb12ba16eaf50cb2957ee2ff61261c56"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.29.0+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.7.0+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9ebfc140cc56e8c2156a15ceac2f0302e327ac0a"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+0"
"""

# ╔═╡ Cell order:
# ╟─7f29d240-ff05-11ed-1edf-319c2734a159
# ╟─fb858d8b-6eda-4ec4-9d48-372580c49b5c
# ╟─5640ba98-e38f-4332-8241-73f140e5a6f5
# ╟─ddcc10ca-ca6d-4ebe-a3ea-43bc15e9e971
# ╟─a2508380-19f0-430c-b4ee-c755c095ca95
# ╟─b7a6c990-1d77-4f21-860c-a0caaef123e3
# ╟─781c02d5-6427-4a1d-8869-c8a5d6e12b06
# ╟─f8c142c9-ab5d-42d0-809d-730d1fa1e3a5
# ╟─c85ba728-946f-4193-ab91-fffaf765536f
# ╟─95b68669-66b5-4abb-b24c-987cd3c3ceec
# ╟─8365b3ac-6c9f-402c-ab02-58a6a4e8042b
# ╟─8cbe2135-0422-4c4d-8b48-46a179aa43c6
# ╟─7887ceea-f792-4cf6-8df0-7a530063eb81
# ╟─8dfc87a5-5c39-40bc-9058-6ffa93726a57
# ╟─418c5858-586e-40b1-a779-a95efbd492fb
# ╟─feb5ac97-bb80-441e-9b40-232a2a4dc792
# ╟─8ff2871b-4344-41ab-b874-46211f2bf0db
# ╟─9d4bdfb9-d594-477e-8030-77e9adc83e23
# ╟─86768e7d-4a79-4b96-8180-6270c18cc433
# ╟─771137f2-3297-4cea-b604-33e7d81667d6
# ╟─4c44d6d5-813c-403a-816f-2659516c4849
# ╟─30ad6069-238e-4ce5-b779-3f0d5f818fa1
# ╟─4736d046-010a-4960-94c7-1dcb245b8930
# ╟─6ccf2778-87cb-43c5-8fb7-09dc3d074457
# ╟─bfb3d900-bcc2-41e1-b32b-0720de3c7e64
# ╟─9a4d0695-b8fb-4ce3-b061-cccf4a17a553
# ╟─a5bea4e1-5893-4cc8-847f-568193ff9b27
# ╟─62aadd5c-c5af-4fa6-8aa8-80373abec1f8
# ╟─3da97618-bf63-43b8-b1a8-5ed235bf8d9e
# ╟─17627d01-95bd-4762-a02d-f5e4a129d131
# ╟─23c9a2ba-4b95-4c20-a9c3-8a126449d923
# ╟─0dc86cfc-ca10-4fe4-87c4-7fcf8cc6d443
# ╟─f76fa0d3-edf0-4771-afab-e08bc11df9e9
# ╟─749a1381-2dfd-43c9-be8b-7ab5e456603f
# ╟─934e863d-c1d6-4725-be96-8483ee1ad788
# ╟─347925e4-9efe-4772-840d-2ad8dcfaac2e
# ╟─86bc3895-90ed-4756-b1c6-2390a355879a
# ╟─6eb8548e-d073-489f-8133-b4b2e2945875
# ╟─7a40f589-f5a5-4ec6-bc37-0f66a7ba95a3
# ╟─b9aba487-0d9b-46be-a86d-b37a44063853
# ╟─01490ae4-11e6-4376-8227-c10e64912151
# ╟─3ac9276d-e753-4aa9-9be0-6844efe9407a
# ╟─e261e91d-2902-40c8-bef0-721280a2f305
# ╟─7f35085e-9704-4f34-855e-2c66c35f614b
# ╟─89ec9922-de97-4595-bf05-dfebc16d72c9
# ╟─6996d075-4260-4bc2-a1bc-942ea49576ec
# ╟─0772b9c6-d995-4b33-ab57-62da6049884c
# ╟─13932017-1d95-4957-9413-90920c121487
# ╟─b2784ef9-cb11-4ce9-9869-00ea4c002390
# ╟─e0b3b61f-f6fa-43df-a756-5442f0893a81
# ╟─eb68c85f-f21c-4f46-8e09-f5beca37f111
# ╟─37995ce7-c044-43dc-91bf-79a511a0366d
# ╟─74fe5d05-95e1-40f8-b4f3-48245094defb
# ╟─877bb8bc-b3e1-4807-9f1c-1774f6671b2f
# ╟─1b329446-7e98-473d-b07d-8a37a43f6351
# ╟─4dbdb8be-db39-4ef0-8b60-6deb170f9336
# ╟─6bc3325e-90e7-4113-9c00-d6b9d8fc6939
# ╟─377e653d-45c1-488b-91d7-862de8917e0f
# ╟─8f85106e-ebd8-4900-862e-582bba8ad9b0
# ╟─72dfd952-7905-49f2-a35f-83cc29bc4fcb
# ╟─ae925b24-ed95-42e9-bd2a-a0cd64294ab8
# ╟─f6304c43-9d2b-4a58-9794-00442971f6b2
# ╟─77cc00b7-e2a7-4f15-8a35-cb9682a8b33b
# ╟─0329b1e6-7e40-4f86-b3a2-a30875af12a2
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

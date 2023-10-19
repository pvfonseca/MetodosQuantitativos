### A Pluto.jl notebook ###
# v0.19.26

using Markdown
using InteractiveUtils

# ╔═╡ 6561f220-f06e-11ed-16d8-931b481048c3
begin
	using PlutoUI
	using Plots
	using LaTeXStrings
	using Measures	
	import PlutoUI: combine	
	theme(:ggplot2)
	gr(size=(800,600), lw = 2, fontfamily = "Computer Modern", grid=true, tickfontsize = 12, guidefontsize=16, framestyle=:box, margin=3mm, right_margin=7mm, guidefonthalign=:right, guidefontvalign=:top)	
end

# ╔═╡ 54c73553-ceb8-4352-b5b3-a70af9c746f8
PlutoUI.TableOfContents(title="Sumário", indent=true)

# ╔═╡ eb9bc300-da31-48cf-944f-a0e097bbe24e
html"<button onclick=present()>Apresentação</button>"

# ╔═╡ c7d8a282-be96-4d54-97af-32382e2421b8
md"""
# Otimização estática com restrições de igualdade $~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ $(Resource("https://www1.udesc.br/imagens/id_submenu/899/cor_horizontal_rgb.jpg", :width => 150))
"""

# ╔═╡ 209bd3c7-8f7e-4cae-af1e-4cf23b061473
md"
* **Disciplina:** 33MQEI - Métodos Quantitativos em Economia I
* **Docente:** [Paulo Victor da Fonseca](https://pvfonseca.github.io)
* **Contato:** [paulo.fonseca@udesc.br](mailto:paulo.fonseca@udesc.br)
"

# ╔═╡ 97fb17b6-164f-4903-bf21-a86b577b0e4f
md"""
!!! danger "Aviso"
	O texto que segue não tem a menor pretensão de originalidade. Ele serve apenas como registro dos principais princípios, conceitos e técnicas analíticas que são trabalhados em sala de aula.
"""

# ╔═╡ 0a7d779f-02db-4105-a9a6-f339ba8dfae7
md"
## Diferencial total de segunda ordem
"

# ╔═╡ b71b98f1-017e-483c-a510-2966efea5a10
md"
* Vimos que ao considerarmos a restrição de igualdade $g(x,y) = c$, isso signifca que $g_xdx + g_ydy = 0$ e, portanto, $dx$ e $dy$ não podem mais ser consideradas como variações arbitrárias
* Se deixarmos $dx$ como uma variação arbitrária, então, deve ser o caso que $dy$ será uma variação dependente de $dx$ de modo que $dy = -(g_x/g_y)dx$
* Portanto, como $g_x$ e $g_y$ dependem das variáveis $x$ e $y$, a variação $dy$ também dependerá de $x$ e $y$
* O diferencial total de segunda ordem, $d^2z$, que vimos para o caso de extremos livres (baseado na arbitrariedade de $dx$ e $dy$) não se aplica mais
"

# ╔═╡ 7f9ab427-3859-4c45-b7fd-f0cf14cfe11b
md"
* Para derivarmos uma expressão adequada de $d^2z$, devemos tratar $dy$ como uma variável dependente de $x$ e $y$ durante o processo de diferenciação (se considerarmos $dx$ como uma variável livre)
* Assim, se $z = f(x,y)$ é uma função $\mathcal{C}^2$, temos:

$$\begin{align}
d^2z &= d(dz) = \frac{\partial (dz)}{\partial x}dx + \frac{\partial (dz)}{\partial y}dy \\
&= \frac{\partial}{\partial x}(f_xdx + f_ydy)dx + \frac{\partial}{\partial y}(f_xdx + f_ydy)dy \\
&= \left[f_{xx}dx + \left(f_{xy}dy + f_y\frac{\partial dy}{\partial x}\right)\right]dx + \left[f_{xy}dx + \left(f_{yy}dy + f_y\frac{\partial dy}{\partial y}\right)\right]dy \\
&= f_{xx}dx^2 + f_{xy}dydx + f_y\frac{\partial dy}{\partial x}dx + f_{yx}dxdy + f_{yy}dy^2 + f_y\frac{\partial dy}{\partial y}dy
\end{align}$$
"

# ╔═╡ 21eca5d0-a777-41e0-a0a3-8fcab59411ef
md"""
!!! warning "Observação"
	Note que a seguinte igualdade é válida:

	$$f_y\left[\frac{\partial dy}{\partial x}dx + \frac{\partial dy}{\partial y}dy\right] = f_yd(dy) = f_yd^2y$$
"""

# ╔═╡ 1ef1d93f-9110-4a58-86c4-de72edd9ec2a
md"
* Portanto, temos a seguinte expressão para $d^2z$:

$$d^2z = f_{xx}dx^2 + 2f_{xy}dxdy + f_{yy}dy^2 + f_yd^2y\tag{1}\label{eq1}$$

* Note que essa expressão difere da que derivamos para o caso de extremo livre pela presença do último termo, $f_y d^2y$

* Dado que $d^2y$ não é o mesmo que $(dy)^2$, o último termo da equação ($\ref{eq1}$) é um termo de primeiro grau e, portanto, a expressão ($\ref{eq1}$) derivada para $d^2z$ não é uma forma quadrática
"

# ╔═╡ e04d7517-ff76-4090-933f-cb60e0e458cc
md"
* Entretanto, podemos transformar a expressão de $d^2z$ em uma forma quadrática ao incorporarmos a restrição de igualdade $g(x,y) = c$:

$$\begin{align}
d^2g &= d(dg) = \frac{\partial dg}{\partial x}dx + \frac{\partial dg}{\partial y}dy \\
&= \frac{\partial}{\partial x}(g_xdx + g_ydy)dx + \frac{\partial}{\partial y}(g_xdx + g_ydy)dy \\
&= \left[g_{xx}dx + \left(g_{xy}dy + g_y\frac{\partial dy}{\partial x}\right) \right]dx + \left[g_{xy}dx + \left(g_{yy}dy + g_y\frac{\partial dy}{\partial y}\right) \right]dy \\
&= g_{xx}dx^2 + 2g_{xy}dxdy + g_{yy}dy^2 + g_yd^2y
\end{align}$$

* Pela restrição, sabemos que $dg = 0$ e, portanto, $d^2g = 0$
* De forma que:

$$g_{xx}dx^2 + 2g_{xy}dxdy + g_{yy}dy^2 + g_yd^2y = 0\tag{2}\label{eq2}$$
"

# ╔═╡ a7cd48b5-b3cd-4aca-b47d-d77c72e367b5
md"
* Pelas expressões ($\ref{eq1}$) e ($\ref{eq2}$), podemos obter $d^2z$ como uma forma quadrática:

$$d^2z = \left(f_{xx} - \frac{f_y}{g_y}g_{xx}\right) dx^2 + 2\left(f_{xy} - \frac{f_y}{g_y}g_{xy}\right)dxdy + \left(f_{yy} - \frac{f_y}{g_y}g_{yy}\right)dy^2\tag{3}\label{eq3}$$

* Os termos entre parênteses da equação ($\ref{eq3}$) podem ser escritos em função do multiplicador de Lagrange, $\lambda$, associado ao problema de otimização

* Pelas CPOs da função Lagrangeana:

$$\begin{align}
\mathcal{L}_x &= f_x - \lambda g_x = 0\\
\mathcal{L}_y &= f_y - \lambda g_y = 0
\end{align}$$

* Portanto: $\lambda = f_y/g_y = f_x/g_x$
"

# ╔═╡ 36e1a489-18a0-472d-a0bf-8027d5a9f9f9
md"
* Além disso, calculando as segundas derivadas, temos:

$$\begin{align}
\mathcal{L}_{xx} &= f_{xx} - \lambda g_{xx} = 0 \\
\mathcal{L}_{xy} &= f_{xy} - \lambda g_{xy} = 0 \\
\mathcal{L}_{yy} &= f_{yy} - \lambda g_{yy} = 0
\end{align}$$

* Portanto:

$$d^2z = \mathcal{L}_{xx}dx^2 + \mathcal{L}_{xy}dxdy + \mathcal{L}_{yx}dydx + \mathcal{L}_{yy}dy^2\tag{4}\label{eq4}$$

* Os coeficientes de ($\ref{eq4}$) são as derivadas segundas de $\mathcal{L}$ com relação às variáveis de escolha $x$ e $y$ e, juntas, podem dar origem a um determinante Hessiano
"

# ╔═╡ 848d7b0e-1daf-4496-8f0c-be38ca2531c4
md"
## Condições de segunda ordem
"

# ╔═╡ 8c17f0d5-6f61-4141-b527-711e1fd4520c
md"
* Para um extremo restrito de $z = f(x,y)$, sujeito à restrição de igualdade $g(x,y) = c$, as condições de primeira e de segunda ordem dependem do sinal algébrico da diferencial total de segunda ordem $d^2z$, avaliada em um ponto estacionário
* A diferença é que, agora, nosso interesse é no sinal definido ou semidefinido de $d^2z$ não para todos os valores possíveis de $dx$ e $dy$, mas somente para os valores de $dx$ e $dy$ que satisfaçam a restrição linear $g_xdx + g_y dy = 0$
"

# ╔═╡ beafce1a-1bbc-4971-98fa-90f20b7353be
md"""
!!! correct "Condições de segunda ordem"
	Dado o problema de otimização:

	$$\begin{eqnarray}
	\max(\min) &\quad z = f(x,y) \\
	\text{s.r. } &\quad g(x,y) = c\end{eqnarray}$$

	Temos as seguintes condições:

	* As **condições necessárias de segunda ordem** são:
	    - Para um ponto de máximo local de $z$: $d^2z$ negativa semidefinida, sujeita a $dg = 0$
	    - Para um ponto de mínimo local de $z$: $d^2z$ positiva semidefinida, sujeita a $dg = 0$

	* As **condições suficientes de segunda ordem** são:
	    - Para um ponto de máximo local de $z$: $d^2z$ negativa definida, sujeita a $dg = 0$
	    - Para um ponto de mínimo local de $z$: $d^2z$ positiva definida, sujeita a $dg = 0$
"""

# ╔═╡ 8d102c29-8d8e-4a75-bbd6-3d3466f87142
md"
### Forma quadrática bivariada
"

# ╔═╡ 9bae6127-32f8-4b8d-aabc-60d9b5b05f61
md"
* Como no caso de extremos livres, podemos expressar as condições de segunda ordem na forma de determinante
* No caso de extremos restritos, ao invés do determinante Hessiano $|H|$, utilizaremos o **Hessiano aumentado**
* Considere, inicialmente, as condições para sinal definido de uma forma quadrática bivariada, sujeita a uma restrição linear:

$$\begin{align}
\quad & \quad q = au^2 + 2huv + bv^2 \\
\text{s.r.} & \quad \alpha u + \beta v = 0
\end{align}$$

* Pelo método de substituição de variáveis, podemos escrever a expressão anterior como função apenas de uma variável:

$$q = (a\beta^2 - 2h\alpha\beta + b\alpha^2)\frac{u^2}{\beta^2}$$

*  $q$ será positiva (negativa) definida se, e somente se, a expressão entre parênteses for positiva (negativa)

* Note que o seguinte determinante simétrico é exatamente a negativa da expressão entre parênteses anterior:

$$\begin{vmatrix}0 & \alpha & \beta \\ \alpha & a & h \\ \beta & h & b\end{vmatrix} = 2h\alpha \beta - \alpha^2 b - a\beta^2$$
"

# ╔═╡ 99a118c6-124a-47b5-b823-2b43a3f28520
md"""
!!! info "Forma quadrática bivariada definida"
	Portanto, podemos afirmar que:

	* A forma quadrática $q$ é **positiva definida** sujeita a $\alpha u + \beta v = 0$ se, e somente se, a seguinte condição é satisfeita:

	$$\begin{vmatrix}0 & \alpha & \beta \\ \alpha & a & h \\ \beta & h & b\end{vmatrix} < 0$$

	* A forma quadrática $q$ é **negativa definida** sujeita a $\alpha u + \beta v = 0$ se, e somente se, a seguinte condição é satisfeita:

	$$\begin{vmatrix}0 & \alpha & \beta \\ \alpha & a & h \\ \beta & h & b\end{vmatrix} > 0$$
"""

# ╔═╡ 98aa8ba5-b7b8-49d3-a31e-eddb139234c3
md"""
!!! warning "Observação"
	* Note que o determinante utilizado nos critérios anteriores é simplesmente o discriminante da forma quadrática original $\begin{vmatrix}a & h\\h & b\end{vmatrix}$, com uma linha adicionada na parte superior e uma coluna semelhante à esquerda

	* A adição é composta dos dois coeficientes $\alpha$ e $\beta$ da restrição, mais um zero na diagonal principal

	* Esse discriminante aumentado é simétrico
"""

# ╔═╡ bc3efbf7-a67e-49c1-84db-65a5e1d7e6eb
md"
> **Exercício**. Determine se $q = 4u^2 + 4uv + 3v^2$ sujeita a $u - 2v = 0$ é positiva ou negativa definida.
"

# ╔═╡ 155de3af-8856-44e9-8a42-888abc7931c7
md"
### Hessiano aumentado
"

# ╔═╡ f4f959f0-9cd6-4c18-8a83-b23fecd530c8
md"
* Quando aplicadas à forma quadrática $d^2z$ em ($\ref{eq4}$), e considerando a restrição à forma quadrática $g_xdx + g_ydy = 0$, podemos obter os seguintes critérios com determinantes para a condição de sinal definido de $d^2z$

*  $d^2z$ é **positiva definida** sujeita a $dg = 0$ se, e somente se, a seguinte condição for satisfeita:

$$\begin{vmatrix}0 & g_x & g_y \\ g_x & \mathcal{L}_{xx} & \mathcal{L}_{xy} \\ g_y & \mathcal{L}_{yx} & \mathcal{L}_{yy}\end{vmatrix} < 0$$

*  $d^2z$ é **negativa definida** sujeita a $dg = 0$ se, e somente se, a seguinte condição for satisfeita:

$$\begin{vmatrix}0 & g_x & g_y \\ g_x & \mathcal{L}_{xx} & \mathcal{L}_{xy} \\ g_y & \mathcal{L}_{yx} & \mathcal{L}_{yy}\end{vmatrix} > 0$$

* O determinante definido acima é, normalmente, denominado um **Hessiano aumentado** (ou **Hessiano orlado**) e será denotado por $|\bar{H}|$
"

# ╔═╡ e33ab705-11b9-4aa6-9f2f-3ccfb9676bea
md"
* Portanto, podemos concluir que, dado um ponto crítico de $z = f(x,y)$ sujeito à restrição de igualdade, ou de $\mathcal{L} = f(x,y) + \lambda[c - g(x,y)]$, um $|\bar{H}|$ positivo (um Hessiano aumentado negativo definido) é suficiente para estabelecê-lo como um máximo relativo restrito de $z$

* De maneira análoga, um $|\bar{H}|$ negativo é suficiente para que este ponto estacionário seja um mínimo relativo restrito de $z$

* Lembrando que todas as derivadas em $|\bar{H}|$ devem ser avaliadas nos valores críticos de $x$ e $y$
"

# ╔═╡ f0021ee7-5c1c-4fef-b1e9-d662c786db0b
md"""
!!! warning "Teorema da Função Implícita"
	Note que, agora, é fácil verificar que a satisfação dessa condição garantirá que o Jacobiano de variáveis endógenas é não-nulo no estado ótimo

	Já que o Jacobiano de variáveis endógenas é igual ao Hessiano aumentado, a satisfação da condição suficiente de segunda ordem assegura que o Jacobiano é diferente de zero e, portanto, podemos utilizar o Teorema da Função Implícita que vimos anteriormente

	Isso será particularmente útil em análises de estática comparativa
"""

# ╔═╡ a327f9d1-a427-47c3-ad24-30011e833b02
md"
> **Exercício**. Calcule o extremo de:
>
> $$z = xy$$
>
> $$\text{s.r.} \quad x + y = 6$$
>
> Determine se é um ponto de mínimo ou de máximo
"

# ╔═╡ 613636ac-7092-400a-b1f9-c03e8f39b386
md"
> **Exercício**. Calcule o extremo de:
>
> $$z = x^2 + y^2$$
>
> $$\text{s.r.} \quad x + 4y = 2$$
>
> Determine se é um ponto de mínimo ou de máximo
"

# ╔═╡ 4ddba26f-a646-4010-8d55-be1bfbe6ee6c
md"
> **Exercício**. Calcule o extremo de:
>
> $$z = xy$$
>
> $$\text{s.r.} \quad x + 4y = 16$$
>
> Determine se é um ponto de mínimo ou de máximo
"

# ╔═╡ cf94138c-8904-4635-a05a-d051db55e147
md"
> **Exercício**. Calcule o extremo de:
>
> $$z = x^2 + y^2$$
>
> $$\text{s.r.} \quad x^2 + xy + y^2 = 3$$
>
> Determine se são pontos de mínimo ou de máximo
"

# ╔═╡ 75a7948a-5397-435f-bdd9-76de01fdd4bd
md"
> **Exercício**. Calcule o extremo de:
>
> $$z = x^2y$$
>
> $$\text{s.r.} \quad 2x^2 + y^2 = 3$$
>
> Determine se é um ponto de mínimo ou de máximo
"

# ╔═╡ a5036a1b-ad07-45f7-af1f-890f1e9e0b86
md"
### Caso multivariado
"

# ╔═╡ aaa59a0b-f6b3-4b22-a8df-61407cd3fc73
md"
* Vamos supor, agora, que a função objetivo e a restrição de igualdade consideradas sejam funções de $n$ variáveis reais:

$$\begin{align}
\max (\min) \quad & \quad z = f(x_1, x_2, \dots, x_n) \\
\text{s.r.} \quad & \quad g(x_1, x_2, \dots, x_n) = c\end{align}$$

* Para este caso, a condição de segunda ordem depende, ainda, do sinal algébrico do diferencial total de segunda ordem $d^2z$

* Visto que o diferencial total de segunda ordem, $d^2z$, é uma forma quadrática restrita nas variáveis $dx_1, dx_2, \dots, dx_n$ sujeita à restrição:

$$g_1dx_1 + g_2dx_2 + \dots + g_ndx_n = 0,$$

as condições para formas quadráticas positivas definidas ou negativas definidas envolvem, novamente, o Hessiano aumentado

* No entanto, essas condições devem ser expressas em termos dos menores principais líderes aumentados do Hessiano

* O Hessiano aumentado, para o caso de $n$ variáveis, é dado por:

$$|\bar{H}| = \begin{vmatrix} 0 & g_1 & g_2 & \dots & g_n \\ g_1 & \mathcal{L}_{11} & \mathcal{L}_{12} & \dots & \mathcal{L}_{1n} \\ g_2 & \mathcal{L}_{21} & \mathcal{L}_{22} & \dots & \mathcal{L}_{2n} \\ \vdots & \vdots & \vdots & \ddots & \vdots \\ g_n & \mathcal{L}_{n1} & \mathcal{L}_{n2} & \dots & \mathcal{L}_{nn}\end{vmatrix}$$
"

# ╔═╡ e0679d62-0cbf-4026-a28e-640e266abd56
md"
* Os menores principais líderes do Hessiano aumentado podem, então, ser definidos como:

$$|\bar{H_2}| \equiv \begin{vmatrix}0 & g_1 & g_2 \\ g_1 & \mathcal{L}_{11} & \mathcal{L}_{12} \\ g_2 & \mathcal{L}_{21} & \mathcal{L}_{22}\end{vmatrix}, \qquad |\bar{H_3}| \equiv \begin{vmatrix}0 & g_1 & g_2 & g_3 \\ g_1 & \mathcal{L}_{11} & \mathcal{L}_{12} & \mathcal{L}_{13} \\ g_2 & \mathcal{L}_{21} & \mathcal{L}_{22} & \mathcal{L}_{23} \\ g_3 & \mathcal{L}_{31} & \mathcal{L}_{32} & \mathcal{L}_{33}\end{vmatrix}, \qquad \text{etc.}$$

* Sendo que $|\bar{H_n}| = |\bar{H}|$
"

# ╔═╡ 9a957841-86d6-45ed-a4c0-cf8d573e3c32
md"""
!!! info "Formas quadráticas definidas: caso multivariado"
	As condições para uma forma quadrática $d^2z$ ser positiva definida ou negativa definida são dadas por:

	1.  $d^2z$ é **positiva definida** se, e somente se, $|\bar{H_2}|, |\bar{H_3}|, \dots, |\bar{H_n}| < 0$

	2.  $d^2z$ é **negativa definida** se, e somente se, $|\bar{H_2}| > 0, |\bar{H_3}| < 0, |\bar{H_4}| > 0, \dots, (-1)^n |\bar{H_n}| > 0$
"""

# ╔═╡ 31d8981e-d70c-4b89-9c9e-c515b32e002b
md"
* Como antes, $d^2z$ ser positiva definida é uma condição suficiente para estabelecer um valor estacionário de $z$ como seu mínimo relativo
*  $d^2z$ ser negativa definida é suficiente para estabelecer como um valor de máximo relativo
* Em resumo, temos as seguintes condições com determinantes para extremos relativos da função $z = f(x_1, x_2, \dots, x_n)$, sujeito a $g(x_1, x_2, \dots, x_n) = c$
"

# ╔═╡ b86e5d45-c850-4668-8f7c-849e8b14bbc8
md"""
!!! correct "Condições necessárias e suficientes para extremos relativos restritos"
	Condições para extremo relativo restrito: $\mathcal{L} = f(x_1, \dots, x_n) + \lambda[c - g(x_1, \dots, x_n)]$

	| Condição | Máximo relativo | Mínimo relativo |
	| :---: | :---: | :---: |
	| Necessária de 1ª ordem | $\mathcal{L}_\lambda = \mathcal{L}_1 = \dots = \mathcal{L}_n = 0$ | $\mathcal{L}_\lambda = \mathcal{L}_1 = \dots = \mathcal{L}_n = 0$ |
	| Suficiente de 2ª ordem | $\begin{vmatrix}\bar{H_2}\end{vmatrix} > 0, \begin{vmatrix}\bar{H_3}\end{vmatrix} < 0, \begin{vmatrix}\bar{H_4}\end{vmatrix} > 0, \dots, (-1)^n \begin{vmatrix}\bar{H_n}\end{vmatrix} > 0$ | $\begin{vmatrix}\bar{H_2}\end{vmatrix}, \begin{vmatrix}\bar{H_3}\end{vmatrix}, \dots, \begin{vmatrix}\bar{H_n}\end{vmatrix} < 0$ |
"""

# ╔═╡ cf7c51c2-a142-4df0-af2b-e9db8f4d1537
md"
### Caso de múltiplas restrições
"

# ╔═╡ 7459d965-1e13-489a-a600-358672a4e11d
md"
* Consideraremos agora, de maneira ainda mais geral, um problema de otimização que envolva $n$ variáveis de escolha e $m$ restrições de igualdade ($m < n$)

* Ao associarmos um multiplicador de Lagrange a cada uma das restrições, temos a função Lagrangeana dada por:

$$\mathcal{L} = f(x_1, \dots, x_n) + \sum_{j = 1}^m \lambda_j[c_j - g^j(x_1, \dots, x_n)]$$

* A matriz Hessiana aumentada é, então, dada por:

$$|\bar{H}| \equiv \begin{vmatrix}
0 & 0 & \dots & 0 & g_1^1 & g_2^1 & \dots & g_n^1 \\
0 & 0 & \dots & 0 & g_1^2 & g_2^2 & \dots & g_n^2 \\
\vdots & \vdots & \ddots & \vdots & \vdots & \vdots & \ddots & \vdots \\
0 & 0 & \dots & 0 & g_1^m & g_2^m & \dots & g_n^m \\
g_1^1 & g_1^2 & \dots & g_1^m & \mathcal{L}_{11} & \mathcal{L}_{12} & \dots & \mathcal{L}_{1n} \\
g_2^1 & g_2^2 & \dots & g_2^m & \mathcal{L}_{21} & \mathcal{L}_{22} & \dots & \mathcal{L}_{2n} \\
\vdots & \vdots & \ddots & \vdots & \vdots & \vdots & \ddots & \vdots \\
g_n^1 & g_n^2 & \dots & g_n^m & \mathcal{L}_{n1} & \mathcal{L}_{n2} & \dots & \mathcal{L}_{nn}
\end{vmatrix}$$

* Na matriz anterior, $g_i^j \equiv \partial g^j/\partial x_i$ são as derivadas parciais das funções de restrição, e os símbolos $\mathcal{L}$ com dois índices denotam as derivadas parciais de segunda ordem da função Lagrangeana

* Vários menores principais líderes podem ser formados a partir de $|\bar{H}|$:

$$|\bar{H}_2| \equiv \begin{vmatrix}
0 & 0 & \dots & 0 & g_1^1 & g_2^1 \\
0 & 0 & \dots & 0 & g_1^2 & g_2^2 \\
\vdots & \vdots & \ddots & \vdots & \vdots & \vdots \\
0 & 0 & \dots & 0 & g_1^m & g_2^m \\
g_1^1 & g_1^2 & \dots & g_1^m & \mathcal{L}_{11} & \mathcal{L}_{12} \\
g_2^1 & g_2^2 & \dots & g_2^m & \mathcal{L}_{21} & \mathcal{L}_{22}
\end{vmatrix}$$

$$|\bar{H}_3| \equiv \begin{vmatrix}
0 & 0 & \dots & 0 & g_1^1 & g_2^1 & g_3^1\\
0 & 0 & \dots & 0 & g_1^2 & g_2^2 & g_3^2 \\
\vdots & \vdots & \ddots & \vdots & \vdots & \vdots & \vdots \\
0 & 0 & \dots & 0 & g_1^m & g_2^m & g_3^m\\
g_1^1 & g_1^2 & \dots & g_1^m & \mathcal{L}_{11} & \mathcal{L}_{12} & \mathcal{L}_{13} \\
g_2^1 & g_2^2 & \dots & g_2^m & \mathcal{L}_{21} & \mathcal{L}_{22} & \mathcal{L}_{23} \\
g_3^1 & g_3^2 & \dots & g_3^m & \mathcal{L}_{31} & \mathcal{L}_{32} & \mathcal{L}_{33}
\end{vmatrix}$$
"

# ╔═╡ 478a49f3-7b0c-4599-abeb-0bff2ee6d984
md"
* Podemos obter os próximos menores principais líderes incluindo mais uma linha e mais uma coluna, até $|\bar{H}_n|$
* Podemos, então, enunciar a condição suficiente de segunda ordem em temos dos sinais dos seguintes $(n-m)$ menores principais líderes aumentados:

$$|\bar{H}_{m+1}|, |\bar{H}_{m+2}|, \dots, |\bar{H}_{n}| (= |\bar{H}|)$$
* Estes menores principais líderes devem ser de ordem maior que $m$ pois um determinante envolvendo menos do que $m$ colunas e linhas será igual a zero
"

# ╔═╡ 4750558f-8d37-4ad8-bc63-0891320e26ee
md"""
!!! correct "Condições de segunda ordem: n variáveis e m restrições de igualdade"
	* Para um máximo local de $z$, uma condição suficiente é que os menores principais líderes aumentados alternem sinais algébricos, sendo que o sinal de $|\bar{H}_{m+1}|$ é o mesmo sinal de $(-1)^{m+1}$
	* Para um mínimo local de $z$, uma condição suficiente é que os menores principais líderes aumentados tenham o mesmo sinal algébrico, a saber, o mesmo sinal que $(-1)^m$
"""

# ╔═╡ 2835e56c-a290-4542-aa9b-e880e82199fa
md"""
!!! danger "Observação"
	* Note que ter um número ímpar ou par de restrições faz uma grande diferença

	* Isso porque $(-1)$ elevado a uma potência ímpar resultará no sinal oposto ao de $(-1)$ elevado a uma potência par

	* Para o caso $m = 1$, a condição apenas enunciada é a mesma que vimos anteriormente, de problemas de otimização com $n$ variáveis de escolha e uma restrição de igualdade
"""

# ╔═╡ 7da98e1b-3f0e-4212-90a5-4ac82de5382a
md"""
> **Exercício**. Escreva o Hessiano aumentado para um problema de otimização restrita com quatro variáveis de escolha e duas restrições
>
> Enuncie, especificamente, a condição suficiente de segunda ordem para um máximo local e um mínimo local de $z$
"""

# ╔═╡ 8b0dcec9-c715-4fc0-bdea-6e25a0675a38
md"
## 📚 Bibliografia

CHIANG, A.C.; WAINWRIGHT, K. Matemática para economistas.
Rio de Janeiro: Elsevier, 2006.

SIMON, C.P.; BLUME, L. Matemática para economistas. Porto
Alegre: Bookman, 2004.

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
Plots = "~1.38.11"
PlutoUI = "~0.7.51"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.3"
manifest_format = "2.0"
project_hash = "ba38107133561ad9f4100b0beef7714c40d01d4a"

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
version = "1.0.5+0"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "96d823b94ba8d187a6d8f0826e731195a74b90e9"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.2.0"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.DataAPI]]
git-tree-sha1 = "e8119c1a33d267e16108be441a287a6981ba1630"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.14.0"

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

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8e9441ee83492030ace98f9789a654a6d0b1f643"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+0"

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
git-tree-sha1 = "efaac003187ccc71ace6c755b197284cd4811bfe"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.72.4"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4486ff47de4c18cb511a0da420efebb314556316"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.72.4+0"

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
git-tree-sha1 = "877b7bc42729aa2c90bbbf5cb0d4294bd6d42e5a"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.9.1"

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
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

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

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

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
git-tree-sha1 = "7302075e5e06da7d000d9bfa055013e3e85578ca"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.9"

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
version = "1.9.2"

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
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Preferences", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "6c7f47fd112001fc95ea1569c2757dffd9e81328"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.38.11"

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

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

    [deps.SpecialFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"

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
git-tree-sha1 = "d1bf48bfcc554a3761a133fe3a9bb01488e06916"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.21"

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

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
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
version = "5.8.0+0"

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
# ╟─6561f220-f06e-11ed-16d8-931b481048c3
# ╟─54c73553-ceb8-4352-b5b3-a70af9c746f8
# ╟─eb9bc300-da31-48cf-944f-a0e097bbe24e
# ╟─c7d8a282-be96-4d54-97af-32382e2421b8
# ╟─209bd3c7-8f7e-4cae-af1e-4cf23b061473
# ╟─97fb17b6-164f-4903-bf21-a86b577b0e4f
# ╟─0a7d779f-02db-4105-a9a6-f339ba8dfae7
# ╟─b71b98f1-017e-483c-a510-2966efea5a10
# ╟─7f9ab427-3859-4c45-b7fd-f0cf14cfe11b
# ╟─21eca5d0-a777-41e0-a0a3-8fcab59411ef
# ╟─1ef1d93f-9110-4a58-86c4-de72edd9ec2a
# ╟─e04d7517-ff76-4090-933f-cb60e0e458cc
# ╟─a7cd48b5-b3cd-4aca-b47d-d77c72e367b5
# ╟─36e1a489-18a0-472d-a0bf-8027d5a9f9f9
# ╟─848d7b0e-1daf-4496-8f0c-be38ca2531c4
# ╟─8c17f0d5-6f61-4141-b527-711e1fd4520c
# ╟─beafce1a-1bbc-4971-98fa-90f20b7353be
# ╟─8d102c29-8d8e-4a75-bbd6-3d3466f87142
# ╟─9bae6127-32f8-4b8d-aabc-60d9b5b05f61
# ╟─99a118c6-124a-47b5-b823-2b43a3f28520
# ╟─98aa8ba5-b7b8-49d3-a31e-eddb139234c3
# ╟─bc3efbf7-a67e-49c1-84db-65a5e1d7e6eb
# ╟─155de3af-8856-44e9-8a42-888abc7931c7
# ╟─f4f959f0-9cd6-4c18-8a83-b23fecd530c8
# ╟─e33ab705-11b9-4aa6-9f2f-3ccfb9676bea
# ╟─f0021ee7-5c1c-4fef-b1e9-d662c786db0b
# ╟─a327f9d1-a427-47c3-ad24-30011e833b02
# ╟─613636ac-7092-400a-b1f9-c03e8f39b386
# ╟─4ddba26f-a646-4010-8d55-be1bfbe6ee6c
# ╟─cf94138c-8904-4635-a05a-d051db55e147
# ╟─75a7948a-5397-435f-bdd9-76de01fdd4bd
# ╟─a5036a1b-ad07-45f7-af1f-890f1e9e0b86
# ╟─aaa59a0b-f6b3-4b22-a8df-61407cd3fc73
# ╟─e0679d62-0cbf-4026-a28e-640e266abd56
# ╟─9a957841-86d6-45ed-a4c0-cf8d573e3c32
# ╟─31d8981e-d70c-4b89-9c9e-c515b32e002b
# ╟─b86e5d45-c850-4668-8f7c-849e8b14bbc8
# ╟─cf7c51c2-a142-4df0-af2b-e9db8f4d1537
# ╟─7459d965-1e13-489a-a600-358672a4e11d
# ╟─478a49f3-7b0c-4599-abeb-0bff2ee6d984
# ╟─4750558f-8d37-4ad8-bc63-0891320e26ee
# ╟─2835e56c-a290-4542-aa9b-e880e82199fa
# ╟─7da98e1b-3f0e-4212-90a5-4ac82de5382a
# ╟─8b0dcec9-c715-4fc0-bdea-6e25a0675a38
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

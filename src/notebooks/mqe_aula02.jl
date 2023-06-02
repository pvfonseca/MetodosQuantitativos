### A Pluto.jl notebook ###
# v0.19.26

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 60438d3e-b977-11ed-2c3f-31fcfeed2a61
begin
	using PlutoUI
	using Plots
	using LaTeXStrings
	using Measures
	import PlutoUI: combine
	using TaylorSeries
	theme(:ggplot2)
	gr(size=(800,600), lw = 2, fontfamily = "Computer Modern", grid=true, tickfontsize = 12, guidefontsize=16, framestyle=:box, margin=3mm, right_margin=7mm, guidefonthalign=:right, guidefontvalign=:top)	
end

# ╔═╡ 1f8cd57d-7e54-4b61-8f6b-6176fa8c4393
PlutoUI.TableOfContents(title="Sumário", indent=true)

# ╔═╡ 5d2ecc37-03e6-4eec-8e8e-e18bdd5ac910
html"<button onclick=present()>Apresentação</button>"

# ╔═╡ 24c71569-6341-4bc4-a672-985a95b9efb8
md"""
# Revisão de conceitos básicos $~~$ $(Resource("https://www1.udesc.br/imagens/id_submenu/899/cor_horizontal_rgb.jpg", :width => 150))
"""

# ╔═╡ 3709a461-a301-4843-b78a-fc8c7bfa6ee5
md"
* **Disciplina:** 33MQEI - Métodos Quantitativos em Economia I
* **Data:** 02/03/2023
* **Docente:** [Paulo Victor da Fonseca](https://pvfonseca.github.io)
* **Contato:** [paulo.fonseca@udesc.br](mailto:paulo.fonseca@udesc.br)
"

# ╔═╡ 90b94b6d-4004-43ae-88bd-41788fac1a13
md"""
!!! danger "Aviso"
	O texto que segue não tem a menor pretensão de originalidade. Ele serve apenas como registro dos principais princípios, conceitos e técnicas analíticas que são trabalhados em sala de aula. A principal fonte destas notas são os livros-texto de James Stewart (2016), Chiang e Wainwright (2006) e Marsden e Tromba - Vector Calculus (2011).
"""

# ╔═╡ e0cd5b85-d359-46b2-aa1d-58ada1f8d44f
PlutoUI.Resource("https://upload.wikimedia.org/wikipedia/commons/6/65/Charles_Hermite_circa_1887.jpg", :width => 300)

# ╔═╡ d43a49ea-8f4d-4977-aa8b-c08e7feab890
md"""
!!! info " "
	"I turn away with fright and horror from the lamentable evil of functions which do not have derivatives."

	[Charles Hermite](https://en.wikipedia.org/wiki/Charles_Hermite) (1822 - 1901) - matemático francês
"""

# ╔═╡ e7927a74-ffa0-49c1-b6df-c7a820d08774
md"""
## Funções
"""

# ╔═╡ 442072e0-2db7-4a43-8957-d92432f451a1
md"
### Funções univariadas
"

# ╔═╡ 0e281328-549c-4df8-a37c-2636524b1e24
md"""
!!! correct "Definição (Função)"
	Uma função $f$ é uma lei que associa, a cada elemento $x$ em um conjunto domínio $D$, exatamente um elemento, chamado $f(x)$, no conjunto contra-domínio $E$.
"""

# ╔═╡ f04d1177-ecf7-4a3e-8209-3f551f23ebe4
md"
* Dizemos que uma função $f$ é um mapeamento de um conjunto $D$ em um outro conjunto $E$, e denotamos por:
$$f: D \to E$$
* O conjunto de todos os valores possíveis de $f(x)$ obtidos quando $x$ varia por todo o domínio é chamado **imagem de $f$**
"

# ╔═╡ b3a32dd8-fe27-4075-a527-b55c79c10f02
md"""
Considerando a figura abaixo, qual(is) da(s) imagem(s) representa(m) uma função?

$(Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/spivak_functions.PNG", :width => 400))
"""

# ╔═╡ 3a184a96-74c5-4c5c-8cf8-07e549453fc0
md"
Exemplos de funções
"

# ╔═╡ c36feb6a-c799-44ba-ba59-ded251a94e2e
begin
	l = @layout [a b; c d]
	p1 = plot(range(-2, -0.1, 100), x -> 1/x, lc=:indianred, label=L"f(x) = \frac{1}{x}")
	plot!(range(0.1, 2, 100), x -> 1/x, lc=:indianred, label=:none)
	vline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
	p2 = plot(range(-2, -0.01, 100), x -> 1/x^2, lc=:indianred, label=L"f(x) = \frac{1}{x^2}")
	plot!(range(0.01, 2, 100), x -> 1/x^2, lc=:indianred, label=:none)
	vline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
	ylims!(0, 50)
	p3 = plot(range(-6, 6, 100), x -> 1/(1 + x^2), lc=:indianred, label=L"f(x) = \frac{1}{1 + x^2}")
	vline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
	p4 = plot(range(-6, 6, 100), x -> x/(1 + x^2), lc=:indianred, label=L"f(x) = \frac{x}{1 + x^2}")
	vline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
	plot(p1, p2, p3, p4, layout = l)
end

# ╔═╡ fc98f7bc-ec3c-4762-9610-a0a7bf229044
md"
#### Algumas funções essenciais
"

# ╔═╡ b1c29562-c61c-455b-a425-29e6fb8d88d2
md"
##### Função linear

$$y = f(x) = mx + b$$

| Parâmetro |      Significado      |
|:-----------|-------------:|
| $m$  |  coeficiente angular da reta |
| $b$  |    intersecção com eixo $y$   |

"

# ╔═╡ 87cc1d35-2794-49bf-b691-f5c07d9fa04a
begin
	coef_angular = @bind m Slider(-2:0.1:2, default=1)
	inter = @bind b Slider(0:0.1:3, default=1)	

	md"""
	* Qual o efeito sobre o gráfico de uma função linear quando os coeficientes se alteram?
	
	Coeficiente angular: $(coef_angular)
	
	Intercepto: $(inter)
	"""
end

# ╔═╡ 48404bf6-915f-4d46-8504-da2154974982
begin
	plot(range(-3, 3, 200), x-> m*x + b, lc=:indianred, label="f(x) = $(m)x + $(b)")
	plot!(range(-3, 3, 200), x-> x + 1, lc=:navyblue, label=L"f(x) = x + 1")
	xlims!(-3, 3)
	ylims!(-6, 6)
	vline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
end

# ╔═╡ 6a9739fc-6bb4-4bf9-91c8-1c5adcf25f43
md"
##### Funções polinomiais

$$f(x) = a_n x^n + a_{n-1}x^{n-1} + \dots + a_2 x^2 + a_1 x + a_0, \qquad n \in \mathbb{Z}_+$$

| $n$ |      Tipo de função      |
|:-----------|-------------:|
| 0  |  constante |
| 1  |    linear  |
| 2 | quadrática |
| 3 | cúbica |
| n | polinomial de grau $n$ |
"

# ╔═╡ ae21f1d6-90ac-4e19-8471-8bc2f9fcf251
begin
	plot(range(-1, 1, 200), x -> 0, lc=:indianred, label=L"n = 0")
	plot!(range(-1, 1, 200), x -> x, lc=:pink, label=L"n = 1")
	plot!(range(-1, 1, 200), x -> x^2, lc=:black, label=L"n = 2")
	plot!(range(-1, 1, 200), x -> x^3, lc=:navyblue, label=L"n = 3")
	plot!(range(-1, 1, 200), x -> x^5, lc=:darkgreen, label=L"n = 5")
	hline!([0], ls=:dash, lw=0.5, lc=:black, label=:none)
	vline!([0], ls=:dash, lw=0.5, lc=:black, label=:none)
end

# ╔═╡ 35f264bf-57a5-4ef2-860a-3920329a3104
md"
##### Funções racionais

$$f(x) = \frac{p(x)}{q(x)}$$

onde $p$ e $q$ são funções polinomiais.
"

# ╔═╡ 12fca25f-3f0e-4477-a078-5a0f89b91fd4
begin
	plot(range(-5,-2.1,100), x->(2*x^4-x^2+1)/(x^2-4), lc=:indianred, label=:none)
	plot!(range(-1.9,1.9,100), x->(2*x^4-x^2+1)/(x^2-4), lc=:indianred, label=:none)
	plot!(range(2.1,5,100), x->(2*x^4-x^2+1)/(x^2-4), lc=:indianred, label=L"f(x) = \frac{2x^4-x^2+1}{x^2-4}")
	vline!([-2, 2], lc=:black, ls=:dash, lw=0.5, label=:none)
	hline!([0], lc=:black, ls=:dash, lw=0.5, label=:none)
end

# ╔═╡ 8caa387a-7dc9-43b3-a580-a69a630d47f6
md"
##### Funções exponenciais

$$f(x) = Ab^x, \qquad b>0$$
"

# ╔═╡ 67739b5a-4291-4a8c-8e2d-767628f19427
begin
	l1 = @layout [a b]
	pp1 = plot(range(-5, 5, 100), x -> 2^x, lc=:indianred, label=L"f(x) = 2^x")
	vline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
	pp2 = plot(range(-5, 5, 100), x -> 0.5^x, lc=:indianred, label=L"f(x) = (0,5)^x")	
	vline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)	
	plot(pp1, pp2, layout = l1)
end

# ╔═╡ 1c1a6301-e4ba-4290-97ae-fb381221d9c9
md"
##### Funções logarítmicas
$$f(x) = \log_b x, \qquad b > 0$$
"

# ╔═╡ 294274bd-c4be-442b-8ae9-b556a46c551d
begin
	plot(range(0.05, 5, 200), x -> log(2, x), label=L"f(x) = \log_2 x")
	plot!(range(0.05, 5, 200), x -> log(3, x), label=L"f(x) = \log_3 x")
	plot!(range(0.05, 5, 200), x -> log(5, x), label=L"f(x) = \log_5 x")
	plot!(range(0.05, 5, 200), x -> log(10, x), label=L"f(x) = \log_{10} x")
	hline!([0], lc=:black, lw=1, label=:none, ls=:dash)
end

# ╔═╡ f0788b7d-a35d-4d12-a873-04a09cd023b8
md"
#### Propriedades de funções
"

# ╔═╡ b3c3b1d7-640d-4a4c-893a-e22308905547
md"""
!!! info "Propriedades de funções"
	Dadas duas funções de valores reais $f$ e $g$, temos:

	| Função | Expressão |
	| :--- | ---: |
	| Soma (diferença) | $(f \pm g)(x) = f(x) \pm g(x)$ |
	| Produto | $(f \cdot g)(x) = f(x) \cdot g(x)$ |
	| Quociente | $(\frac{f}{g})(x) = \frac{f(x)}{g(x)}$ |
	| Mult. por constante | $(c \cdot f)(x) = c \cdot f(x), \quad c \in \mathbb{R}$ |
	| Composta | $(f \circ g)(x) = f(g(x))$ |
"""

# ╔═╡ d50a78a7-7a4e-4a3c-aa92-c394145e4a3f
md"
### Funções multivariadas
"

# ╔═╡ aa8762cd-ebd0-4606-b5f4-031e23984da6
md"""
!!! correct "Definição (Função de n variáveis)"
	Uma função com $n$ variáveis é uma regra que associa um número $y = f(x_1, \dots, x_n)$ a uma $n$-upla $(x_1, \dots, x_n)$ de números reais.
"""

# ╔═╡ 65152e1a-8e13-47bc-a937-15427a22a817
md"""
!!! correct "Definição (Gráfico de uma função)"
	Seja $f: U \subset \mathbb{R}^n \to \mathbb{R}$. Defina o **gráfico** de $f$ como o subconjunto do $\mathbb{R}^{n+1}$ que consiste de todos os pontos

	$$(x_1, \dots, x_n, f(x_1, \dots, x_n))$$

	no $\mathbb{R}^{n+1}$ para $(x_1, \dots, x_n) \in U$.
"""

# ╔═╡ 7252c6da-1baf-4278-8578-a4af3d6f5224
md"
* Se $n = 1$, o gráfico é uma curva no $\mathbb{R}^2$
"

# ╔═╡ 64d04542-7bb8-4942-b9c2-0159283b7258
begin
	plot(range(1, 3, 200), x -> x / (2 + x^2), label=L"Gráfico de $f$")
	scatter!([(1, 1/3), (3, 3 / 11)], mc=:indianred, ms=5, label=:none)
	plot!(Shape([(1, 0), (3, 0)]), label=:none)
	annotate!([(2, 0.015, L"U")])
	scatter!([(1, 0), (3, 0)], mc=:indianred, ms=5, label=:none)
	xlims!(0.5, 3.5)
	ylims!(0, 0.5)
end

# ╔═╡ c4c7c634-8537-49dc-af39-44ab0e861e52
md"
* Se $n = 2$, o gráfico de $f$ é uma **superfície** no $\mathbb{R}^3$
"

# ╔═╡ b2fc9fcb-755f-4859-a92a-4f9a8956bb5e
md"
Exemplo: gráfico da função $f(x, y) = xe^{-x^2-y^2}$
"

# ╔═╡ 2d51d1d7-c132-4aeb-9d25-1407c47e3edb
begin	
	k = range(-3, 3, length=100)	
	surface(
	  k, k, (x, y)-> x * exp(-x^2 -y^2), c=:bone_1, legend=:none, 
	  nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH, camera=(40,20)
	)
end

# ╔═╡ 2b1d2698-f8b4-436a-b9b2-bbe94a117a43
md"
Exemplo: gráfico da função $f(x, y) = (x^2 + 3y^2) e^{1-x^2-y^2}$
"

# ╔═╡ eeae1a73-4bd7-4cd2-b540-17e97ed6fdbf
begin	
	kk = range(-2, 2, length=100)	
	surface(
	  kk, kk, (x, y)-> (x^2 + 3*y^2)*exp(1-x^2-y^2), c=:bone_1, legend=:none, 
	  nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH, camera=(60,30)
	)
end

# ╔═╡ a4ad1361-7d89-49b9-b2e4-7eea126062b7
md"
* Quando $n = 3$ é difícil visualizar o gráfico.

Como nós, humanos, vivemos em um mundo tridimensional, é difícil imaginar conjuntos no $\mathbb{R}^4$.

Para ajudar nesta dificuldade, introduzimos a ideia de um **conjunto de nível**

---
"

# ╔═╡ 204b7628-3490-4965-874a-f89163b4fc6a
md"
Suponha $f(x,y,z) = x^2 + y^2 + z^2$. Um **conjunto de nível** é um subconjunto do $\mathbb{R}^3$ no qual $f$ é constante.

Por exemplo, o conjunto no qual $x^2 + y^2 + z^2 = 1$ é um conjunto de nível para a função $f$.

Isso nós conseguimos visualizar, é uma esfera de raio 1 no $\mathbb{R}^3$
"

# ╔═╡ 6e55a7a0-2ede-4b39-9c54-159e4913ffc5
md"
---

Formalmente, um conjunto de nível é o conjunto de $(x,y,z)$ para o qual $f(x,y,z) = c$, onde $c$ é uma constante.

O comportamento ou estrutura de uma função é determinado, em partes, pelo formato de seus conjuntos de nível.

---

Conjuntos de nível também são úteis para a compreensão de funções bivariadas $f(x,y)$, neste caso, falamos de **curvas de nível** ou **contornos de nível**.
"

# ╔═╡ ef859de2-cbc9-4499-aaff-4485d47143e7
md"""
!!! correct "Definição (Curvas e superfícies de nível)"
	Seja $f: U \subset \mathbb{R}^n \to \mathbb{R}$ e seja $c \in \mathbb{R}$. Então, o **conjunto de nível $c$** é definido como o conjunto de pontos $x \in U$ nos quais $f(x) = c$.

	* Se $n = 2$, falamos de uma **curva de nível** (de valor $c$).

	* Se $n 3$, falamos de uma **superfície de nível** (de valor $c$).

	Formalmente, o conjunto de nível de valor $c$ é definido por:

	$$\{x \in U| f(x) = c\} \subset \mathbb{R}^n$$.

	Note que o conjunto de nível está sempre no espaço do domínio
"""

# ╔═╡ f93ac318-bc12-4942-8f81-48fc0bbd1944
md"""
A temperatura $T$ em um ponto da superfície da Terra, em um dado instante de tempo, depende da longitude $x$ e da latitude $y$ do ponto: $T = f(x,y)$.

Podemos traçar as curvas de nível para a função temperatura, que neste caso são chamadas **isotérmicas**, que ligam localidades que têm a mesma temperatura.

A Figura abaixo mostra um mapa de clima indicando as temperaturas médias do mês de julho.

$(Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula2_temperatura.png", :width => 800))
"""

# ╔═╡ 06df759c-58b3-4de4-9cf1-375119b724d9
md"
* Exemplo - gráfico e curvas de nível da função $f(x,y) = x^2 + y^2$
"

# ╔═╡ 5aeb2bf1-fac6-4111-bc5a-dc6f79c4e62d
begin		
	k1 = range(-2, 2, length=100)	
	level_plot = @layout [a b]
	level1 = surface(
	  k1, k1, (x, y)-> x^2 + y^2, c=:bone_1, legend=:none, 
	  nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH, camera=(40,20)
	)
	level2 = contour(k1, k1, (x, y)-> x^2 + y^2, c=:bone_1, legend=:none, levels = [1, 2, 3, 4], clabels=true)	
	plot(level1, level2, layout = level_plot)	
end

# ╔═╡ d784bd85-4e11-4510-8549-c43d6655c216
md"""
!!! warning "Exercício"
	Esboce as curvas de nível da função $f(x,y) = 6 - 3x - 2y$ para os valores $k = -6, 0, 6, 12$.
"""

# ╔═╡ 30a55b1d-b8fc-4a7e-960b-324151f10812
md"""
!!! hint "Resolução"
	As curvas de nível são $6 - 3x - 2y = k$ ou $3x + 2y + (k - 6) = 0.

	Essa é uma família de retas com inclinação $-\frac{3}{2}$.	
"""

# ╔═╡ 5d32162d-3314-4d15-8eb5-4fc158fe19e5
begin			
	x1 = range(-6, 6, length=100)	
	contour(x1, x1, (x, y)-> 6 - 3*x - 2*y, c=:bone_1, legend=:none, levels = [-6, 0, 6, 12], clabels=true)
	vline!([0], lw=1, ls=:dash, lc=:black, label=:none)
	hline!([0], lw=1, ls=:dash, lc=:black, label=:none)
end

# ╔═╡ c26a23f3-76d3-43e6-a6bc-d578ffbe468c
md"""
!!! info "Função Cobb-Douglas"
	Em 1928, [Charles Cobb](https://en.wikipedia.org/wiki/Charles_Cobb_(economist)) e [Paul Douglas](https://en.wikipedia.org/wiki/Paul_Douglas) modelaram o crescimento da economia norte-americana de 1899-1922.

	Supondo uma função de produção do tipo:

	$$F(K, L) = A K^{\alpha}L^{1-\alpha}$$

	Por MQO, Cobb e Douglas estimaram a seguinte função de produção para a economia dos EUA no período amostral:
	
	$$F(K, L) = 1,01 K^{0,25}L^{0,75}$$
"""

# ╔═╡ 10863783-346c-4795-aa08-d73a6723690c
begin		
	k2 = range(0, 300, length=200)	
	cobb_plot = @layout [a b]
	cobb1 = surface(
	  k2, k2, (x, y)-> 1.01 * x^0.25 * y^0.75, c=:bone_1, legend=:none, 
	  nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH, camera=(40,20)
	)
	cobb2 = contour(k2, k2, (x, y)-> 1.01 * x^0.25 * y^0.75, c=:bone_1, legend=:none, levels = [100, 120, 140, 160, 180, 200, 220, 240], clabels=true)	
	plot(cobb1, cobb2, layout = cobb_plot)	
end

# ╔═╡ 5aeaabaf-3525-4987-bc01-425329b3976c
md"
* Curvas de nível para as funções apresentadas anteriormente
"

# ╔═╡ 11ac601f-f962-4b87-8df4-1b8d7953df16
begin		
	g1x = range(-2, 2, length=100)	
	g1_plot = @layout [a b]
	g1 = surface(
	  g1x, g1x, (x, y)-> x * exp(-x^2 -y^2), c=:bone_1, legend=:none, 
	  nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH, camera=(40,20)
	)
	g2 = contour(g1x, g1x, (x, y)-> x * exp(-x^2 -y^2), c=:summer, legend=:none, levels = 10, clabels=false, fill=true, alpha=0.3)	
	plot(g1, g2, layout = g1_plot)	
end

# ╔═╡ 1da178be-a030-4a85-bd69-9e17c754f80a
begin		
	f1x = range(-2, 2, length=100)	
	f1_plot = @layout [a b]
	f1 = surface(
	  f1x, f1x, (x, y)-> (x^2 + 3*y^2)*exp(1-x^2-y^2), c=:bone_1, legend=:none, 
	  nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH, camera=(40,20)
	)
	f2 = contour(f1x, f1x, (x, y)-> (x^2 + 3*y^2)*exp(1-x^2-y^2), c=:summer, legend=:none, levels = 10, clabels=false, fill=true, alpha=0.3)	
	plot(f1, f2, layout = f1_plot)	
end

# ╔═╡ a8ee00ce-4ac3-4c99-b919-9f0b3893170b
md"
## Brevíssima revisão de cálculo diferencial
"

# ╔═╡ 69303d2e-f470-4458-9783-d3f20f39f655
md"
### Funções univariadas
"

# ╔═╡ e7a4b998-a471-4e5b-a940-ce11a4501c32
md"
* Um tópico importante em muitas disciplinas científicas, incluindo economia, é o estudo do quão rápido quantidades mudam ao longo do tempo
* Para calcular a posição futura de um planeta, prever o crescimento populacional de uma espécie biológica, ou para estimar a demanda futura de uma determinada _commodity_, precisamos de informações acerca das taxas de variação
* O conceito usado para descrever a taxa de variação de uma função é o de **derivada**
* Em economia, seja $C = f(Q)$ a função custo total, onde $C$ denota o custo total e $Q$ a quantidade produzida, o **custo marginal** é definido como a variação no custo total resultante de uma pequena variação (_infinitesimal_) na quantidade produzida
* Vimos, em fundamentos de economia, que o custo marginal pode ser medido pela inclinação da reta tangente à curva de custo total, que nada mais é que o limite da razão $\Delta C/\Delta Q$ quando $\Delta Q$ tende a zero
* Assim, o conceito de inclinação da reta tangente a uma curva é a contrapartida geométrica do conceito de derivada
"

# ╔═╡ d3e0653d-2eba-4942-9e36-a9b696f4c0ea
md"
---

**Problema da tangente**

* Considere o problema de determinação de uma reta tangente a uma curva com equação $y = f(x)$, em um dado ponto $P$.
* Como $P$ é um ponto sobre a reta tangente, podemos determinar a equação da reta se conhecermos sua inclinação $m$.
* No entanto, para determinarmos a inclinação $m$, é necessário conhecer dois pontos e, sobre a reta tangente, conhecemos apenas o ponto $P$.
"

# ╔═╡ f4000d95-ab90-453d-917f-74a8b3af4265
begin
	gg(x) = - (x - 3)^2 + 5
	c_ang = 2
	plot(range(1, 4, 100), x -> gg.(x), label=:none, lc=:indianred)
	plot!(range(0, 4, 100), x -> c_ang * x, label=:none, lc=:navyblue)	
	xlims!(0, 5)
	ylims!(0, 6.5)
	scatter!((2, 4), label=:none, ms=7, mc=:black)
	annotate!([(1.85, 4.25, ("P", 16, :top, :black))])	
end

# ╔═╡ bea0cfd8-c588-45fc-ad7e-9487cb37de4a
md"
* Para contornar este problema, determinamos primeiro uma aproximação para a inclinação $m$, tomando sobre a curva um ponto próximo e arbitrário $Q$ e calculando a inclinação $m_{PQ}$ da reta secante $PQ$:
$$m_{PQ} = \frac{f(h) - f(a)}{h - a}.$$
* Tente, na Figura abaixo, mover o ponto $Q$ ao longo da curva em direção ao ponto $P$.
* Nota-se que a reta secante gira e aproxima-se da reta tangente como sua posição limite.
* Isso significa que a inclinação $m_{PQ}$ da reta secante fica cada vez mais próxima da inclinação $m$ da reta tangente:
$$m = \lim_{Q \to P} m_{PQ}.$$
* Dito de otura forma:
$$m = \lim_{h \to a} \frac{f(h) - f(a)}{h - a}.$$
"

# ╔═╡ 166594cd-43ac-48c3-8e3e-da54d1f06b66
begin
	h_sec = @bind h Slider(range(2, 3.5, 100), default = 3.5)
	md"""
	Ponto sobre a reta secante: 
	
	h = $(h_sec)
	"""
end

# ╔═╡ 5b287394-da61-4264-bd85-10544b969bd6
begin
	plot(range(1, 4, 100), x -> gg(x), label=:none, lc=:indianred)
	plot!(range(0, 4, 100), x -> c_ang * x, label=:none, lc=:navyblue)
	plot!(range(0, 4, 100), x -> ((gg(h) - gg(2))/(h-2)) * (x - 2) + gg(2), label=:none, lc=:darkgreen)
	xlims!(0, 5)
	ylims!(0, 6.5)
	scatter!((2, 4), label=:none, ms=7, mc=:black)
	annotate!([(1.85, 4.25, ("P", 16, :top, :black))])
	vline!([2], ls=:dash, lw=1, lc=:black, label=:none)
	vline!([h], ls=:dash, lw=1, lc=:black, label=:none)
	annotate!([(h, -0.04, ("h", 16, :top, :white))])
end

# ╔═╡ b503a055-7c56-44ba-8f4c-c1a469db605f
md"""
!!! correct "Definição (Derivada)"
	A **derivada de uma função $f$ em um número $a$**, denotada por $f'(a)$, é dada por:

	$$f'(a) = \lim_{h \to 0}\frac{f(a + h) - f(a)}{h}$$

	Neste caso, dizemos que a função $f$ é **diferenciável** no ponto $a$.

	Se a função $f$ é diferenciável em todos os pontos de seu domínio, dizemos que $f$ é uma função diferenciável
"""

# ╔═╡ 752af5cc-0559-4337-a850-fd2063d8cc76
md"
### Regras de derivação
"

# ╔═╡ 87391628-d113-4a99-a733-40bdc9b81e6c
md"
| Primitiva | Derivada |
| :--- | ---: |
| $f(x) = c$ | $f'(x) = 0$ |
| $f(x) = x^n$ | $f'(x) = nx^{n-1}$ |
| $(f \pm g)(x)$ | $(f \pm g)'(x) = f'(x) \pm g'(x)$ |
| $(f \cdot g)(x)$ | $(f \cdot g)'(x) = f'(x) \cdot g(x) + f(x) \cdot g'(x)$ |
| $(\frac{f}{g})(x)$ | $(\frac{f}{g})'(x) = \frac{f'(x) \cdot g(x) - f(x) \cdot g'(x)}{g(x)^2}$ |
| $(f\circ g)(x)$ | $(f\circ g)'(x) = f'(g(x)) \cdot g'(x)$ |
| $f(x) = e^x$ | $f'(x) = e^x$ |
| $f(x) = a^x$ | $f'(x) = a^x \ln a$ |
| $f(x) = \ln x$ | $f'(x) = \frac{1}{x}$ |
"

# ╔═╡ a75ed21a-e592-4662-b324-aa4f601df058
md"
* A derivada de uma derivada é chamada de segunda derivada (ou derivada de segunda ordem) é denotada por $f''(x)$
"

# ╔═╡ ea6beea4-ad98-4787-aed2-daab0d686342
md"""
!!! warning "Exercícios"
	* Encontre as derivadas das seguintes funções:
	    *  $f(x) = (2 - x^2)^3$
	    *  $f(x) = (x^3 + x^2)^{50}$
	    *  $f(x) = \sqrt{x^2 + 1}$
	    *  $f(x) = \frac{3x-5}{x-2}$
	* Encontre a primeira e segunda derivadas das seguintes funções:
	    *  $f(x) = x^3 + e^x$
	    *  $f(x) = \frac{e^x}{x}$
	    *  $f(x) = x^2\ln x$
"""

# ╔═╡ e3559b36-8827-4c4a-a409-759177b785ed
md"""
!!! correct "Definição (Diferencial)"
	Seja $y = f(x)$ uma função contínua e diferenciável, denote uma variação arbitrária na variável $x$ por $dx$.

	Neste caso, a expressão $f'(x)dx$ é chamada o **diferencial** de $y = f(x)$ e é denotada por $dy$, de modo que:

	$$dy = f'(x)dx$$

	Ou seja, $dy$ é proporcional a $dx$, com $f'(x)$ como o fator de proporcionalidade.
"""

# ╔═╡ f57ea9d0-f910-4928-bed8-9489f5bbf4b8
md"
### Funções multivariadas
"

# ╔═╡ 82ade8f5-ccaa-482c-aaa3-3ee1df8ede9a
md"
* Para o caso em que temos uma função de $n$ variáveis $f(x_1, \dots, x_n)$, a ideia de uma derivada como definida anteriormente não é bem definida (a inclinação de uma função depende da direção em que é tomada)
* Usualmente, as inclinações direcionais de interesse são aquelas obtidas quando variamos um dos argumentos da função enquanto mantemos os demais constantes
* Estas inclinações direcionais são chamadas **derivadas parciais** da função $f$ e denotamos por:
$$\frac{\partial f}{\partial x_i}, \quad f_{x_i}, \quad f_i$$
"

# ╔═╡ 4e8f1574-ea71-4d6f-b19b-1bbaa7e2b8a9
md"""
!!! correct "Definição (Derivada parcial)"
	Sem perda de generalidade, a derivada parcial da função $f(x_1, \dots, x_n)$ com relação a $x_1$ é definida, formalmente, por:

	$$\left.\frac{\partial f}{\partial x_1}\right|_{\bar{x}_2, \dots, \bar{x}_n} = f_1 = \lim_{h \to 0} \frac{f(x_1 + h, \bar{x}_2, \dots, \bar{x}_n) - f(x_1, \bar{x}_2, \dots, \bar{x}_n)}{h}$$
"""

# ╔═╡ ab7f17ba-946d-4711-b443-84eb595c70f6
md"
A derivada parcial de uma derivada parcial é chamada **derivada parcial de segunda ordem**:

$$\frac{\partial(\partial f/\partial x_i)}{\partial x_j} = \frac{\partial^2 f}{\partial x_i \partial x_j} = f_{ij}$$
"

# ╔═╡ e76a2e5b-a3bd-4d10-af8a-ab1a0b0141ee
md"""
!!! danger "Teorema - Simetria das segundas derivadas"
	Simetria das segundas derivadas para a função $f(x_1, \dots, x_n)$:

	$$\frac{\partial^2 f}{\partial x_i \partial x_j} = \frac{\partial^2 f}{\partial x_j \partial x_i}$$
"""

# ╔═╡ bc416426-2077-4327-88b2-4749b49402b2
md"""
> O teorema apenas enunciado também é conhecido como Teorema de [Young](https://en.wikipedia.org/wiki/William_Henry_Young), Teorema de [Clairaut](https://en.wikipedia.org/wiki/Alexis_Clairaut) ou Teorema de [Schwarz](https://en.wikipedia.org/wiki/Hermann_Schwarz)
"""

# ╔═╡ c05208c6-e0c5-4822-8f5b-353b59d1cb68
md"""
!!! warning "Exercícios"
	* Encontre as derivadas parciais de primeira e segunda ordem das seguintes funções:
	    *  $f(x_1, x_2) = ax_1^2 + bx_1x_2 + cx_2^2$
	    *  $f(x_1, x_2) = e^{ax_1 + bx_2}$
	    *  $f(x_1, x_2) = a\ln x_1 + b\ln x_2$
"""

# ╔═╡ b3c9026a-faae-42eb-b4c9-30b541e1c023
md"""
!!! correct "Definição (Diferencial total)"
	Seja $y = f(x_1, \dots, x_n)$ uma função contínua e diferenciável, o diferencial total de primeira ordem de $y = f(\textbf{x})$, denotado por $dy$ ou $df$, é dado por:

	$$dy = df = \frac{\partial f}{\partial x_1} dx_1 + \dots + \frac{\partial f}{\partial x_n} dx_n = \sum_{i=1}^n f_i dx_i$$
"""

# ╔═╡ f1129478-d95b-4643-97ff-35bdcacf5e09
md"""
!!! warning "Exercícios"
	* Encontre o diferencial total de primeira ordem das seguintes funções:
	    *  $f(x, y) = xy$
	    *  $Y = F(K, L)$
	    *  $f(x, y) = xy^2 + x^3$
"""

# ╔═╡ 0568038c-f3ca-4f1a-baf1-209b541dbf94
md"
## Aproximação por funções polinomiais: Teorema de Taylor
"

# ╔═╡ 0b00fa9a-5e83-499a-84db-f690253bd5ad
PlutoUI.Resource("https://upload.wikimedia.org/wikipedia/commons/2/25/BTaylor.jpg", :width => 300)

# ╔═╡ 5fd9fa21-ed94-483a-b380-dd280361689e
md"
* Grande parte da análise econômica moderna é dependente de métodos numéricos para **aproximar** as soluções dos modelos.
* Portanto, ao invés de trabalharmos com funções que podem ser complicadas, é de grande conveniência analítica, em inúmeras situações, trabalharmos com aproximações polinomiais da nossa função inicial.
* O [**teorema de Taylor**](https://en.wikipedia.org/wiki/Taylor's_theorem) nos permite aproximar uma função diferenciável $f$ ao redor de um ponto $x_0$ mediante um polinômio cujos coeficientes dependem das derivadas da função $f$ avaliadas neste ponto.
"

# ╔═╡ c6a9a001-aec0-4568-8992-bf658b961c4b
md"""
!!! correct "Teorema (Aproximação de Taylor)"
	Seja $n \geq 0$ um número inteiro e $f$ uma função univariada $n$ vezes diferenciável no intervalo fechado $[x_0, x]$ e $n + 1$ no intervalo aberto $(x_0, x)$, então, a aproximação de Taylor da função $f(x)$ ao redor do ponto $x_0$ é dada por:

	$$f(x) \approx f(x_0) + \frac{f'(x_0)}{1!}(x - x_0) + \frac{f''(x_0)}{2!}(x-x_0)^2 + \dots + \frac{f^{(n)}(x_0)}{n!}(x-x_0)^n$$
"""

# ╔═╡ 898e1951-b489-4cb7-b0ac-0f99772155e6
md"""
!!! warning "Exercício"
	* Para um número natural $n$ qualquer, obtenha a expansão de Taylor de $n$-ésima ordem da função $f(x) = e^x$ ao redor do ponto $x = 0$.
"""

# ╔═╡ 0f10cf50-c5bd-49f7-9d17-5e70796bad78
begin
	taylorn1 = @bind taylorn1 Slider(range(0, 10, 11), default = 1)
	md"""
	Ordem de aproximação: 
	
	n = $(taylorn1)
	"""
end

# ╔═╡ 99f62ccd-eca8-45c1-ad4f-693fb55361f4
begin	
	x = range(-3, 3, 200)
	taylor1(x) = exp.(x)
	taylor1_approx = taylor_expand(taylor1, 0; order = Int(taylorn1))
	plot(x, taylor1(x), label=L"f(x) = e^x")
	plot!(x, taylor1_approx.(x), label="Aproximação ordem $taylorn1")
	hline!([0], lw=1, lc=:black, ls=:dash, label=:none)
	vline!([0], lw=1, lc=:black, ls=:dash, label=:none)
end

# ╔═╡ 516ec22b-a158-4c87-9a4f-d5d3c4f8a7e3
md"""
!!! warning "Exercício"
	* Obtenha uma aproximação quadrática para a função $f(x) = (1 + x)^5$ ao redor do ponto $x = 0$.
"""

# ╔═╡ 4e8a3cc5-d721-4854-a1d1-da94a3c17415
begin
	taylor2n = @bind taylor2n Slider(range(0, 10, 11), default = 1)
	md"""
	Ordem de aproximação: 
	
	n = $(taylor2n)
	"""
end

# ╔═╡ e7309153-c9e8-4daa-934b-321defe4b843
begin	
	xx = range(-2, 2, 200)
	taylor2(x) = (1 .+ x).^5
	taylor2_approx = taylor_expand(taylor2, 0; order = Int(taylor2n))
	plot(xx, taylor2(xx), label=L"f(x) = e^x")
	plot!(xx, taylor2_approx.(xx), label="Aproximação ordem $taylor2n")
	hline!([0], lw=1, lc=:black, ls=:dash, label=:none)
	vline!([0], lw=1, lc=:black, ls=:dash, label=:none)
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Measures = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
TaylorSeries = "6aa5eb33-94cf-58f4-a9d0-e4b2c4fc25ea"

[compat]
LaTeXStrings = "~1.3.0"
Measures = "~0.3.2"
Plots = "~1.38.6"
PlutoUI = "~0.7.50"
TaylorSeries = "~0.13.2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.0"
manifest_format = "2.0"
project_hash = "fd2ce5e3c39db3a05fe4c19e30eb349c1480a8fa"

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
git-tree-sha1 = "c6d890a52d2c4d55d326439580c3b8d0875a77d9"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.15.7"

[[deps.ChangesOfVariables]]
deps = ["LinearAlgebra", "Test"]
git-tree-sha1 = "485193efd2176b88e6622a39a246f8c5b600e74e"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.6"
weakdeps = ["ChainRulesCore"]

    [deps.ChangesOfVariables.extensions]
    ChangesOfVariablesChainRulesCoreExt = "ChainRulesCore"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "9c209fb7536406834aa938fb149964b985de6c83"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.1"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Random", "SnoopPrecompile"]
git-tree-sha1 = "aa3edc8f8dea6cbfa176ee12f7c2fc82f0608ed3"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.20.0"

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
deps = ["Dates", "LinearAlgebra", "UUIDs"]
git-tree-sha1 = "61fdd77467a5c3ad071ef8277ac6bd6af7dd4c04"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.6.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.2+0"

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
git-tree-sha1 = "660b2ea2ec2b010bb02823c6d0ff6afd9bdc5c16"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.71.7"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "d5e1fd17ac7f3aa4c5287a61ee28d4f8b8e98873"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.71.7+0"

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
deps = ["Base64", "CodecZlib", "Dates", "IniFile", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "37e4657cd56b11abe3d10cd4a1ec5fbdb4180263"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.7.4"

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

[[deps.IniFile]]
git-tree-sha1 = "f550e6e32074c939295eb5ea6de31849ac2c9625"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.1"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "49510dfcb407e572524ba94aeae2fced1f3feb0f"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.8"

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
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

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
git-tree-sha1 = "2422f47b34d4b127720a18f86fa7b1aa2e141f29"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.18"

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
git-tree-sha1 = "6503b77492fd7fcb9379bf73cd31035670e3c509"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.3.3"

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
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+0"

[[deps.Parsers]]
deps = ["Dates", "SnoopPrecompile"]
git-tree-sha1 = "6f4fbcd1ad45905a5dee3f4256fabb49aa2110c6"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.7"

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
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "SnoopPrecompile", "Statistics"]
git-tree-sha1 = "c95373e73290cf50a8a22c3375e4625ded5c5280"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.3.4"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "Preferences", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SnoopPrecompile", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "da1d3fb7183e38603fcdd2061c47979d91202c97"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.38.6"

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
git-tree-sha1 = "5bb5129fdd62a2bbbe17c2756932259acf467386"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.50"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

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
deps = ["SnoopPrecompile"]
git-tree-sha1 = "261dddd3b862bd2c940cf6ca4d1c8fe593e457c8"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.3"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "RecipesBase", "SnoopPrecompile"]
git-tree-sha1 = "e974477be88cb5e3040009f3767611bc6357846f"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.11"

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
git-tree-sha1 = "f94f779c94e58bf9ea243e77a37e16d9de9126bd"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.1"

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

[[deps.SnoopPrecompile]]
deps = ["Preferences"]
git-tree-sha1 = "e760a70afdcd461cf01a575947738d359234665c"
uuid = "66db9d55-30c0-4569-8b51-7e840670fc0c"
version = "1.0.3"

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
git-tree-sha1 = "f9af7f195fb13589dd2e2d57fdb401717d2eb1f6"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.5.0"

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

[[deps.TaylorSeries]]
deps = ["LinearAlgebra", "Markdown", "Requires", "SparseArrays"]
git-tree-sha1 = "31834a05c8a9d52d7f56b23ae7ad1c3b72a4f1bf"
uuid = "6aa5eb33-94cf-58f4-a9d0-e4b2c4fc25ea"
version = "0.13.2"

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
git-tree-sha1 = "94f38103c984f89cf77c402f2a68dbd870f8165f"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.11"

[[deps.Tricks]]
git-tree-sha1 = "6bac775f2d42a611cdfcd1fb217ee719630c4175"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.6"

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
git-tree-sha1 = "c6edfe154ad7b313c01aceca188c05c835c67360"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.4+0"

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
# ╟─60438d3e-b977-11ed-2c3f-31fcfeed2a61
# ╟─1f8cd57d-7e54-4b61-8f6b-6176fa8c4393
# ╟─5d2ecc37-03e6-4eec-8e8e-e18bdd5ac910
# ╟─24c71569-6341-4bc4-a672-985a95b9efb8
# ╟─3709a461-a301-4843-b78a-fc8c7bfa6ee5
# ╟─90b94b6d-4004-43ae-88bd-41788fac1a13
# ╟─e0cd5b85-d359-46b2-aa1d-58ada1f8d44f
# ╟─d43a49ea-8f4d-4977-aa8b-c08e7feab890
# ╟─e7927a74-ffa0-49c1-b6df-c7a820d08774
# ╟─442072e0-2db7-4a43-8957-d92432f451a1
# ╟─0e281328-549c-4df8-a37c-2636524b1e24
# ╟─f04d1177-ecf7-4a3e-8209-3f551f23ebe4
# ╟─b3a32dd8-fe27-4075-a527-b55c79c10f02
# ╟─3a184a96-74c5-4c5c-8cf8-07e549453fc0
# ╟─c36feb6a-c799-44ba-ba59-ded251a94e2e
# ╟─fc98f7bc-ec3c-4762-9610-a0a7bf229044
# ╟─b1c29562-c61c-455b-a425-29e6fb8d88d2
# ╟─87cc1d35-2794-49bf-b691-f5c07d9fa04a
# ╟─48404bf6-915f-4d46-8504-da2154974982
# ╟─6a9739fc-6bb4-4bf9-91c8-1c5adcf25f43
# ╟─ae21f1d6-90ac-4e19-8471-8bc2f9fcf251
# ╟─35f264bf-57a5-4ef2-860a-3920329a3104
# ╟─12fca25f-3f0e-4477-a078-5a0f89b91fd4
# ╟─8caa387a-7dc9-43b3-a580-a69a630d47f6
# ╟─67739b5a-4291-4a8c-8e2d-767628f19427
# ╟─1c1a6301-e4ba-4290-97ae-fb381221d9c9
# ╟─294274bd-c4be-442b-8ae9-b556a46c551d
# ╟─f0788b7d-a35d-4d12-a873-04a09cd023b8
# ╟─b3c3b1d7-640d-4a4c-893a-e22308905547
# ╟─d50a78a7-7a4e-4a3c-aa92-c394145e4a3f
# ╟─aa8762cd-ebd0-4606-b5f4-031e23984da6
# ╟─65152e1a-8e13-47bc-a937-15427a22a817
# ╟─7252c6da-1baf-4278-8578-a4af3d6f5224
# ╟─64d04542-7bb8-4942-b9c2-0159283b7258
# ╟─c4c7c634-8537-49dc-af39-44ab0e861e52
# ╟─b2fc9fcb-755f-4859-a92a-4f9a8956bb5e
# ╟─2d51d1d7-c132-4aeb-9d25-1407c47e3edb
# ╟─2b1d2698-f8b4-436a-b9b2-bbe94a117a43
# ╟─eeae1a73-4bd7-4cd2-b540-17e97ed6fdbf
# ╟─a4ad1361-7d89-49b9-b2e4-7eea126062b7
# ╟─204b7628-3490-4965-874a-f89163b4fc6a
# ╟─6e55a7a0-2ede-4b39-9c54-159e4913ffc5
# ╟─ef859de2-cbc9-4499-aaff-4485d47143e7
# ╟─f93ac318-bc12-4942-8f81-48fc0bbd1944
# ╟─06df759c-58b3-4de4-9cf1-375119b724d9
# ╟─5aeb2bf1-fac6-4111-bc5a-dc6f79c4e62d
# ╟─d784bd85-4e11-4510-8549-c43d6655c216
# ╟─30a55b1d-b8fc-4a7e-960b-324151f10812
# ╟─5d32162d-3314-4d15-8eb5-4fc158fe19e5
# ╟─c26a23f3-76d3-43e6-a6bc-d578ffbe468c
# ╟─10863783-346c-4795-aa08-d73a6723690c
# ╟─5aeaabaf-3525-4987-bc01-425329b3976c
# ╟─11ac601f-f962-4b87-8df4-1b8d7953df16
# ╟─1da178be-a030-4a85-bd69-9e17c754f80a
# ╟─a8ee00ce-4ac3-4c99-b919-9f0b3893170b
# ╟─69303d2e-f470-4458-9783-d3f20f39f655
# ╟─e7a4b998-a471-4e5b-a940-ce11a4501c32
# ╟─d3e0653d-2eba-4942-9e36-a9b696f4c0ea
# ╟─f4000d95-ab90-453d-917f-74a8b3af4265
# ╟─bea0cfd8-c588-45fc-ad7e-9487cb37de4a
# ╟─166594cd-43ac-48c3-8e3e-da54d1f06b66
# ╟─5b287394-da61-4264-bd85-10544b969bd6
# ╟─b503a055-7c56-44ba-8f4c-c1a469db605f
# ╟─752af5cc-0559-4337-a850-fd2063d8cc76
# ╟─87391628-d113-4a99-a733-40bdc9b81e6c
# ╟─a75ed21a-e592-4662-b324-aa4f601df058
# ╟─ea6beea4-ad98-4787-aed2-daab0d686342
# ╟─e3559b36-8827-4c4a-a409-759177b785ed
# ╟─f57ea9d0-f910-4928-bed8-9489f5bbf4b8
# ╟─82ade8f5-ccaa-482c-aaa3-3ee1df8ede9a
# ╟─4e8f1574-ea71-4d6f-b19b-1bbaa7e2b8a9
# ╟─ab7f17ba-946d-4711-b443-84eb595c70f6
# ╟─e76a2e5b-a3bd-4d10-af8a-ab1a0b0141ee
# ╟─bc416426-2077-4327-88b2-4749b49402b2
# ╟─c05208c6-e0c5-4822-8f5b-353b59d1cb68
# ╟─b3c9026a-faae-42eb-b4c9-30b541e1c023
# ╟─f1129478-d95b-4643-97ff-35bdcacf5e09
# ╟─0568038c-f3ca-4f1a-baf1-209b541dbf94
# ╟─0b00fa9a-5e83-499a-84db-f690253bd5ad
# ╟─5fd9fa21-ed94-483a-b380-dd280361689e
# ╟─c6a9a001-aec0-4568-8992-bf658b961c4b
# ╟─898e1951-b489-4cb7-b0ac-0f99772155e6
# ╟─0f10cf50-c5bd-49f7-9d17-5e70796bad78
# ╟─99f62ccd-eca8-45c1-ad4f-693fb55361f4
# ╟─516ec22b-a158-4c87-9a4f-d5d3c4f8a7e3
# ╟─4e8a3cc5-d721-4854-a1d1-da94a3c17415
# ╟─e7309153-c9e8-4daa-934b-321defe4b843
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

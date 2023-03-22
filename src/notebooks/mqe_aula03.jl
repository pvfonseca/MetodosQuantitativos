### A Pluto.jl notebook ###
# v0.19.22

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

# ╔═╡ d0b3ef72-bc42-11ed-0872-07547ee82c64
begin
	using PlutoUI
	using Plots
	using LaTeXStrings
	using Measures
	import PlutoUI: combine	
	theme(:ggplot2)
	gr(size=(800,600), lw = 2, fontfamily = "Computer Modern", grid=true, tickfontsize = 12, guidefontsize=16, framestyle=:box, margin=3mm, right_margin=7mm, guidefonthalign=:right, guidefontvalign=:top)	
end

# ╔═╡ 78424b9c-44c1-4e61-ba01-09a2c82ad0b3
PlutoUI.TableOfContents(title="Sumário", indent=true)

# ╔═╡ 97474620-4abb-4192-bb6e-e95043044751
html"<button onclick=present()>Apresentação</button>"

# ╔═╡ a449c066-12df-4de5-bf24-46453c32bd8f
md"""
# Otimização estática irrestrita $(Resource("https://www1.udesc.br/imagens/id_submenu/899/cor_horizontal_rgb.jpg", :width => 150))
"""

# ╔═╡ e6556f3c-85e0-4dc9-b70b-dd7a48efce49
md"
* **Disciplina:** 33MQEI - Métodos Quantitativos em Economia I
* **Data:** 08/03/2023
* **Docente:** [Paulo Victor da Fonseca](https://pvfonseca.github.io)
* **Contato:** [paulo.fonseca@udesc.br](mailto:paulo.fonseca@udesc.br)
"

# ╔═╡ c22d4f93-d70a-4ba3-ab70-b11c2e98cb7c
md"""
!!! danger "Aviso"
	O texto que segue não tem a menor pretensão de originalidade. Ele serve apenas como registro dos principais princípios, conceitos e técnicas analíticas que são trabalhados em sala de aula.
"""

# ╔═╡ 69a948fc-76a4-4da6-b6bf-10cc1e4febb9
md"
## Introdução
"

# ╔═╡ 7791fbdb-31be-4f30-834c-c171c03282dd
md"
* Os processos econômicos são resultados das interações entre as decisões tomadas por inúmeros agentes econômicos
* Portanto, qualquer teoria econômica deve basear-se em algum modelo que especifique o processo de tomada de decisão desses agentes. Sejam eles agentes individuais, famílias, firmas ou governo
* Postulados acerca do comportamento com objetivos por parte dos agentes levou, naturalmente, ao desenvolvimento de modelos matemáticos que envolvem a maximização de alguma função que dependa de vários fatores
"

# ╔═╡ 4b9d61de-9581-48a9-9bbc-32e71170d45c
md"""
!!! warning "Racionalidade limitada"
	Recentemente, novas teorias tem sido desenvolvidas baseadas em, por exemplo, _racionalidade limitada_ e _satisficing_, como alternativa ao **modelo de escolha racional**.

	A abordagem de racionalidade limitada relaxa a hipótese de comportamento otimizador ou de expectativas modelo-consistentes (ou ambas). Para o aluno interessado, consultar o seguinte [**`link`**](https://plato.stanford.edu/entries/bounded-rationality).
"""

# ╔═╡ f29148d0-93eb-4b0a-a83e-339cb117aea2
md"""
Racionalidade limitada - autores:

$(Resource("https://www.nobelprize.org/images/simon-13300-content-portrait-mobile-tiny.jpg", :width => 160))

$(Resource("https://www.nobelprize.org/images/kahneman-13673-portrait-mini-2x.jpg", :width => 150))

$(Resource("https://www.nobelprize.org/images/smith-13674-content-portrait-mobile-tiny.jpg", :width => 160))

$(Resource("https://www.nobelprize.org/images/thaler-15229-content-portrait-mobile-tiny.jpg", :width => 150))

Figura (da esquerda para direita):
* [Herbert Simon](https://www.nobelprize.org/prizes/economic-sciences/1978/simon/biographical/)
* [Daniel Kahneman](https://www.nobelprize.org/prizes/economic-sciences/2002/kahneman/biographical/)
* [Vernon Smith](https://www.nobelprize.org/prizes/economic-sciences/2002/smith/biographical/)
* [Richard Thaler](https://www.nobelprize.org/prizes/economic-sciences/2017/thaler/biographical/)

"""

# ╔═╡ 202c0ec1-30d5-4b15-9a9d-8a5c61fb312f
md"
* No entanto, a teoria da otimização e o modelo de escolha racional continuam sendo os pilares da análise econômica
"

# ╔═╡ c830232d-ef99-41d9-a981-9d034e23f535
md"""
!!! info "Modelo de escolha racional"
	Modelos de escolha racional consistem de dois elementos:
	* Racionalidade individual: agentes econômicos tomam a **melhor** decisão dadas as oportunidades **percebidas**
	* Consistência mútua das ações: ações individuais são **mutuamente consistentes** (conhecimento comum de racionalidade e coordenação em um equilíbrio)

	Modelo de escolha racional = otimização + equilíbrio

	O que a racionalidade individual implica?
	* **Conhecimento do problema**: tomador de decisão tem pleno conhecimento do problema de decisão com que se depara e do conjunto de alternativas do qual tem de escolher
	* **Preferências claras**: ordenamento completo sobre o conjunto completo de alternativas
	* **Capacidade de otimizar**: possui as habilidades necessárias para realizar quaisquer cálculos complicados necessários para encontrar sua trajetória ótima de ações. Sua habilidade de calcular é ilimitada e não comete erros
	* **Indiferença a descrições logicamente equivalentes de alternativas e conjuntos escolhas**: Substituir uma descrição de alternativas por outra que seja "logicamente equivalente" não afeta a escolha
"""

# ╔═╡ adb820b1-c97e-4a24-9373-689c142b0221
md"
* Portanto, na maioria das vezes, o problema de otimização está sujeito a algum tipo de restrição
* Por exemplo, no modelo de maximização de utilidade, o consumidor tem por objetivo maximizar uma função utilidade sujeito à condição de que seu orçamento não seja extrapolado
* No entanto, existem exemplos importantes de problemas de maximização irrestrita - modelo de uma firma maximizadora de lucros
"

# ╔═╡ 6c677617-06c8-4d55-b789-f8594d91de4c
md"""
> Nosso objetivo, nas próximas aulas, é estudar problemas de **otimização estática sem restrições**. Dado que o problema irrestrito é mais simples.
"""

# ╔═╡ 7c563e57-2553-4cd5-af51-9ca976fd1c9e
md"""
## Máximos e mínimos de funções univariadas
"""

# ╔═╡ cf51f0e4-f1b9-4608-8799-6f47bae2fa26
md"""
---
### Existência de soluções: teorema de Weierstrass
"""

# ╔═╡ 67e97f99-bd1b-4a61-b88b-aa717184ddec
md"""
* Começaremos nosso estudo de otimização com a questão fundamental acerca da **existência**: sob quais condições sob a função objetivo $f$ e o conjunto restrição $\mathcal{D}$ é assegurado que soluções sempre existirão em problemas de otimização da forma $\max\{f(x)| x \in \mathcal{D}\}$ ou $\min\{f(x)| x \in \mathcal{D}\}$?
* De maneira equivalente, sob quais condições sobre $f$ e $\mathcal{D}$ é o caso de que o conjunto de valores assumidos de $f(\mathcal{D})$ contem um supremo e/ou um ínfimo?
* Casos triviais e problema de existência: se $\mathcal{D}$ é um conjunto finito, assegura-se que $f$ atinge um máximo e um mínimo em $\mathcal{D}$!
"""

# ╔═╡ a2ad174d-c945-49b5-a688-b89fdb02177f
md"""
> O principal resultado desta seção é o **Teorema de Weierstrass** (ou **Teorema do Valor Extremo**), que será enunciado inicialmente para o caso univariado, e descreve o conjunto de condições que estamos interessados
"""

# ╔═╡ 33116ab9-c4e5-45c7-90e7-63a1603e412d
md"""
!!! info "Definição 3.1. (Máximos e mínimos absolutos)"
	Seja $f$ uma função e $A$ um conjunto de números contido no domínio de $f$.

	Um ponto $x$ em $A$ é:
	* um valor **máximo absoluto** de $f$ em $A$ se $f(x) \geq f(y)$ para todo $y \in A$.
	* um valor **mínimo absoluto** de $f$ em $A$ se $f(x) \leq f(y)$ para todo $y \in A$.
"""

# ╔═╡ 6c662d33-d22e-4edc-a1c0-6786c09fd3e6
md"
* Um máximo ou mínimo absoluto, às vezes, é chamado de máximo ou mínimo **global**.
* Os valores máximos e mínimos de $f$ são chamados de **valores extremos** de $f$.
"

# ╔═╡ f07793c7-2750-4b95-8efd-9f9d3452acc0
begin
	plot(range(0, 6.5, 200), x -> 2sin(x) + 3, label=L"f(x) = 2sen(x) + 3", lc=:indianred)
	xlims!(0, 7)
	ylims!(0, 6)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	scatter!([(π/2, 5), (3π/2, 1)], ms=6, label=:none, mc=:black)
end

# ╔═╡ 23e427ea-ca64-47bd-9b3c-9a28e6353371
md"
> A figura acima mostra o gráfico de uma função com um máximo absoluto em $(π/2, 5)$ e um mínimo absoluto em $(3π/2, 1)$.
"

# ╔═╡ 9e217828-12d4-429f-917e-ffdf92f0406b
begin
	f(x) = 3x^4 - 16x^3 + 18x^2
	plot(range(0, 4, 200), x -> f(x), label=L"f(x) = 3x^4-16x^3+18x^2", lc=:indianred)
	xlims!(0, 4)
	ylims!(-50, 50)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	scatter!([(1, f(1)), (3, f(3)), (4, f(4))], ms=6, label=:none, mc=[:darkviolet, :black, :black])
end

# ╔═╡ 8c27995a-8b42-4bf8-af06-a2bcbcda124e
md"""
> Note, na figura acima, o gráfico de uma função $f$ que tem um máximo absoluto em $(4, 32)$ e mínimo absoluto em $(3, -27)$.
>
> Note, ainda, que se considerarmos apenas os valores de $x$ próximos (na vizinhança) de $x = 1$, então, $x = 1$ é o maior destes valores de $f(x)$ e é chamado de **valor de máximo local** de $f$.
"""

# ╔═╡ decca2f3-26d0-4ca2-84ab-56d136d8db55
md"""
!!! info "Definição 3.2. (Máximos e mínimos locais)"
	Seja $f$ uma função, e $A$ um conjunto de números contido no domínio de $f$.

	Um ponto $x \in A$ é:
	* um **ponto de máximo local** de $f$ em $A$ se existe algum $\delta > 0$ tal que $x$ é um ponto de máximo de $f$ em $A \cap (x - \delta, x + \delta)$.
	* um **ponto de mínimo local** de $f$ em $A$ se existe algum $\delta > 0$ tal que $x$ é um ponto de mínimo de $f$ em $A \cap (x - \delta, x + \delta)$.
"""

# ╔═╡ 5df23df2-4fee-48b0-af31-8dc3441bc312
md"""
Exemplo de mínimos/máximos locais e globais
$(Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula3_fig1.PNG", :width=> 600))
"""

# ╔═╡ 80a550a8-3326-40a7-b81e-5665fb7a2ed6
md"
#### Exemplos
"

# ╔═╡ a2a6a6ad-d804-4a6f-b43f-90152872c43e
md"""
$$f(x) = 3x^4 - 16x^3 + 18x^2, \qquad -1 \leq x \leq 4$$
"""

# ╔═╡ c96ca469-e151-42d1-8c12-27d8a1e018f1
begin	
	plot(range(-1, 4, 200), x -> f(x), label=L"f(x) = 3x^4-16x^3+18x^2", lc=:indianred)
	xlims!(-2, 5)
	ylims!(-50, 50)
	xticks!(-2:1:5)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	scatter!([(-1, f(-1)), (0, f(0)), (1, f(1)), (3, f(3)), (4, f(4))], ms=6, label=:none, mc=:black)
end

# ╔═╡ 4e940361-18c1-40e1-9c15-194ba6a13d0c
md"
| Ponto | Classificação |
| :--- | ---: |
| $f(1) = 5$ | Máximo local |
| $f(-1) = 37$ | Máximo absoluto |
| $f(0) = 0$ | Mínimo local |
| $f(3) = -27$ | Mínimo local e absoluto |


* Note que $f(-1) = 37$ é um máximo absoluto mas **não** é um máximo local, pois ocorre em um extremo do intervalo
* Note que $f(4) = 32$ não é máximo local nem global
"

# ╔═╡ c2c77e04-0f8c-4b2c-9903-21d6373d48ad
md"""
---
$$f(x) = \cos(x)$$
"""

# ╔═╡ 5ca736fa-37e5-40bc-adf8-cb1c072f0e87
begin	
	g(x) = cos(x)
	plot(range(-3π/4, 7π/2, 200), x -> g(x), label=L"f(x) = \cos(x)", lc=:indianred)
	xticks!([-π, 0, π, 2π, 3π], ["-π", "0", "π", "2π", "3π"])
	xlims!(-3, 12)
	ylims!(-2,2)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	scatter!([(0, g(0)), (π, g(π)), (2π, g(2π)), (3π, g(3π))], ms=6, label=:none, mc=:black)
end

# ╔═╡ 164dd5e2-635b-43d2-9e88-0088b8abd4e2
md"
* A função $f(x) = \cos(x)$ assume seu valor máximo (local e absoluto) 1 infinitas vezes, uma vez que $\cos 2nπ = 1$ para todo inteiro $n$ e $-1\leq \cos x\leq 1$ para todo $x$.
* Da mesma forma, $\cos (2n + 1)π = -1$ é seu valor mínimo, onde $n \in \mathbb{Z}$.
"

# ╔═╡ b25c4bca-394a-4d5d-99d8-e233490e54b3
md"
---
$$f(x) = x^2$$
"

# ╔═╡ d0cfa9c7-c23e-4265-8506-f44d482b8df6
begin
	plot(range(-4, 4, 200), x->x^2, label=L"f(x) = x^2", lc=:indianred)
	xlims!(-5, 5)
	ylims!(-1, 20)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	scatter!([(0, 0)], ms=6, label=:none, mc=:black)
end

# ╔═╡ 82b4e7f3-fc13-49c6-a837-cd2436a1ca62
md"
* Se $f(x) = x^2$, então, $f(x) \geq f(0)$ para todo $x$.
* Consequentemente, $f(0) = 0$ é o valor mínimo absoluto (e local) de $f$.
* Porém, não há um ponto mais alto sobre a parábola e, portanto, a função não tem um valor máximo.
"

# ╔═╡ 993ac944-4660-4c9f-b484-dc5d1d3b48ab
md"
---
$$f(x) = x^3$$
"

# ╔═╡ bca45e92-bfad-4a6e-aae7-c1a63118abd2
begin
	plot(range(-2, 2, 200), x->x^3, label=L"f(x) = x^3", lc=:indianred)
	xlims!(-3, 3)
	ylims!(-10, 10)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)	
end

# ╔═╡ 380cf939-205d-48d0-a60c-e92f24997f32
md"
* Essa função não tem um valor máximo absoluto, nem um valor mínimo absoluto.
* De fato, ela também não tem nenhum valor extremo local.
"

# ╔═╡ 7ff5456d-d5b8-4156-94d1-c7ee6a4c1afc
md"""
$(Resource("https://upload.wikimedia.org/wikipedia/commons/f/f1/Karl_Weierstrass.jpg", :width=>300))

[Karl Weierstrass (1815-1897) - Matemático alemão](https://en.wikipedia.org/wiki/Karl_Weierstrass)
"""

# ╔═╡ 27c003b1-5936-4dc1-a47b-6dc8f62a66a7
md"""
!!! correct "Teorema 3.1 - Teorema de Weierstrass (Teorema do valor extremo)"
	Seja $f$ uma função contínua de valores reais definida em um intervalo fechado $[a, b]$, então, $f$ necessariamente atinge um valor máximo absoluto e um valor mínimo absoluto, pelo menos uma vez.

	Isto é, existem números $c$ e $d$ em $[a, b]$ tais que:

	$$f(c) \geq f(x) \geq f(d), \qquad \forall x \in [a, b]$$
	---
	▶️ Demonstração

	Para uma demonstração de uma versão mais geral do teorema, ver Sundaram - A First Course in Optimization Theory (1996) - pp. 96-97 🔳
"""

# ╔═╡ 919ab09f-43f4-4955-8a3f-058cd51cd6b6
PlutoUI.Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula3_fig2.PNG", :width=>800)

# ╔═╡ ebbb81e7-8fae-411b-ba27-5320c83fbcfb
md"""
!!! warning "Observação - Teorema de Weierstrass"
	👉 O teorema de Weierstrass fornece, apenas, condições **suficientes** para a existência de pontos ótimos.

	O teorema não diz nada a respeito do que acontece caso estas condições não sejam satisfeitas e, de fato, em geral, nada pode ser afirmado nestes casos.

	Nos exemplos a seguir, apenas uma das condições do teorema de Weierstrass é violada e, ainda assim, mínimos e máximos não existem em cada caso.

	Por fim, vemos um exemplo no qual **todas** as condições do teorema são violadas e, ainda assim, mínimos e máximos existem.
"""

# ╔═╡ 0f39d48f-61ac-4ff8-8d5e-421b1d29a522
md"
##### Função $f$ definida em intervalo fechado $[0,2]$, mas $f$ discontínua
* A função é limitada superiormente, mas não existe um ponto de máximo
"

# ╔═╡ 950f46f5-809e-4f0a-bbbe-bfa9bf8d6d6c
begin
	plot(range(0, 1, 100), x->exp(x), lc=:indianred, label=L"y = f(x)")
	plot!(range(1,2, 100), x->-3log(0.5x), lc=:indianred, label=:none)
	xlims!(0, 2.5)
	ylims!(0, 3)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)	
	scatter!([(1, exp(1))], label=:none, m = (6, :white, stroke(1, :indianred)))
	scatter!([(1, -3log(0.5))], label=:none, m = (6, :indianred, stroke(1, :indianred)))
end

# ╔═╡ 62d4ed87-16aa-4175-92a8-1dcbae2d0d62
md"
##### Função $f$ contínua mas definida no intervalo aberto $(0,2)$
* A função não possui máximo nem mínimo
"

# ╔═╡ 9710c296-c7c5-4047-b0bc-18267282ef62
begin
	plot(range(0, 2, 100), x->2/(2-x), lc=:indianred, label=L"y = f(x)")	
	xlims!(0, 2.5)
	ylims!(0, 20)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)	
	vline!([2], lc=:black, lw=1, label=:none, ls=:dash)	
	scatter!([(0, 1)], label=:none, m = (6, :white, stroke(1, :indianred)))
	yticks!([1])
	xticks!([2])
end

# ╔═╡ d67c1280-a25b-4772-82d3-e11b87c2da78
md"
##### Função $f$ discontínua e definida no intervalo aberto $(-\infty,+\infty)$

Considere a seguinte função:
$$f(x) = \begin{cases} 1, & \quad x \in \mathbb{Q} \\ 0, & \quad x \notin \mathbb{Q}\end{cases}$$

* A função não satisfaz nenhuma das condições do teorema de Weierstrass e, ainda assim, possui mínimo e máximo
"

# ╔═╡ de87e52c-bd3a-47d5-924f-746e80455112
PlutoUI.Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula3_fig3.PNG", :width=>800)

# ╔═╡ e0418d0f-dd68-4d54-98bf-8e72dfc15426
md"""
!!! warning " "
	* Se as condições do Teorema de Weierstrass são satisfeitas, asseguramos a **existência** de um mínimo e um máximo.
	* Por outro lado, se uma condição ou mais do teorema não for satisfeita, máximos e mínimos podem ou não existir, a depender da estrutura específica do problema em questão.
"""

# ╔═╡ 6065e600-d611-44e7-af18-d6b345cfb363
md"""
---
### Ótimos irrestritos
"""

# ╔═╡ 3c104357-03f4-4cf6-96f2-763a39198b38
md"
* Passamos, agora, para o estudo da teoria da otimização sob as hipóteses de diferenciabilidade.
* Nosso principal objetivo é identificar as **condições _necessárias_** que a derivada da função $f$ deve satisfazer em um ponto de ótimo.
* Começaremos nossa análise analisando o que ficou conhecido por **otimização irrestrita**.
"

# ╔═╡ 7a618c6c-9efc-445e-b76b-2cb9b3469bdc
md"""
!!! warning "Observação sobre ótimos irrestritos"
	A terminologia "ótimos irrestritos", apesar de convencional, pode causar confusão, dado que irrestrito não significa, literalmente, ausência de restrições. Ao invés disso, refere-se à situação mais geral na qual podemos nos mover (ao menos) por uma pequena distância a partir do ponto ótimo, em qualquer direção, sem sair do conjunto factível.
	
	▶️ Para uma breve discussão a respeito da terminologia ''ótimos irrestritos'', ver Sundaram (1996), pp. 100
"""

# ╔═╡ 6d89f754-9087-4d13-b5a4-71b0acba0a05
md"""
$(Resource("https://upload.wikimedia.org/wikipedia/commons/f/f3/Pierre_de_Fermat.jpg", :width=>300))

[Pierre de Fermat (1601-1665) - Magistrado francês](https://pt.wikipedia.org/wiki/Pierre_de_Fermat)
"""

# ╔═╡ e70a3e5a-c064-4189-906b-1c3328d1e1dd
md"""
!!! correct "Teorema 3.2 - Teorema de Fermat (Condição necessária de primeira ordem)"
	Se $f$ é definida no intervalo aberto $(a,b)$ e tiver um máximo ou mínimo local em $x$ e, além disso, $f$ for diferenciável em $x$, então, $f'(x) = 0$.

	---
	▶️ Demonstração

	Ver Stewart et al. - Cálculo, Vol. 1 (2022) - pp. 258-259 🔳
"""

# ╔═╡ bb5b9c0f-b7e3-4fac-bad9-7bd49a08346b
md"
* Portanto, dada uma função $y = f(x)$, a derivada primeira $f'(x)$ desempenha um papel importante na identificação de seus pontos ótimos.
* Isso porque, se um extremo relativo da função acontecer em um ponto $x$, ou (i) $f'(x)$ não existe, ou (ii) $f'(x) = 0$.
"

# ╔═╡ c8bcba54-698d-4323-857d-cf4231b122d2
md"""
!!! danger "Teorema de Fermat - Observações"
	⚠️ A recíproca do Teorema de Fermat **não é verdadeira**❗❗❗
	* É possível que $f'(x) = 0$ e, ainda assim, $x$ não ser um ponto de mínimo ou de máximo para $f$.
	* Além disso, pode existir um valor extremo mesmo quando $f'(x)$ não existir.
"""

# ╔═╡ 1afefcbc-dc7e-4f5c-b070-686c6a271272
begin
	plot(range(-3, 3, 200), x->x^3, lc=:indianred, label=L"f(x) = x^3")	
	xlims!(-4, 4)
	ylims!(-30, 30)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)		
	scatter!([(0, 0)], label=:none, m = (6, :indianred, stroke(1, :indianred)))
	annotate!([(0.7, -2, text(L"f'(0) = 0", :indianred))])
	annotate!([(0.1, -6, text("⚠️ não é máximo nem mínimo", :darkyellow, :left))])
end

# ╔═╡ 5b5ac592-bbd7-4f6e-8ed0-2cdfd6720d3a
md"
---
Para a função $f(x) = |x|$, $f(0) = 0$ é um valor mínimo, mas $f'(0)$ não existe.
"

# ╔═╡ 448ed48d-a4e0-413c-946c-aa5a0c564fb1
begin
	plot(range(-3, 3, 200), x->abs(x), lc=:indianred, label=L"f(x) = |x|")	
	xlims!(-3, 3)
	ylims!(0, 4)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)		
	scatter!([(0, 0)], label=:none, m = (6, :indianred, stroke(1, :indianred)))		
end

# ╔═╡ f2c29059-49f7-4515-8e12-6003e1b19a92
md"
* Um dos equívocos mais comuns em cálculo têm a ver com o comportamento de uma função $f$ em uma vizinhança de $x$ quando $f'(x) = 0$.
* O ponto feito anteriormente é fundamental: **a recíproca do Teorema de Fermat não é verdadeira**!
* ⚠️ A condição $f'(x) = 0$ **não** implica que $x$ é um ponto de mínimo ou máximo local de $f$.
* Precisamente por este motivo, uma terminologia especial foi adotada para descrever números $x$ que satisfazem a condição $f'(x) = 0$.
"

# ╔═╡ 805e13d0-bfae-4156-8436-db55dc1db3ba
md"""
!!! info "Definição 3.3 (Ponto crítico)"
	Um **ponto crítico** de uma função $f$ é um número $x$ que satisfaz
	
	$$f'(x) = 0,$$

	ou se $f'(x)$ não existe.

	O valor $f(x)$ é denominado **valor crítico** de $f$.
"""

# ╔═╡ 5f07d271-170d-4444-8f57-50f6e7259e1b
md"""
> **Exercício 1**. Encontre os pontos críticos das seguintes funções:
>
> (a) $f(x) = x^3 - 3x^2 + 1.$
>
> (b) $f(x) = x^{3/5}(4 - x).$
"""

# ╔═╡ b9970ad6-53b3-4bbd-a42f-d317aab7288a
md"""
!!! hint "Respostas"
	(a) Note que $f'(x)$ está definida para todo valor de $x$. Portanto, os pontos críticos são $x = 0$ e $x = 2$.

	(b) Quando $f'(x) = 0$, temos $x = \frac{3}{2}$. Além disso, $f'(x)$ não existe quando $x = 0$. Assim, os pontos críticos são $x = \frac{3}{2}$ e $x = 0$.
"""

# ╔═╡ e12ee181-e0c2-47ed-982e-e6bed0e367a5
md"""
> O Teorema de Fermat pode, então, ser reescrito da seguinte forma:
>
> Se $f$ tiver um máximo ou um mínimo local em $x$, então, $x$ é um ponto crítico de $f$.
"""

# ╔═╡ 82ad10b3-cacc-4e23-9af6-d7c7f7be9134
md"
* Vamos, agora, considerar o problema de encontrar o máximo ou mínimo de $f$ em um intervalo fechado $[a, b]$.
* Pelo Teorema de Weierstrass, se $f$ é uma função contínua, então, podemos ter certeza que um ponto de máximo e um ponto de mínimo existem.
* Para determinar o mínimo e o máximo de $f$, podemos usar o **Método do Intervalo Fechado**.
"

# ╔═╡ cb2ff438-b7f0-4c3a-ae54-84fdad5af27b
md"""
!!! correct "Método do Intervalo Fechado"
	Para encontrar os valores máximo e mínimo absolutos de uma função contínua $f$ em um intervalo fechado $[a,b]$:

	1. Encontre os valores de $f$ nos pontos críticos de $f$ no intervalo $(a, b)$.

	2. Encontre os valores de $f$ nas extremidades do intervalo.

	3. O maior valor entre as etapas 1 e 2 é o valor máximo absoluto, ao passo que o menor desses valores é o valor mínimo absoluto.
"""

# ╔═╡ 42a91e68-ae82-4181-969f-ff0ae9e10562
md"""
> **Exercício 2**. Encontre os valores máximo e mínimo absolutos da função $f(x) = x^3 - x$ no intervalo $[-1, 2]$.
"""

# ╔═╡ 62eae816-02ff-4be7-baed-03d8e3806cf5
md"""
!!! hint "Resposta"
	Note que a função $f(x)$ é diferenciável em todo o intervalo. Portanto, os pontos críticos de $f$ são $x = \sqrt{1/3}$ e $x = -\sqrt{1/3}$. Os pontos extremos do intervalo são $x = -1$ e $x = 2$. Temos, então, as seguintes situações:

	 $f(\sqrt{1/3}) = -\frac{2}{3}\sqrt{1/3},$

	 $f(-\sqrt{1/3}) = \frac{2}{3}\sqrt{1/3},$

	 $f(-1) = 0,$

	 $f(2) = 6.$

	Claramente, o valor mínimo é $-\frac{2}{3}\sqrt{1/3}$, que ocorre em $x = \sqrt{1/3}$, e o valor máximo é $6$, que ocorre em $x = 2$.
"""

# ╔═╡ 6ff3d827-529c-4097-8a88-7afbde57bdb9
md"""
> **Exercício 3**. Encontre os valores máximo e mínimo absolutos da função $f(x) = x^3 - 3x^2 + 1$ no intervalo $\left[-\frac{1}{2}, 4\right].$
"""

# ╔═╡ f7b0e426-8001-4899-b5f8-f9e0bf3e52d2
md"""
!!! hint "Resposta"
	Os pontos críticos $x = 0$ e $x = 2$ pertencem ao intervalo $\left(-\frac{1}{2}, 4\right)$. Temos as seguintes situações:

	 $f(0) = 1,$

	 $f(2) = -3,$

	 $f\left(-\frac{1}{2}\right) = \frac{1}{8},$

	 $f(4) = 17.$

	Portanto, o valor máximo absoluto é $f(4) = 17$ e o valor mínimo absoluto, $f(2) = -3.$
"""

# ╔═╡ 2a0cee9a-99b1-4392-a8a4-62406d72219c
md"""
---
### Teorema do Valor Médio
"""

# ╔═╡ 86e4126e-aeec-4e10-b7f3-29d251d1ab76
md"
* Os resultados que vimos até agora, a respeito das derivadas, sempre nos dão informações a respeito de $f'$ em termos das informações acerca de $f$.
* As coisas não são tão simples quando tentamos extrair informações a respeito de $f$ a partir de informações acerca de $f'$ 😟
* Considere o seguinte questionamento: Se $f'(x) = 0$ para qualquer valor de $x$, a função $f$ deve ser uma função constante?
* É difícil imaginar que $f$ possa ser outra coisa! No entanto, é difícil até mesmo iniciar uma demonstração de que apenas funções constantes satisfazem $f'(x) = 0$ para qualquer valor de $x$.
* A hipótese de que $f'(x) = 0$ significa, apenas, que:

$$\lim_{h \to 0} \frac{f(x + h) - f(x)}{h} = 0,$$

e não é óbvio que possamos usar a informação a respeito de um limite para extrairmos informações a respeito de uma função.

> O fato de que $f$ é uma função constante se $f'(x) = 0$ para qualquer valor de $x$, e muitos outros fatos semelhantes, podem ser derivados de um teorema fundamental - **`Teorema do Valor Médio`**, que enuncia resultados bem mais fortes.
>
> Para chegarmos ao Teorema do Valor Médio, precisamos do seguinte resultado:
"

# ╔═╡ d7e075ce-5c63-4763-8a98-fb7650554c13
md"""
$(Resource("https://upload.wikimedia.org/wikipedia/commons/b/b8/Michel_Rolle.jpg", :width=>300))

[Michel Rolle (1652 - 1719) - Matemático francês](https://en.wikipedia.org/wiki/Michel_Rolle)
"""

# ╔═╡ 6ed1bf78-369f-4114-b214-c3dc723d40e2
md"""
!!! correct "Teorema 3.3 - Teorema de Rolle"
	Se $f$ é uma função contínua no intervalo fechado $[a,b]$ e diferenciável no intervalo $(a,b)$ e, além disso, $f(a) = f(b)$, então, existe um $x \in (a,b)$ tal que $f'(x) = 0$.

	---
	▶️ Demonstração

	Ver Stewart et al. - Cálculo, Vol. 1 (2022) - pp. 266 🔳
"""

# ╔═╡ f5552f3d-c78d-4986-b8d8-93b324993026
PlutoUI.Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula3_fig4.PNG", :width=>800)

# ╔═╡ f826222b-428f-47c7-a0c9-69bca1955de0
md"""
> **Exemplo.**
>
> Considere a função posição $s = f(t)$ de um objeto em movimento.
>
> Se o objeto estiver no mesmo lugar em dois instantes diferentes $t = a$ e $t = b$, então, $f(a) = f(b).$
>
> O Teorema de Rolle afirma que existe algum instante do tempo $t = c$, entre $a$ e $b$, no qual $f'(c) = 0$ (i.e., a velocidade é 0!).
>
> Em particular, percebemos que isto é verdadeiro quando uma bola é atirada diretamente para cima.
"""

# ╔═╡ ace7c499-2e3a-473d-a908-feec74c9f2ed
md"""
$(Resource("https://upload.wikimedia.org/wikipedia/commons/c/c7/Arthur_Laffer_2019.jpg", :width=>300))

[Arthur Laffer (1940 - )](https://en.wikipedia.org/wiki/Arthur_Laffer) - Economista norte-americano
"""

# ╔═╡ 98da49ef-c304-476a-a14d-61743727aaa5
md"""
!!! info "Curva de Laffer e Teorema de Rolle"
	A curva de Laffer ilustra uma relação teórica entre alíquotas de impostos e os níveis resultantes de arrecadação por parte do governo.

	Assume-se a interação entre dois efeitos de taxação:

	1. "Efeito aritmético": a receita obtida a partir da taxação é dada pela multiplicação entre a alíquota de imposto e a base tributária ($R = \tau \times B$). Portanto, com uma alíquota de imposto $\tau = 0\%$, a arrecadação é nula.

	2. "Efeito econômico": a alíquota de imposto afeta a própria base tributária. A uma alíquota de imposto extrema de $\tau = 100\%$, a arrecadação seria nula pois os contribuintes alterariam seus comportamentos em resposta a esta mudança - perdem incentivo para trabalhar ou encontram uma maneira de evitar o pagamento de impostos.

	Portanto, a arrecadação será nula quando $\tau = 0\%$ e quando $\tau = 100\%$.	
"""

# ╔═╡ 170e8fc8-b344-4433-ae86-2ca805f9491c
md"""
$(Resource("https://upload.wikimedia.org/wikipedia/commons/e/e8/Laffer_curve.svg", :width=>500))
"""

# ╔═╡ b2a406f2-4402-4c76-802c-3817be96cd7b
md"""
$(Resource("https://upload.wikimedia.org/wikipedia/commons/6/69/Joseph_Louis_Lagrange2.jpg", :width=>250))

O Teorema do Valor Médio foi primeiro enunciado pelo matemático italiano [Joseph-Louis Lagrange (1736-1813)](https://en.wikipedia.org/wiki/Joseph-Louis_Lagrange).
"""

# ╔═╡ 787001f6-ecbe-4272-b849-b1b7b1821150
md"""
!!! correct "Teorema 3.4 - Teorema do Valor Médio"
	Se $f$ é uma função contínua em $[a,b]$ e diferenciável em $(a,b)$, então, existe um número $x \in (a,b)$ tal que:

	$$f'(x) = \frac{f(b) - f(a)}{b - a}.$$

	---
	▶️ Demonstração

	Ver Stewart et al. - Cálculo, Vol. 1 (2022) - pp. 267-268 🔳
"""

# ╔═╡ ee03f1cd-b5ac-4be9-b505-0fde06d4d827
md"
* Geometricamente, o Teorema do Valor Médio nos diz que alguma reta tangente é paralela à linha secante entre $(a, f(a))$ e $(b, f(b))$. Ou seja, há no mínimo um ponto $P(x, f(x))$ sobre o gráfico onde a inclinação da reta tangente é igual à reta secante $AB$.
"

# ╔═╡ 8c8ca2e7-9822-422c-8d07-bbf13d09912b
PlutoUI.Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula3_fig5.PNG", :width=>800)

# ╔═╡ 0c292257-d8ee-4e94-b139-a2c63631fdb3
md"
* Ou ainda, a taxa de variação instantânea de $f$ no ponto $x$, é exatamente igual à variação média de $f$ em $[a,b]$, sendo que esta média é $[f(b) - f(a)]/[b - a]$.
* Por exemplo, se viajarmos 100km em uma hora, então, em algum dado instante, estávamos nos deslocando a exatamente 100km/h.
"

# ╔═╡ 8490c2ff-7ba3-402c-9e2c-d9ef5b6b8a4f
md"""
> **Exemplo**. Vamos ilustrar o TVM com a função $f(x) = x^3 - x$ no intervalo $[0, 2]$.
"""

# ╔═╡ 6c4978c9-92ce-49ad-9941-8cdabdc779f1
begin
	plot(range(-1, 2.5, 200), x->x^3 - x, lc=:indianred, label=L"f(x) = x^3 - x")	
	xlims!(-1, 3)
	ylims!(-7, 15)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)		
	scatter!([(0, 0)], label=:none, m = (6, :indianred, stroke(1, :indianred)))
	scatter!([(2, 6)], label=:none, m = (6, :indianred, stroke(1, :indianred)))
	scatter!([(2/√3, (2/√3)^3 - 2/√3)], label=:none, m = (6, :black, stroke(1, :indianred)))
	plot!(range(-1, 2.5, 200), x-> 3x, lc=:navyblue, label=:none)
	plot!(range(-1, 2.5, 200), x-> 3x + ((2/√3)^3 - 8/√3), lc=:black, label=:none)
end

# ╔═╡ 5e3427b7-a0c4-47fe-a948-646c923ae666
md"""
!!! warning " "
	A grande importância do Teorema do Valor Médio reside no fato de ele nos possibilitar obter informações sobre uma função a partir de dados sobre sua derivada.
"""

# ╔═╡ 1476e345-73f2-4899-b6ef-927fe3f4a7bb
md"""
> **Exercício**. Suponha que $f$ seja uma função diferenciável em todo seu domínio e, além disso, $f(0) = -3$ e $f'(x) \leq 5$ para todos os valores de $x$. Quão grande $f(2)$ pode ser?
"""

# ╔═╡ 15e45302-5fd8-40ea-b17f-1de199ccc836
md"""
!!! hint "Resposta"
	Se $f$ é contínua e, portanto, diferenciável em qualquer valor de $x$, podemos aplicar o TVM no intervalo $[0,2]$. Portanto, existe um número $c$ tal que:

	$$f(2) - f(0) = f'(c)(2 - 0),$$

	logo:

	$$f(2) = f(0) + 2f'(c) = -3 + 2f'(c).$$

	Como $f'(x) \leq 5$ para todo $x$, sabemos que $f'(c) \leq 5$. Portanto, $2f'(c) \leq 10$ e, então:

	$$f(2) = -3 + 2f'(c) \leq -3 + 10 = 7.$$

	Ou seja, o maior valor possível para $f(2)$ é 7.
"""

# ╔═╡ 53233768-3b74-4896-8c82-54ae06c13401
md"""
!!! correct "Corolário 3.1."
	Se $f$ é definida em um intervalo $(a,b)$ e $f'(x) = 0$ para qualquer valor de $x$ neste intervalo, então, $f$ é constante em $(a, b)$.

	---
	▶️ Demonstração (na lousa)

	Ver Stewart et al. - Cálculo, Vol. 1 (2022) - pp. 269 🔳
"""

# ╔═╡ e12887a7-fc7f-4b59-8ee8-2e3b1d5ce39a
md"""
!!! warning "Observação sobre Corolário 3.1"
	Naturalmente, o Corolário 3.1 não é válido para funções definidas em dois ou mais intervalos.

	Exemplo:

	$$f(x) = \frac{x}{|x|} = \begin{cases}1, & \quad x > 0\\ -1, & \quad x < 0\end{cases}$$

	a função $f$, obviamente, não é uma função constante. Isso não contradiz o corolário pois $D = \{x | x \neq 0\}$.
"""

# ╔═╡ b4731098-7def-40a9-bb66-0ce25dc88e0a
begin
	plot(range(0, 5, 200), x->x/abs(x), lc=:indianred, label=L"f(x) = \frac{x}{|x|}")	
	plot!(range(-5, 0, 200), x->x/abs(x), lc=:indianred, label=:none)	
	xlims!(-5, 5)
	ylims!(-2, 2)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)			
end

# ╔═╡ 50fb651c-bc74-4043-b7ac-a6e56fbd3093
md"""
!!! correct "Corolário 3.2."
	Se $f$ e $g$ são funções definidas em um mesmo intervalo $(a,b)$, e $f'(x) = g'(x)$ para qualquer valor de $x$ neste intervalo, então, existe um número $c$ tal que $f = g + c$.

	---
	▶️ Demonstração (na lousa)

	Ver Stewart et al. - Cálculo, Vol. 1 (2022) - pp. 269 🔳
"""

# ╔═╡ 1a6f1490-460a-485e-9582-2f967ca27413
md"
* O corolário 3.2 diz que se duas funções têm a mesma derivada em um intervalo, então, seus gráficos devem ser translações verticais um do outro.
* Dito de outra forma, os gráficos têm a mesma forma, mas podem ser deslocados para cima ou para baixo.
"

# ╔═╡ 10ea25df-fa46-4eca-84f0-f8a93bfee555
md"""
!!! info "Definição 3.4 (Funções crescentes e funções decrescentes)"
	Uma função $f$ é **crescente** em um intervalo $I$ se

	$$f(x_1) < f(x_2), \quad \text{quando } x_1 < x_2 \text{ em } I$$

	Uma função $f$ é **decrescente** em um intervalo $I$ se

	$$f(x_1) > f(x_2), \quad \text{quando } x_1 < x_2 \text{ em } I$$

"""

# ╔═╡ 9b7b8b1d-1d5f-44a2-b6dd-d888ff2b5fda
begin
	plot(range(0, 2π, 100), x->x + 2sin(x), lc=:indianred, label=L"f(x) = x + 2sen(x)")
	xlims!(0, 2π)
	ylims!(0, 7)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)		
	scatter!([(2π/3, 2π/3 + 2sin(2π/3)), (4π/3, 4π/3 + 2sin(4π/3)), (2π, 2π + 2sin(2π))], label=:none, m = (6, :indianred, stroke(1, :indianred)))
	xticks!([0, 2π/3, 4π/3, 2π], [L"0", L"\frac{2π}{3}", L"\frac{4π}{3}", L"2π"])
end

# ╔═╡ e83348c0-13ec-4b11-97fe-a86d8fab43bb
md"""
!!! correct "Corolário 3.3."
	Se $f'(x) > 0$ para qualquer valor de $x$ em um intervalo, então, $f$ é uma função crescente neste intervalo.

	Se $f'(x) < 0$ para qualquer valor de $x$ em um intervalo, então, $f$ é uma função decrescente neste intervalo.

	---
	▶️ Demonstração (na lousa)

	Ver Stewart et al. - Cálculo, Vol. 1 (2022) - pp. 272 🔳
"""

# ╔═╡ d0a21a19-5728-4f9c-b279-236be35a0596
md"""
> **Exercício**.
>
> Encontre onde a função $f(x) = 3x^4 - 4x^3 - 12x^2 + 5$ é crescente e onde é decrescente.
"""

# ╔═╡ e550e26e-10ee-4943-86b8-ead1cc8259bf
md"""
> O Corolário 3.3 nos dá informações importantes para termos uma boa ideia a respeito do gráfico de uma função.
>
> Perceba este fato ao tentar fazer um esboço da função do exercício anterior utilizando suas respostas.
"""

# ╔═╡ beefa888-76fe-41bc-ae14-9deece007f03
begin
	func(x) = 3*x^4-4*x^3-12*x^2 + 5
	plot(range(-2, 3, 100), x->func(x), lc=:indianred, label=L"f(x) = 3x^4 - 4x^3 - 12x^2 + 5")
	xlims!(-2, 3)
	#ylims!(0, 7)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)		
	scatter!([(-1, func(-1)), (0, func(0)), (2, func(2))], label=:none, m = (6, :indianred, stroke(1, :indianred)))	
end

# ╔═╡ 75176f5c-5bc0-4b41-8905-2267ed7d4ea7
md"""
!!! warning "Observação a respeito dos corolários"
	Note que apesar de as recíprocas dos Corolários 3.1 e 3.2 serem verdadeiras (e óbvias), a recíproca do Corolário 3.3 **não é verdadeira**.

	Se $f$ é crescente, é fácil ver que $f'(x) \geq 0$ para qualquer valor de $x$, no entanto, o sinal de igualdade pode ser válido para algum valor de $x$ (considere, por exemplo, $f(x) = x^3$).
"""

# ╔═╡ 030424c4-8ce6-42e0-a59e-539a0245e17c
md"""
---
### Teste da primeira derivada
"""

# ╔═╡ a3af2ad6-cf6c-4897-82cc-1e79ef92b607
md"
* Toda a discussão que acabamos de fazer nos fornece um esquema geral para decidir se um ponto crítico é um ponto de máximo local, um ponto de mínimo local, ou nenhum desses casos
"

# ╔═╡ 39b5797b-d408-45d5-9eb6-6df20f6ead73
md"""
!!! correct "Teste da Primeira Derivada"
	Seja $x$ um ponto crítico de uma função contínua $f$:

	(1) Se $f' > 0$ em algum intervalo à esquerda de $x$ e $f' < 0$ em algum intervalo à direita de $x$, então, $x$ é um ponto de máximo local.

	(2) Se $f' < 0$ em algum intervalo à esquerda de $x$ e $f' > 0$ em algum intervalo à direita de $x$, então, $x$ é um ponto de mínimo local.

	(3) Se $f'$ tem o mesmo sinal em algum intervalo à esquerda de $x$ que possui em algum intervalo à direita, então, $x$ não é nem um ponto de máximo local nem um ponto de mínimo local.
"""

# ╔═╡ 24e215e8-ce81-452e-ba67-7b515c27fe54
PlutoUI.Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula3_fig6.PNG", :width=>800)

# ╔═╡ 11396406-8e90-426d-b2ca-ea8f842905af
md"""
> **Exercícios**. Encontre os pontos de mínimo relativo ou de máximo relativo para as seguintes funções:
>
> (a) $f(x) = x^3 - 12x^2 + 36x + 8$
>
> (b) $f(x) = -2x^2 + 8x + 7$
>
> (c) $f(x) = 3 - (x - 2)^2$
>
> (d) $f(x) = \frac{8}{3x^2 + 4}$
>
> (e) $f(x) = x^3 - 1$
"""

# ╔═╡ d6c095fe-7840-4861-9be1-70a890350b06
begin	
	plot(range(-1, 8, 100), x->x^3 - 12x^2 + 36x + 8, lc=:indianred, label=L"f(x) = x^3 - 12x^2 + 36x + 8")
	xlims!(-1, 8)	
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)		
	scatter!([(2, 40), (6, 8)], label=:none, m = (6, :indianred, stroke(1, :indianred)))	
end

# ╔═╡ e4826002-3ae7-4d87-afb1-eb349f3bdbe6
begin	
	plot(range(-2, 6, 100), x->-2x^2 + 8x + 7, lc=:indianred, label=L"f(x) = -2x^2 + 8x + 7")
	xlims!(-2, 6)	
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)		
	scatter!([(2, 15)], label=:none, m = (6, :indianred, stroke(1, :indianred)))	
end

# ╔═╡ ab6d40d1-dad2-4b26-a6ad-57ee297657e9
begin	
	plot(range(-1, 5, 100), x->3 - (x - 2)^2, lc=:indianred, label=L"f(x) = 3 - (x - 2)^2")
	xlims!(-1, 5)	
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)		
	scatter!([(2, 3)], label=:none, m = (6, :indianred, stroke(1, :indianred)))	
end

# ╔═╡ 78991214-33ec-46ed-a042-e6c34d3f6aa6
begin	
	plot(range(-5, 5, 100), x->8/(3x^2 + 4), lc=:indianred, label=L"f(x) = \frac{8}{3x^2 + 4}")
	xlims!(-5, 5)	
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)		
	scatter!([(0, 2)], label=:none, m = (6, :indianred, stroke(1, :indianred)))	
end

# ╔═╡ 8977e59b-1c10-45a1-91d5-06ca92bcdfcd
begin	
	plot(range(-2, 2, 100), x->x^3 - 1, lc=:indianred, label=L"f(x) = x^3 - 1")
	xlims!(-2, 2)	
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)			
end

# ╔═╡ c8fe97f4-e52b-4ab5-b6cc-0ad7639ed91c
md"
---
### Segunda derivada, concavidade e convexidade
"

# ╔═╡ 0c1a3b59-dd47-4b6a-86dc-9106258aa0c9
md"
* O gráfico de uma função poder ser esboçado de maneira relativamente precisa a partir de informações fornecidas pelas suas derivadas.
* No entanto, alguns aspectos sutis podem ser revelados apenas quando analisamos a derivada segunda.
* Mas não apenas isso, as noções de concavidade e convexidade são muito mais importantes do que apenas ferramentas auxiliares no esboço de gráficos.
* Veremos mais adiante que, apesar de a localização de mínimos e máximos locais poder ser revelada por um esboço detalhado do gráfico da função, usualmente é desnecessário termos todo este trabalho.
* Existe um teste popular para máximos e mínimo que depende do comportamento da função apenas em seus pontos críticos.
"

# ╔═╡ 3f5fc585-63a4-48d4-b6bd-1d79a3b92318
md"""
!!! info "Definição 3.5 (Função estritamente convexa e função estritamente côncava)"
	Uma função $f$ é **estritamente convexa** em um intervalo se, para qualquer valor de $a$ e $b$ no intervalo, o segmento de reta que une $(a, f(a))$ e $(b, f(b))$ estiver acima do gráfico de $f$.

	Uma função $f$ é **estritamente côncava** em um intervalo se, para qualquer valor de $a$ e $b$ no intervalo, o segmento de reta que une $(a, f(a))$ e $(b, f(b))$ estiver abaixo do gráfico de $f$.
"""

# ╔═╡ 2b36d298-541e-427a-88c5-ecd2d7c58a43
md"
##### Exemplo de função estritamente convexa: $f(x) = x^2 + 1$
"

# ╔═╡ 082c0302-8be8-4604-bbb1-f9f029f3716b
begin
	pontoa = @bind pa Slider(-3:0.5:3, default=-1)
	pontob = @bind pb Slider(-3:0.5:3, default=2)	

	md"""
	Ponto a: $(pontoa)
	
	Ponto b: $(pontob)	
	
	"""
end

# ╔═╡ 7b20951f-6cab-476f-84d3-d9beb1cc2d81
begin	
	plot(range(-3, 3, 100), x->x^2 + 1, lc=:indianred, label="f convexa")
	plot!(Shape([(pa, pa^2 + 1), (pb, pb^2 + 1)]), label=:none, lc=:deepskyblue4)
	xlims!(-3, 3)	
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	scatter!([(pa, pa^2 + 1), (pb, pb^2+1)], label=:none, m = (6, :indianred, stroke(1, :indianred)))	
end

# ╔═╡ 04b46e41-3f18-4d2e-8a97-15f17f863a09
md"
##### Exemplo de função estritamente côncava: $f(x) = -x^2 + 1$
"

# ╔═╡ 150fb1fe-a113-464e-b66f-a9d7bca9901c
begin
	pontoaa = @bind paa Slider(-3:0.5:3, default=-1)
	pontobb = @bind pbb Slider(-3:0.5:3, default=2)	

	md"""
	Ponto a: $(pontoaa)
	
	Ponto b: $(pontobb)	
	
	"""
end

# ╔═╡ 285eba04-fe12-4d05-959a-fee626a7c913
begin	
	plot(range(-3, 3, 100), x->-x^2 + 1, lc=:indianred, label="f côncava")
	plot!(Shape([(paa, -paa^2 + 1), (pbb, -pbb^2 + 1)]), label=:none, lc=:deepskyblue4)
	xlims!(-3, 3)	
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	scatter!([(paa, -paa^2 + 1), (pbb, -pbb^2+1)], label=:none, m = (6, :indianred, stroke(1, :indianred)))	
end

# ╔═╡ fe11e2c0-1007-46a1-9dbb-b483e6e27b7b
md"
##### E se $f(x) = x^3$?
"

# ╔═╡ 9717127b-a5f8-4b5b-b0f6-eece34faafce
begin
	pontoa3 = @bind pa3 Slider(-3:0.5:3, default=-1)
	pontob3 = @bind pb3 Slider(-3:0.5:3, default=2)	

	md"""
	Ponto a: $(pontoa3)
	
	Ponto b: $(pontob3)	
	
	"""
end

# ╔═╡ 1958aed5-ad08-4885-b13d-d0cbd827f470
begin	
	plot(range(-3, 3, 100), x->x^3, lc=:indianred, label=L"f(x) = x^3")
	plot!(Shape([(pa3, pa3^3), (pb3, pb3^3)]), label=:none, lc=:deepskyblue4)
	xlims!(-3, 3)	
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	scatter!([(pa3, pa3^3), (pb3, pb3^3)], label=:none, m = (6, :indianred, stroke(1, :indianred)))	
end

# ╔═╡ fe778b14-62c7-494b-9fa3-0f3be2310792
md"""
!!! warning "Segmento de reta: expressão analítica"
	A condição geométrica que aparece na Definição 3.5 pode ser expressa de maneira analítica.

	O segmento de reta entre os pontos $(a, f(a))$ e $(b, f(b))$ é o gráfico da função $g$ definida por:

	$$g(x) = \frac{f(b) - f(a)}{b-a}(x-a) + f(a)$$
"""

# ╔═╡ 5bd0a512-f410-4968-afdc-409796f72cad
md"
* Portanto, temos a seguinte definição equivalente de convexidade e concavidade estritas (demonstração na lousa)
"

# ╔═╡ 589e1a22-1cf5-4b6b-b526-ef37430fe6dd
md"""
!!! info "Definição 3.6 (Função estritamente convexa e função estritamente côncava)"
	Uma função $f$ é **estritamente convexa** em um intervalo se, para $a, x$ e $b$ neste intervalo, com $a < x < b$, temos:

	$$\frac{f(x) - f(a)}{x - a} < \frac{f(b) - f(a)}{b - a}$$

	Uma função $f$ é **estritamente côncava** em um intervalo se, para $a, x$ e $b$ neste intervalo, com $a < x < b$, temos:

	$$\frac{f(x) - f(a)}{x - a} > \frac{f(b) - f(a)}{b - a}$$
"""

# ╔═╡ 05627a7f-d002-404f-9ed2-f8e9c86b4857
md"
> Não é difícil ver que funções côncavas são precisamente da forma $-f$, onde $f$ é convexa.
"

# ╔═╡ 7bb1cc0f-e2f6-4e33-85e3-ae0c2b8e8722
begin
	pontoa4 = @bind pa4 Slider(-3:0.5:3, default=-1)	

	md"""
	Ponto a: $(pontoa4)	
	"""
end

# ╔═╡ f1e8c9a7-7a43-4288-9234-6d6b657c789c
begin	
	plot(range(-3, 3, 100), x->x^2 + 1, lc=:indianred, label="f convexa")
	plot!(range(pa4-0.5, pa4+0.5, 100), x -> 2*pa4*(x-pa4) + (pa4^2+1), label=:none, lc=:deepskyblue4)
	xlims!(-4, 4)	
	ylims!(0, 12)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	scatter!([(pa4, pa4^2 + 1)], label=:none, m = (6, :indianred, stroke(1, :indianred)))	
end

# ╔═╡ e9f2ad54-b5e5-4e3a-9d6c-b5e8d320cea5
md"
Ao observarmos a figura da função estritamente convexa acima, observamos dois pontos:
1. O gráfico de $f$ está acima da linha tangente ao ponto $(a, f(a))$ exceto no próprio ponto $(a, f(a))$ (**ponto de contato** da reta tangente).
2. Se $a< b$, então, a inclinação da reta tangente a $(a, f(a))$ é menor que a inclinação da reta tangente em $(b, f(b))$, i.e., $f'$ é crescente
"

# ╔═╡ 9217b0ba-1a68-4fda-afc7-25b4478cb5d3
md"""
!!! correct "Teorema 3.5"
	Seja $f$ uma função estritamente convexa. Se $f$ é diferenciável em $a$, então, o gráfico de $f$ está acima da reta tangente $(a, f(a))$, exceto no próprio ponto $(a, f(a))$. Se $a < b$ e $f$ é diferenciável em $a$ e $b$, então, $f'(a) < f'(b)$.

	---
	▶️ Demonstração

	Ver Spivak - Calculus (1994) - pp. 205 🔳
"""

# ╔═╡ bfb79391-0fb4-4700-bea6-a857a6922c7f
md"""
!!! correct "Teorema 3.6"
	Se $f$ é diferenciável e $f'$ é crescente, então, $f$ é estritamente convexa.

	---
	▶️ Demonstração

	Ver Spivak - Calculus (1994) - pp. 205 🔳
"""

# ╔═╡ 1510f5f1-4a04-4eb6-8667-9758f21fb302
md"""
!!! warning "Observação"
	Os teoremas acima foram enunciados para funções estritamente convexas, é simples obter os resultados análogos quando estamos interessados em funções estritamente côncavas.
"""

# ╔═╡ e7b1b06d-3c1c-4d76-8032-b267a77837d1
md"
* Se a função $f$ possui uma derivada de segunda ordem razoável, as informações dos teoremas acima podem ser usadas para descobrirmos as regiões nas quais a função $f$ é convexa ou côncava.
* Considere, por exemplo, a função:
$$f(x) = \frac{1}{1 + x^2}$$
* Para essa função:
$$f'(x) = -\frac{2x}{(1 + x^2)^2}$$
* Portanto, $f'(x)$ é igual a 0 apenas quando $x = 0$ e, nesse caso, $f(0) = 1$.
* Concluímos que:
$$f'(x) > 0, \quad x < 0$$
$$f'(x) < 0, \quad x > 0$$
* Além disso:
$$f(x) > 0, \quad \forall x,$$
$$f(x) \to 0, \quad \text{quando } x \to \infty \text{ ou } x \to -\infty$$
$$f \text{ é par}$$
* Com isso, temos informações para traçar um esboço do gráfico desta função.
"

# ╔═╡ 4f85efad-6eae-49d9-b970-78438a1b4e05
begin
	plot(range(-7, 7, 200), x-> 1/(1 + x^2), lc=:indianred, label=L"f(x) = \frac{1}{1 + x^2}")
	vline!([0], lc=:black, lw=1, label=:none)
	hline!([0], lc=:black, lw=1, label=:none)
end

# ╔═╡ c7941622-c159-4be8-8526-3d7df6fa8ae1
md"
* A derivada de segunda ordem é dada por:
$$f''(x) = \frac{2(3x^2-1)}{(1+x^2)^3}$$
* Portanto, não é difícil determinar o sinal de $f''(x)$.
* Note que $f''(x) = 0$ apenas quando $x = \sqrt{1/3}$ ou $x = -\sqrt{1/3}$
* Dado que $f''$ é claramente contínua, a função deve preservar o mesmo sinal em cada um dos seguintes conjuntos
$$\left(-\infty, -\sqrt{1/3}\right)$$
$$\left(-\sqrt{1/3}, \sqrt{1/3}\right)$$
$$\left(\sqrt{1/3}, \infty\right)$$
* Portanto, concluímos que:

    $f'' > 0$ nos intervalos $\left(-\infty, -\sqrt{1/3}\right)$ e $\left(\sqrt{1/3}, \infty\right)$

    $f'' < 0$ no intervalo $\left(-\sqrt{1/3}, \sqrt{1/3}\right)$
"

# ╔═╡ d036c8ee-13fc-4e3f-b759-ccff981302dd
md"
> Dado que $f''>0$ significa que $f'$ é crescente, segue do Teorema 3.6 que $f$ é estritamente convexa em $\left(-\infty, -\sqrt{1/3}\right)$ e $\left(\sqrt{1/3}, \infty\right)$
>
> Ao passo que no intervalo $\left(-\sqrt{1/3}, \sqrt{1/3}\right)$, $f$ é estritamente côncava
"

# ╔═╡ e76a4846-b1d2-429e-a3c7-fbfd4041da53
PlutoUI.Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula3_fig7.PNG", :width=>800)

# ╔═╡ 8a432026-633f-4d52-9d99-bf4d052975ba
md"
* Note que no ponto $\left(\sqrt{1/3}, 3/4\right)$, a linha tangente está abaixo do gráfico à direita ($f$ estritamente convexa) mas acima do gráfico à esquerda ($f$ côncava)
* Portanto, a reta tangente cruza o gráfico da função
* Em geral, dizemos que um número $a$ é um **ponto de inflexão** de $f$ se a reta tangente ao gráfico de $f$ em $(a, f(a))$ cruza o gráfico
* Vemos, portanto, que para esta função $\sqrt{1/3}$ e $-\sqrt{1/3}$ são pontos de inflexão de $f(x) = 1/(1+x^2)$
"

# ╔═╡ 37e0252a-d307-4449-b011-aef8a00fdd0e
md"""
!!! warning "Pontos de inflexão"
	Note que a condição $f''(a) = 0$ não assegura que $a$ seja um ponto de inflexão.

	Contra-exemplo: $f(x) = x^4$
"""

# ╔═╡ 2767cd29-34ff-42e9-8e3c-146f9efd3178
md"
* Portanto, a segunda derivada de uma função está relacionada à **curvatura** de seu gráfico
* Se $f''(x)<0, \forall x \in D$, então, a função primitiva deve ser estritamente côncava
* De maneira similar, se $f''(x)>0, \forall x \in D$, $f$ deve ser estritamente convexa
* Cabe ressaltar que não é válido inverter essa inferência e dizer que, se $f(x)$ for estritamente côncava (convexa), então, $f''(x)$ deve ser negativa (positiva) para todo $x$
* Isso porque a segunda derivada pode ser igual à zero em um ponto estacionário
* Exemplo: $f(x) = x^4$ é estritamente convexa mas, em $x=0$, temos $f'(0) = 0$
* Concavidade e convexidade serão estudadas com maior profundidade mais tarde na disciplina
"

# ╔═╡ 6e691417-b4a8-43d4-bcbd-2f6939774435
md"
---
### Concavidade e convexidade: aplicação econômica
"

# ╔═╡ fa96d08f-cd44-426a-a219-269772721a2a
md"""
$(Resource("https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https:%2F%2Fbucketeer-e05bbc84-baa3-437e-9518-adb32be77984.s3.amazonaws.com%2Fpublic%2Fimages%2Fbcdd4e04-3a2e-40cd-bdb1-4ce3087c355f_1052x685.png", :width=>600))

[Oskar Morgenstern](https://en.wikipedia.org/wiki/Oskar_Morgenstern) e [John von Neumann](https://pt.wikipedia.org/wiki/John_von_Neumann)
"""

# ╔═╡ 974f6ff1-befd-436f-b31a-29ad51ba21ad
md"
* Vamos ver como os conceitos de concavidade e convexidade são aplicados em um problema de retorno de jogo de azar para distinguir entre as diferentes atitudes de indivíduos em relação ao risco
* Considere um jogo no qual, mediante uma quantia fixa paga adiantadamente (custo do jogo), você pode lançar um dado não-viesado e ganhar \$10 se o resultado for um número ímpar ou \$20 caso seja par
* O **valor esperado do retorno** deste jogo é, portanto:
$$EV = 0,5 \times \$10 + 0,5 \times \$20 = \$15$$
* O jogo é considerado um **jogo justo**, ou aposta justa, se o custo de participar for exatamente \$15
   ⚠️ Mesmo que a distribuição de probabilidades dos resultados possíveis seja conhecida, o resultado propriamente dito de uma jogada individual não o é
* Portanto, pessoas com **aversão ao risco** se negariam a jogá-lo
* No entanto, amantes do risco poderiam estar dispostos a participar de jogos justos ou até mesmo de jogos cujas probabilidades lhes são adversas (custo do jogo maior que valor do retorno esperado)
* As preferências dos indivíduos com relação ao risco são captadas pela especificação de diferentes funções utilidades
"

# ╔═╡ 934ab5f1-58e4-47f0-aab0-307c2b211134
PlutoUI.Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula3_fig8.PNG", :width=>800)

# ╔═╡ 240124a3-61ed-4fe2-8bb6-6df265d8096e
md"
* Seja $U = U(x)$, onde $x$ denota o retorno, a função utilidade de um agente, a utilidade esperada de jogar este jogo é dada por:
$$EU = 0,5 \times U(\$10) + 0,5 \times U(\$15)$$
* Uma função utilidade estritamente côncava, $U(0) = 0$, $U'(x) > 0$ e $U''(x) < 0$ é associada a um comportamento de aversão ao risco
* Neste caso, a utilidade de não participar do jogo é maior que a utilidade esperada de participar
* Uma função estritamente convexa, por sua vez, é associada a um comportamento favorável ao risco (ver Figura acima)
"

# ╔═╡ 86aded17-dafa-4438-a4e5-4c06940c0ea0
md"""
!!! info "Exercício"
	Considere um indivíduo com uma dotação de riqueza igual a \$100.000 que se depara com uma chance de 25% de perder seu automóvel avaliado em \$20.000 por um roubo ao longo do próximo ano

	Suponha que a função utilidade deste indivíduo é logarítmica - $U(W) = \ln W$

	1. Mostre que esta função é estritamente côncava e, portanto, este indivíduo apresenta um comportamento de aversão ao risco

	2. Qual seria a utilidade esperada se este indivíduo decidir passar o próximo ano sem se assegurar?

	3. Nesta situação, um prêmio justo do seguro seria \$5.000. Qual seria a utilidade esperada de um seguro justo?

	4. Qual prêmio máximo este indivíduo estaria disposto a pagar para se precaver da possibilidade de furto?
"""

# ╔═╡ 513183ef-f34e-47ee-a241-018c67a34a21
md"""
!!! hint "Resposta"
	1.  $U'(W) = \frac{1}{W} > 0$ e $U''(W) = -\frac{1}{W^2} < 0$.

	2. Se este indivíduo passa o próximo ano sem se assegurar, sua utilidade esperada será

	$$E_{no}[U(W)] = 0,75 U(100.000) + 0,25 U(80.000) \approx 11,45714$$

	3. Se este indivíduo assegura completamente seu automóvel, sua riqueza será de \$95.000 independente de ter sido roubado ou não. Portanto, a utilidade esperada de um seguro justo é de:

	$$E_{justo}[U(W)] = U(95.000) = \ln (95.000) \approx 11,46163$$

	4. Vimos que a utilidade deste indivíduo é maior se adquirir um seguro justo.  Na verdade, estaria disposto a pagar mais do que o prêmio justo por um seguro. Podemos determinar o prêmio máximo de seguro que estaria disposto a pagar da seguinte forma:

	$$E_{wtp}[U(W)] = U(100.000 - x) = \ln(100.000 - x) = 11,45714$$

	Resolvendo esta equação para $x$, temos: $x = 5.426$

	Este indivíduo estaria disposto a pagar até \$426 em custos administrativos para uma seguradora (além do prêmio de \$5.000 para cobrir o valor esperado da perda)
"""

# ╔═╡ 2b06a05d-827b-4907-96e1-39342e6f81c1
md"
---
### Teste da segunda derivada
"

# ╔═╡ 12c29c4b-c091-44df-aad6-bf329bbb9431
md"
* Com a relação estabelecida entre a segunda derivada de uma função $f$ e a curvatura de seu gráfico, podemos estabelecer as seguintes condições para extremos locais
"

# ╔═╡ 8860db70-ef0d-4b78-b5e8-b2a02bd9ca47
md"""
!!! correct "Teorema 3.7 - Teste da segunda derivada"
	Suponha que $f''$ seja contínua na vizinhança do ponto $a$.

	* Se $f'(a) = 0$ e $f''(a) > 0$, então, $f$ tem um mínimo local em $a$.
	* Se $f'(a) = 0$ e $f''(a) < 0$, então, $f$ tem um máximo local em $a$.
	
	---
	▶️ Demonstração

	Ver Spivak - Calculus (1994) - pp. 186-187 🔳
"""

# ╔═╡ f3dccee7-38e7-44f9-b451-7efd38f30985
md"
* O Teorema 3.7 pode ser aplicado à função $f(x) = x^3-x$, que já analisamos
* Note que:

$$f'(x) = 3x^2 - 1$$

$$f''(x) = 6x$$

* Nos pontos críticos, $-\sqrt{1/3}$ e $\sqrt{1/3}$, temos:

$$f''\left(-\sqrt{1/3}\right) = -6\sqrt{1/3} < 0$$

$$f''\left(\sqrt{1/3}\right) = 6\sqrt{1/3} > 0$$

* Consequentemente, $-\sqrt{1/3}$ é um ponto de máximo local e $\sqrt{1/3}$ é um ponto de mínimo local
"

# ╔═╡ 1dbf1020-a4ba-42a5-bbc5-c6953cd569c1
md"""
!!! warning "Casos em que a segunda derivada é nula"
	Note que se $a$ é um ponto crítico de $f$, é possível que $f''(a) = 0$. Neste caso, o Teorema 3.7 não fornece informações: é possível que $a$ seja um ponto de máximo local, um ponto de mínimo local, ou nenhum dos casos anteriores.

	Exemplos: $f(x) = -x^4$, $f(x) = x^4$, $f(x) = x^5$
"""

# ╔═╡ 92e39b84-1e3a-4390-8fd3-5c1aac7dc00b
begin
	la = @layout [a b; c]
	plota = plot(range(-2, 2, 200), x -> -x^4, lc=:indianred, label=L"f(x) = -x^4")	
	vline!([0], ls=:solid, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:solid, lc=:black, lw=0.5, label=:none)
	plotb = plot(range(-2, 2, 100), x -> x^4, lc=:indianred, label=L"f(x) = x^4")	
	vline!([0], ls=:solid, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:solid, lc=:black, lw=0.5, label=:none)
	plotc = plot(range(-2, 2, 100), x -> x^5, lc=:indianred, label=L"f(x) = x^5")
	vline!([0], ls=:solid, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:solid, lc=:black, lw=0.5, label=:none)	
	plot(plota, plotb, plotc, layout = la)
end

# ╔═╡ f0a33ae9-bfa5-4cf9-b103-f3ed781e5964
md"""
!!! correct "Teorema 3.8"
	Suponha que $f''(a)$ exista.

	* Se $f$ tem um mínimo local em $a$, então, $f'(a) = 0$ e $f''(a) \geq 0$.
	* Se $f$ tem um máximo local em $a$, então, $f'(a) = 0$ e $f''(a) \leq 0$.
	
	---
	▶️ Demonstração

	Ver Spivak - Calculus (1994) - pp. 187 🔳
"""

# ╔═╡ 63293e11-8e93-4baa-ba12-30e70e307b0b
md"""
!!! danger "Resumo"
	Portanto, podemos resumir os resultados obtidos até agora na seguinte tabela:

	Condições para um extremo relativo: $y = f(x)$

	| Condição | Máximo | Mínimo |
	| :--- | ---: | ---: |
	| Necessária de primeira ordem | $f'(x) = 0$ | $f'(x) = 0 |
	| Necessária de segunda ordem | $f''(x) \leq 0$ | $f''(x) \geq 0$|
	| Suficiente de segunda ordem | $f''(x) < 0$ | $f''(x) > 0$|
"""

# ╔═╡ bc25519b-1072-40e9-a130-4346ec5e7f05
md"""
> **Exercícios**.
>
> 1. Encontre o extremo relativo da seguinte função e determine se é um ponto de mínimo ou máximo local:
>
> $f(x) = 4x^2 - x$
>
> 2. Encontre os extremos relativos da seguinte função e classifique-os:
>
> $g(x) = x^3 - 3x^2 + 2$
>
> 3. CLassifique os pontos críticos da função:
>
> $h(x) = x^2 e^x$
"""

# ╔═╡ 06b2f3e4-81cf-45d4-82c8-2c5c18928cd1
begin
	l_exerc = @layout [a b; c]
	plot_exerc1 = plot(range(-2, 2, 200), x -> 4x^2 - x, lc=:indianred, label=L"f(x) = 4x^2 - x")	
	vline!([0], ls=:solid, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:solid, lc=:black, lw=0.5, label=:none)
	plot_exerc2 = plot(range(-2, 4, 100), x -> x^3 - 3x^2 + 2, lc=:indianred, label=L"g(x) = x^3 - 3x^2 + 2")	
	vline!([0], ls=:solid, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:solid, lc=:black, lw=0.5, label=:none)
	plot_exerc3 = plot(range(-9, 1, 100), x -> x^2*exp(x), lc=:indianred, label=L"h(x) = x^2 e^x")
	vline!([0], ls=:solid, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:solid, lc=:black, lw=0.5, label=:none)	
	plot(plot_exerc1, plot_exerc2, plot_exerc3, layout = l_exerc)
end

# ╔═╡ dabe7cca-43b4-4bf0-808b-4ac1d12decb8
md"
---
### Maximização de lucros
"

# ╔═╡ 62891aaa-e6f2-46ca-adb1-7aa178131745
md"
* O problema de maximização de lucros por parte de uma firma pode ser especificado como um problema de otimização estática irrestrito:
$$\max_{Q} \pi(Q) \equiv R(Q) - C(Q)$$

* **Condição necessária de primeira ordem**: quantidade ótima produzida ($Q^*$) deve satisfazer à condição de que receita marginal é igual a custo marginal
$$\frac{d\pi}{dQ} = 0 \Leftrightarrow R'(Q) = C'(Q)$$

* **Condição necessária de segunda ordem**:
$$\frac{d^2\pi}{dQ^2} \leq 0 \Leftrightarrow R''(Q) \leq C''(Q)$$
Note que, como vimos anteriormente, no caso em que $R''(Q) = C''(Q)$, não chegamos a uma conclusão definitiva sobre $Q*$ ser um máximo relativo

* **Condição suficiente de segunda ordem**:
$$\frac{d^2\pi}{dQ^2} < 0 \Leftrightarrow R''(Q) < C''(Q)$$
Portanto, avaliadas no ponto $Q^*$, a taxa de variação da receita marginal deve ser menor que a taxa de variação do custo marginal
"

# ╔═╡ 8fbe7475-06b3-436a-a4e7-77ff042c696b
md"""
!!! info "Exemplo (Maximização de lucros)"
	Considere, respectivamente, as seguintes funções receita total e custo total:

	$$\begin{eqnarray*} R(Q) &=& 1200Q - 2Q^2, \\ C(Q) &=& Q^3 - 61,25Q^2 + 1528,5Q + 2000\end{eqnarray*}$$

	Calcule os pontos críticos da função lucro e a quantidade $Q^*$ que maximiza o lucro desta firma.
"""

# ╔═╡ c463aa4a-cb04-4bca-8d4d-3ff3cc9a7f4c
md"
---
### Teste da $n$-ésima derivada
"

# ╔═╡ 2bc46688-e134-4360-8336-1d6a6aff4033
md"
* Como vimos no [`teste da primeira derivada`](#030424c4-8ce6-42e0-a59e-539a0245e17c) para máximos e mínimos relativos, podemos usar informações a respeito do sinal algébrico da primeira derivada da função na vizinhança de um ponto crítico para classificá-lo
* Nesta seção, veremos como este resultado pode ser combinado à aproximação de funções $n$ vezes diferenciável em um ponto para desenvolvermos um teste geral de um extremo relativo
"

# ╔═╡ 6a96b780-731d-4fd9-bd85-f1c921d38d14
md"""
!!! correct "Teorema 3.9"
	Seja $n \geq 1$ um número inteiro e uma função $f: \mathbb{R} \to \mathbb{R}$ $n$-vezes diferenciável no ponto $a \in \mathbb{R}$.

	Defina uma função polinomial da forma:
	
	$$P_{n,a}(x) = f(a) + \frac{f'(a)}{1!}(x - a) + \frac{f''(a)}{2!}(x-a)^2 + \dots + \frac{f^{(n)}(a)}{n!}(x-a)^n$$

	Então, temos que:

	$$\lim_{x\to a}\frac{f(x) - P_{n,a}(x)}{(x - a)^n} = 0$$

	---
	▶️ Demonstração

	Ver Spivak - Calculus (1994) - pp. 384 🔳
"""

# ╔═╡ 82d65f83-39e8-4233-add8-1a03e7f7d223
md"
* Usaremos o Teorema 3.9 para aperfeiçoar o teste de primeira derivada que desenvolvemos anteriormente
* Se $a$ é um ponto crítico de $f$, então, $f$ tem um mínimo local em $a$ se $f''(a) > 0$, e um máximo local em $a$ se $f''(a) < 0$
* Caso $f''(a) = 0$ nenhuma conclusão era possível, mas podemos imaginar que o sinal algébrico de $f'''(a)$ possa nos dar alguma nova informação
* E caso $f'''(a) = 0$, então, o sinal de $f^{(4)}$ pode ser importante
* De maneira mais geral, podemos perguntar o que acontece quando:
$$\begin{eqnarray} f'(a) = f''(a) = \dots = f^{(n-1)}(a) &=& 0 \\ f^{(n)}(a) &\neq& 0\end{eqnarray}$$
* Podemos criar alguma intuição a respeito do que acontecerá ao examinarmos as seguintes funções potência (que satisfazem as condições acima):
$$\begin{eqnarray} f(x) &=& (x - a)^n \\ g(x) &=& -(x-a)^n\end{eqnarray}$$
"

# ╔═╡ 729d122a-506e-4f43-9941-66c4852e746e
begin	
	plot(range(-1, 1, 200), x -> x, lc=:indianred, label=L"n = 1")
	plot!(range(-1, 1, 200), x -> x^2, lc=:black, label=L"n = 2")
	plot!(range(-1, 1, 200), x -> x^3, lc=:darkorange, label=L"n = 3")
	plot!(range(-1, 1, 200), x -> x^4, lc=:navyblue, label=L"n = 4")
	plot!(range(-1, 1, 200), x -> x^5, lc=:darkgreen, label=L"n = 5")
	plot!(range(-1, 1, 200), x -> x^6, label=L"n = 6")
	hline!([0], ls=:dash, lw=0.5, lc=:black, label=:none)
	vline!([0], ls=:dash, lw=0.5, lc=:black, label=:none)
end

# ╔═╡ 1799bdb7-850f-4124-bbbe-7c2c95a5083f
begin	
	plot(range(-1, 1, 200), x -> -x, lc=:indianred, label=L"n = 1")
	plot!(range(-1, 1, 200), x -> -x^2, lc=:black, label=L"n = 2")
	plot!(range(-1, 1, 200), x -> -x^3, lc=:darkorange, label=L"n = 3")
	plot!(range(-1, 1, 200), x -> -x^4, lc=:navyblue, label=L"n = 4")
	plot!(range(-1, 1, 200), x -> -x^5, lc=:darkgreen, label=L"n = 5")
	plot!(range(-1, 1, 200), x -> -x^6, label=L"n = 6")
	hline!([0], ls=:dash, lw=0.5, lc=:black, label=:none)
	vline!([0], ls=:dash, lw=0.5, lc=:black, label=:none)
end

# ╔═╡ 997f8836-eed0-429a-a874-f9019462d32e
md"
* Note pela figura acima que se $n$ é ímpar, então, $a$ (que, sem perda de generalidade, foi fixado em 0) não é nem mínimo nem máximo local para $f$ ou $g$
* Por outro lado, se $n$ é par, então, $f$ (com uma $n$-ésima derivada positiva) tem um mínimo local em $a$, enquanto $g$ (com uma $n$-ésima derivada negativa) tem um máximo local em $a$
* O Teorema 3.10 a seguir mostra que este resultado é geral para funções que satisfazem o mesmo conjunto de condições que $f$ e $g$
"

# ╔═╡ 59ea5f94-b82f-4acb-9a86-4e73d4749044
md"""
!!! correct "Teorema 3.10"
	Suponha que as seguintes condições sejam satisfeitas:

	$$\begin{eqnarray}f'(a) = f''(a) = \dots = f^{(n-1)}(a) &=& 0 \\ f^{(n)}(a) &\neq& 0\end{eqnarray}$$

	Temos as seguintes situações:

	(1) se $n$ é par e $f^{(n)}(a) > 0$, então, $f$ tem um mínimo local em $a$

	(2) se $n$ é par e $f^{(n)}(a) < 0$, então, $f$ tem um máximo local em $a$

	(3) se $n$ é ímpar, então, $f$ não possui nem um mínimo local nem um máximo local em $a$
"""

# ╔═╡ 89d1587e-be19-476f-8878-18d0d26bd393
md"""
!!! danger "Demonstração"
	Suponha, sem perda de generalidade, que $f(a) = 0$ (note que nem as hipóteses nem a conclusão são afetadas se $f$ for substituída por $f - f(a)$). Então, como as $n-1$ primeiras derivadas de $f$ em $a$ são nulas, o polinômio de Taylor $P_{n,a}$ de $f$ é:

	$$\begin{eqnarray}P_{n,a}(x) &=& f(a) + \frac{f'(a)}{1!}(x-a) + \dots + \frac{f^{(n)}(a)}{n!}(x-a)^n \\ &=& \frac{f^{(n)}(a)}{n!}(x-a)^n\end{eqnarray}$$

	Pelo Teorema 3.9, temos:

	$$0 = \lim_{x\to a}\frac{f(x)-P_{n,a}(x)}{(x-a)^n} = \lim_{x\to a}\left[\frac{f(x)}{(x-a)^n} - \frac{f^{(n)}(a)}{n!}\right]$$

	* **Caso 1**: $n$ é par.

	    * Neste caso $(x-a)^n > 0, \forall x \neq a$
        * Como $\text{sgn}\left(f(x)/(x-a)^n\right) = \text{sgn}\left(f{(n)} (a)/n!\right)$ para $x$ suficientemente próximo de $a$ (por continuidade), segue que $\text{sgn}\left(f(x)\right) = \text{sgn}\left(f^{(n)}(a)/n!\right)$ para $x$ suficientemente próximo de $a$
        * Se $f^{(n)}(a) > 0$, isso significa que $f(x) > 0 = f(a)$ para $x$ próximo a $a$
        * Consequentemente, $f$ tem um mínimo local em $a$
        * Uma demonstração similar funciona para o caso em que $f^{(n)}(a) < 0$

	* **Caso 2**: $n$ é ímpar.
	    * Usando o mesmo argumento anterior, temos que $\frac{f(x)}{(x-a)^n}$ sempre tem o mesmo sinal
	    * Mas $(x-a)^n > 0$ se $x > a$ e $(x-a)^n < 0$ se $x < a$
	    * Portanto, $f(x)$ tem sinais diferentes para $x > a$ e $x < a$
	    * Isso prova que $f$ não tem nem um mínimo local nem um máximo local em $a$ 🔳

"""

# ╔═╡ 16d64d5f-d2b4-4439-a37c-0ca97c72b587
md"
## 📚 Bibliografia

* SPIVAK, M. Calculus. Cambridge University Press, 1994.

* STEWART, J; CLEGG, D.; WATSON, S. [Cálculo – Volume 1](https://app.minhabiblioteca.com.br/reader/books/9786555584097). 6.ed - Tradução da 9.ed. norte-americana. Cengage Learning Brasil, 2022.

* SUNDARAM, R.K. A first course in optimization theory. Cambridge University Press, 1996.
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
Plots = "~1.38.6"
PlutoUI = "~0.7.50"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.5"
manifest_format = "2.0"
project_hash = "9d8e0b5eb44ada63f68e061ff9afa8d2a96e47f7"

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
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "485193efd2176b88e6622a39a246f8c5b600e74e"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.6"

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
git-tree-sha1 = "7a60c856b9fa189eb34f5f8a6f6b5529b7942957"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.6.1"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.1+0"

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
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

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
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "0a1b7c2863e44523180fdb3146534e265a91870b"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.23"

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
version = "2.28.0+0"

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
version = "2022.2.1"

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
version = "0.3.20+0"

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
version = "10.40.0+0"

[[deps.Parsers]]
deps = ["Dates", "SnoopPrecompile"]
git-tree-sha1 = "478ac6c952fddd4399e71d4779797c538d0ff2bf"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.8"

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
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

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
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "ef28127915f4229c971eb43f3fc075dd3fe91880"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.2.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

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

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.1"

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
version = "1.2.12+3"

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
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

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
# ╟─d0b3ef72-bc42-11ed-0872-07547ee82c64
# ╟─78424b9c-44c1-4e61-ba01-09a2c82ad0b3
# ╟─97474620-4abb-4192-bb6e-e95043044751
# ╟─a449c066-12df-4de5-bf24-46453c32bd8f
# ╟─e6556f3c-85e0-4dc9-b70b-dd7a48efce49
# ╟─c22d4f93-d70a-4ba3-ab70-b11c2e98cb7c
# ╟─69a948fc-76a4-4da6-b6bf-10cc1e4febb9
# ╟─7791fbdb-31be-4f30-834c-c171c03282dd
# ╟─4b9d61de-9581-48a9-9bbc-32e71170d45c
# ╟─f29148d0-93eb-4b0a-a83e-339cb117aea2
# ╟─202c0ec1-30d5-4b15-9a9d-8a5c61fb312f
# ╟─c830232d-ef99-41d9-a981-9d034e23f535
# ╟─adb820b1-c97e-4a24-9373-689c142b0221
# ╟─6c677617-06c8-4d55-b789-f8594d91de4c
# ╟─7c563e57-2553-4cd5-af51-9ca976fd1c9e
# ╟─cf51f0e4-f1b9-4608-8799-6f47bae2fa26
# ╟─67e97f99-bd1b-4a61-b88b-aa717184ddec
# ╟─a2ad174d-c945-49b5-a688-b89fdb02177f
# ╟─33116ab9-c4e5-45c7-90e7-63a1603e412d
# ╟─6c662d33-d22e-4edc-a1c0-6786c09fd3e6
# ╠═f07793c7-2750-4b95-8efd-9f9d3452acc0
# ╟─23e427ea-ca64-47bd-9b3c-9a28e6353371
# ╟─9e217828-12d4-429f-917e-ffdf92f0406b
# ╟─8c27995a-8b42-4bf8-af06-a2bcbcda124e
# ╟─decca2f3-26d0-4ca2-84ab-56d136d8db55
# ╟─5df23df2-4fee-48b0-af31-8dc3441bc312
# ╟─80a550a8-3326-40a7-b81e-5665fb7a2ed6
# ╟─a2a6a6ad-d804-4a6f-b43f-90152872c43e
# ╟─c96ca469-e151-42d1-8c12-27d8a1e018f1
# ╟─4e940361-18c1-40e1-9c15-194ba6a13d0c
# ╟─c2c77e04-0f8c-4b2c-9903-21d6373d48ad
# ╟─5ca736fa-37e5-40bc-adf8-cb1c072f0e87
# ╟─164dd5e2-635b-43d2-9e88-0088b8abd4e2
# ╟─b25c4bca-394a-4d5d-99d8-e233490e54b3
# ╟─d0cfa9c7-c23e-4265-8506-f44d482b8df6
# ╟─82b4e7f3-fc13-49c6-a837-cd2436a1ca62
# ╟─993ac944-4660-4c9f-b484-dc5d1d3b48ab
# ╟─bca45e92-bfad-4a6e-aae7-c1a63118abd2
# ╟─380cf939-205d-48d0-a60c-e92f24997f32
# ╟─7ff5456d-d5b8-4156-94d1-c7ee6a4c1afc
# ╟─27c003b1-5936-4dc1-a47b-6dc8f62a66a7
# ╟─919ab09f-43f4-4955-8a3f-058cd51cd6b6
# ╟─ebbb81e7-8fae-411b-ba27-5320c83fbcfb
# ╟─0f39d48f-61ac-4ff8-8d5e-421b1d29a522
# ╟─950f46f5-809e-4f0a-bbbe-bfa9bf8d6d6c
# ╟─62d4ed87-16aa-4175-92a8-1dcbae2d0d62
# ╟─9710c296-c7c5-4047-b0bc-18267282ef62
# ╟─d67c1280-a25b-4772-82d3-e11b87c2da78
# ╟─de87e52c-bd3a-47d5-924f-746e80455112
# ╟─e0418d0f-dd68-4d54-98bf-8e72dfc15426
# ╟─6065e600-d611-44e7-af18-d6b345cfb363
# ╟─3c104357-03f4-4cf6-96f2-763a39198b38
# ╟─7a618c6c-9efc-445e-b76b-2cb9b3469bdc
# ╟─6d89f754-9087-4d13-b5a4-71b0acba0a05
# ╟─e70a3e5a-c064-4189-906b-1c3328d1e1dd
# ╟─bb5b9c0f-b7e3-4fac-bad9-7bd49a08346b
# ╟─c8bcba54-698d-4323-857d-cf4231b122d2
# ╟─1afefcbc-dc7e-4f5c-b070-686c6a271272
# ╟─5b5ac592-bbd7-4f6e-8ed0-2cdfd6720d3a
# ╟─448ed48d-a4e0-413c-946c-aa5a0c564fb1
# ╟─f2c29059-49f7-4515-8e12-6003e1b19a92
# ╟─805e13d0-bfae-4156-8436-db55dc1db3ba
# ╟─5f07d271-170d-4444-8f57-50f6e7259e1b
# ╟─b9970ad6-53b3-4bbd-a42f-d317aab7288a
# ╟─e12ee181-e0c2-47ed-982e-e6bed0e367a5
# ╟─82ad10b3-cacc-4e23-9af6-d7c7f7be9134
# ╟─cb2ff438-b7f0-4c3a-ae54-84fdad5af27b
# ╟─42a91e68-ae82-4181-969f-ff0ae9e10562
# ╟─62eae816-02ff-4be7-baed-03d8e3806cf5
# ╟─6ff3d827-529c-4097-8a88-7afbde57bdb9
# ╟─f7b0e426-8001-4899-b5f8-f9e0bf3e52d2
# ╟─2a0cee9a-99b1-4392-a8a4-62406d72219c
# ╟─86e4126e-aeec-4e10-b7f3-29d251d1ab76
# ╟─d7e075ce-5c63-4763-8a98-fb7650554c13
# ╟─6ed1bf78-369f-4114-b214-c3dc723d40e2
# ╟─f5552f3d-c78d-4986-b8d8-93b324993026
# ╟─f826222b-428f-47c7-a0c9-69bca1955de0
# ╟─ace7c499-2e3a-473d-a908-feec74c9f2ed
# ╟─98da49ef-c304-476a-a14d-61743727aaa5
# ╟─170e8fc8-b344-4433-ae86-2ca805f9491c
# ╟─b2a406f2-4402-4c76-802c-3817be96cd7b
# ╟─787001f6-ecbe-4272-b849-b1b7b1821150
# ╟─ee03f1cd-b5ac-4be9-b505-0fde06d4d827
# ╟─8c8ca2e7-9822-422c-8d07-bbf13d09912b
# ╟─0c292257-d8ee-4e94-b139-a2c63631fdb3
# ╟─8490c2ff-7ba3-402c-9e2c-d9ef5b6b8a4f
# ╟─6c4978c9-92ce-49ad-9941-8cdabdc779f1
# ╟─5e3427b7-a0c4-47fe-a948-646c923ae666
# ╟─1476e345-73f2-4899-b6ef-927fe3f4a7bb
# ╟─15e45302-5fd8-40ea-b17f-1de199ccc836
# ╟─53233768-3b74-4896-8c82-54ae06c13401
# ╟─e12887a7-fc7f-4b59-8ee8-2e3b1d5ce39a
# ╟─b4731098-7def-40a9-bb66-0ce25dc88e0a
# ╟─50fb651c-bc74-4043-b7ac-a6e56fbd3093
# ╟─1a6f1490-460a-485e-9582-2f967ca27413
# ╟─10ea25df-fa46-4eca-84f0-f8a93bfee555
# ╟─9b7b8b1d-1d5f-44a2-b6dd-d888ff2b5fda
# ╟─e83348c0-13ec-4b11-97fe-a86d8fab43bb
# ╟─d0a21a19-5728-4f9c-b279-236be35a0596
# ╟─e550e26e-10ee-4943-86b8-ead1cc8259bf
# ╟─beefa888-76fe-41bc-ae14-9deece007f03
# ╟─75176f5c-5bc0-4b41-8905-2267ed7d4ea7
# ╟─030424c4-8ce6-42e0-a59e-539a0245e17c
# ╟─a3af2ad6-cf6c-4897-82cc-1e79ef92b607
# ╟─39b5797b-d408-45d5-9eb6-6df20f6ead73
# ╟─24e215e8-ce81-452e-ba67-7b515c27fe54
# ╟─11396406-8e90-426d-b2ca-ea8f842905af
# ╟─d6c095fe-7840-4861-9be1-70a890350b06
# ╟─e4826002-3ae7-4d87-afb1-eb349f3bdbe6
# ╟─ab6d40d1-dad2-4b26-a6ad-57ee297657e9
# ╟─78991214-33ec-46ed-a042-e6c34d3f6aa6
# ╟─8977e59b-1c10-45a1-91d5-06ca92bcdfcd
# ╟─c8fe97f4-e52b-4ab5-b6cc-0ad7639ed91c
# ╟─0c1a3b59-dd47-4b6a-86dc-9106258aa0c9
# ╟─3f5fc585-63a4-48d4-b6bd-1d79a3b92318
# ╟─2b36d298-541e-427a-88c5-ecd2d7c58a43
# ╟─082c0302-8be8-4604-bbb1-f9f029f3716b
# ╟─7b20951f-6cab-476f-84d3-d9beb1cc2d81
# ╟─04b46e41-3f18-4d2e-8a97-15f17f863a09
# ╟─150fb1fe-a113-464e-b66f-a9d7bca9901c
# ╟─285eba04-fe12-4d05-959a-fee626a7c913
# ╟─fe11e2c0-1007-46a1-9dbb-b483e6e27b7b
# ╟─9717127b-a5f8-4b5b-b0f6-eece34faafce
# ╟─1958aed5-ad08-4885-b13d-d0cbd827f470
# ╟─fe778b14-62c7-494b-9fa3-0f3be2310792
# ╟─5bd0a512-f410-4968-afdc-409796f72cad
# ╟─589e1a22-1cf5-4b6b-b526-ef37430fe6dd
# ╟─05627a7f-d002-404f-9ed2-f8e9c86b4857
# ╟─7bb1cc0f-e2f6-4e33-85e3-ae0c2b8e8722
# ╟─f1e8c9a7-7a43-4288-9234-6d6b657c789c
# ╟─e9f2ad54-b5e5-4e3a-9d6c-b5e8d320cea5
# ╟─9217b0ba-1a68-4fda-afc7-25b4478cb5d3
# ╟─bfb79391-0fb4-4700-bea6-a857a6922c7f
# ╟─1510f5f1-4a04-4eb6-8667-9758f21fb302
# ╟─e7b1b06d-3c1c-4d76-8032-b267a77837d1
# ╟─4f85efad-6eae-49d9-b970-78438a1b4e05
# ╟─c7941622-c159-4be8-8526-3d7df6fa8ae1
# ╟─d036c8ee-13fc-4e3f-b759-ccff981302dd
# ╟─e76a4846-b1d2-429e-a3c7-fbfd4041da53
# ╟─8a432026-633f-4d52-9d99-bf4d052975ba
# ╟─37e0252a-d307-4449-b011-aef8a00fdd0e
# ╟─2767cd29-34ff-42e9-8e3c-146f9efd3178
# ╟─6e691417-b4a8-43d4-bcbd-2f6939774435
# ╟─fa96d08f-cd44-426a-a219-269772721a2a
# ╟─974f6ff1-befd-436f-b31a-29ad51ba21ad
# ╟─934ab5f1-58e4-47f0-aab0-307c2b211134
# ╟─240124a3-61ed-4fe2-8bb6-6df265d8096e
# ╟─86aded17-dafa-4438-a4e5-4c06940c0ea0
# ╟─513183ef-f34e-47ee-a241-018c67a34a21
# ╟─2b06a05d-827b-4907-96e1-39342e6f81c1
# ╟─12c29c4b-c091-44df-aad6-bf329bbb9431
# ╟─8860db70-ef0d-4b78-b5e8-b2a02bd9ca47
# ╟─f3dccee7-38e7-44f9-b451-7efd38f30985
# ╟─1dbf1020-a4ba-42a5-bbc5-c6953cd569c1
# ╟─92e39b84-1e3a-4390-8fd3-5c1aac7dc00b
# ╟─f0a33ae9-bfa5-4cf9-b103-f3ed781e5964
# ╟─63293e11-8e93-4baa-ba12-30e70e307b0b
# ╟─bc25519b-1072-40e9-a130-4346ec5e7f05
# ╟─06b2f3e4-81cf-45d4-82c8-2c5c18928cd1
# ╟─dabe7cca-43b4-4bf0-808b-4ac1d12decb8
# ╟─62891aaa-e6f2-46ca-adb1-7aa178131745
# ╟─8fbe7475-06b3-436a-a4e7-77ff042c696b
# ╟─c463aa4a-cb04-4bca-8d4d-3ff3cc9a7f4c
# ╟─2bc46688-e134-4360-8336-1d6a6aff4033
# ╟─6a96b780-731d-4fd9-bd85-f1c921d38d14
# ╟─82d65f83-39e8-4233-add8-1a03e7f7d223
# ╟─729d122a-506e-4f43-9941-66c4852e746e
# ╟─1799bdb7-850f-4124-bbbe-7c2c95a5083f
# ╟─997f8836-eed0-429a-a874-f9019462d32e
# ╟─59ea5f94-b82f-4acb-9a86-4e73d4749044
# ╟─89d1587e-be19-476f-8878-18d0d26bd393
# ╟─16d64d5f-d2b4-4439-a37c-0ca97c72b587
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

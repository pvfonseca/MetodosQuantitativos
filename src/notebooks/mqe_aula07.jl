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

# ╔═╡ 407c2350-d35d-11ed-3732-970fa3d6d6b1
begin
	using PlutoUI
	using Plots
	using LaTeXStrings
	using Measures	
	import PlutoUI: combine	
	theme(:ggplot2)
	gr(size=(800,600), lw = 2, fontfamily = "Computer Modern", grid=true, tickfontsize = 12, guidefontsize=16, framestyle=:box, margin=3mm, right_margin=7mm, guidefonthalign=:right, guidefontvalign=:top)	
end

# ╔═╡ 2b89dc01-35e1-432f-84a9-33f4c3bbe052
PlutoUI.TableOfContents(title="Sumário", indent=true)

# ╔═╡ cf2fbc7b-6f3f-41a1-8f20-1e1b6de5b3b8
html"<button onclick=present()>Apresentação</button>"

# ╔═╡ 0c60cc99-614b-44ba-969f-4ba20476d943
md"""
# Concavidade e Convexidade $~~~$ $(Resource("https://www1.udesc.br/imagens/id_submenu/899/cor_horizontal_rgb.jpg", :width => 150))
"""

# ╔═╡ 4f508c8b-176f-4b13-b4fa-65e3fe578255
md"
* **Disciplina:** 33MQEI - Métodos Quantitativos em Economia I
* **Docente:** [Paulo Victor da Fonseca](https://pvfonseca.github.io)
* **Contato:** [paulo.fonseca@udesc.br](mailto:paulo.fonseca@udesc.br)
"

# ╔═╡ b4357649-ae3e-4d44-8451-4969be877616
md"""
!!! danger "Aviso"
	O texto que segue não tem a menor pretensão de originalidade. Ele serve apenas como registro dos principais princípios, conceitos e técnicas analíticas que são trabalhados em sala de aula.
"""

# ╔═╡ bf1ebb30-c9a5-4f82-9193-9b8373275f70
md"
## Introdução
"

# ╔═╡ 4691f12c-79e4-4d77-917e-d67944bda4e3
md"
* Nos nossos estudos de problemas de otimização estática até agora, nossas definições fizeram a distinção entre ótimos locais e globais
* No entanto, as condições de primeira e segunda ordem que enunciamos referem-se, simplesmente, aos mínimos e máximos locais
* As condições de segunda ordem - sejam enunciados em termos dos menores principais líderes do determinante Hessiano ou das raízes características da matriz Hessiana - estão sempre relacionadas à questão de um ponto extremo ser o pico de uma colina (máximo local) ou o fundo de um vale (mínimo local)
* Em outras palavras, referem-se ao modo como uma curva, superfície ou hipersuperfície se curva ao redor de um ponto estacionário
"

# ╔═╡ 803642c9-bb73-47b1-833e-b8a6359f6344
md"
> Nosso objetivo, agora, é determinar as condições sob as quais um máximo ou mínimo local será, também, um máximo ou mínimo global
"

# ╔═╡ ceae33b1-a67c-4b70-8e6e-813c94fede82
md"
* Se um ponto de ótimo local é também um ótimo global dependerá do formato da função objetivo considerada e, portanto, devemos estudar as classes de funções que tenham a propriedade de que os ótimos locais e globais coincidem
* Ao final veremos que quando temos uma **função convexa**, então, o ponto de mínimo local será, também, um ponto de mínimo global
* Por outro lado, quando a função objetivo é uma **função côncava**, então, o máximo local é, também, um máximo global
"

# ╔═╡ e427e6d6-6d3f-4fae-8db4-c781dafa8ac7
md"
* Uma função que dá origem a uma colina em todo o seu domínio é denominada uma **função côncava**
* A definição formal será dada mais adiante
"

# ╔═╡ 14802dbc-dff2-471a-8fdb-8eea86cc7835
begin	
	plot(range(-2, 2, 100), x -> -x^2, lc=:indianred, label=L"f(x) = -x^2")
	hline!([0], lw=1, lc=:black, label=:none)
	vline!([0], lw=1, lc=:black, label=:none)
	ylims!(-4, 1)
end

# ╔═╡ 31494539-6c43-4ab7-b6f4-674dfe01d6a1
begin	
	surface(range(-2, 2, 100), range(-2, 2, 100), (x, y) -> -x^2 - y^2, c=:thermal, display_option=Plots.GR.OPTION_SHADED_MESH, title=L"f(x, y) = -x^2 - y^2")	
end

# ╔═╡ 8942cc1c-28a5-4735-af9e-aeb3ce84af35
md"
* Uma função que dá origem a um vale em todo o seu domínio é denominada uma **função convexa**
* A definição formal será dada mais adiante
"

# ╔═╡ bcfa64c1-5ba6-452f-b68b-d7642c7ae7e6
begin	
	plot(range(-2, 2, 100), x -> x^2, lc=:indianred, label=L"f(x) = x^2")
	hline!([0], lw=1, lc=:black, label=:none)
	vline!([0], lw=1, lc=:black, label=:none)
	ylims!(-1, 4)
end

# ╔═╡ 0fabe2df-6343-410e-ab10-a784b0798a3d
begin	
	surface(range(-2, 2, 100), range(-2, 2, 100), (x, y) -> x^2 + y^2, c=:thermal, display_option=Plots.GR.OPTION_SHADED_MESH, title=L"f(x, y) = x^2 + y^2")	
end

# ╔═╡ d8c18dbf-cf8c-4c25-8546-44506db3919b
md"
* Na presente discussão, admitiremos que o domínio é todo o $\mathbb{R}^n$, onde $n \in \mathbb{N}$ é o número de variáveis de escolha
* Considerando que a caracterização como colina ou vale refere-se a todo o domínio da função, concavidade e convexidade são, é claro, conceitos **globais**
* Se as propriedades de concavidade e convexidade são válidas apenas para uma porção da curva, superfície ou hipersuperfície (somente para um subconjunto $S$ do domínio - $S\subset \mathbb{R}^n$), então, o máximo e o mínimo associados são relativos (ou locais) para aquele subconjunto do domínio, uma vez que não podemos ter certeza da situação fora do subconjunto $S$
"

# ╔═╡ 9c09a35d-333c-426f-91f8-3902e1d4b108
begin	
	surface(range(-3, 3, 100), range(-3, 3, 100), (x, y) -> x*exp(-x^2-y^2), camera=(30,15), display_option = Plots.GR.OPTION_SHADED_MESH, c=:thermal, level=true, title=L"f(x, y) = xe^{-x^2-y^2}")	
end

# ╔═╡ 58036263-5f21-4aaf-8ebe-53b7d0863dfb
md"
* Quando discutimos a condição de sinal definido de $d^2z$ (ou da matriz Hessiana $H$), avaliamos os menores principais líderes do determinante Heassiano somente nos pontos críticos
* Assim, limitamos a verificação de colina ou vale a uma pequena vizinhança do ponto crítico e, portanto, poderíamos discutir apenas máximos e mínimos **relativos**
* Mas pode acontecer de $d^2z$ ter um sinal algébrico definido em toda a extensão do domínio da função objetivo, independentemente de onde os menores principais líderes são avaliados
* Nesse caso, a colina ou vale cobriria todo o domínio e o máximo ou mínimo encontrado seria de natureza **global**
* Mais especificamente, se $d^2 z$ for negativa (positiva) semidefinida **em toda a sua extensão**, a função $z = f(x_1, \dots, x_n)$ deve ser côncava (convexa)
"

# ╔═╡ 3c8e461a-59cb-40e9-9527-3be51315a67f
md"
* Se quisermos uma classificação mais minuciosa, podemos também distinguir entre concavidade e convexidade por um lado, e **concavidade estrita** e **convexidade estrita** por outro
* No caso de _não-estrita_, a colina ou vale pode apresentar uma ou mais porções planas, tais como segmentos de reta ou segmentos de plano
* O conceito de concavidade (convexidade) estrita exclui tais segmentos planos
* As figuras que vimos até agora foram de funções estritamente convexas ou côncavas
"

# ╔═╡ 37e1792f-a700-48e7-a36d-482dac507cf1
begin
	plot(range(-2, 0, 100), x-> -x, lc=:indianred, label=L"f(x) = |x|")
	plot!(range(0, 2, 100), x-> x, lc=:indianred, label=:none)
	vline!([0], lw=1, lc=:black, label=:none)
	hline!([0], lw=1, lc=:black, label=:none)
end

# ╔═╡ 9a2deedf-5b59-49b8-a086-be794e0c2545
md"
* O gráfico da função $f(x) = |x|$ evidencia que a função é convexa, mas não estritamente convexa (contém segmentos de reta)
* Uma função estritamente côncava (estritamente convexa) deve ser côncava (convexa), mas a recíproca não é verdadeira
* Um ponto crítico de uma função côncava deve ser um máximo (em oposição a um mínimo)
* Além do mais, esse máximo deve ser um máximo absoluto, já que a colina abrange o domínio inteiro da função objetivo
* No entanto, esse máximo absoluto pode não ser único, porque podem ocorrer vários máximos se a colina tiver um topo horizontal plano
* Esta última possibilidade só pode ser descartada quando especificamos concavidade estrita
* Pois é apenas neste caso (de concavidade estrita) que um pico consistirá em um único ponto e o máximo absoluto será único
"

# ╔═╡ 7dad24b4-ca37-4a3b-924a-6e1cdf9ac884
begin	
	plot(range(-2, -0.5, 50), x->x, lc=:indianred, label=:none)
	plot!(range(-0.5, 0.5, 50), x->-0.5, lc=:indianred, label=:none)
	plot!(range(0.5, 2, 50), x->-x, lc=:indianred, label=:none)	
	vline!([0], lc=:black, lw=1, label=:none)
	hline!([0], lc=:black, lw=1, label=:none)
	title!("Não unicidade do ponto de máximo")
end

# ╔═╡ a86bdf84-7e74-4cd2-a275-b36a0a8cbe83
md"
* Por raciocínio análogo, um extremo de uma função convexa deve ser um mínimo absoluto (ou global), que pode não ser único
* Um extremo de uma função estritamente convexa deve ser um mínimo absoluto único
* Em termos da condição de sinal definido de $d^2z$ (ou da matriz Hessiana $H$), se $d^2z$ for negativa (positiva) definida em toda a sua extensão, a função $f$ deve ser estritamente côncava (estritamente convexa)
"

# ╔═╡ c1911f72-44f2-4211-a4bf-6d49de3e4601
md"""
!!! info "🎥 Spoiler"
	O principal resultado que teremos nesta seção da disciplina é que, dada uma função objetivo côncava (convexa), qualquer ponto crítico pode ser imediatamente identificado como um máximo (mínimo) global.

	Além disso, se a função objetivo for estritamente côncava (estritamente convexa), o ponto crítico deve ser, de fato, um máximo (mínimo) absoluto único!

	Portanto, uma vez satisfeita a condição necessária de primeira ordem, a concavidade (convexidade) ou concavidade estrita (convexidade estrita) substitui efetivamente as condições de segunda ordem como condição suficiente para um máximo absoluto.
"""

# ╔═╡ 2ea20fe7-b2b2-4e13-8622-5025e5d5d384
md"
* O poder dessa nova condição suficiente fica claro quando temos $d^2z = 0$ em um pico (vale), o que faz com que a CSO que vimos anteriormente falhe
* A concavidade (convexidade) ou concavidade estrita (convexidade estrita) pode dar conta até mesmo desses picos (vales) difíceis, porque garante que uma condição suficiente de ordem mais alta seja satisfeita, mesmo que a de segunda ordem não seja
* É por essa razão que muitas vezes economistas supõem concavidade da função objetivo desde o princípio (em modelos de maximização) já que, neste caso, basta aplicar a CPO

    ⚠️ Todavia, observe que se for usada uma função objetivo específica, a propriedade de concavidade ou convexidade deve ser verificada
"

# ╔═╡ aa857d0e-035b-4083-a67b-d311e309f3dc
md"
## Funções convexas e funções côncavas
"

# ╔═╡ 73036edf-b28e-40ea-8dce-bf2566a1c751
md"""
!!! correct "Definição 7.1 - Função convexa e função côncava"
	Seja $f: D \to \mathbb{R}$, onde $D \subset \mathbb{R}^n$, dizemos que $f$ é uma **função convexa** se para quaisquer dois pontos $\textbf{x}_1, \textbf{x}_2 \in D$, e qualquer número real $\lambda \in [0,1]$, a seguinte condição é satisfeita:

	$$f(\lambda \textbf{x}_1 + (1-\lambda)\textbf{x}_2) \leq \lambda f(\textbf{x}_1) + (1-\lambda)f(\textbf{x}_2) \tag{1}$$

	Se $f$ é uma função convexa, então, $g = -f$ é uma **função côncava**.

	Algebricamente:

	$$g(\lambda \textbf{x}_1 + (1-\lambda)\textbf{x}_2) \geq \lambda g(\textbf{x}_1) + (1-\lambda)g(\textbf{x}_2) \tag{2}$$
"""

# ╔═╡ f6689099-ff08-458f-9cdd-651855d47af2
md"""
!!! correct "Definição 7.2 - Função estritamente convexa e função estritamente côncava"
	Seja $f: D \to \mathbb{R}$, onde $D \subset \mathbb{R}^n$, dizemos que $f$ é uma **função estritamente convexa** se para quaisquer dois pontos $\textbf{x}_1, \textbf{x}_2 \in D$, e qualquer número real $\lambda \in (0,1)$, a seguinte condição é satisfeita:

	$$f(\lambda \textbf{x}_1 + (1-\lambda)\textbf{x}_2) < \lambda f(\textbf{x}_1) + (1-\lambda)f(\textbf{x}_2) \tag{3}$$

	Se $f$ é uma função estritamente convexa, então, $g = -f$ é uma **função estritamente côncava**.

	Algebricamente:

	$$g(\lambda \textbf{x}_1 + (1-\lambda)\textbf{x}_2) > \lambda g(\textbf{x}_1) + (1-\lambda)g(\textbf{x}_2) \tag{4}$$
"""

# ╔═╡ 89cbb8b1-37a1-4fac-910d-1cda73f1367d
md"
* As definições de funções côncavas e funções convexas podem ser representadas geometricamente para o caso em que $D \subset \mathbb{R}$ pelas seguintes figuras
"

# ╔═╡ 99b1e156-bace-48ac-a493-226864e67da9
begin
	pontoa = @bind pa Slider(-3:0.1:0, default=-1)
	pontob = @bind pb Slider(0:0.1:3, default=2)	

	md"""
	Ponto a: $(pontoa)
	
	Ponto b: $(pontob)	
	
	"""
end

# ╔═╡ ab4e2003-278b-40db-b656-322908b94e8c
begin	
	plot(range(-3, 3, 100), x->x^2 + 1, lc=:indianred, label="f convexa")
	plot!(Shape([(pa, pa^2 + 1), (pb, pb^2 + 1)]), label=:none, lc=:deepskyblue4)
	xlims!(-3, 3)	
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	scatter!([(pa, pa^2 + 1), (pb, pb^2+1)], label=:none, m = (6, :indianred, stroke(1, :indianred)))	
end

# ╔═╡ fbd32cae-5bd9-4f04-9097-0b78a429bdd4
begin
	pontoaa = @bind paa Slider(-3:0.1:0, default=-1)
	pontobb = @bind pbb Slider(0:0.1:3, default=2)	

	md"""
	Ponto a: $(pontoaa)
	
	Ponto b: $(pontobb)	
	
	"""
end

# ╔═╡ 123eba48-a134-4d80-9984-f0f3b7e4336c
begin	
	plot(range(-3, 3, 100), x->-x^2 + 1, lc=:indianred, label="f côncava")
	plot!(Shape([(paa, -paa^2 + 1), (pbb, -pbb^2 + 1)]), label=:none, lc=:deepskyblue4)
	xlims!(-3, 3)	
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	scatter!([(paa, -paa^2 + 1), (pbb, -pbb^2+1)], label=:none, m = (6, :indianred, stroke(1, :indianred)))	
end

# ╔═╡ 1e258939-1c5f-48fb-89b8-bfcc2be3244e
md"
> Geometricamente, a função $f$ é convexa (côncava) se, e somente se, para qualquer par de pontos distintos $M$ e $N$ em seu gráfico, o segmento de reta $MN$ que une estes pontos estiver sobre ou acima (abaixo) da superfície
>
> A função é estritamente convexa (estritamente côncava) se, e somente se, o segmento de reta $MN$ estiver inteiramente acima (abaixo) da superfície, exceto em $M$ e $N$
"

# ╔═╡ 72915102-07b2-43a8-b1d1-f9165dfe7d01
md"""
A função $f$ é côncava, mas não estritamente côncava
$(Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula7_fig1.PNG", width=>800))
Fonte: Jehle e Reny (2011)
"""

# ╔═╡ 2f1429f7-932d-424c-847d-3b0bdf990eed
md"""
!!! info "Teorema 7.1 - Função linear"
	Se $f$ é uma função linear, então, $f$ é uma função côncava, bem como uma função convexa, mas não estritamente
"""

# ╔═╡ e135488d-22c8-49b8-bde2-02b6f9506f22
md"""
!!! info "Teorema 7.2 - Negativa de uma função"
	Se $f$ é uma função côncava, então, $-f$ é uma função convexa, e vice-versa

	De modo semelhante, se $f$ for uma função estritamente côncava, então, $-f$ é uma função estritamente convexa, e vice-versa
"""

# ╔═╡ 84e81cfd-4d08-4fc8-8af6-2ff280906251
md"""
!!! info "Teorema 7.3 - Soma de funções"
	Se $f$ e $g$ forem ambas funções côncavas (funções convexas), então $f + g$ também é uma função côncava (função convexa)

	Se $f$ e $g$ forem ambas funções côncavas (funções convexas) e, além disso, qualquer uma delas, ou ambas, for estritamente côncava (estritamente convexa), então, $f + g$ é estritamente côncava (estritamente convexa)
"""

# ╔═╡ 14911687-99ad-4490-993c-2ea9aec2c8af
md"
> **Exercício 1**. Verifique a concavidade ou convexidade da função $f(x) = x^2$
"

# ╔═╡ 9a0c48f3-c9c2-469e-a5a3-c2722ce0f984
md"""
!!! hint "Resolução"
	Tome $x_1, x_2$ números arbitrários pertencentes ao domínio da função $f$ e assuma, sem perda de generalidade, que $x_1 < x_2$. E seja $\lambda \in [0,1]$

	Temos, então que:

	$$\begin{eqnarray}f(\lambda x_1 + (1-\lambda)x_2) - \lambda f(x_1) &-& (1-\lambda)f(x_2) = [\lambda x_1 + (1-\lambda)x_2]^2 - \lambda x_1^2 - (1-\lambda x_2^2) \\ &=& \lambda^2 x_1^2 + 2\lambda(1-\lambda)x_1x_2 + (1-\lambda)^2 x_2^2 - \lambda x_1^2 - (1-\lambda)x_2^2 \\ &=& -\lambda(1-\lambda)x_1^2 + 2\lambda(1-\lambda)x_1x_2 - \lambda(1-\lambda)x_2^2 \\ &=& -\lambda(1-\lambda)[x_1^2 - 2x_1x_2 + x_2^2] \\ &=& -\lambda(1-\lambda)[x_1-x_2]^2 < 0\end{eqnarray}$$

	Portanto, concluímos que: $f(\lambda x_1 + (1-\lambda)x_2) < \lambda f(x_1) + (1-\lambda)f(x_2)$ e, portanto, a função $f(x) = x^2$ é (estritamente) convexa (Definições 7.1 e 7.2)
"""

# ╔═╡ c1e76327-d470-4e5b-ba00-864f00ce4969
begin
	plot(range(-2, 2, 50), x->x^2, lc=:indianred, label=L"f(x)=x^2")
	vline!([0], lc=:black, lw=1, label=:none)
	hline!([0], lc=:black, lw=1, label=:none)
end

# ╔═╡ d4b57854-dd19-4594-865e-761b411d9ea1
md"
> **Exercício 2**. Verifique a concavidade ou convexidade da função $g(x) = -x^2$
"

# ╔═╡ 09cbeaa6-e090-4033-895b-a3110e49adcb
md"""
!!! hint "Resolução"
	1️⃣ Pelo Exercício 1, vimos que $f(x) = x^2$ é uma função (estritamente) convexa. Pelo Teorema 7.2, podemos concluir que $g(x) = -x^2 = -f(x)$ é uma função (estritamente) côncava
	
	2️⃣ Tome $x_1, x_2$ números arbitrários pertencentes ao domínio da função $g$ e assuma, sem perda de generalidade, que $x_1 < x_2$. E seja $\lambda \in [0,1]$

	Temos, então que:

	$$\begin{eqnarray}g(\lambda x_1 + (1-\lambda)x_2) &-& \lambda g(x_1) - (1-\lambda)g(x_2) = -[\lambda x_1 + (1-\lambda)x_2]^2 + \lambda x_1^2 + (1-\lambda x_2^2) \\ &=& -\lambda^2 x_1^2 - 2\lambda(1-\lambda)x_1x_2 - (1-\lambda)^2 x_2^2 + \lambda x_1^2 + (1-\lambda)x_2^2 \\ &=& \lambda(1-\lambda)x_1^2 - 2\lambda(1-\lambda)x_1x_2 + \lambda(1-\lambda)x_2^2 \\ &=& \lambda(1-\lambda)[x_1^2 - 2x_1x_2 + x_2^2] \\ &=& \lambda(1-\lambda)[x_1-x_2]^2 > 0\end{eqnarray}$$

	Portanto, concluímos que: $g(\lambda x_1 + (1-\lambda)x_2) > \lambda g(x_1) + (1-\lambda)g(x_2)$ e, portanto, a função $g(x) = -x^2$ é (estritamente) côncava (Definições 7.1 e 7.2)
"""

# ╔═╡ f31091a7-225a-465e-be0a-f93e5742af43
begin
	plot(range(-2, 2, 50), x->x^2, lc=:indianred, label=L"g(x)=-x^2")
	vline!([0], lc=:black, lw=1, label=:none)
	hline!([0], lc=:black, lw=1, label=:none)
end

# ╔═╡ 849ced0b-2223-49ae-8a5a-46628ab4cf01
md"
> **Exercício 3**. Verifique a concavidade ou convexidade da função $h(x, y) = x^2 + y^2$
"

# ╔═╡ fe2722b8-f584-4da4-8214-b2a32cfe465f
md"""
!!! hint "Resolução"
	1️⃣ Pelo Exercício 1, vimos que $f(x) = x^2$ é uma função (estritamente) convexa. Pelo Teorema 7.3, podemos concluir que $h(x, y) = x^2 + y^2$ é uma função (estritamente) convexa, por ser a soma de duas funções (estritamente) convexas
	
	2️⃣ Tome $x = (x_1, x_2)$ e $y = (y_1, y_2)$ pontos arbitrários pertencentes ao domínio da função $h$, e seja $\lambda \in [0,1]$

	Temos, então que:

	$$\begin{eqnarray}h(\lambda x + (1-\lambda)y) &-& \lambda h(x) - (1-\lambda)h(y) = [\lambda x_1 + (1-\lambda)y_1]^2 + [\lambda x_1 + (1-\lambda)y_1]^2 \\ &\qquad& -\lambda x_1^2 -\lambda x_2^2 - (1-\lambda) y_1^2 - (1-\lambda) y_2^2\\ &=& -\lambda(1-\lambda)x_1^2 + 2\lambda(1-\lambda)x_1y_1 - \lambda(1-\lambda)y_1^2 \\ &\qquad& -\lambda(1-\lambda)x_2^2 + 2\lambda(1-\lambda)x_2y_2 - \lambda(1-\lambda)y_2^2\\ &=& -\lambda(1-\lambda)[x_1^2 - 2x_1y_1 + y_1^2] -\lambda(1-\lambda)[x_2^2 - 2x_2y_2 + y_2^2] \\ &=& -\lambda(1-\lambda)[x_1-y_1]^2 -\lambda(1-\lambda)[x_2-y_2]^2 < 0\end{eqnarray}$$

	Portanto, concluímos que: $h(\lambda x + (1-\lambda)y) < \lambda h(x) + (1-\lambda)h(y)$ e, portanto, a função $h(x,y) = x^2 + y^2$ é (estritamente) convexa (Definições 7.1 e 7.2)
"""

# ╔═╡ 86a7baa9-7ad4-4ccd-8aac-b08d2d84a07a
begin	
	surface(range(-2, 2, 100), range(-2, 2, 100), (x, y) -> x^2 + y^2, c=:thermal, display_option=Plots.GR.OPTION_SHADED_MESH, title=L"f(x, y) = x^2 + y^2", colorbar=false)	
end

# ╔═╡ 67094557-39a5-49e7-89a1-52bea6ac69bb
md"
## Funções diferenciáveis
"

# ╔═╡ 85e3c144-c7f4-493c-a5c6-dd1fa769e9f3
md"
* Vimos que dada uma função objetivo côncava (convexa), qualquer ponto crítico pode ser, imediatamente, identificado como um máximo (mínimo) global do problema de otimização estático irrestrito
* Além disso, os conceitos estritos de convexidade e concavidade, quando se aplicam, podem ser usados para garantir a unicidade destes máximos ou mínimos globais
* Como enunciado na Definição 7.1, as definições de funções convexas e funções côncavas são livres de derivada e, portanto, não requerem diferenciabilidade
* No entanto, se a função for diferenciável, concavidade e convexidade podem, também, ser definidas em termos de suas derivadas primeiras
"

# ╔═╡ 34e06c87-428b-4f40-9134-f701bbf18304
md"""
Função côncava (contínua mas não diferenciável)
$(Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula7_fig2.PNG", width=>800))
Fonte: Sydsæter et al. (2016)
"""

# ╔═╡ b1e7f5ef-5fde-4a2b-a1a2-b9751dab416a
md"""
Função convexa (contínua e diferenciável)
$(Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula7_fig3.PNG", width=>800))
Fonte: Sydsæter et al. (2016)
"""

# ╔═╡ 4a252de9-23ad-4fae-b328-03ed7254c9b7
md"
* Para o caso de funções univariadas, contínuas e diferenciáveis, concavidade e convexidade podem ser definidos como segue
"

# ╔═╡ 92498bda-d01b-46a0-972c-466f5f84934f
md"""
!!! correct "Definição 7.3 - Função convexa e função côncava"
	Seja $f: D\to \mathbb{R}$, $D\subset\mathbb{R}$, uma função contínua e diferenciável, $f$ é uma **função convexa** se, e somente se, para quaisquer $x_1, x_2 \in D$, a seguinte condição for satisfeita:

	$$f(x_1) \geq f(x_2) + f'(x_2)(x_1 - x_2)\tag{5}$$

	De maneira análoga, $f$ é uma **função côncava** se, e somente se, para quaisquer $x_1, x_2 \in D$, a seguinte condição for satisfeita:

	$$f(x_1) \leq f(x_2) + f'(x_2)(x_1 - x_2)\tag{6}$$
"""

# ╔═╡ 735a6052-b77e-4ee7-a2d1-c5172a07b628
md"""
!!! correct "Definição 7.4 - Função estritamente convexa e função estritamente côncava"
	Seja $f: D\to \mathbb{R}$, $D\subset\mathbb{R}$, uma função contínua e diferenciável, $f$ é uma **função estritamente convexa** se, e somente se, para quaisquer $x_1, x_2 \in D$, a seguinte condição for satisfeita:

	$$f(x_1) > f(x_2) + f'(x_2)(x_1 - x_2)\tag{7}$$

	De maneira análoga, $f$ é uma **função estritamente côncava** se, e somente se, para quaisquer $x_1, x_2 \in D$, a seguinte condição for satisfeita:

	$$f(x_1) < f(x_2) + f'(x_2)(x_1 - x_2)\tag{8}$$
"""

# ╔═╡ 04825c07-d085-49a2-85bd-72042e02fbee
md"
* A interpretação geométrica é similar à que vimos anteriormente, essas definições retratam uma curva convexa (côncava) como uma curva que está sobre ou acima (abaixo) de todas as suas retas tangentes
* Para qualificar-se como uma curva estritamente convexa (estritamente côncava), a curva deve estar estritamente acima (abaixo) de todas as retas tangentes, exceto nos pontos de tangência
"

# ╔═╡ 11d8089b-8c1c-4913-9335-fd2b9b9e763b
md"
* Para o caso multivariado, as Definições 7.3 e 7.4 precisam de uma pequena modificação
"

# ╔═╡ d3f146e4-7bcc-4b0f-9adc-34b2ebf382e9
md"""
!!! correct "Definição 7.5 - Função convexa e função côncava"
	Seja $f: D\to \mathbb{R}$, $D\subset\mathbb{R}^n$, uma função contínua e diferenciável, $f$ é uma **função convexa** se, e somente se, para quaisquer $\textbf{u}, \textbf{v} \in D$, a seguinte condição for satisfeita:

	$$f(\textbf{u}) \geq f(\textbf{v}) + \sum_{j=1}^n f_j(\textbf{v})(u_j - v_j)\tag{9},$$
	onde $f_j(\textbf{v}) \equiv \partial f/\partial x_j$ está avaliada em $\textbf{v} = (v_1, \dots, v_n)$

	De maneira análoga, $f$ é uma **função côncava** se, e somente se, para quaisquer $\textbf{u}, \textbf{v} \in D$, a seguinte condição for satisfeita:

	$$f(\textbf{u}) \leq f(\textbf{v}) + \sum_{j=1}^n f_j(\textbf{v})(u_j - v_j)\tag{10},$$
	onde $f_j(\textbf{v}) \equiv \partial f/\partial x_j$ está avaliada em $\textbf{v} = (v_1, \dots, v_n)$
"""

# ╔═╡ fbfb2148-b9e0-44f1-9fd8-5521596de241
md"""
!!! correct "Definição 7.6 - Função estritamente convexa e função estritamente côncava"
	Seja $f: D\to \mathbb{R}$, $D\subset\mathbb{R}^n$, uma função contínua e diferenciável, $f$ é uma **função estritamente convexa** se, e somente se, para quaisquer $\textbf{u}, \textbf{v} \in D$, a seguinte condição for satisfeita:

	$$f(\textbf{u}) > f(\textbf{v}) + \sum_{j=1}^n f_j(\textbf{v})(u_j - v_j)\tag{11},$$
	onde $f_j(\textbf{v}) \equiv \partial f/\partial x_j$ está avaliada em $\textbf{v} = (v_1, \dots, v_n)$

	De maneira análoga, $f$ é uma **função estritamente côncava** se, e somente se, para quaisquer $\textbf{u}, \textbf{v} \in D$, a seguinte condição for satisfeita:

	$$f(\textbf{u}) < f(\textbf{v}) + \sum_{j=1}^n f_j(\textbf{v})(u_j - v_j)\tag{12},$$
	onde $f_j(\textbf{v}) \equiv \partial f/\partial x_j$ está avaliada em $\textbf{v} = (v_1, \dots, v_n)$
"""

# ╔═╡ 74485075-1f39-4ac6-a7b3-d3d31468f718
md"
> **Exercício 4**. Verifique a concavidade ou convexidade da função $f(x) = x^2$
"

# ╔═╡ 742ef73c-3aec-4f59-a0df-3232174e8cd4
md"""
!!! hint "Resolução"
	Note que $f(x) = x^2$ é uma função contínua e diferenciável
	
	Sejam $x_1, x_2$ números arbitrários pertencentes ao domínio da função $f$

	Temos, então que:

	$$\begin{eqnarray}f(x_1) - f(x_2) - f'(x_2)(x_1 - x_2) &=& x_1^2 - x_2^2 - 2x_2(x_1 - x_2) \\ &=& x_1^2 - 2x_1x_2 + x_2^2 \\ &=& (x_1 - x_2)^2 > 0\end{eqnarray}$$

	Portanto, concluímos que: $f(x_1) > f(x_2) + f'(x_2)(x_2-x_2)$ e, portanto, a função $f(x) = x^2$ é (estritamente) convexa (Definições 7.3 e 7.4)
"""

# ╔═╡ 5188a887-7502-4033-8e19-9190eb4a6cf1
md"
> **Exercício 5**. Verifique a concavidade ou convexidade da função $g(x) = -x^2$
"

# ╔═╡ 437af6c8-78e2-46dc-986f-5f97ee4f4f6e
md"""
!!! hint "Resolução"
	Note que $g(x) = -x^2$ é uma função contínua e diferenciável
	
	Sejam $x_1, x_2$ números arbitrários pertencentes ao domínio da função $g$

	Temos, então que:

	$$\begin{eqnarray}g(x_1) - g(x_2) - g'(x_2)(x_1 - x_2) &=& -x_1^2 + x_2^2 + 2x_2(x_1 - x_2) \\ &=& -x_1^2 + 2x_1x_2 - x_2^2 \\ &=& -(x_1 - x_2)^2 < 0\end{eqnarray}$$

	Portanto, concluímos que: $g(x_1) < g(x_2) + g'(x_2)(x_2-x_2)$ e, portanto, a função $g(x) = -x^2$ é (estritamente) côncava (Definições 7.3 e 7.4)
"""

# ╔═╡ 55edb607-2cd2-4606-a70b-3f83f2fa56d6
md"
> **Exercício 6**. Verifique a concavidade ou convexidade da função $h(x) = x^2 + y^2$
"

# ╔═╡ 4cf22954-bb6d-4769-bc23-041ccb4dd2d3
md"""
!!! hint "Resolução"
	Note que $h(x, y) = x^2 + y^2$ é uma função contínua e diferenciável
	
	Sejam $\textbf{u} = (u_1, u_2)$ e $\textbf{v} = (v_1, v_2)$ pontos arbitrários pertencentes ao domínio da função $h$

	Temos, então que:

	$$\begin{eqnarray}h(\textbf{u}) - h(\textbf{v}) - \sum_{j=1}^2 h_j(\textbf{v})(\textbf{u}_j - \textbf{v}_j) &=& (u_1^2 + u^2) - (v_1^2 + v^2) - [2v_1(u_1-v_1) + 2v_2(u_2 - v_2)] \\ 
	&=& u_1^2 + u_2^2 - v_1^2 - v_2^2 - 2u_1v_1 + 2v_1^2 - 2u_2v_2 + 2v_2^2 \\
	&=& (u_1^2 - 2u_1v_1 + v_1^2) + (u_2^2 - 2u_2v_2 + v_2^2) \\
	&=& (u_1-v_1)^2 + (u_2-v_2)^2 > 0
	\end{eqnarray}$$

	Portanto, concluímos que: $h(\textbf{u}) > h(\textbf{v}) + \sum_{j=1}^2 h_j(\textbf{v})(\textbf{u}_j - \textbf{v}_j)$ e, portanto, a função $h(x, y) = x^2 + y^2$ é (estritamente) convexa (Definições 7.5 e 7.6)
"""

# ╔═╡ 570e3dbb-b9be-4f32-b117-8abc43554087
md"
* Por fim, podemos enunciar os seguintes resultados (sem demonstrações) que contém os resultados mais importantes referentes a funções côncavas e funções convexas para nossos propósitos
"

# ╔═╡ 7c1ca537-2543-402e-b5af-02c9df0dffee
md"""
!!! info "Teorema 7.4"
	Seja $f: D\to \mathbb{R}, D\subset\mathbb{R}^n$ uma função contínua e duas vezes diferenciável, então, $f$ é uma **função convexa** se, e somente se, $d^2f$ for positiva semidefinida em toda a sua extensão.

	Ou seja, $f$ é uma função convexa se, e somente se, sua Hessiana é positiva semidefinida para todo $\textbf{x} \in D$:

	$$\text{f é convexa} \Leftrightarrow \textbf{z}'\bigtriangledown f(x)\textbf{z}\geq 0, \qquad \forall\textbf{x}\in D, \forall \textbf{z}\in\mathbb{R}^n\tag{13}$$
	---
	De maneira análoga, $f$ é uma **função côncava** se, e somente se, $d^2f$ for negativa semidefinida em toda a sua extensão.

	Ou seja, $f$ é uma função côncava se, e somente se, sua Hessiana é negativa semidefinida para todo $\textbf{x} \in D$:

	$$\text{f é côncava} \Leftrightarrow \textbf{z}'\bigtriangledown f(x)\textbf{z}\leq 0, \qquad \forall\textbf{x}\in D, \forall \textbf{z}\in\mathbb{R}^n\tag{14}$$
"""

# ╔═╡ a6c2d04c-5b7c-49d8-99ba-90887485019d
md"""
!!! warning "Função estritamente convexa e função estritamente côncava"
	As definições de funções estritamente convexas e funções estritamente côncavas podem ser obtidas substituindo os termos ''semidefinida'' por ''definida'' no Teorema 7.4
"""

# ╔═╡ 0bebfc3a-52f5-4ec2-9681-2348a6674bd2
md"
* Com isso podemos, então, enunciar o teorema mais importante desta seção (sem demonstrá-lo)
"

# ╔═╡ 9dc7ce83-9c4e-4c9f-9e89-437fbc561178
md"""
!!! danger "Teorema 7.5"
	Se $f$ é uma função convexa, então, qualquer ponto de mínimo local é, também, um ponto de mínimo global

	---

	De maneira similar, se $f$ é uma função côncava, então, qualquer ponto de máximo local é, também, um ponto de máximo global
"""

# ╔═╡ d0c06db8-1d82-4c1b-90f8-303e313053f8
md"
* A importância dos conceitos de concavidade e convexidade, especialmente em trabalhos teóricos, deve estar clara a esta altura
* Podemos assegurar a existência de um ponto de mínimo ou máximo global ao assumirmos que as funções objetivos sejam convexas ou côncavas
* Por exemplo, em microeconomia assumimos que as curvas de indiferença sejam convexas e as fronteiras de produção sejam côncavas
"

# ╔═╡ 242a1a4f-8977-4e97-b1f8-49c1d366d42c
md"
## 📚 Bibliografia
"

# ╔═╡ 7756b9bd-d772-4b15-86c6-edfcc8605476
md"
CHIANG, A.C.; WAINWRIGHT, K. Matemática para economistas.
Rio de Janeiro: Elsevier, 2006.

DADKHAH, K. Foundations of Mathematical and Computational
Economics. Boston: Springer, 2011.

JEHLE, G. A.; RENY, P. J. Advanced Microeconomic Theory. 3rd.ed.
Essex: Pearson Education Limited, 2011.

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
Plots = "~1.38.8"
PlutoUI = "~0.7.50"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.5"
manifest_format = "2.0"
project_hash = "e9be83a6c7fd21f04cfc4051871fb477d5cc6cf9"

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
git-tree-sha1 = "4423d87dc2d3201f3f1768a29e807ddc8cc867ef"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.71.8"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "3657eb348d44575cc5560c80d7e55b812ff6ffe1"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.71.8+0"

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
git-tree-sha1 = "d321bf2de576bf25ec4d3e4360faca399afca282"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.0"

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
git-tree-sha1 = "f49a45a239e13333b8b936120fe6d793fe58a972"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.38.8"

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
git-tree-sha1 = "45a7769a04a3cf80da1c1c7c60caf932e6f4c9f7"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.6.0"

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
# ╟─407c2350-d35d-11ed-3732-970fa3d6d6b1
# ╟─2b89dc01-35e1-432f-84a9-33f4c3bbe052
# ╟─cf2fbc7b-6f3f-41a1-8f20-1e1b6de5b3b8
# ╟─0c60cc99-614b-44ba-969f-4ba20476d943
# ╟─4f508c8b-176f-4b13-b4fa-65e3fe578255
# ╟─b4357649-ae3e-4d44-8451-4969be877616
# ╟─bf1ebb30-c9a5-4f82-9193-9b8373275f70
# ╟─4691f12c-79e4-4d77-917e-d67944bda4e3
# ╟─803642c9-bb73-47b1-833e-b8a6359f6344
# ╟─ceae33b1-a67c-4b70-8e6e-813c94fede82
# ╟─e427e6d6-6d3f-4fae-8db4-c781dafa8ac7
# ╟─14802dbc-dff2-471a-8fdb-8eea86cc7835
# ╟─31494539-6c43-4ab7-b6f4-674dfe01d6a1
# ╟─8942cc1c-28a5-4735-af9e-aeb3ce84af35
# ╟─bcfa64c1-5ba6-452f-b68b-d7642c7ae7e6
# ╟─0fabe2df-6343-410e-ab10-a784b0798a3d
# ╟─d8c18dbf-cf8c-4c25-8546-44506db3919b
# ╟─9c09a35d-333c-426f-91f8-3902e1d4b108
# ╟─58036263-5f21-4aaf-8ebe-53b7d0863dfb
# ╟─3c8e461a-59cb-40e9-9527-3be51315a67f
# ╟─37e1792f-a700-48e7-a36d-482dac507cf1
# ╟─9a2deedf-5b59-49b8-a086-be794e0c2545
# ╟─7dad24b4-ca37-4a3b-924a-6e1cdf9ac884
# ╟─a86bdf84-7e74-4cd2-a275-b36a0a8cbe83
# ╟─c1911f72-44f2-4211-a4bf-6d49de3e4601
# ╟─2ea20fe7-b2b2-4e13-8622-5025e5d5d384
# ╟─aa857d0e-035b-4083-a67b-d311e309f3dc
# ╟─73036edf-b28e-40ea-8dce-bf2566a1c751
# ╟─f6689099-ff08-458f-9cdd-651855d47af2
# ╟─89cbb8b1-37a1-4fac-910d-1cda73f1367d
# ╟─99b1e156-bace-48ac-a493-226864e67da9
# ╟─ab4e2003-278b-40db-b656-322908b94e8c
# ╟─fbd32cae-5bd9-4f04-9097-0b78a429bdd4
# ╟─123eba48-a134-4d80-9984-f0f3b7e4336c
# ╟─1e258939-1c5f-48fb-89b8-bfcc2be3244e
# ╟─72915102-07b2-43a8-b1d1-f9165dfe7d01
# ╟─2f1429f7-932d-424c-847d-3b0bdf990eed
# ╟─e135488d-22c8-49b8-bde2-02b6f9506f22
# ╟─84e81cfd-4d08-4fc8-8af6-2ff280906251
# ╟─14911687-99ad-4490-993c-2ea9aec2c8af
# ╟─9a0c48f3-c9c2-469e-a5a3-c2722ce0f984
# ╟─c1e76327-d470-4e5b-ba00-864f00ce4969
# ╟─d4b57854-dd19-4594-865e-761b411d9ea1
# ╟─09cbeaa6-e090-4033-895b-a3110e49adcb
# ╟─f31091a7-225a-465e-be0a-f93e5742af43
# ╟─849ced0b-2223-49ae-8a5a-46628ab4cf01
# ╟─fe2722b8-f584-4da4-8214-b2a32cfe465f
# ╟─86a7baa9-7ad4-4ccd-8aac-b08d2d84a07a
# ╟─67094557-39a5-49e7-89a1-52bea6ac69bb
# ╟─85e3c144-c7f4-493c-a5c6-dd1fa769e9f3
# ╟─34e06c87-428b-4f40-9134-f701bbf18304
# ╟─b1e7f5ef-5fde-4a2b-a1a2-b9751dab416a
# ╟─4a252de9-23ad-4fae-b328-03ed7254c9b7
# ╟─92498bda-d01b-46a0-972c-466f5f84934f
# ╟─735a6052-b77e-4ee7-a2d1-c5172a07b628
# ╟─04825c07-d085-49a2-85bd-72042e02fbee
# ╟─11d8089b-8c1c-4913-9335-fd2b9b9e763b
# ╟─d3f146e4-7bcc-4b0f-9adc-34b2ebf382e9
# ╟─fbfb2148-b9e0-44f1-9fd8-5521596de241
# ╟─74485075-1f39-4ac6-a7b3-d3d31468f718
# ╟─742ef73c-3aec-4f59-a0df-3232174e8cd4
# ╟─5188a887-7502-4033-8e19-9190eb4a6cf1
# ╟─437af6c8-78e2-46dc-986f-5f97ee4f4f6e
# ╟─55edb607-2cd2-4606-a70b-3f83f2fa56d6
# ╟─4cf22954-bb6d-4769-bc23-041ccb4dd2d3
# ╟─570e3dbb-b9be-4f32-b117-8abc43554087
# ╟─7c1ca537-2543-402e-b5af-02c9df0dffee
# ╟─a6c2d04c-5b7c-49d8-99ba-90887485019d
# ╟─0bebfc3a-52f5-4ec2-9681-2348a6674bd2
# ╟─9dc7ce83-9c4e-4c9f-9e89-437fbc561178
# ╠═d0c06db8-1d82-4c1b-90f8-303e313053f8
# ╟─242a1a4f-8977-4e97-b1f8-49c1d366d42c
# ╟─7756b9bd-d772-4b15-86c6-edfcc8605476
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

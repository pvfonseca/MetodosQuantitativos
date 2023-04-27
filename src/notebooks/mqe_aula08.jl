### A Pluto.jl notebook ###
# v0.19.9

using Markdown
using InteractiveUtils

# ╔═╡ c5427b90-da54-11ed-14fe-ebd284d9265b
begin
	using PlutoUI
	using Plots
	using LaTeXStrings
	using Measures	
	import PlutoUI: combine	
	theme(:ggplot2)
	gr(size=(800,600), lw = 2, fontfamily = "Computer Modern", grid=true, tickfontsize = 12, guidefontsize=16, framestyle=:box, margin=3mm, right_margin=7mm, guidefonthalign=:right, guidefontvalign=:top)	
end

# ╔═╡ 5814f255-77e8-432d-a5b9-95ed6afdda27
PlutoUI.TableOfContents(title="Sumário", indent=true)

# ╔═╡ 3f805a81-914e-40f1-9dab-968b86bf0b33
html"<button onclick=present()>Apresentação</button>"

# ╔═╡ 49e8546b-844e-49c9-aab9-b7b9d34af649
md"""
# Otimização estática com restrições de igualdade $~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ $(Resource("https://www1.udesc.br/imagens/id_submenu/899/cor_horizontal_rgb.jpg", :width => 150))
"""

# ╔═╡ 8ed1b9f0-0311-4215-825b-0bb3a68782f5
md"
* **Disciplina:** 33MQEI - Métodos Quantitativos em Economia I
* **Docente:** [Paulo Victor da Fonseca](https://pvfonseca.github.io)
* **Contato:** [paulo.fonseca@udesc.br](mailto:paulo.fonseca@udesc.br)
"

# ╔═╡ c698111c-ee94-45ac-832d-e6997f293928
md"""
!!! danger "Aviso"
	O texto que segue não tem a menor pretensão de originalidade. Ele serve apenas como registro dos principais princípios, conceitos e técnicas analíticas que são trabalhados em sala de aula.
"""

# ╔═╡ 446ec895-0207-4785-9a9d-c20131bc19d1
md"
## Introdução
"

# ╔═╡ 4733bfa6-d92d-4f19-a842-87633e64418b
md"
* No bloco anterior da disciplina, analisamos problemas de otimização estática irrestritos - univariados e multivariados
* Variáveis de escolha eram independentes umas das outras
* I.e., a decisão referente a uma variável não influencia na escolha das variáveis restantes
* Em economia, no entanto, variáveis de escolha, normalmente, devem satisfazer uma ou mais condições de restrições
"

# ╔═╡ c273328a-a008-4762-a698-8b77f4fc8949
md"
* Por exemplo, suponha uma firma que produza dois tipos de bens: $A$ e $B$
* Assume-se que o custo diário de produção de $x$ unidades do bem $A$ e de $y$ unidades do bem $B$ seja dado por:

$$C(x,y) = 0,04x^2 + 0,01xy + 0,01y^2 + 4x + 2y + 500$$

* Suponha, ainda, que esta firma venda toda sua produção aos preços unitários de \$15 para o bem $A$ e \$9 para o bem $B$
* Quais os níveis de produção $x$ e $y$ que maximizam o lucro diário?
"

# ╔═╡ e85ebf7c-a51d-4c76-aa33-17c18bd8a6c6
	md"""
	!!! hint "Resolução"
		* Função lucro:
	
		$$\pi(x, y) = -0,04x^2 - 0,01xy - 0,01y^2 + 11x + 7y - 500$$
		
		* Condições necessárias de primeira ordem:
	
		$$\begin{eqnarray}\pi_x &=& -0,08x - 0,01y + 11 = 0 \\ \pi_y &=& -0,01x - 0,02y + 7 = 0\end{eqnarray}$$
	
		* Pontos críticos:
	
		$$\begin{bmatrix}0,08 & 0,01 \\ 0,01 & 0,02\end{bmatrix}\begin{bmatrix}x\\y\end{bmatrix} = \begin{bmatrix}11\\7\end{bmatrix}$$
	
		Portanto:
	
		$$\begin{bmatrix}x\\y\end{bmatrix} = \begin{bmatrix}0,08 & 0,01 \\ 0,01 & 0,02\end{bmatrix}^{-1}\begin{bmatrix}11\\7\end{bmatrix} = \begin{bmatrix}100\\ 300\end{bmatrix}$$

		* Condições de segunda ordem:

		$$\nabla^2\pi(x,y) = \begin{bmatrix}-0,08 & -0,01 \\ -0,01 & -0,02\end{bmatrix}$$

		Note que a matriz Hessiana é negativa definida e, portanto, o ponto $(x^*, y^*) = (100, 300)$ é, de fato, um ponto de máximo
	"""

# ╔═╡ 294981f7-975b-41ca-9965-03b7bce4c001
let
	surface(range(0, 300, 50), range(0, 400, 50), (x, y) -> -0.04x^2-0.01*x*y-0.01y^2+11x+7y-500, c=:bone, display_option=Plots.GR.OPTION_SHADED_MESH, title=L"\pi(x, y) = -0.04x^2-0.01xy-0.01y^2+11x+7y-500", camera=(30, 10))	
	scatter!((100, 300, 1100), mc=:indianred, ms=6, label=:none)
end

# ╔═╡ b4c7d751-bb1f-4b0e-843e-6df5ac74b829
let
	contour(range(0,320,50), range(0,400,50), (x, y) -> -0.04x^2-0.01*x*y-0.01y^2+11x+7y-500, levels=20)	
	scatter!((100, 300), mc=:indianred, ms=6, label=:none)
end

# ╔═╡ b3d4b91c-d691-4488-91b8-4bb1caefb14b
md"
* Considere, agora, que esta firma seja poluente para qualquer nível de produção que decida e, portanto, é legalmente restrita a uma quota de produção total de 320 unidades dos dois tipos de mercadoria
* Temos, então, o seguinte problema de otimização com restrição:

$$\begin{eqnarray}&\max_{x,y} & -0,04x^2 - 0,01xy - 0,01y^2 + 11x + 7y - 500 \\ &\text{sujeito a }& x + y = 320\end{eqnarray}$$

* Note que, agora, os níveis de produto que maximizam o lucro não apenas serão simultâneos mas, também, dependentes
* Quanto maior a produção do bem $x$, menor deverá ser a produção de $y$ para que a firma mantenha-se dentro da quota estipulada
* Ou seja, a independência entre as variáveis de escolha deixa de existir
"

# ╔═╡ ed585b41-3a42-485e-94d0-936eb7731ed5
md"
* O novo ótimo que satisfaz a quota de produção constitui um **ótimo restrito** que, em geral, poderá ser diferente do _ótimo livre_
* Uma forma de resolver o problema de otimização estática com restrição de igualdade descrito anteriormente é transformá-lo em um problema irrestrito
* No entanto, esta abordagem torna-se difícil (ou até mesmo impossível) quando a restrição envolve uma função complicada ou quando existem várias restrições a serem consideradas
* Portanto, precisamos considerar métodos de solução mais gerais
"

# ╔═╡ 8858dafb-49ed-48db-b9ad-1c2bba867c37
md"""
!!! info "Objetivo"
	O objetivo deste novo bloco da disciplina é estudar os problemas de otimização estática com restrição.

	Consideraremos, inicialmente, problemas com restrições de igualdade, o método dos multiplicadores de Lagrange e a abordagem do diferencial total
"""

# ╔═╡ d7bbf013-8bbc-45e2-b3aa-42421fb23d71
md"
## Efeitos de uma restrição
"

# ╔═╡ f63c11d2-beb0-40a2-85a3-49aca09da1db
md"""
* O objetivo principal de impor uma restrição é reconhecer devidamente certos fatores limitantes presentes no problema de otimização
* Por exemplo, considere o problema de escolha de um consumidor cujas preferências são representadas pela função utilidade:

$$U(x,y) = xy + 2x$$

* Como as utilidades marginais são positivas para todos os valores positivos de $x$ e $y$, a maximização de utilidade sem restrições implicaria na aquisição de quantidades infinitas de ambos os bens

* Para tornar o problema economicamente significante, devemos impor uma restrição orçamentária à escolha do consumidor, por exemplo:

$$4x + 2y = 60$$

* Tal restrição resulta na escolha de $x^*$ e $y^*$ mutuamente dependentes
* Matematicamente, a restrição estreita o domínio e, consequentemente, a imagem da função objetivo
* A imposição de uma restrição faz com que só sejam admissíveis valores das variáveis que satisfaçam essa condição
* O domínio é imediatamente reduzido ao conjunto de pontos que estão sobre o gráfico da restrição
* Isso automaticamente afeta a imagem da função objetivo - somente o subconjunto da superfície de utilidade que está sobre a linha orçamentária é relevante agora
"""

# ╔═╡ 4122a5d6-d0d7-45dc-b499-1356911c5155
let
	plot(range(0, 15, 50), x -> (60 - 4x)/2, lc=:indianred, label=L"4x + 2y = 60")
	vline!([0], lc=:black, label=:none, lw=1)
	hline!([0], lc=:black, label=:none, lw=1)
	title!("Reta orçamentária")
end

# ╔═╡ a92b38aa-168d-41db-8f05-ed15cf86612c
let
	plot(range(0, 15, 50), x -> x*(60 - 4x)/2 + 2x, lc=:indianred, label=:none)	
	plot!(Shape([(0, 0), (15, 0)]), lc=:blue, lw=3, label="Linha orçamentária", fill=(0, 0.3, :blue))
	vline!([0], lc=:black, label=:none, lw=1)
	hline!([0], lc=:black, label=:none, lw=1)
	vline!([15], lc=:black, label=:none, lw=1, ls=:dash)
	title!("Utilidade X reta orçamentária")
end

# ╔═╡ 02e24286-6d62-458a-96db-68b01fff6ade
md"""
Extremos livres e restritos
$(Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula8_fig1.PNG", width=>800))
Fonte: Chiang e Wainwright (2006)
"""

# ╔═╡ 1e617195-3eff-4184-b273-fe2d11680390
md"""
---
### Problema primal de maximização da utilidade
"""

# ╔═╡ ee6f1865-c9f2-4b56-8ba2-64d8df631b71
md"
* Um exemplo econômico típico de um problema de otimização com restrição de igualdade é o de maximização da função utilidade sujeito à restrição orçamentária
* Anteriormente, consideramos um consumidor com preferências sobre o conjunto consumo $M = \mathbb{R}_+^2$ representadas pela função utilidade:

$$U(x,y) = xy + 2x$$

* Em termos matemáticos, o problema primal do consumidor pode ser expresso por:

$$\begin{eqnarray}&\max_{x,y}& U(x,y) \\ &\text{s.a. }& p_x x + p_y y = I\end{eqnarray}$$

* Por hipótese, este consumidor defronta-se com os seguintes preços unitários exógenos: $p_x = 4, p_y =2$ e aufere uma renda exógena $I = 60$
"

# ╔═╡ 6987d7cf-d240-4dd7-a209-0c981eec360b
md"""
!!! info "Solução por substituição"
	* Podemos resolver o problema do consumidor transformando-o em um problema de otimização irrestrito. Basta notar que:

	$$y = \frac{I-p_x x}{p_y} = \frac{60 - 4x}{2} = 30-2x$$

	* E maximizar a função utilidade após substituído o valor de $y$:

	$$\max_{x} (30-2x)x + 2x$$

	* Obtemos, então, $x^* = 8, y^* = 30-2(8) = 14$ e um nível de utilidade máximo de $U^* = 128$
"""

# ╔═╡ cc2e6147-f6e9-4973-8e34-c9a8701f30e7
md"""
## Método dos multiplicadores de Lagrange
* Quando a restrição é uma função complicada, ou quando há várias restrições a serem consideradas, a técnica de substituição e eliminação de variáveis pode tornar-se difícil ou até mesmo impossível

* Nestes casos, podemos recorrer ao **método dos multiplicadores de Lagrange**

* Este nome deve-se à sua proposição pelo matemático franco-italiano Joseph-Louis Lagrange (1736-1813)

$(Resource("https://upload.wikimedia.org/wikipedia/commons/1/19/Lagrange_portrait.jpg", width=>300))
[Joseph-Louis Lagrange](https://pt.wikipedia.org/wiki/Joseph-Louis_Lagrange)

* O economista dinamarquês Harald Westergaard (1853-1936) parece ter sido o primeiro a utilizar este método em economia, em 1876

$(Resource("https://upload.wikimedia.org/wikipedia/commons/3/3e/Haraldwestergaard2.jpg", width=>300))
[Harald Ludvig Westergaard](https://en.wikipedia.org/wiki/Harald_Ludvig_Westergaard)
"""

# ╔═╡ 6130e6c1-fe1b-4ecc-81f4-9c607ea9770a
md"
* Em termos práticos, este método é utilizado mesmo em problemas que sejam fáceis de serem expressos em termos de otimização sem restrições
* Isso porque os multiplicadores de Lagrange possuem uma interpretação econômica importante
* Além disso, um método similar pode ser utilizado para resolver problemas de otimização mais complexos, como aqueles em que as restrições são expressas em termos de desigualdades - como veremos mais adiante na disciplina
"

# ╔═╡ d8fc1685-5678-4e86-8a53-35586db352c2
md"""
* A essência do método dos multiplicadores de Lagrange é converter um problema de extremo restrito em uma forma tal que a condição de primeira ordem do problema de extremo livre ainda possa ser aplicado
* Começaremos com o problema de maximizar uma função de duas variáveis reais $f(x,y)$, com $x$ e $y$ restritos a satisfazer uma restrição de igualdade $g(x,y) = c$
* Matematicamente:
$$\begin{eqnarray}&\max_{x,y}& f(x, y) \\ &\text{s.a. \quad}& g(x,y) = c\end{eqnarray}$$
"""

# ╔═╡ ea42a8cd-2753-483f-8850-38ab612a99a8
md"
* O primeiro passo do método é introduzir um **multiplicador de Lagrange**, normalmente denotado por $\lambda$, que seja associado à restrição $g(x,y) = c$
* Fazemos isso ao definir a _função Lagrangeana_, $\mathcal{L}$, da seguinte forma:
$$\mathcal{L}(x,y,\lambda) = f(x,y) - \lambda[g(x,y) - c]$$
na qual a expressão $g(x,y) - c$, que deve ser igual a zero quando a restrição é satisfeita, foi multiplicada por $\lambda$
* Note que $\mathcal{L}(x,y,\lambda) = f(x,y)$ para todo par ordenado $(x,y)$ que satisfaça a restrição $g(x,y) = c$
"

# ╔═╡ 0119c1ff-d00d-4edc-aca7-094503ef7487
md"
* O problema de otimização pode, então, ser reformulado da seguinte forma:
$$\max_{x,y,\lambda} \mathcal{L}(x,y,\lambda) = f(x,y) - \lambda[g(x,y) - c]$$
* A condição necessária de primeira ordem consistirá, então, em um conjunto de equações simultâneas:
$$\begin{eqnarray}\mathcal{L}_\lambda &=& g(x,y) - c = 0 \\ \mathcal{L}_x &=& f_x(x,y) - \lambda g_x(x,y) = 0 \\ \mathcal{L}_y &=& f_y(x,y) - \lambda g_y(x,y) = 0\end{eqnarray}$$
* Uma vez que a primeira equação é simplesmente uma nova maneira de enunciar a restrição, os valores críticos da função Lagrangeana automaticamente irão satisfazer a restrição do problema de otimização original
"

# ╔═╡ 9f21c074-70f2-4bcd-adbf-0fd5e2241e3c
md"
## Aplicações econômicas
"

# ╔═╡ 3f04958f-5803-4c4b-b7a8-5b8985e2194e
md"
#### Maximização de utilidade
"

# ╔═╡ 8fdc08a6-7fae-423e-9829-26b6ac5a9592
md"
* Podemos aplicar o método dos multiplicadores de Lagrange ao problema primal de maximização de utilidade do consumidor que vimos anteriormente:

$$\begin{eqnarray}&\max_{x,y}& xy + 2x \\ &\text{s.a. \quad}& 4x + 2y = 60\end{eqnarray}$$
"

# ╔═╡ bbf65c05-61b0-48ea-91f7-5e31de56dc92
md"""
!!! info "Resolução"
	* Função Lagrangeana:

	$$\mathcal{L}(x,y,\lambda) = xy + 2x - \lambda[4x + 2y - 60]$$

	* Condições de primeira ordem:

	$$\begin{eqnarray}\mathcal{L}_\lambda &=& 4x + 2y - 60 = 0 \\ \mathcal{L}_x &=& y + 2 - 4\lambda = 0 \\ \mathcal{L}_y &=& x - 2\lambda = 0\end{eqnarray}$$

	* Pontos críticos:

	$$\begin{bmatrix}4 & 2 & 0 \\ 0 & 1 & -4\\ 1 & 0 & -2\end{bmatrix}\begin{bmatrix}x\\y\\\lambda\end{bmatrix} = \begin{bmatrix}60\\-2\\0\end{bmatrix}$$
	
	Portanto:
	
	$$\begin{bmatrix}x\\y\\\lambda\end{bmatrix} = \begin{bmatrix}4 & 2 & 0 \\ 0 & 1 & -4\\ 1 & 0 & -2\end{bmatrix}^{-1}\begin{bmatrix}60\\-2\\0\end{bmatrix} = \begin{bmatrix}8\\14\\4\end{bmatrix}$$
"""

# ╔═╡ e92d845c-a7e8-4c0d-87aa-2320e1d9f97c
let
	contour(range(0,30,50), range(0,30,50), (x, y) -> x*y + 2x, levels=[collect(30:20:300)...], lw=2, color=:roma)
	plot!(range(0, 15, 50), x->(60-4x)/2, lc=:black, lw=2, label="Restrição")
	vline!([0], lc=:black, lw=0.5, label=:none)
	hline!([0], lc=:black, lw=0.5, label=:none)
	scatter!((8, 14), ms=6, mc=:red, label="Ótimo restrito", legend=:topright)	
end

# ╔═╡ 39878743-cd9b-499c-b1e9-9e7462071484
md"
#### Maximização de lucros de uma firma poluente
"

# ╔═╡ 999c0f4f-806d-4d91-8490-f57ad87b80d6
md"
* Podemos, agora, voltar ao problema de maximização de lucros de uma firma poluente que enunciamos anteriormente
* Lembrando que a firma era legalmente restrita a produzir apenas um total de 320 unidades dos dois tipos de mercadoria
* Formalmente, o problema de maximização de lucros sujeito à restrição legal era dado por:

$$\begin{eqnarray}&\max_{x,y} & -0,04x^2 - 0,01xy - 0,01y^2 + 11x + 7y - 500 \\ &\text{sujeito a }& x + y = 320\end{eqnarray}$$
"

# ╔═╡ e4939055-c1c8-4f83-baac-8aef3cdeed22
md"""
!!! info "Resolução"
	* Função Lagrangeana:

	$$\mathcal{L}(x,y,\lambda) = -0,04x^2 - 0,01xy - 0,01y^2 + 11x + 7y - 500 + \lambda[320-x-y]$$

	* Condições de primeira ordem:

	$$\begin{eqnarray}\mathcal{L}_\lambda &=& 320 - x - y = 0 \\ \mathcal{L}_x &=& -0,08x - 0,01y + 11 - \lambda = 0 \\ \mathcal{L}_y &=& -0,01x - 0,02y + 7 - \lambda = 0\end{eqnarray}$$

	* Pontos críticos:

	$$\begin{bmatrix}1 & 1 & 0 \\ 0,08 & 0,01 & 1\\ 0,01 & 0,02 & 1\end{bmatrix}\begin{bmatrix}x\\y\\\lambda\end{bmatrix} = \begin{bmatrix}320\\11\\7\end{bmatrix}$$
	
	Portanto:
	
	$$\begin{bmatrix}x\\y\\\lambda\end{bmatrix} = \begin{bmatrix}1 & 1 & 0 \\ 0,08 & 0,01 & 1\\ 0,01 & 0,02 & 1\end{bmatrix}^{-1}\begin{bmatrix}320\\11\\7\end{bmatrix} = \begin{bmatrix}90\\230\\1,5\end{bmatrix}$$
"""

# ╔═╡ 11221b87-9926-476c-ba5f-f611e4d120d9
let
	contour(range(0,320,50), range(0,320,50), (x, y) -> -0.04x^2-0.01*x*y-0.01y^2+11x+7y-500, levels=[collect(200:30:1100)...], lw=2, color=:thermal)
	plot!(range(0, 320, 50), x->320-x, lc=:black, lw=2, label="Restrição")
	vline!([0], lc=:black, lw=0.5, label=:none)
	hline!([0], lc=:black, lw=0.5, label=:none)
	scatter!((100, 300), ms=6, mc=:blue, label="Ótimo livre")
	scatter!((90, 230), ms=6, mc=:red, label="Ótimo restrito", legend=:bottomright)
end

# ╔═╡ de651a9f-c34c-4313-b965-323b480bb6af
md"
#### Minimização de custos
"

# ╔═╡ 192e3ba7-00a8-4724-8574-4e530c074f1d
md"
* Uma firma que produz um único bem planeja produzir 30 unidades de produto da maneira mais barata possível
* Ao usar $K$ unidades de capital e $L$ unidades de trabalho, consegue produzir $\sqrt{K} + L$ unidades deste bem
* Suponha que os preços unitários de capital e trabalho sejam, respectivamente, \$1 e \$20
    1. Escreva o problema de minimização de custos para esta firma
    2. Encontre as escolhas ótimas de $K$ e $L$
    3. Qual o custo adicional de produzir 31 ao invés de 30 unidades?
"

# ╔═╡ e8afee77-4ef7-4ac9-b9ce-81312f124b67
md"""
!!! info "Resolução"
	* Formulação do problema de minimização de custos:

	$$\begin{eqnarray}&\min_{K,L} & K + 20L \\ &\text{sujeito a }& \sqrt{K} + L = 30\end{eqnarray}$$

	* Função Lagrangeana:

	$$\mathcal{L}(K,L,\lambda) = K + 20L + \lambda\left[30-\sqrt{K}-L\right]$$

	* Condições de primeira ordem:

	$$\begin{eqnarray}\mathcal{L}_\lambda &=& 30 - \sqrt{K} - L = 0 \\ \mathcal{L}_K &=& 1 - 0,5\lambda K^{-0,5} = 0 \\ \mathcal{L}_L &=& 20 - \lambda = 0\end{eqnarray}$$

	* Pontos críticos:
	
	    Temos que: $\lambda^* = 20, K^* = 100$ e $L^* = 20$

	* Custo de produção: \$500

	* Se a firma planeja produzir 31 unidades, temos: $K^* = 100$ e $L^* = 21$

	   Portanto, o custo adicional de produzir 31 unidades (ao invés de 30) é dado por: \$520 - \$500 = \$20

	   🚩 Note que o custo adicional de produzir uma unidade a mais é igual ao multiplicador de Lagrange
"""

# ╔═╡ 4f2b55c2-1e01-4478-9c35-f54ecb3f191f
let
	contour(range(0,150,50), range(0,40,50), (x, y) -> x + 20y, levels=[collect(100:50:700)..., 520], lw=2, c=:turbo, clabels=true)
	plot!(range(0, 150, 50), x->30-sqrt(x), lc=:black, lw=2, label="Restrição")
	plot!(range(0, 150, 50), x->31-sqrt(x), lc=:red, lw=2, label="Nova restrição")
	vline!([0], lc=:black, lw=0.5, label=:none)
	hline!([0], lc=:black, lw=0.5, label=:none)
	scatter!((100, 20), ms=6, mc=:blue, label="Ótimo restrito", legend=:topright)	
	scatter!((100, 21), ms=6, mc=:lightgreen, label="Novo ótimo restrito", legend=:topright)	
end

# ╔═╡ ab8f1307-e8b0-47e1-a32c-34cdf5fc6eda
md"
## Abordagem de diferencial total
"

# ╔═╡ b60965aa-e123-4b85-a5d7-00314de32c69
md"
* Para o problema de otimização estático com restrição de igualdade:

$$\begin{align}\max_{x,y}  \quad & z = f(x,y) \\ \text{s.r. } \quad & g(x,y) = c\end{align}$$

* A condição de primeira ordem em termos de diferencial total, $dz$, que vimos para um extremo livre de $z = f(x,y)$ permanece válida:

$$dz = f_x dx + f_y dy = 0$$

* Mas na presença da restrição, $dx$ e $dy$ não podem mais ser considerados variações arbitrárias

* Isso deve-se ao fato de que se $g(x,y) = c$ deve ser satisfeita, então:

$$g_x dx + g_y dy = 0$$

* Essas relações tornam $dx$ e $dy$ dependentes uma da outra

* Portanto, para satisfazer a condição necessária de primeira ordem em um problema de otimização estático com restrição de igualdade, devemos ter:

$$\frac{f_x}{g_x} = \frac{f_y}{g_y}$$

* Os valores ótimos $x^*$ e $y^*$ que solucionam o problema de otimização são dados pela solução do sistema de equações simultâneas:

$$\begin{align}g(x,y) &= c \\ \frac{f_x}{f_y} &= \frac{g_x}{g_y}\end{align}$$
"

# ╔═╡ fa709446-80b3-489d-8b9f-d14471537b2d
md"""
!!! warning "Diferencial total X multiplicador de Lagrange"
	* Note que temos:

	$$\frac{f_x}{g_x} = \lambda \qquad \text{e} \qquad \frac{f_y}{g_y} = \lambda$$

	* A abordagem do diferencial total resulta na mesma CPO do método do multiplicador de Lagrange

	* No entanto, a diferencial total nos dá apenas os pontos críticos

	* O método do multiplicador de Lagrange, por sua vez, também nos dá o valor de $\lambda^*$ como um subproduto direto

	* O multiplicador de Lagrange nos dá uma medida da sensibilidade de $\mathcal{L}^*$ (e $z^*$) a uma mudança na restrição

	* Portanto, o método do multiplicador de Lagrange oferece a vantagem de conter certas informações de estática comparativa embutidas na solução
"""

# ╔═╡ 0c54534e-f6c4-4e57-ace4-20b717c89b23
md"
## Interpretação do multiplicador de Lagrange
"

# ╔═╡ 45b6f72a-d698-4b85-b121-f725416e709a
md"
* Para mostrar que $\lambda^*$ mede a sensibilidade da função Lagrangeana $\mathcal{L}^*$ a variações na restrição, executaremos uma análise de estática comparativa da CPO
* As CPOs do problema de otimização restrito enunciado acima são dadas pelo seguinte sistema de equações:

$$\begin{align}\mathcal{L}_\lambda &= c - g(x,y) = 0 \\ \mathcal{L}_x &= f_x - \lambda g_x = 0 \tag{1}\label{eq1}\\ \mathcal{L}_y &= f_y - \lambda g_y = 0\end{align}$$

* Visto que $\lambda, x$ e $y$ são variáveis endógenas, a única variável exógena é o parâmetro de restrição $c$

* Uma variação em $c$ causaria um deslocamento da curva de restrição no plano $xy$ e, consequentemente, alteraria a solução ótima

* Em particular, o efeito de um aumento em $c$ indicaria como a solução ótima é afetada por um abrandamento da restrição

* Para conduzir a análise de estática comparativa, recorremos ao [**Teorema da Função Implícita**](https://en.wikipedia.org/wiki/Implicit_function_theorem)
"

# ╔═╡ 530d1c7b-39f5-4b84-83c9-bdbb6f01ec72
md"""
!!! info "Teorema da Função Implícita"	
	▶️ **Duas variáveis reais** 

	* Considere a função contínua de variáveis reais $f(x_1, x_2)$ em um conjunto aberto $V \in \mathbb{R}^2$
	* Supondo que $f$ é continuamente diferenciável com relação aos seus argumentos, consideraremos o problema de solucionar as seguintes equações implícitas de primeira ordem:

	$$\begin{align}f^1(x_1, x_2, \alpha) &= 0 \\ f^2(x_1, x_2, \alpha) &= 0\end{align}$$

	para as relações explícitas:

	$$\begin{align}x_1 &= x_1^*(\alpha) \\ x_2 &= x_2^*(\alpha)\end{align}$$

	onde $x_1$ e $x_2$ são as variáveis de escolha e $\alpha$ representa os parâmetros do modelo

	* As condições suficientes sob as quais este procedimento é válido são dadas pelo **Teorema da Função Implícita**

	* Diferenciando o sistema de equações simultâneas, obtemos:

	$$\begin{bmatrix}\frac{\partial f^1}{\partial x_1} & \frac{\partial f^1}{\partial x_2} \\ \frac{\partial f^2}{\partial x_1} & \frac{\partial f^2}{\partial x_2}\end{bmatrix}\begin{bmatrix}\frac{\partial x_1^*}{\partial \alpha} \\ \frac{\partial x_2^*}{\partial \alpha}\end{bmatrix} = \begin{bmatrix}-f^1_\alpha \\ -f^2_\alpha\end{bmatrix}$$

	* Uma condição necessária e suficiente para resolvermos para $\partial x_1^*/\partial \alpha$ e $\partial x_2^*/\partial \alpha$ unicamente é que o determinante Jacobiano $J$ seja diferente de zero:

	$$J = \begin{vmatrix}\frac{\partial f^1}{\partial x_1} & \frac{\partial f^1}{\partial x_2} \\ \frac{\partial f^2}{\partial x_1} & \frac{\partial f^2}{\partial x_2}\end{vmatrix} \neq 0$$

	---
	▶️ **$n$ variáveis reais** 

	* Para modelos com $n$ equações:

	$$\begin{align}f^1(x_1, \dots, x_n, \alpha) &= 0 \\ \vdots & \ddots \vdots \\ f^n(x_1, \dots, x_n, \alpha) &= 0\end{align}$$

	* Uma condição suficiente para que existam soluções explícitas do tipo:

	$$x_i = x_i^*(\alpha), \qquad i \in \{1, \dots, n\}$$

	em um dado ponto é que o Jacobiano associado, avaliado neste ponto, seja não-nulo:

	$$J = \begin{vmatrix}f_1^1 & f_2^1 & \dots & f_n^1 \\ \vdots & \vdots & \ddots & \vdots \\ f_1^n & f_2^n & \dots & f_n^n\end{vmatrix} \neq 0$$
"""

# ╔═╡ 88a31b36-3168-4419-9e8b-e981e3983ee7
md"
* Com as três equações em ($\ref{eq1}$) na forma $F^j(\lambda, x, y; c) = 0$ e supondo que elas possuem derivadas parciais contínuas, devemos verificar se o Jacobiano de variáveis endógenas associado não se anula no estado ótimo:

$$|J| = \begin{vmatrix}\frac{\partial F^1}{\partial \lambda} & \frac{\partial F^1}{\partial x} & \frac{\partial F^1}{\partial y} \\ \frac{\partial F^2}{\partial \lambda} & \frac{\partial F^2}{\partial x} & \frac{\partial F^2}{\partial y} \\ \frac{\partial F^3}{\partial \lambda} & \frac{\partial F^3}{\partial x} & \frac{\partial F^3}{\partial y}\end{vmatrix} = \begin{vmatrix}0 & -g_x & -g_y \\ -g_x & f_{xx} - \lambda g_{xx} & f_{xy} - \lambda g_{xy} \\ -g_y & f_{xy} - \lambda g_{xy} & f_{yy} - \lambda g_{yy}\end{vmatrix}$$

🔜 Neste momento vamos supor que $|J| \neq 0$, fato que demonstraremos mais adiante na disciplina

* Podemos, então, expressar $\lambda^*, x^*$ e $y^*$ como funções implícitas do parâmetro $c$:

$$\lambda^* = \lambda^*(c), \quad x^* = x^*(c) \quad \text{ e } \quad y^* = y^*(c)$$
"

# ╔═╡ 7932b23c-236c-4e5d-8ab4-5e4c36309f19
md"
* Além disso, temos as identidades de equilíbrio:

$$\begin{align}c - g(x^*, y^*) &= 0 \\ f_x(x^*, y^*) - \lambda^* g_x(x^*, y^*) &= 0 \\ f_y(x^*, y^*) - \lambda^* g_y(x^*, y^*) &= 0\end{align}$$

* Como o valor ótimo de $\mathcal{L}$ depende de $\lambda^*, x^*$ e $y^*$, temos:

$$\mathcal{L^*}(\lambda^*, x^*, y^*; c) = f(x^*, y^*) + \lambda^*[c - g(x^*, y^*)]$$

* Tomando o diferencial total de $\mathcal{L}^*$ com relação a $c$, obtemos:

$$\frac{d\mathcal{L}^*}{dc} = (f_x - \lambda^* g_x)\frac{dx^*}{dc} + (f_y-\lambda^* g_y)\frac{dy^*}{dc} + [c - g(x^*, y^*)]\frac{d\lambda^*}{dc} + \lambda^*$$

onde $f_x, f_y, g_x$ e $g_y$ devem ser avaliadas no ponto ótimo

* Portanto, concluímos que:

$$\frac{d\mathcal{L}^*}{dc} = \lambda^*$$

* Ou seja, o valor de solução do multiplicador de Lagrange constitui uma medida do efeito de uma variação na restrição por meio do parâmetro $c$ sobre o valor ótimo da função Lagrangeana
"

# ╔═╡ 8748d113-d402-4781-bbc9-ab1d118c0f02
md"""
> **Exercício**. Considere o seguinte problema de maximização de utilidade:
>
> $$\begin{align}\max_{x,y} \quad & xy \\ \text{s.r.} \quad & 2x + y = m\end{align}$$
>
> Suponha que, inicialmente, $m = 100$. Se $m$ aumentar em uma unidade, qual o efeito sobre a utilidade máxima deste consumidor?
"""

# ╔═╡ 0d797f84-863a-4d45-a6fa-fb847274c944
md"""
> **Exercício**. Suponha que $Q = F(K, L)$ seja a função de produção de uma firma controlada pelo Estado
>
> Suponha, ainda, que os preços unitários do capital e do trabalho sejam denotados, respectivamente, por $r$ e $w$
>
> Além disso, essa firma tem um orçamento total de $m$ unidades monetárias para despender nos dois insumos de produção
>
> O objetivo da firma é determinar os valores de capital e trabalho que maximizem sua produção
>
> Portanto, o problema de otimização é dado por:
>
> $$\begin{align}\max_{K,L} \quad & F(K, L) \\ \text{s.r.} \quad & rK + wL = m\end{align}$$
>
> Se $F(K,L) = 120KL, r = 2$ e $w = 5$, mostre que o valor do multiplicador de Lagrange nos diz, aproximadamente, o aumento observado na quantidade ótima produzida se $m$ aumentar em 1 unidade
"""

# ╔═╡ 8ec25d8f-5d7c-4dac-82c7-37f4febcb6ee
md"
## Caso multivariado
"

# ╔═╡ 633efa11-239b-44f7-84b7-2ae8f4d93e46
md"
* Os problemas de otimização restrita em economia, geralmente, envolvem mais do que apenas duas variáveis de escolha
* O problema típico com $n$ variáveis pode ser formulado da seguinte maneira:

$$\begin{align}\max(\min) \quad & f(x_1, \dots, x_n) \\ \text{s.r.} \quad & g(x_1, \dots, x_n) = c\end{align}$$

* Consideraremos, então, uma generalização do método do multiplicador de Lagrange
* Como anteriormente, associa-se o multiplicador de Lagrange $\lambda$ à restrição para formarmos a função Lagrangeana:

$$\mathcal{L} = f(x_1, \dots, x_n) + \lambda[c - g(x_1, \dots, x_n)]$$

* A seguir, encontramos as condições de primeira ordem que assumirá a forma de um sistema de $n + 1$ equações simultâneas:

$$\begin{align}\mathcal{L}_\lambda &= c - g(x_1, \dots, x_n) = 0 \\ \mathcal{L}_1 &= f_1 - \lambda g_1 = 0 \\ \vdots & \quad \vdots \quad \ddots \\ \mathcal{L}_n &= f_n - \lambda g_n = 0\end{align}$$

* A primeira equação assegura que a restrição seja satisfeita
"

# ╔═╡ 3f69caa9-0463-4872-9121-c502ffb9b8bb
md"
## Múltiplas restrições
"

# ╔═╡ 2a6cccea-4607-4c9e-8698-05e7b617d89d
md"
* Ocasionalmente, economistas precisam considerar problemas de otimização com mais do que uma restrição de igualdade
🔜 Mesmo que o caso mais comum seja o de múltiplas restrições de desigualdade, que veremos mais adiante no curso
* O problema de otimização generalizado correspondente pode, então, ser formulado da seguinte forma:

$$\begin{align}\max(\min) \quad & f(x_1, \dots, x_n) \\ \text{s.r.} \quad & \begin{cases}g_1(x_1, \dots, x_n) = c_1 \\ g_2(x_1, \dots, x_n) = c_2 \\ \qquad \vdots \\ g_m(x_1, \dots, x_n) = c_m\end{cases}\end{align}$$

* Quando há mais do que uma restrição, o método dos multiplicadores de Lagrange é igualmente aplicável, contanto que sejam introduzidos tantos multiplicadores quantas forem as restrições na função Lagrangeana

* Portanto, associando um multiplicador de Lagrange a cada uma das restrições, a função Lagrangeana é dada por:

$$\mathcal{L}(x_1, \dots, x_n) = f(x_1, \dots, x_n) + \sum_{j = 1}^m \lambda_j[c_j - g_j(x_1, \dots, x_n)]$$

* A função Lagrangeana assim definida terá o mesmo valor que a função objetivo original $f$ se as $m$ restrições impostas forem satisfeitas
* Isto é, se os $m$ termos finais da função Lagrangeana se anularem
* Neste caso, as condições necessárias de primeira ordem formarão um sistema de $n + m$ equações simultâneas:

$$\begin{align}\mathcal{L}_{\lambda_j} &= c_j - g_j(x_1, \dots, x_n) = 0, \qquad j\in\{1, \dots, n\} \\ \mathcal{L}_{x_i} &= f_i - \sum_{k=1}^m \lambda_k \frac{\partial g_k(x_1, \dots, x_n)}{\partial x_i} = 0, \qquad i\in\{1,\dots, n\}\end{align}$$

* Essas equações, normalmente, nos habilitam a resolver para todos os valores de $x_i$, bem como para todos os $\lambda_j$
"

# ╔═╡ d157f708-eca3-4394-846c-1bdf439acb77
md"""
> **Exercício**. Resolva o seguinte problema de maximização de utilidade do consumidor:
>
> $$\begin{align}\max_{x,y,z} \quad & U(x,y,z) = x^2y^3z \\ \text{s.r.} \quad & x + y + z = 12\end{align}$$
"""

# ╔═╡ 8569d318-cd2b-4501-bc50-d026fc0e91f3
md"""
> **Exercício**. Solucione o seguinte problema de otimização:
>
> $$\begin{align}\min_{x,y,z} \quad & (x-4)^2 + (y-4)^2 + \left(z - \frac{1}{2}\right)^2 \\ \text{s.r.} \quad & x^2 + y^2 = z\end{align}$$
"""

# ╔═╡ 60ac45ad-3088-4988-8e6f-856b35c4afd7
md"""
> **Exercício**. Solucione o seguinte problema de otimização:
>
> $$\begin{align}\min_{x,y,z} \quad & x^2 + y^2 + z^2 \\ \text{s.r.} \quad & \begin{cases}x + 2y + z = 30 \\ 2x - y - 3z = 10\end{cases}\end{align}$$
"""

# ╔═╡ 061bb44d-dbf0-490a-b607-409620aba229
md"
## 📚 Bibliografia

CHIANG, A.C.; WAINWRIGHT, K. Matemática para economistas.
Rio de Janeiro: Elsevier, 2006.

HOY, M.; LIVERNOIS, J.; McKENNA, C.; REES, R.; STENGOS, T.
Mathematics for Economics. 3rd.ed. Cambridge, Massachusetts: The
MIT Press, 2011.

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
Plots = "~1.38.9"
PlutoUI = "~0.7.50"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.5"
manifest_format = "2.0"
project_hash = "83ed028aeeaa556bec6cd9e7e98dbacbcf3fcd40"

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
git-tree-sha1 = "0635807d28a496bb60bc15f465da0107fb29649c"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.72.0"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "99e248f643b052a77d2766fe1a16fb32b661afd4"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.72.0+0"

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
git-tree-sha1 = "e9d68fe4b5f78f215aa2f0e6e6dc9e9911d33048"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.3.4"

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
git-tree-sha1 = "186d38ea29d5c4f238b2d9fe6e1653264101944b"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.38.9"

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
git-tree-sha1 = "0b829474fed270a4b0ab07117dce9b9a2fa7581a"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.12"

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
# ╟─c5427b90-da54-11ed-14fe-ebd284d9265b
# ╟─5814f255-77e8-432d-a5b9-95ed6afdda27
# ╟─3f805a81-914e-40f1-9dab-968b86bf0b33
# ╟─49e8546b-844e-49c9-aab9-b7b9d34af649
# ╟─8ed1b9f0-0311-4215-825b-0bb3a68782f5
# ╟─c698111c-ee94-45ac-832d-e6997f293928
# ╟─446ec895-0207-4785-9a9d-c20131bc19d1
# ╟─4733bfa6-d92d-4f19-a842-87633e64418b
# ╟─c273328a-a008-4762-a698-8b77f4fc8949
# ╟─e85ebf7c-a51d-4c76-aa33-17c18bd8a6c6
# ╟─294981f7-975b-41ca-9965-03b7bce4c001
# ╟─b4c7d751-bb1f-4b0e-843e-6df5ac74b829
# ╟─b3d4b91c-d691-4488-91b8-4bb1caefb14b
# ╟─ed585b41-3a42-485e-94d0-936eb7731ed5
# ╟─8858dafb-49ed-48db-b9ad-1c2bba867c37
# ╟─d7bbf013-8bbc-45e2-b3aa-42421fb23d71
# ╟─f63c11d2-beb0-40a2-85a3-49aca09da1db
# ╟─4122a5d6-d0d7-45dc-b499-1356911c5155
# ╟─a92b38aa-168d-41db-8f05-ed15cf86612c
# ╟─02e24286-6d62-458a-96db-68b01fff6ade
# ╟─1e617195-3eff-4184-b273-fe2d11680390
# ╟─ee6f1865-c9f2-4b56-8ba2-64d8df631b71
# ╟─6987d7cf-d240-4dd7-a209-0c981eec360b
# ╟─cc2e6147-f6e9-4973-8e34-c9a8701f30e7
# ╟─6130e6c1-fe1b-4ecc-81f4-9c607ea9770a
# ╟─d8fc1685-5678-4e86-8a53-35586db352c2
# ╟─ea42a8cd-2753-483f-8850-38ab612a99a8
# ╟─0119c1ff-d00d-4edc-aca7-094503ef7487
# ╟─9f21c074-70f2-4bcd-adbf-0fd5e2241e3c
# ╟─3f04958f-5803-4c4b-b7a8-5b8985e2194e
# ╟─8fdc08a6-7fae-423e-9829-26b6ac5a9592
# ╟─bbf65c05-61b0-48ea-91f7-5e31de56dc92
# ╟─e92d845c-a7e8-4c0d-87aa-2320e1d9f97c
# ╟─39878743-cd9b-499c-b1e9-9e7462071484
# ╟─999c0f4f-806d-4d91-8490-f57ad87b80d6
# ╟─e4939055-c1c8-4f83-baac-8aef3cdeed22
# ╟─11221b87-9926-476c-ba5f-f611e4d120d9
# ╟─de651a9f-c34c-4313-b965-323b480bb6af
# ╟─192e3ba7-00a8-4724-8574-4e530c074f1d
# ╟─e8afee77-4ef7-4ac9-b9ce-81312f124b67
# ╟─4f2b55c2-1e01-4478-9c35-f54ecb3f191f
# ╟─ab8f1307-e8b0-47e1-a32c-34cdf5fc6eda
# ╟─b60965aa-e123-4b85-a5d7-00314de32c69
# ╟─fa709446-80b3-489d-8b9f-d14471537b2d
# ╟─0c54534e-f6c4-4e57-ace4-20b717c89b23
# ╟─45b6f72a-d698-4b85-b121-f725416e709a
# ╟─530d1c7b-39f5-4b84-83c9-bdbb6f01ec72
# ╟─88a31b36-3168-4419-9e8b-e981e3983ee7
# ╟─7932b23c-236c-4e5d-8ab4-5e4c36309f19
# ╟─8748d113-d402-4781-bbc9-ab1d118c0f02
# ╟─0d797f84-863a-4d45-a6fa-fb847274c944
# ╟─8ec25d8f-5d7c-4dac-82c7-37f4febcb6ee
# ╟─633efa11-239b-44f7-84b7-2ae8f4d93e46
# ╟─3f69caa9-0463-4872-9121-c502ffb9b8bb
# ╟─2a6cccea-4607-4c9e-8698-05e7b617d89d
# ╟─d157f708-eca3-4394-846c-1bdf439acb77
# ╟─8569d318-cd2b-4501-bc50-d026fc0e91f3
# ╟─60ac45ad-3088-4988-8e6f-856b35c4afd7
# ╟─061bb44d-dbf0-490a-b607-409620aba229
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

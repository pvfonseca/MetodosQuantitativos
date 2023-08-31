### A Pluto.jl notebook ###
# v0.19.26

using Markdown
using InteractiveUtils

# ╔═╡ 30d4ca70-c46b-11ed-3459-31d786b43749
begin
	using PlutoUI
	using Plots
	using LaTeXStrings
	using Measures
	import PlutoUI: combine	
	theme(:dark)
	gr(size=(800,600), lw = 2, fontfamily = "Computer Modern", grid=true, tickfontsize = 12, guidefontsize=16, framestyle=:box, margin=3mm, right_margin=7mm, guidefonthalign=:right, guidefontvalign=:top)	
end

# ╔═╡ 27cf199f-03df-4e54-b9c9-67b0ecc4cc8a
PlutoUI.TableOfContents(title="Sumário", indent=true)

# ╔═╡ e9a821fd-b497-4730-a7b3-5b42b66834eb
html"<button onclick=present()>Apresentação</button>"

# ╔═╡ 447db1e7-5a54-4520-9d24-2fdd0a5b2797
md"""
# Otimização estática irrestrita $(Resource("https://www1.udesc.br/imagens/id_submenu/899/cor_horizontal_rgb.jpg", :width => 150))
"""

# ╔═╡ 7d303843-60e4-44d0-ae65-491458eb468e
md"
* **Disciplina:** 33MQEI - Métodos Quantitativos em Economia I
* **Docente:** [Paulo Victor da Fonseca](https://pvfonseca.github.io)
* **Contato:** [paulo.fonseca@udesc.br](mailto:paulo.fonseca@udesc.br)
* **Página da disciplina:** [Métodos Quantitativos I](https://pvfonseca.github.io/teaching/metodosquant)
"

# ╔═╡ 1e00be7a-fed6-4415-a57e-9a2a4d998b29
md"""
!!! danger "Aviso"
	O texto que segue não tem a menor pretensão de originalidade. Ele serve apenas como registro dos principais princípios, conceitos e técnicas analíticas que são trabalhados em sala de aula.
"""

# ╔═╡ 92700435-88f1-4161-9cc3-96e90a75a309
md"
## Introdução
"

# ╔═╡ 26f5a9b8-633c-4a18-9841-87f57f981f51
md"
* No **cálculo univariado**, para testar se uma função $f(x)$ possui um máximo ou mínimo local, frequentemente, usamos informações a respeito de sua segunda derivada
* Determinamos seus pontos críticos $x_0$, i.e., pontos $x_0$ nos quais $f'(x_0) = 0$ e, então, em cada um desses pontos, checamos o sinal algébrico da derivada segunda $f''(x_0)$
* Se $f''(x_0) < 0$, então, $f(x_0)$ é um máximo local de $f$
* Se $f''(x_0) > 0$, então, $f(x_0)$ é um mínimo local de $f$
* Se $f''(x_0) = 0$, o teste da segunda derivada falha
"

# ╔═╡ 82b02990-c1f8-457d-87ea-5b48ed5488db
md"""
> Nosso objetivo, agora, é estender estes métodos para funções de valores reais multivariadas
"""

# ╔═╡ 7589c4ca-621d-4220-bed2-2c9c90503700
md"
## Planos tangentes e aproximações lineares
"

# ╔═╡ 3372eab3-c73e-4273-820b-5d93cb5257a2
md"
* Vimos no cálculo univariado que à medida que damos *zoom* em torno de um ponto no gráfico de uma função diferenciável, o gráfico torna-se cada vez mais indistinguível de sua reta tangente
* Podemos, então, aproximar a função por uma função linear
* Desenvolveremos ideias semelhantes em três dimensões
* À medida que damos *zoom* em torno de um ponto na superfície, essa superfície assemelha-se, cada vez mais, com um plano (seu plano tangente) e, então, podemos aproximar a função, na vizinhança do ponto, por uma função linear bivariada
* Estenderemos a ideia de diferencial para funções de duas ou mais variáveis
"

# ╔═╡ 05eb45df-276e-4881-89d5-26c6e8d52fc1
md"
### Planos tangentes
"

# ╔═╡ 261efb51-da55-4ba6-b795-5bc9b032d072
md"""
!!! correct "Equação do plano tangente"
	Suponha que $f$ seja uma função de duas variáveis reais onde $f$ tenha derivadas parciais contínuas de primeira ordem. Uma equação do plano tangente à superfície de $f(x,y)$ no ponto $P(x_0, y_0)$ é dada por:

	$$f(x,y) = f(x_0,y_0) + f_x(x_0, y_0)(x-x_0) + f_y(x_0,y_0)(y-y_0)\tag{1}\label{eq4.1}$$
"""

# ╔═╡ 9240206a-eb9c-4024-bf15-bac4f16ebaa6
md"
---
* Vamos determinar o plano tangente no ponto $(1, 1, 3)$  da seguinte função
$$f(x,y) = 2x^2 + y^2$$
* Pela equação ($\ref{eq4.1}$), o plano tangente no ponto $(1, 1, 3)$ é dado por:
$$f(x,y) = 4x + 2y - 3$$
"

# ╔═╡ 01899ce9-b68e-49ce-8c3f-0c8c1936927a
begin		
	surface(
	  range(-4, 4, 50), range(-4, 4, 50), (x, y)-> (2x^2 + y^2), c=:roma, legend=:none, 
	  nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH
	)
	surface!(
	  range(-4, 4, 50), range(-4, 4, 50), (x, y)-> 4x+2y-3, c=:acton, alpha = 0.4, legend=:none, nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH, camera=(40,10)
	)
	zlims!(-60,60)
end

# ╔═╡ c33f194c-519a-4a2e-9491-c713cd621990
begin		
	surface(
	  range(-2, 2, 50), range(-2, 2, 50), (x, y)-> (2x^2 + y^2), c=:roma, legend=:none, 
	  nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH
	)
	surface!(
	  range(-2, 2, 50), range(-2, 2, 50), (x, y)-> 4x+2y-3, c=:acton, alpha = 0.40, legend=:none, nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH, camera=(40,10)
	)
	zlims!(-60,60)
end

# ╔═╡ 7cc9ca6e-39cb-4d2a-90c9-d6800a176506
begin		
	surface(
	  range(-1, 1, 50), range(-1, 1, 50), (x, y)-> (2x^2 + y^2), c=:roma, legend=:none, 
	  nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH
	)
	surface!(
	  range(-1, 1, 50), range(-1, 1, 50), (x, y)-> 4x+2y-3, c=:acton, alpha = 0.4, legend=:none, nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH, camera=(40,10)
	)
	zlims!(-60,60)
end

# ╔═╡ db14f371-f0c4-4932-a559-edab2fdd9788
md"
### Aproximações lineares e diferenciais
"

# ╔═╡ 4f7f934c-dc5a-4669-8f3f-47b55c99598c
md"
* Uma inspeção visual das figuras anteriores nos mostra que a função linear bivariada $L(x,y) = 4x + 2y - 3$ é uma boa aproximação de $f(x,y)$ na vizinhança de $(1,1)$
* A função $L$ é chamada *linearização* de $f$ em $(1, 1)$ e a aproximação $f(x,y) \approx 4x + 2y - 3$ é denominada *aproximação linear* ou *aproximação pelo plano tangente* de $f$ em $(1,1)$
"

# ╔═╡ 7f3c7542-757a-453d-a0d9-38ca3dcecb33
md"""
!!! correct "Aproximação linear"
	A **linearização** de uma função $f(x,y)$ contínua e diferenciável ao redor do ponto $(a,b)$ é dada por:

	$$L(x,y) = f(a, b) + f_x(a, b)(x-a) + f_y(a,b)(y-b)$$

	A linearização $L$ também é chamada de **polinômio de Taylor de primeiro grau** de $f$ em $(a,b)$

	Portanto, uma **aproximação linear** ou **aproximação pelo plano tangente** de $f$ em $(a, b)$ é dada por:

	$$f(x,y) \approx f(a,b) + f_x(a,b)(x-a) + f_y(a,b) (y-b)$$
"""

# ╔═╡ 4286074b-1662-42d2-93d8-2763d3037928
md"
* Lembre que para uma função univariada, $y = f(x)$, definimos a diferencial $dx$ como uma variável independente
* Ou seja, $dx$ pode ser qualquer número real
* Portanto, seja $y = f(x)$ uma função contínua e diferenciável, definimos a diferencial de $y$ como:
$$dy = f'(x)dx$$
"

# ╔═╡ a33fed0a-ecde-461d-8cdc-5c81f83a1239
PlutoUI.Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula4_fig1.PNG", :width=>800)

# ╔═╡ 5b14473b-2822-434c-9c2f-8eac830a7d66
md"
* A figura acima mostra as relações entre o incremento $\Delta y$ e a diferencial $dy$
*  $\Delta y$ representa a variação de altura da curva $y = f(x)$
*  $dy$ representa a variação de altura da reta tangente quando $x$ varia da quantidade $dx = \Delta x$
* Note que se $f'(x) > 0$, $dy$ e $dx$ devem assumir o mesmo sinal algébrico
* Por outro lado, se $f'(x)<0$, $dy$ e $dx$ assumem sinais algébricos opostos
"

# ╔═╡ 8da3c4dd-96b6-4534-b29d-e16fb8c60b91
PlutoUI.Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula4_fig2.PNG", :width=>800)

# ╔═╡ 5664d638-a5d7-48f4-ad6c-3e504836ad0c
md"
* Note que pontos nos quais $f'(x) \neq 0$ (como $A$ e $A'$) não podem ser classificados como pontos extremos
* A condição necessária para um extremo é dada por $dy = 0$ para pequenas variações de $x$ ao redor do ponto ótimo ($dx \neq 0$)
"

# ╔═╡ 65dec968-a82f-4cbc-a623-cc6841c34394
md"""
!!! correct "Diferencial total (caso bivariado)"
	Para uma função de duas variáveis, $z = f(x,y)$, definimos as **diferenciais** $dx$ e $dy$ como variáveis independentes (i.e., podem assumir qualquer valor). Então, a **diferencial total** $dz$ é definida por:

	$$dz = f_x(x,y)dx + f_y(x,y)dy = \frac{\partial z}{\partial x}dx + \frac{\partial z}{\partial y}dy$$
"""

# ╔═╡ ff8ffcc4-baac-4987-bc63-2b3536ecf310
md"
* Note que se tomarmos $dx = \Delta x = x - a$ e $dy = \Delta y = y - b$, então, a diferencial total de $z$ é:
$$dz = f_x(a, b)(x-a) + f_y(a,b)(y-b)$$
* Podemos, então, escrever a aproximação linear de uma função bivariada como:
$$f(x,y) \approx f(a, b) + dz$$
"

# ╔═╡ 07736b22-d256-4004-8771-b0335b408b94
PlutoUI.Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula4_fig3.PNG", :width=>800)

# ╔═╡ 363e2e28-f7d9-4c6e-8043-e0a130c06db2
md"
* A figura acima é o correspondente tridimensional da figura que vimos anteriormente para o caso do diferencial total de uma função univariada
* Esta figura mostra a interpretação geométrica do diferencial total $dz$ e o incremento $\Delta z$
*  $dz$ representa a alteração da altura do plano tangente
*  $\Delta z$ representa a alteração da altura da superfície $z = f(x,y)$ quando $(x,y)$ varia de $(a, b)$ para $(a + \Delta x, b + \Delta y)$
"

# ╔═╡ 6d86f39b-db7a-41e4-be9d-5d3e2d1cf502
md"
> **Exercício**
>
> (a) Se $z = f(x, y) = x^2 + 3xy - y^2$, determine o diferencial total $dz$
>
> (b) Se $x$ varia de 2 para 2,05 e $y$ varia de 3 a $2,96$, compare os valores de $\Delta z$ e $dz$
"

# ╔═╡ c917d763-21d3-48ba-bdc2-877ff6aec695
md"""
!!! hint "Resposta"
	(a) Temos que $dz = (2x + 3y)dx + (3x - 2y)dy$

	(b) Tomando $x = 2$, $dx = \Delta x = 0,05$ e $dy = \Delta y = -0,04$, obtemos:

	$$dz = [2(2) + 3(3)]0,05 + [3(2) - 2(3)](-0,04) = 0,65$$

	O incremento de $z$ é:

	$$\Delta z = f(2,05; 2,96) - f(2, 3) = 0,6449$$

	Observe que $\Delta z \approx dz$, mas $dz$ é mais simples de calcular
"""

# ╔═╡ 0656c002-a6bd-4904-a1a2-029c613de147
md"
* Neste caso, $dz$ está próximo de $\Delta z$ porque o plano tangente é uma boa aproximação da superfície $z = x^2 + 3xy - y^2$ ao redor do ponto $(2, 3, 13)$
"

# ╔═╡ 360eea16-55dc-451a-8061-fa4c83bbd5e6
begin		
	surface(
	  range(0, 5, 50), range(0, 5, 50), (x, y)-> (x^2 + 3x*y - y^2), c=:roma, legend=:none, 
	  nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH
	)
	surface!(
	  range(0, 5, 50), range(0, 5, 50), (x, y)-> 13x-13, c=:acton, alpha = 0.4, legend=:none, nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH, camera=(40,10)
	)
	#zlims!(-60,60)
end

# ╔═╡ a1776954-50e4-40d5-a67b-2c380836ade0
md"
* Estamos, agora, em posição para verificar a condição necessária para um extremo de uma função de duas variáveis reais
* Seja $z = f(x, y)$ uma função contínua e diferenciável, a condição necessária de primeira ordem para um extremo local (seja máximo ou mínimo) envolve, novamente, $dy = 0$
* Tomando o diferencial total da função $f$, obtemos:
$$dz = f_x dx + f_y dy$$
* Para um ponto específico ser um máximo (mínimo) local da função $f$, não pode ser o caso que pequenos movimentos em qualquer direção de suas variáveis independentes aumente (diminua) o valor da função
* Ou seja, todas as derivadas direcionais (parciais) de $f$ devem ser iguais a zero
* Portanto, a **condição necessária de primeira ordem para um ponto extremo** é dada por:
$$f_x = f_y = 0$$
* Esta condição tem uma interpretação econômica útil
* Para que uma função atinja seu valor de máximo, qualquer argumento deve ser aumentado até o ponto em que seu valor marginal de contribuição à função seja igual a zero
* Se $f_x > 0$, este ponto não pode ser um máximo pois um aumento em $x$, *ceteris paribus*, aumentaria o valor de $f$
"

# ╔═╡ 66cb6929-4e22-4acd-823d-7fe471e73982
md"
> **Exercício**: Encontre o ponto de máximo para a seguinte função:
>
> $$y = -x_1^2 + 2x_1 - x_2^2 + 4x_2 + 5$$
"

# ╔═╡ 60d973df-0f74-45bd-bb47-a0b5fa24e18b
md"
> **Exercício**: Considere uma firma com poder de mercado que se defronta com as seguintes funções demanda de mercado inversas:
>
> $$\begin{eqnarray}p_1 &=& 144-5q_1 \\ p_2 &=& 148 - 3q_2\end{eqnarray}$$
>
> Portanto, os preço unitários dos bens produzidos pela firma não são mais variáveis exógenas, e a função receita total passa a ser:
>
> $$R(q_1, q_2) = p_1q_1 + p_2q_2 = (144-5q_1)q_1 + (148-3q_2)q_2$$
>
> Suponha que a estrutura de custos da firma seja dada pela seguinte função custo total:
>
> $$C(q_1, q_2) = q_1^2 + 4q_1q_2 + q_2^2 + 75$$
>
> Estruture o problema de maximização de lucros para esta firma monopolista e calcule as quantidades produzidas ótimas
"

# ╔═╡ 81e2f884-4418-4091-8301-41572162eecc
md"""
!!! hint "Resposta"
	* A função lucro desta firma monopolista é dada por:
	
	$$\begin{eqnarray}\pi(q_1, q_2) &\equiv & R(q_1, q_2) - C(q_1, q_2) \\ &=& -6q_1^2 - 4q_2^2 + 144q_1 + 148q_2 - 4q_1q_2 - 75\end{eqnarray}$$

	* Portanto, o objetivo da firma maximizadora de lucros é:

	$$\max_{(q_1, q_2)} \pi(q_1, q_2) = -6q_1^2 - 4q_2^2 + 144q_1 + 148q_2 - 4q_1q_2 - 75 \tag{lucro} \label{lucro}$$

	* Condições de primeira ordem:

	$$\begin{eqnarray}\pi_1 &=& -12q_1 + 144 - 4q_2 &=& 0 \\ \pi_2 &=& -8q_2 + 148 - 4q_1 &=& 0\end{eqnarray}$$

	* Os pontos críticos podem, então, ser calculados através da solução do seguinte sistema linear:

	$$\begin{bmatrix}12 & 4\\4 & 8\end{bmatrix} \begin{bmatrix}q_1\\q_2\end{bmatrix} = \begin{bmatrix}144\\148\end{bmatrix}$$
"""

# ╔═╡ 8ed4470a-ae81-4148-88d0-2f1c36608b77
println("As quantidades ótimas produzidas pela firma monopolista são dadas por: $([12 4; 4 8]\[144; 148])")

# ╔═╡ 043ed29f-b047-4afd-b005-b840edc9ca01
md"
## Condições de primeira e segunda ordem: funções de duas variáveis reais
"

# ╔═╡ 64757cbf-382e-4287-8ab8-fc3a45269576
md"""
!!! warning "Condições de primeira e segunda ordem: caso univariado"
	* Vimos que para uma função $y = f(x)$ contínua e diferenciável, seu diferencial total de primeira ordem é dado por: $dy = f'(x) dx$

	* A partir desta observação, concluímos que, em termos de diferencial, os pontos críticos podem ser obtidos a partir da condição $dy = 0$

	* Para verificarmos as condições de segunda ordem para mínimos e máximos relativos, podemos tomar o diferencial total do diferencial total da função $f$ para obter o **diferencial total de segunda ordem**:

	$$\begin{eqnarray}d^2 y &=& d[f'(x)dx] = [df'(x)]dx \qquad \text{[já que $dx$ é uma constante]} \\ &=& [f''(x)dx]dx \\ &=& f''(x) dx^2\end{eqnarray}$$

	* Como o termo $dx^2$ é sempre positivo, $d^2y$ e $f''$ devem, necessariamente, possuir o mesmo sinal algébrico

	* Portanto, a condição suficiente para máximo ou mínimo relativo que enunciamos anteriormente pode ser, de modo equivalente, escrito em termos de condições sobre o diferencial total de segunda ordem:

	| Condição | Máximo relativo | Mínimo relativo |
	| :--- | --- | --- |
	| Necessária | $d^2 y\leq 0$ | $d^2 y \geq 0$ |
	| Suficiente | $d^2 y < 0$ | $d^2 y > 0$ |
"""

# ╔═╡ da918e2f-147d-4453-90d9-517ada257036
md"
* Seja $z = f(x,y)$ uma função contínua e diferenciável, seu diferencial total de primeira ordem é dado por:
$$dz = f_x dx + f_y dy$$
* O diferencial total de segunda ordem é, portanto, igual a:
$$d^2 z = f_{xx}dx^2 + f_{xy}dxdy + f_{yx}dy dx + f_{yy}dy^2$$
* Pela condição de simetria das derivadas parciais cruzadas (Teorema de Clairaut), sabemos que $f_{xy} = f_{yx}$, portanto:
$$d^2z = f_{xx}dx^2 + 2f_{xy}dxdy + f_{yy}dy^2$$
"

# ╔═╡ b2f81e4e-3c3b-4f51-8964-34072c969ee2
md"""
> **Exercício**. Obtenha o diferencial total de segunda ordem da seguinte função:
>
> $$z = x^3 + 5xy - y^2$$
"""

# ╔═╡ 77d52649-1373-4d7e-ae9f-7a5ea0348b45
md"""
!!! hint "Resposta"
	* Para a função $z = x^3 + 5xy - y^2$, temos que: $f_x = 3x^2 + 5y$, $f_y = 5x - 2y$
	* Ou seja, o diferencial total de primeira ordem é: $dz = (3x^2 + 5y)dx + (5x - 2y)dy$
	* Portanto: $f_{xx} = 6x, f_{xy} = f_{yx} = 5, f_{yy} = -2$
	* O diferencial total de segunda ordem da função $z$ é dado, então, por:
	$$d^2z = 6xdx^2 + 10dxdy - 2dy^2$$
"""

# ╔═╡ 0559cf5f-698f-4c9a-b75f-78dcd25320f0
md"
* Sabemos que o diferencial total de primeira ordem de uma função $z = f(x,u)$ é nulo, $dy = 0$, em um ponto crítico $(x^*, y^*)$
* Se num ponto crítico $(x^*, y^*)$ temos $d^2z<0$, segue que $dz$ sofre uma variação negativa em qualquer direção que se vá a partir do ponto $(x^*, y^*)$
* Como $dz = 0$ no ponto $(x^*, y^*)$ e esta grandeza é decrescente ($d^2z<0$), segue que numa vizinhança suficientemente próxima ao ponto crítico, teremos $dz < 0$
* Isto é, a função é decrescente em qualquer direção numa vizinhança suficientemente pequena em torno de $(x^*, y^*)$
* Portanto, neste ponto, há um máximo local que assume valor de $f(x^*, y^*)$
* O argumento para um mínimo local é similar
"

# ╔═╡ cedd18e0-cede-46e4-9b9b-78767be3e646
md"
💡 Portanto, para determinar se no ponto crítico $(x^*, y^*)$ há um máximo ou mínimo local, temos que verificar o sinal algébrico do diferencial total de segunda ordem $d^2z$ avaliado neste ponto
* O diferencial total de segunda ordem, como veremos, é uma **forma quadrática** e, portanto, determinar o sinal do primeiro resume-se a encontrar o sinal de uma forma quadrática
"

# ╔═╡ 0f2b7bdd-8c09-4603-a8e1-04891a760fe2
md"""
!!! correct "Forma quadrática"
	Uma forma quadrática em duas variáveis $u$ e $v$ é um polinômio da forma:
	
	$$q(u,v) = \alpha u^2 + 2\gamma uv + \beta v^2 \tag{2}\label{eq4.2}$$
	
	onde $\alpha, \gamma$ e $\beta$ são constantes.
"""

# ╔═╡ 515c6b7e-ac9f-41df-a4f4-413fef5493cc
md"
* Considerando a definição de forma quadrática dada em ($\ref{eq4.2}$), podemos observar que o diferencial total de segunda ordem $d^2z = f_{xx}dx^2 + 2f_{xy}dxdy + f_{yy}dy^2$ é uma forma quadrática nas variáveis $dx$ e $dy$
* Mais explicitamente, temos $q(u,v) = d^2z$, $u = dx$, $v = dy$, $\alpha = f_{xx}, \gamma = f_{xy}$ e $\beta = f_{yy}$
* Portanto, estudar o sinal algébrico do diferencial $d^2z$ significa estudar o sinal de uma forma quadrática
"

# ╔═╡ adf61fb1-1e8c-4cc4-9d4d-0d1af288e572
md"""
!!! correct "Formas quadráticas: classificação"
	As formas quadráticas podem ser classificadas com base no sinal algébrico que assumem:

	| Classificação | Condição |
	| :--- | ---: |	
	| Positiva definida | $q(u, v) > 0$ |
	| Positiva semidefinida | $q(u, v) \geq 0$ |
	| Negativa definida | $q(u, v) < 0$ |
	| Negativa semidefinida | $q(u, v) \leq 0$ |
"""

# ╔═╡ ba82f8f3-8c55-4550-ba06-696dcf167607
md"
* Para obtermos o sinal da forma quadrática $q(u, v)$ dado pela equação ($\ref{eq4.2}$) adotamos um procedimento denominado **completar o quadrado**:

$$\begin{eqnarray}q(u,v) &=& \alpha u^2 + 2\gamma uv + \beta v^2 \\ &=& \alpha\left(u^2 + \frac{2\gamma uv}{\alpha}\right) + \beta v^2 \\
&=& \alpha\left[u^2 + \frac{2\gamma uv}{\alpha} + \left(\frac{\gamma v}{\alpha}\right)^2 - \left(\frac{\gamma v}{\alpha}\right)^2\right] + \beta v^2 \\
&=& \alpha\left[u^2 + \frac{2\gamma uv}{\alpha} + \left(\frac{\gamma v}{\alpha}\right)^2\right] + \left(\beta v^2 - \frac{\gamma^2 v^2}{\alpha}\right) \\
&=& \alpha \left(u + \frac{\gamma v}{\alpha}\right)^2 + \frac{\alpha \beta - \gamma^2}{\alpha} v^2\end{eqnarray}$$
* Portanto, podemos concluir que:
    * Se $\alpha > 0$ e $\alpha\beta - \gamma^2 > 0$, então, $q(u,v) > 0$ e $q$ é **positiva definida**
    * Se $\alpha < 0$ e $\alpha\beta - \gamma^2 > 0$, então, $q(u,v) < 0$ e $q$ é **negativa definida**
* Note, ainda, que como $\alpha\beta - \gamma^2 > 0$, então, $\alpha$ e $\beta$ devem possuir o mesmo sinal algébrico
"

# ╔═╡ d7dec854-b818-415c-b7a8-3686af7b84ca
md"
* Podemos, então, estabelecer a condição de segunda ordem para um máximo ou mínimo local de uma função de duas variáveis reais
* Como vimos, o diferencial total de segunda ordem $d^2z = f_{xx}dx^2 + 2f_{xy}dxdy + f_{yy}dy^2$ é uma forma quadrática nas variáveis $u = dx$ e $v = dy$
* Sendo $\alpha = f_{xx}, \gamma = f_{xy}$ e $\beta = f_{yy}$
* Portanto:
    1.  $f(x^*,y^*)$ é um **mínimo local** se $f_{xx}, f_{yy}>0$ e $f_{xx}f_{yy} > f_{xy}^2$
    2.  $f(x^*,y^*)$ é um **máximo local** se $f_{xx}, f_{yy}<0$ e $f_{xx}f_{yy} > f_{xy}^2$
"

# ╔═╡ 38028b85-d15b-4fc5-8f59-05c3b42c77db
md"""
!!! correct "Condições para um extremo relativo da função z = f(x,y)"
	| Condição | Máximo relativo | Mínimo relativo |
	| :--- | ---: | ---: |
	| Necessária de primeira ordem | $f_x = f_y = 0$ | $f_x = f_y = 0$ |
	| Suficiente de segunda ordem | $\begin{eqnarray} f_{xx}, f_{yy} &<& 0 \\ f_{xx}f_{yy} &>& f_{xy}^2\end{eqnarray}$ | $\begin{eqnarray} f_{xx}, f_{yy} &>& 0 \\ f_{xx}f_{yy} &>& f_{xy}^2\end{eqnarray}$ |
"""

# ╔═╡ 336b83c0-14d1-4c3a-89df-bc2529ef9282
md"""
!!! danger "Pontos de sela"
	Quando temos $f_{xx}f_{yy} - f_{xy}^2 < 0$ (avaliado no ponto crítico), dizemos que $(x^*, y^*)$ é um **ponto de sela**

	Isso pode ocorrer quando, e.g., $f_{xx}(x^*,y^*) < 0$ ou $f_{yy}(x^*,y^*) < 0$, mas $[f_{xy}(x^*,y^*)]^2 \neq 0$
"""

# ╔═╡ 14c2f9d9-1b67-494b-b043-064737887178
md"""
Montanha em formato de sela
$(Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula4_fig4.PNG", :width=>800))
"""

# ╔═╡ 3351047c-9987-4a05-aac5-c75e247693bf
md"""
> **Exercício**. Encontre e classifique os pontos críticos da seguinte função:
>
> $$f(x,y) = y^2 + x^2$$
"""

# ╔═╡ da2e819a-d7f2-435b-9915-dfd11da34509
md"""
!!! hint "Resposta"
	1. Condição necessária de primeira ordem

	$$\begin{eqnarray} f_x &=& 2x = 0 \\ f_y &=& 2y = 0\end{eqnarray}$$

	Ponto crítico: $(0, 0)$

	2. Condições de segunda ordem:

	$$f_{xx}(0,0) = 2, f_{yy}(0,0) = 2, f_{xy}(0,0) = 0$$

	Portanto, o ponto $(0,0)$ é um mínimo local
"""

# ╔═╡ 1dff376c-d9ac-400c-a7e1-3d6e52bad4be
begin		
	surface(
	  range(-3, 3, 50), range(-3, 3, 50), (x, y)-> (y^2 +x^2), c=:roma, legend=:none, camera=(60,15),
	  nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH
	)
end

# ╔═╡ 88cd93dc-6ed5-4854-b298-50393a84347a
begin		
	contour(
	  range(-3, 3, 50), range(-3, 3, 50), (x, y)-> y^2+x^2, c=:roma, legend=:none, levels = 20	  
	)
	scatter!([(0, 0)], ms=8, mc=:indianred)
	vline!([0], label=:none, c=:white, lw=0.5)
	hline!([0], label=:none, c=:white, lw=0.5)
end

# ╔═╡ 2d353e55-1414-49b0-9975-e3ec83203415
md"
* Note, pelo mapa de contorno da função $f$, que as curvas de nível perto de (0,0) têm formato oval e indicam que, quando nos movemos para longe do ponto em qualquer direção, os valores de $f$ crescem
"

# ╔═╡ 80ad3e9e-04b0-4789-9848-2280279cd894
md"""
> **Exercício**. Encontre e classifique os pontos críticos da seguinte função:
>
> $$f(x,y) = y^2 - x^2$$
"""

# ╔═╡ fe2d8593-a34b-46d4-95ed-d1f6f87f02e7
md"""
!!! hint "Resposta"
	1. Condição necessária de primeira ordem

	$$\begin{eqnarray} f_x &=& -2x = 0 \\ f_y &=& 2y = 0\end{eqnarray}$$

	Ponto crítico: $(0, 0)$

	2. Condições de segunda ordem:

	$$f_{xx}(0,0) = -2, f_{yy}(0,0) = 2, f_{xy}(0,0) = 0$$

	Portanto, o ponto $(0,0)$ é um ponto de sela
"""

# ╔═╡ 26287112-b517-47f7-ba84-b77eb6ee039a
begin		
	surface(
	  range(-3, 3, 50), range(-3, 3, 50), (x, y)-> (y^2 -x^2), c=:roma, legend=:none, camera=(60,15),
	  nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH
	)
end

# ╔═╡ 8b4aeb31-750d-4d5f-9396-c28a5b55a117
begin		
	contour(
	  range(-3, 3, 50), range(-3, 3, 50), (x, y)-> y^2-x^2, c=:roma, legend=:none, levels = 20	  
	)
	scatter!([(0, 0)], ms=8, mc=:indianred)
	vline!([0], label=:none, c=:white, lw=0.5)
	hline!([0], label=:none, c=:white, lw=0.5)
end

# ╔═╡ 0226907c-9a4c-4054-a1dd-e51675ea2888
md"
* Note pelo mapa de contorno da função $f$ que as curvas de nível próximas ao ponto $(0,0)$ parecem hipérboles e, portanto, revelam que quando nos movemos para longe da origem os valores de $f$ decrescem em algumas direções mas crescem em outras
"

# ╔═╡ e99d6fbb-db98-4206-9576-8a7b652b784c
md"""
> **Exercício**. Encontre e classifique os pontos críticos da seguinte função:
>
> $$f(x,y) = x^4 + y^4 - 4xy + 1$$
"""

# ╔═╡ 7a55cd2c-ae87-4f77-9a25-ee11b01c6162
md"""
!!! hint "Resposta"
	1. Condição necessária de primeira ordem

	$$\begin{eqnarray} f_x &=& 4x^3 - 4y = 0 \\ f_y &=& 4y^3 - 4x = 0\end{eqnarray}$$

	Pontos críticos: $(0, 0), (1, 1)$ e $(-1, -1)$

	2. Condições de segunda ordem:

	$$f_{xx} = 12x^2, f_{yy} = 12y^2, f_{xy} = -4$$

	Portanto, o ponto $(0,0)$ é um ponto de sela, os pontos $(-1, -1)$ e $(1, 1)$ são mínimos locais
"""

# ╔═╡ c8d21a92-4c9a-4822-9a70-fd83552305a2
begin		
	surface(
	  range(-1.5, 1.5, 50), range(-1.5, 1.5, 50), (x, y)-> x^4 + y^4 -4x*y + 1, c=:roma, legend=:none, camera=(40,15),
	  nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH
	)
end

# ╔═╡ 5c6f43e0-94a9-45ee-8e2d-3d791cfd0ee1
begin		
	contour(
	  range(-2, 2, 50), range(-2, 2, 50), (x, y)-> x^4 + y^4 -4x*y + 1, c=:bone_1, legend=:none, levels = 100	  
	)
	vline!([0], label=:none, c=:white, lw=0.5)
	hline!([0], label=:none, c=:white, lw=0.5)
	scatter!([(0,0), (-1,-1), (1,1)], mc=:indianred, ms=5)
end

# ╔═╡ 8a205e43-f15e-4fe5-876f-c23112413d4c
md"""
> **Exercício**. Encontre e classifique os pontos críticos da seguinte função:
>
> $$f(x,y) = 8x^3 + 2xy - 3x^2 + y^2 + 1$$
"""

# ╔═╡ f228f80c-4eee-4a71-b948-62c4b3c0f205
md"""
!!! hint "Resposta"
	1. Condição necessária de primeira ordem

	$$\begin{eqnarray} f_x &=& 24x^2+2y-6x = 0 \\ f_y &=& 2x+2y = 0\end{eqnarray}$$

	Pontos críticos: $(0, 0)$ e $(1/3, -1/3)$

	2. Condições de segunda ordem:

	$$f_{xx} = 48x-6, f_{yy} = 2, f_{xy} = 2$$

	Portanto, o ponto $(0,0)$ é um ponto de sela, e o ponto $(1/3, -1/3)$ é um mínimo local
"""

# ╔═╡ 363d3854-d6da-411b-8834-f2bcaa073eaf
begin		
	surface(
	  range(-0.5, 0.5, 50), range(-0.5, 0.5, 50), (x, y)-> 8x^3+2x*y-3x^2+y^2+1, c=:roma, legend=:none, camera=(40,15),
	  nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH
	)
end

# ╔═╡ 131cbc05-1f36-4440-8653-f073d1c82bfe
begin		
	contour(
	  range(-0.5, 0.5, 50), range(-0.5, 0.5, 50), (x, y)-> 8x^3+2x*y-3x^2+y^2+1, c=:bone_1, legend=:none, levels = 100	  
	)
	vline!([0], label=:none, c=:white, lw=0.5)
	hline!([0], label=:none, c=:white, lw=0.5)
	scatter!([(0,0), (1/3,-1/3)], mc=:indianred, ms=5)
end

# ╔═╡ 7cb43262-9e79-4cd7-b586-5f2ba04525ae
md"""
> **Exercício**. Encontre e classifique os pontos críticos da seguinte função:
>
> $$f(x,y) = x + 2ey - e^x - e^{2y}$$
"""

# ╔═╡ f4bd0497-7afc-4f35-9e03-adc17981924b
md"""
!!! hint "Resposta"
	1. Condição necessária de primeira ordem

	$$\begin{eqnarray} f_x &=& 1-e^x = 0 \\ f_y &=& 2e - 2e^{2y} = 0\end{eqnarray}$$

	Ponto crítico: $(0, 1/2)$

	2. Condições de segunda ordem:

	$$f_{xx} = -e^x, f_{yy} = -4e^{2y}, f_{xy} = 0$$

	Portanto, o ponto $(0,1/2)$ é um máximo local
"""

# ╔═╡ 4bc16829-e8a2-45bb-9c6e-1e533b45bb56
begin		
	surface(
	  range(-1, 1, 50), range(0, 1, 50), (x, y)-> x + 2*exp(1)*y - exp(x)-exp(2y), c=:roma, legend=:none, camera=(60,20),
	  nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH
	)
end

# ╔═╡ 349f108e-ce4d-463e-aed8-6be2573e994b
begin		
	contour(
	  range(-1, 1, 50), range(0, 1, 50), (x, y)-> x + 2*exp(1)*y - exp(x)-exp(2y), c=:bone_1, legend=:none, levels = 30	  
	)
	vline!([0], label=:none, c=:white, lw=0.5)
	hline!([0], label=:none, c=:white, lw=0.5)
	scatter!([(0,1/2)], mc=:indianred, ms=5)
end

# ╔═╡ 75d8b4e6-bf06-47e5-9f74-043f454c196d
md"""
> **Exercício**. Considere o problema de maximização da firma monopolista que vimos anteriormente - Função $\ref{lucro}$
>
> Determine se o ponto crítico é, de fato, um ponto que maximiza o lucro da firma monopolista
"""

# ╔═╡ d33f162b-4470-4cf6-a275-73171453b4f6
md"""
!!! hint "Resposta"
	* Vimos que:

	$$\begin{eqnarray}\pi_1 &=& -12q_1 + 144 - 4q_2 = 0\\ \pi_2 &=& -8q_2 + 148 - 4q_1 = 0\end{eqnarray}$$

	* O ponto crítico obtido foi $(7, 15)$

	* Temos: $$\pi_{11} = -12, \pi_{12} = -4, \pi_{22} = -8$$

	* Portanto, $(7, 15)$ é um ponto de máximo local
"""

# ╔═╡ 9e544e5e-acae-4e62-9ca5-c8c795307eb4
begin		
	surface(
	  range(0, 20, 50), range(0, 20, 50), (x, y)-> -6x^2-4y^2+144x+148y-4x*y-75, c=:roma, legend=:none, camera=(60,20),
	  nx=50, ny=50, display_option=Plots.GR.OPTION_SHADED_MESH
	)
end

# ╔═╡ 6979819b-4ce4-4f58-8b34-83c06bf6cb57
begin		
	contour(
	  range(0, 20, 50), range(0, 20, 50), (x, y)-> -6x^2-4y^2+144x+148y-4x*y-75, c=:bone_1, legend=:none, levels = 30	  
	)
	vline!([0], label=:none, c=:white, lw=0.5)
	hline!([0], label=:none, c=:white, lw=0.5)
	scatter!([(7,15)], mc=:indianred, ms=5)
end

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

julia_version = "1.9.2"
manifest_format = "2.0"
project_hash = "70f75929b5ad01b42d4cd7f638c3d19b05d428b6"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "91bd53c39b9cbfb5ef4b015e8b582d344532bd0a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.2.0"

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
git-tree-sha1 = "02aa26a4cf76381be7f66e020a3eddeb27b0a092"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.2"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "d9a8f86737b665e15a9641ecbac64deef9ce6724"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.23.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "a1f44953f2382ebb937d60dafbe2deea4bd23249"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.10.0"

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.ColorVectorSpace.weakdeps]
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.Compat]]
deps = ["UUIDs"]
git-tree-sha1 = "e460f044ca8b99be31d35fe54fc33a5c33dd8ed7"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.9.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.5+0"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "5372dbbf8f0bdb8c700db5367132925c0771ef7e"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.2.1"

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
git-tree-sha1 = "3dbd312d370723b6bb43ba9d02fc36abade4518d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.15"

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

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "e90caa41f5a86296e014e148ee061bd6c3edec96"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.9"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "4558ab818dcceaab612d1bb8c19cee87eda2b83c"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.5.0+0"

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
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "d8db6a5a2fe1381c1ea4ef2cab7c69c2de7f9ea0"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.1+0"

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
git-tree-sha1 = "d73afa4a2bb9de56077242d98cf763074ab9a970"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.72.9"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "1596bab77f4f073a14c62424283e7ebff3072eca"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.72.9+1"

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
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "cb56ccdd481c0dd7f975ad2b3b62d9eda088f7e2"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.9.14"

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
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "7e5d6779a1e09a36db2a7b6cff50942a0a7d0fca"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.5.0"

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

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f689897ccbe049adb19a065c495e75f372ecd42b"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "15.0.4+0"

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
git-tree-sha1 = "f428ae552340899a935973270b8d98e5a31c49fe"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.1"

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
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "2da088d113af58221c52828a80378e16be7d037a"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.5.1+1"

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
git-tree-sha1 = "7d6dd4e9212aebaeed356de34ccf262a3cd415aa"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.26"

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
git-tree-sha1 = "a03c77519ab45eb9a34d3cfe2ca223d79c064323"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.1"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "9ee1618cbf5240e6d4e0371d6f24065083f60c48"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.11"

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
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "bbb5c2115d63c2f1451cb70e5ef75e8fe4707019"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.22+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "2e73fe17cac3c62ad1aebe70d44c963c3cfdc3e3"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.2"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "716e24b21538abc91f6205fd1d8363f39b442851"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.7.2"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "64779bc4c9784fee475689a1752ef4d5747c5e87"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.42.2+0"

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
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Preferences", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "9f8675a55b37a70aa23177ec110f6e3f4dd68466"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.38.17"

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
git-tree-sha1 = "e47cd150dbe0443c3a3651bc5b9cbd5576ab75b7"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.52"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "03b4c25b43cb84cee5c90aa9b5ea0a78fd848d2f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "7eb1686b4f04b82f96ed7a4ea5890a4f0c7a09f1"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "364898e8f13f7eaaceec55fd3d08680498c0aa6e"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.4.2+3"

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
git-tree-sha1 = "c60ec5c62180f27efea3ba2908480f8055e17cee"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.1.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

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
git-tree-sha1 = "b7a5e99f24892b6824a954199a45e9ffcc1c70f0"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.0"

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
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "a72d22c7e13fe2de562feda8645aa134712a87ee"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.17.0"

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    InverseFunctionsUnitfulExt = "InverseFunctions"

    [deps.Unitful.weakdeps]
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

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

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "cf2c7de82431ca6f39250d2fc4aacd0daa1675c0"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.4.4+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "afead5aba5aa507ad5a3bf01f58f82c8d1403495"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.6+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6035850dcc70518ca32f012e46015b9beeda49d8"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.11+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "34d526d318358a859d7de23da945578e8e8727b7"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.4+0"

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
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8fdda4c692503d44d04a0603d9ac0982054635f9"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.1+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "b4bfde5d5b652e22b9c790ad00af08b6d042b97d"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.15.0+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "730eeca102434283c50ccf7d1ecdadf521a765a4"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.2+0"

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
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "330f955bc41bb8f5270a369c473fc4a5a4e4d3cb"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.6+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "691634e5453ad362044e2ad653e79f3ee3bb98c3"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.39.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e92a1a012a10506618f10b7047e478403a046c77"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.5.0+0"

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
# ╟─30d4ca70-c46b-11ed-3459-31d786b43749
# ╟─27cf199f-03df-4e54-b9c9-67b0ecc4cc8a
# ╟─e9a821fd-b497-4730-a7b3-5b42b66834eb
# ╟─447db1e7-5a54-4520-9d24-2fdd0a5b2797
# ╟─7d303843-60e4-44d0-ae65-491458eb468e
# ╟─1e00be7a-fed6-4415-a57e-9a2a4d998b29
# ╟─92700435-88f1-4161-9cc3-96e90a75a309
# ╟─26f5a9b8-633c-4a18-9841-87f57f981f51
# ╟─82b02990-c1f8-457d-87ea-5b48ed5488db
# ╟─7589c4ca-621d-4220-bed2-2c9c90503700
# ╟─3372eab3-c73e-4273-820b-5d93cb5257a2
# ╟─05eb45df-276e-4881-89d5-26c6e8d52fc1
# ╟─261efb51-da55-4ba6-b795-5bc9b032d072
# ╟─9240206a-eb9c-4024-bf15-bac4f16ebaa6
# ╟─01899ce9-b68e-49ce-8c3f-0c8c1936927a
# ╟─c33f194c-519a-4a2e-9491-c713cd621990
# ╟─7cc9ca6e-39cb-4d2a-90c9-d6800a176506
# ╟─db14f371-f0c4-4932-a559-edab2fdd9788
# ╟─4f7f934c-dc5a-4669-8f3f-47b55c99598c
# ╟─7f3c7542-757a-453d-a0d9-38ca3dcecb33
# ╟─4286074b-1662-42d2-93d8-2763d3037928
# ╟─a33fed0a-ecde-461d-8cdc-5c81f83a1239
# ╟─5b14473b-2822-434c-9c2f-8eac830a7d66
# ╟─8da3c4dd-96b6-4534-b29d-e16fb8c60b91
# ╟─5664d638-a5d7-48f4-ad6c-3e504836ad0c
# ╟─65dec968-a82f-4cbc-a623-cc6841c34394
# ╟─ff8ffcc4-baac-4987-bc63-2b3536ecf310
# ╟─07736b22-d256-4004-8771-b0335b408b94
# ╟─363e2e28-f7d9-4c6e-8043-e0a130c06db2
# ╟─6d86f39b-db7a-41e4-be9d-5d3e2d1cf502
# ╟─c917d763-21d3-48ba-bdc2-877ff6aec695
# ╟─0656c002-a6bd-4904-a1a2-029c613de147
# ╟─360eea16-55dc-451a-8061-fa4c83bbd5e6
# ╟─a1776954-50e4-40d5-a67b-2c380836ade0
# ╟─66cb6929-4e22-4acd-823d-7fe471e73982
# ╟─60d973df-0f74-45bd-bb47-a0b5fa24e18b
# ╟─81e2f884-4418-4091-8301-41572162eecc
# ╟─8ed4470a-ae81-4148-88d0-2f1c36608b77
# ╟─043ed29f-b047-4afd-b005-b840edc9ca01
# ╟─64757cbf-382e-4287-8ab8-fc3a45269576
# ╟─da918e2f-147d-4453-90d9-517ada257036
# ╟─b2f81e4e-3c3b-4f51-8964-34072c969ee2
# ╟─77d52649-1373-4d7e-ae9f-7a5ea0348b45
# ╟─0559cf5f-698f-4c9a-b75f-78dcd25320f0
# ╟─cedd18e0-cede-46e4-9b9b-78767be3e646
# ╟─0f2b7bdd-8c09-4603-a8e1-04891a760fe2
# ╟─515c6b7e-ac9f-41df-a4f4-413fef5493cc
# ╟─adf61fb1-1e8c-4cc4-9d4d-0d1af288e572
# ╟─ba82f8f3-8c55-4550-ba06-696dcf167607
# ╟─d7dec854-b818-415c-b7a8-3686af7b84ca
# ╟─38028b85-d15b-4fc5-8f59-05c3b42c77db
# ╟─336b83c0-14d1-4c3a-89df-bc2529ef9282
# ╟─14c2f9d9-1b67-494b-b043-064737887178
# ╟─3351047c-9987-4a05-aac5-c75e247693bf
# ╟─da2e819a-d7f2-435b-9915-dfd11da34509
# ╟─1dff376c-d9ac-400c-a7e1-3d6e52bad4be
# ╟─88cd93dc-6ed5-4854-b298-50393a84347a
# ╟─2d353e55-1414-49b0-9975-e3ec83203415
# ╟─80ad3e9e-04b0-4789-9848-2280279cd894
# ╟─fe2d8593-a34b-46d4-95ed-d1f6f87f02e7
# ╟─26287112-b517-47f7-ba84-b77eb6ee039a
# ╟─8b4aeb31-750d-4d5f-9396-c28a5b55a117
# ╟─0226907c-9a4c-4054-a1dd-e51675ea2888
# ╟─e99d6fbb-db98-4206-9576-8a7b652b784c
# ╟─7a55cd2c-ae87-4f77-9a25-ee11b01c6162
# ╟─c8d21a92-4c9a-4822-9a70-fd83552305a2
# ╟─5c6f43e0-94a9-45ee-8e2d-3d791cfd0ee1
# ╟─8a205e43-f15e-4fe5-876f-c23112413d4c
# ╟─f228f80c-4eee-4a71-b948-62c4b3c0f205
# ╟─363d3854-d6da-411b-8834-f2bcaa073eaf
# ╟─131cbc05-1f36-4440-8653-f073d1c82bfe
# ╟─7cb43262-9e79-4cd7-b586-5f2ba04525ae
# ╟─f4bd0497-7afc-4f35-9e03-adc17981924b
# ╟─4bc16829-e8a2-45bb-9c6e-1e533b45bb56
# ╟─349f108e-ce4d-463e-aed8-6be2573e994b
# ╟─75d8b4e6-bf06-47e5-9f74-043f454c196d
# ╟─d33f162b-4470-4cf6-a275-73171453b4f6
# ╟─9e544e5e-acae-4e62-9ca5-c8c795307eb4
# ╟─6979819b-4ce4-4f58-8b34-83c06bf6cb57
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002

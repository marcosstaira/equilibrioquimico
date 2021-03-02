turtles-own [ ;; Esse define a turtle do cronômetroprocedures
  ready-timer  ;; Cronômetro que tem com função impedir que as moléculas entrem
  ;;imediatamente em uma reação reversa.
]

;;Configurações iniciais
to setup ;; Comando primitivo inicial
  clear-all ;; Limpa tudo
  set-default-shape turtles "circle" ;; Cria a "forma" das turtles
  create-turtles moleculas-azuis [ ;; Criará a quantidade de moléculas azuis que o usuário irá designar no deslizador
    setup-molecules blue
  ]
  create-turtles moleculas-amarelas [ ;;;; Criará a quantidade de moléculas amarelas que o usuário irá designar no deslizador
    setup-molecules yellow
  ]
  reset-ticks ;;Reseta o contador de ticks para zero
end


to setup-molecules [c] ;; procedimento da turtle
  set ready-timer 0 ;;Cronômetro que indica se a molécula está pronta ou não para reagir é definido para zero
  set color c ;; a cor da molécula, e a posição aleatória da molécula em x e y.
  setxy random-xcor random-ycor ;; xcor e ycor se refere às coordenadas que as turtles aparecerão
end


;;  Procedimentos de tempo de execução
;;  As turtles se mexem e verificam se há uma reação. As turtles que têm um temporizador também o reduzem em um tique.
to go
  ask turtles [
    if ready-timer > 0 [
      set ready-timer ready-timer - 1
    ]
    wiggle

    ;;Se uma molécula azul se encontra com uma amarela, elas se tornam verde e rosas, respectivamente.
    check-for-reaction blue yellow green pink

    ;;Se uma molécula verde se encontra com uma rosa, elas se tornam azul e amarelas, respectivamente.

    check-for-reaction green pink blue yellow

  ]
  tick
end

;; As turtles recebem um leve giro aleatório em sua direção.
to wiggle ;; Procedimento da turtle
  fd 1  ;;frente
  rt random-float 2 ;; direita
  lt random-float 2 ;; esquerda
end

;; Uma reação é definida por quatro cores: As cores das duas moléculas que podem potencialmente
;; reagir entre si(molécula-cor1 e molécula-cor2) e a cor das duas moléculas
;; que serão produzidas se uma tal reação acontecer(produto de cor1 e produto de cor2).
to check-for-reaction [ reactant-1-color reactant-2-color product-1-color product-2-color ]
  ;; Primeiramente, verifica-se se a reação está pronta para ser executada
  ;; E se as cores estão corretas para ocorrer as reações.
  if ready-timer = 0 and color = reactant-1-color [
    ;; Tentativa de achar parceiro apropriado para reação

    if any? turtles-here with [ color = reactant-2-color ] [
      ;; condicional para identificar se há uma reação e executá-la
      react product-1-color
      ask one-of turtles-here with [ color = reactant-2-color ] [ react product-2-color ]
    ]
  ]
end

;; Quando uma molécula reage, muda sua cor e seta uma nova direção,
;; e um temporizador que lhe dará tempo o suficiente se movimentar
;; antes de reagir novamente
to react [ new-color ]
  set color new-color
  rt random-float 360
  set ready-timer 2
end
@#$#@#$#@
GRAPHICS-WINDOW
370
10
747
388
-1
-1
9.0
1
10
1
1
1
0
1
1
1
-20
20
-20
20
0
0
1
ticks
30.0

BUTTON
75
50
162
83
Configurar
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
168
49
249
82
Iniciar
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

SLIDER
10
10
165
43
moleculas-amarelas
moleculas-amarelas
0.0
500.0
289.0
1.0
1
NIL
HORIZONTAL

SLIDER
168
10
323
43
moleculas-azuis
moleculas-azuis
0.0
500.0
168.0
1.0
1
NIL
HORIZONTAL

MONITOR
168
87
245
132
azuis
count turtles with [color = blue]
3
1
11

MONITOR
83
87
160
132
amarelas
count turtles with [color = yellow]
3
1
11

MONITOR
168
137
245
182
verdes
count turtles with [color = green]
3
1
11

MONITOR
83
137
160
182
rosas
count turtles with [color = pink]
3
1
11

PLOT
10
189
324
410
Quantidade de moléculas
ticks
Número de moléculas
0.0
100.0
0.0
200.0
true
true
"set-plot-y-range 0 max (list moleculas-amarelas moleculas-azuis)" ""
PENS
"amarelas" 1.0 0 -1184463 true "" "plot count turtles with [color = yellow]"
"verdes" 1.0 0 -12087248 true "" "plot count turtles with [color = green]"
"rosas" 1.0 0 -2064490 true "" "plot count turtles with [color = pink]"
"azuis" 1.0 0 -13345367 true "" "plot count turtles with [color = blue]"

@#$#@#$#@
## O QUE É O MODELO?



Esse modelo com fim didático, baseado no modelo "Wilensky, U. (1998). NetLogo Chemical Equilibrium model. http://ccl.northwestern.edu/netlogo/models/ChemicalEquilibrium. Center for Connected Learning and Computer-Based Modeling, Northwestern Institute on Complex Systems, Northwestern University, Evanston, IL", adaptado e traduzido para português mostra como um simples sistema químico chega em diferentes estados de equilíbrio de acordo com os níveis de concentração dos reagentes iniciais. Equilíbrio é o termo que se usa para descrever um sistema no qual não há mudanças macroscópicas. Isso significa que o sistema aparenta como se não estivesse nada acontecendo. Na verdade, em todos os sistemas químicos, os processos em nível atômico continuam mas em um equiílibrio que não provoca mudanças macroscópicas.
Esse modelo simula duas simples reação entre quatro moléculas. As reações podem ser escritas dessa forma:

```text
        A + B =======> C + D
```

e

```text
        C + D =======> A + B
```

Também pode ser escrita como uma simples e reversível reação.

```text
        A + B <=======> C + D
```



Um simples exemplo de tal reação na vida real é a reação que ocorre quando monóxido de carbono reage com dióxido de nitrogênio para produzir dióxido de carbono e monóxido de nitrogênio (ou óxido de nitrogênio). A reação reversa (quando dióxido de carbono e monóxido de nitrogênio reagem para formar monóxido de carbono e dióxido de nitrogênio) também é possível. Embora todas as substâncias da reação forem gases, poderíamos observar como um sistema atinge equilíbrio, visto que dióxido de nitrogênio (NO<sub>2</sub>) é um gás de cor avermelhada visível. Quando o dióxido de nitrogênio (NO<sub>2</sub>) se combina com o monóxido de carbono (CO), os produtos resultantes -- monóxido de nitrogênio(NO) e dióxido de carbono (CO<sub>2</sub>) -- são incolores, fazendo com que o sistema perca um pouco de sua cor avermelhada. Por fim, o sistema chega a um estado de equilíbrio com alguns dos "reagentes e alguns dos "produtos" presentes.

Embora o quanto de reagente e produto um sistema termina depende de um número de fatores (incluindo, por exemplo, o quanto de energia é liberada quando uma substância reage ou a temperatura do sistema), esse modelo focaliza nas concentrações dos reagentes.

## COMO FUNCIONA 



No modelo, moléculas azuis e amarelas podem reagir com outras como verdes e rosas. A cada tick, cada molécula se move randomicamente dentro da simulação encontrando outras molécuals. Se encontra uma molécula com a qual ela pode reagir (como por exemplo, uma amarela encontrando uma azul, ou uma rosa encontrando uma verde, a reação acontece. Porque moléculas azuis e amarelas reagem para produzir moléculas verdes e rosas, moléculas verdes e rosas reagem para produzir azuis e amarelas, e eventualmente, um equilíbrio químico é alcançado.)

Para impedir que as moléculas reagem duas vezes ao mesmo tempo, cada molécula possui um cronômetro que é zerado a cada dois tiques. permitindo que a molécula reaja novamente.


## COMO USAR 


Os deslizadores das "moléculas-amarelas" e das "moléculas azuis" determinam a quantidade inicial de moléculas amarelas e azuis. Uma vez que esse deslizador é ajustado, o usuário deve clicar em configurar, onde as moléculas serão criadas e distribuídas na simulação.

O botão "Iniciar" começa a simulação. As moléculas se movem randomicamente e reagem com as outras, mudando de cor para representar o rearranjamento dos átomos em diferentes estruturas moléculares. O sistema logo entra em equilíbrio.



Quatro monitores mostram o quanto de cada molécula está presente no sistema. O gráfico "montante de moléculas" mostra o quanto cada molécula esteve presente durante o tempo.


## COISAS NOTÁVEIS


Você pode perceber que o número de moléculas do produto é limitado pela menor quantidade de reagentes inicias. Perceba que sempre há o mesmo número de moléculas de produto, pois elas são formadas em uma correspondência de um para um com o outro.

## COISAS PARA O PROFESSOR TESTAR EM CLASSE



Como dois montantes diferentes de reagentes afetam no equilíbrio final? As quantidades absolutas são importantes, é a diferença entre as quantidades ou o que importa é a proporção entre os dois reagentes?

Tente setar as moléculas amarelas em 400 e as azuis em 20, 40, 100, 200, 400 em 5 simulações seguidas. 
Qual tipo de equilíbrio você previu em cada caso? Algumas taxas são previsíveis?


O que acontece quando você inicia com o mesmo número de moléculas amarelas e moléculas azuis? Depois de iniciar o modelo, qual a relação entre a contagem dessas duas moléculas?
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
1
@#$#@#$#@

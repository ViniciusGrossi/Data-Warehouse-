Crie um sistema de animação moderno para um dashboard de análise de dados com gráficos de linha e indicadores numéricos.

O objetivo é tornar a visualização fluida e interativa, utilizando quatro tipos de animação principais.

1. Grow From Center Animation
   Quando o dashboard carregar:

* O container do gráfico deve surgir a partir do centro.
* Usar transform scale (scale 0.2 → scale 1).
* Combinar com fade-in (opacity 0 → 1).
* Duração entre 600ms e 900ms.
* Easing suave (ease-out ou cubic).

2. Progressive Reveal do gráfico
   Após o container aparecer:

Etapa 1:
Mostrar os eixos X e Y com fade-in.

Etapa 2:
Mostrar os pontos de dados progressivamente ao longo da linha do tempo.

Etapa 3:
Desenhar a linha conectando os pontos com animação de line-draw.

Sequência:
container → eixos → pontos → linha.

3. Count-up Animation para métricas
   Indicadores numéricos devem:

* iniciar em 0
* contar progressivamente até o valor real
* duração entre 800ms e 1200ms
* easing suave.

4. Animated Filter Transition (Chart Morphing)
   Quando o usuário alterar filtros:

* Não remover o gráfico atual.
* Fazer interpolação entre datasets.
* Os pontos devem se mover suavemente para as novas posições.
* A linha deve se transformar gradualmente na nova forma.

5. Data Highlight Animation (Hover Interaction)
   Quando o usuário passar o mouse sobre uma linha do gráfico:

* A linha selecionada deve ganhar destaque visual (aumentar espessura ou brilho).
* Os pontos dessa linha devem aumentar levemente de tamanho.
* As outras linhas devem reduzir opacidade para cerca de 30–40%.
* O efeito deve ocorrer em menos de 200ms para parecer instantâneo.
* Mostrar tooltip com os valores do ponto.

6. Performance e UX

* Animações devem ocorrer apenas na primeira renderização ou mudança de filtros.
* Evitar animação em cada pequeno rerender.
* Manter transições rápidas e suaves.

7. Estrutura modular
   Criar componentes reutilizáveis para:

* animação de container
* progressive reveal
* count-up de métricas
* morphing de dados
* highlight de séries no hover.

O resultado final deve criar uma experiência visual semelhante a dashboards modernos de produtos SaaS.


Sequência visual final do dashboard

Quando abre:

1️⃣ container surge do centro
2️⃣ eixos aparecem
3️⃣ pontos surgem
4️⃣ linha é desenhada
5️⃣ números contam

Quando troca filtro:

linha antiga
   ↓
pontos se movem
   ↓
nova linha aparece

Quando passa o mouse:

linha destacada
outras linhas apagadas
pontos aumentam
tooltip aparece

💡 Dica forte para seu portfólio

No seu dashboard de combustíveis você poderia ter:

Linhas:

gasolina

etanol

diesel

Quando passar o mouse em gasolina:

gasolina → destaque
etanol → fade
diesel → fade
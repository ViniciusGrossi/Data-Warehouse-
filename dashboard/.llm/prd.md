# PRD - Case 1: Dashboard Analítico E-commerce

## Contexto

Dashboard para 3 diretores de um e-commerce consumirem os Data Marts gold do banco PostgreSQL (Supabase). Cada diretor tem necessidades distintas. O dashboard deve ser self-service: abrir, selecionar filtros, ver os números.

**Banco:** PostgreSQL (Supabase)
**Referência técnica:** Ler o arquivo `database.md` para schemas completos, colunas, tipos e regras de negócio.

---

## Arquitetura

```
Supabase (PostgreSQL)
    │
    ├── public_gold_sales.vendas_temporais
    ├── public_gold_cs.clientes_segmentacao
    └── public_gold_pricing.precos_competitividade
            │
            ▼
    Next.js App (App Router)
    ├── /api/vendas        ← Server-side, query ao Supabase
    ├── /api/clientes
    ├── /api/pricing
            │
            ▼
    Pages (Client Components)
    ├── /dashboard/vendas
    ├── /dashboard/clientes
    └── /dashboard/pricing
```

**Stack:**
- Next.js (App Router)
- TypeScript
- Supabase JS Client (`@supabase/supabase-js`)
- Recharts (gráficos)
- TanStack Query (data fetching e cache)

---

## Conexão com o Banco

Usar variáveis de ambiente via `.env.local`:

```
SUPABASE_HOST=seu-host.supabase.co
SUPABASE_PORT=5432
SUPABASE_DB=postgres
SUPABASE_USER=seu-usuario
SUPABASE_PASSWORD=sua-senha
```

Queries executadas em **Route Handlers** (`/api/*`) — nunca no cliente. O cliente consome apenas os endpoints internos da aplicação.

---

## Estrutura do App

### Navegação

- Sidebar fixa com navegação entre as 3 páginas:
  - Vendas
  - Clientes
  - Pricing
- Rota ativa destacada visualmente (a cargo do design system)

---

## Página 1: Vendas (Diretor Comercial)

**Endpoint:** `GET /api/vendas`
**Tabela fonte:** `public_gold_sales.vendas_temporais`

### KPIs (linha superior — 4 cards)

| KPI | Cálculo SQL |
|---|---|
| Receita Total | `SUM(receita_total)` |
| Total de Vendas | `SUM(total_vendas)` |
| Ticket Médio | `SUM(receita_total) / SUM(total_vendas)` |
| Clientes Únicos | `MAX(total_clientes_unicos)` agrupado por dia |

Formato: R$ com ponto de milhar e vírgula decimal.

### Gráfico 1 — Receita Diária (linha)
- X: `data_venda`
- Y: `SUM(receita_total)` GROUP BY `data_venda`

### Gráfico 2 — Receita por Dia da Semana (barras)
- X: `dia_semana_nome` (ordem: Segunda → Domingo)
- Y: `SUM(receita_total)` GROUP BY `dia_semana_nome`

### Gráfico 3 — Volume de Vendas por Hora (barras)
- X: `hora_venda` (0–23)
- Y: `SUM(total_vendas)` GROUP BY `hora_venda`

### Filtro
- Seletor de mês (`mes_venda`) — aplicado em todos os gráficos e KPIs da página

---

## Página 2: Clientes (Diretora de Customer Success)

**Endpoint:** `GET /api/clientes`
**Tabela fonte:** `public_gold_cs.clientes_segmentacao`

### KPIs (linha superior — 4 cards)

| KPI | Cálculo SQL |
|---|---|
| Total Clientes | `COUNT(*)` |
| Clientes VIP | `COUNT(*) WHERE segmento_cliente = 'VIP'` |
| Receita VIP | `SUM(receita_total) WHERE segmento_cliente = 'VIP'` |
| Ticket Médio Geral | `AVG(ticket_medio)` |

### Gráfico 1 — Distribuição por Segmento (pizza)
- Valores: `COUNT(*) GROUP BY segmento_cliente`
- Labels: VIP, TOP_TIER, REGULAR

### Gráfico 2 — Receita por Segmento (barras)
- X: `segmento_cliente`
- Y: `SUM(receita_total)` GROUP BY `segmento_cliente`

### Gráfico 3 — Top 10 Clientes por Receita (barras horizontais)
- Y: `nome_cliente` (top 10 por `ranking_receita`)
- X: `receita_total`

### Gráfico 4 — Clientes por Estado (barras)
- X: `estado`
- Y: `COUNT(*) GROUP BY estado` ordenado DESC

### Tabela detalhada
- Todas as colunas da tabela
- Filtro por segmento (dropdown): VIP | TOP_TIER | REGULAR | Todos

---

## Página 3: Pricing (Diretor de Pricing)

**Endpoint:** `GET /api/pricing`
**Tabela fonte:** `public_gold_pricing.precos_competitividade`

### KPIs (linha superior — 4 cards)

| KPI | Cálculo SQL |
|---|---|
| Total Produtos Monitorados | `COUNT(*)` |
| Mais Caros que Todos | `COUNT(*) WHERE classificacao = 'MAIS_CARO_QUE_TODOS'` |
| Mais Baratos que Todos | `COUNT(*) WHERE classificacao = 'MAIS_BARATO_QUE_TODOS'` |
| Diferença Média vs Mercado | `AVG(diferenca_percentual_vs_media)` — formato: `+X.X%` |

### Gráfico 1 — Posicionamento vs Concorrência (pizza)
- Valores: `COUNT(*) GROUP BY classificacao_preco`

### Gráfico 2 — Competitividade por Categoria (barras)
- X: `categoria`
- Y: `AVG(diferenca_percentual_vs_media)` GROUP BY `categoria`
- Coloração semântica: negativo = mais barato, positivo = mais caro (definir cores no design system)

### Gráfico 3 — Competitividade × Volume (scatter)
- X: `diferenca_percentual_vs_media`
- Y: `quantidade_total`
- Cor: `classificacao_preco`
- Tamanho do ponto: `receita_total`

### Tabela de alertas
- Apenas produtos com `classificacao = 'MAIS_CARO_QUE_TODOS'`
- Colunas: `produto_id`, `nome_produto`, `categoria`, `nosso_preco`, `preco_maximo_concorrentes`, `diferenca_percentual_vs_media`

### Filtro
- Multi-seleção de categoria — aplicado em todos os gráficos e tabela da página

---

## Requisitos Não Funcionais

- **Cache:** TanStack Query com `staleTime` alinhado à frequência do `dbt run` — dados não devem parecer mais frescos do que são
- **Erros de conexão:** tratar falhas de rede com estado de erro explícito em cada página (não deixar tela em branco)
- **Formatação:** números em formato brasileiro (R$ com ponto de milhar e vírgula decimal) em todos os cards e tabelas
- **Layout:** tela cheia aproveitando largura máxima — sem container estreito
- **Responsividade:** desktop-first; tablet aceitável; mobile fora do escopo

---

## Arquivos a Gerar

| Arquivo | Descrição |
|---|---|
| `app/api/vendas/route.ts` | Route Handler — query e retorno dos dados de vendas |
| `app/api/clientes/route.ts` | Route Handler — query e retorno dos dados de clientes |
| `app/api/pricing/route.ts` | Route Handler — query e retorno dos dados de pricing |
| `app/dashboard/vendas/page.tsx` | Página de Vendas |
| `app/dashboard/clientes/page.tsx` | Página de Clientes |
| `app/dashboard/pricing/page.tsx` | Página de Pricing |
| `lib/supabase.ts` | Client Supabase reutilizável (server-side) |
| `lib/format.ts` | Funções de formatação de números (R$, %, etc.) |
| `.env.example` | Template das variáveis de ambiente |

---

## Como Rodar

```bash
cp .env.example .env.local
# Preencher com as credenciais do Supabase
npm install
npm run dev
```

Dashboard disponível em `http://localhost:3000/dashboard/vendas`.
# Modern Data Warehouse & Analytics Dashboard

> Um projeto ponta a ponta de Engenharia de Dados, modelagem dimensional e Analytics Frontend construído com arquitetura Medalhão (Medallion Architecture) e Vibe Coding.

## 🚀 Visão Geral

Este projeto exemplifica a construção de um **Data Warehouse** completo, cobrindo todo o ciclo de vida do dado: desde a extração automatizada de um Data Lake até a visualização final em um dashboard de alta fidelidade para os times de negócios.

O ecossistema integra tecnologias modernas de dados com uma interface frontend premium, entregando **Data Marts** diretos, rápidos e visualmente impecáveis.

---

## 🏗️ Arquitetura e Engenharia de Dados

A base do projeto segue os princípios de Engenharia de Dados modernos (Modern Data Stack):

1. **Extração (AWS S3 & Python):**
   - Os dados brutos residem em um repositório Data Lake hospedado localmente/Mock no ambiente AWS S3. 
   - Scripts em Python realizam a extração (EL) e o carregamento massivo.

2. **Armazenamento (Supabase / PostgreSQL):**
   - Os dados são centralizados num banco de dados relacional PostgreSQL robusto servido na infraestrutura de nuvem do Supabase, facilitando consultas analíticas e integrações.

3. **Arquitetura Medalhão (dbt - Data Build Tool):**
   - A transformação realocada do banco (ELT) foi inteiramente orquestrada via **dbt** (Data Build Tool), dividindo as camadas em:
     - 🥉 **Bronze:** Ingestão de tabelas cruas (Raw Data) do E-commerce exatamente como chegam.
     - 🥈 **Silver:** Limpeza, padronização de tipagens, deduplicação e normalização.
     - 🥇 **Gold (Data Marts):** Criação de tabelas agregadas e orientadas a negócio prontas para consumo. Diferenciadas nas verticais de: **Sales**, **Customer Success** e **Pricing Intelligence**.

---

## 📊 Dashboard & Vibe Coding

O consumo da camada Gold foi idealizado através de desenvolvimento impulsionado por IA (**Vibe Coding**), resultando em um dashboard setorial modular feito em HTML, JS e CSS nativo:

- **Estratégia de Produto:** A construção foi totalmente orientada pelo documento de requisitos do produto (`prd.md`), mapeando perguntas de negócios cruciais (Ex.: "Quais clientes geraram mais de R$10k?").
- **Design System ("Aero"):** Utilização estrita do `design-system.html` garantindo estética premium, modo escuro nativo (Dark Mode absoluto), micro-interações GSAP (animações de staggered entrance e count-up) e design Token compliance (vetando cores padrão de template como roxo e azul comum).
- **Tooling:** Visualização avançada habilitada com **Chart.js** encapsulado em painéis interativos com Glassmorphism.

---

## 🛠️ Como Navegar pelo Projeto

### Estrutura de Pastas

* `/ecommerce/models/bronze/` → SQLs das views brutas.
* `/ecommerce/models/silver/` → Modelagem e regras de limpeza de dados.
* `/ecommerce/models/gold/` → Data Marts segmentados (`sales`, `customer_success`, `pricing`).
* `/dashboard/` → Arquivos do Dashboard Frontend.
  * `index.html`: A aplicação do dashboard completa com interatividade e gráficos JS configurados visualmente no Design System próprio.
  * `dashboard.md`: Dicionário de dados, schemas finais testados e layout estrutural para uso das queries no Front.
  * `animacoes.md`: Guidelines base para a fluidez (Motion) da aplicação GUI.

### Abrindo o Dashboard Local

Para ver a entrega final (Visualização Analytics):
1. Navegue até a pasta `dashboard`.
2. Abra o arquivo `index.html` em qualquer navegador web moderno, ou inicie um pequeno servidor local:
   ```bash
   npx serve .
   ```
3. O dashboard demonstrará a estrutura de dados renderizada por trás de três abas focadas.

---

## 📚 Tecnologias Utilizadas

- **Pipeline & DB:** AWS S3, Python, Supabase (PostgreSQL)
- **Transformação de Dados:** dbt (Data Build Tool)
- **Analytics GUI:** HTML5, CSS3, Vanilla JS, GSAP (Animações), Chart.js
- **Conceitos:** Data Warehouse, Data Mart, Medallion Architecture, Vibe Coding, Design System.

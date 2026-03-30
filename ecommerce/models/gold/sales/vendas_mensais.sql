-- ============================================
-- CAMADA GOLD: Crescimento Mensal de Vendas
-- ============================================

WITH mensal AS (
    SELECT
        ano_venda,
        mes_venda,
        SUM(receita_total) AS receita_mes,
        SUM(quantidade) AS quantidade_total,
        COUNT(DISTINCT id_venda) AS total_vendas
    FROM {{ ref('silver_vendas') }}
    GROUP BY 1, 2
),
comparativo AS (
    SELECT
        ano_venda,
        mes_venda,
        receita_mes,
        quantidade_total,
        total_vendas,
        LAG(receita_mes) OVER (ORDER BY ano_venda, mes_venda) AS receita_mes_anterior
    FROM mensal
)
SELECT
    ano_venda,
    mes_venda,
    receita_mes,
    receita_mes_anterior,
    (receita_mes - receita_mes_anterior) AS variacao_absoluta,
    ROUND(
        ((receita_mes - receita_mes_anterior) / NULLIF(receita_mes_anterior, 0)) * 100, 
        2
    ) AS percentual_crescimento,
    quantidade_total,
    total_vendas
FROM comparativo
ORDER BY ano_venda, mes_venda

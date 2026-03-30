-- ============================================
-- CAMADA BRONZE: Clientes
-- ============================================
SELECT
    id_cliente,
    nome_cliente,
    estado,
    pais,
    data_cadastro
FROM {{ source('raw', 'clientes') }}

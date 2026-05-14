WITH cte AS (
    SELECT 
        t2.product_category_name,
        COUNT(t1.order_id) AS qtd_itens_vendidos,
        round(sum(t1.freight_value+t1.price),2) as valor_total_vendas
    FROM tb_order_items t1
    LEFT JOIN tb_products t2 ON t1.product_id = t2.product_id
    GROUP BY t2.product_category_name
)
SELECT 
    product_category_name,
    qtd_itens_vendidos,
    valor_total_vendas
FROM cte
ORDER BY qtd_itens_vendidos DESC

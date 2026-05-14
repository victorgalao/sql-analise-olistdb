with sellers as (
    select t1.seller_id,
    t1.product_id,
    t2.product_category_name,
    count(DISTINCT(t1.order_id)) as qntd,
    round(sum(t1.price), 2) as valor_venda

from tb_order_items as t1

left join tb_products as t2
on t1.product_id = t2.product_id

group by 1,2,3

),

rankeamento as (
    select *,
    row_number() over(partition by seller_id order by qntd desc, valor_venda desc) as ranking
    from sellers
)

select * 
from rankeamento 
where ranking = 1
order by valor_venda desc

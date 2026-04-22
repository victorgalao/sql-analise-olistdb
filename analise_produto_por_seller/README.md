# 📊 Análise de Produto Mais Vendido por Seller

## 📌 Sobre o projeto
Este projeto tem como objetivo identificar, para cada seller, qual é o produto mais vendido, considerando:

- Quantidade de pedidos  
- Valor total de vendas  
- Categoria do produto  

A análise foi realizada utilizando SQL sobre o dataset público de e-commerce disponibilizado pela Olist.

---

## 🎯 Objetivo da análise
Encontrar o produto mais relevante por seller, priorizando:

1. Maior volume de vendas (quantidade de pedidos)  
2. Em caso de empate, maior valor total de vendas  

---

## 🛠️ Ferramentas utilizadas
- SQL  
- Funções de agregação (`COUNT`, `SUM`)  
- CTE (Common Table Expression)  
- Funções de janela (`ROW_NUMBER`)  

---

## 🧠 Estratégia
A solução foi construída em duas etapas:

1. **Agregação dos dados**
   - Cálculo da quantidade de pedidos por produto e seller  
   - Soma do valor total de vendas  

2. **Ranqueamento**
   - Utilização de `ROW_NUMBER()` para ordenar os produtos por seller  
   - Critérios:
     - Maior quantidade vendida  
     - Maior valor de vendas (desempate)  

---

## 📂 Query

```sql
with sellers as (
    select 
        t1.seller_id,
        t1.product_id,
        t2.product_category_name,
        count(distinct t1.order_id) as qntd,
        round(sum(t1.price), 2) as valor_venda
    from tb_order_items as t1
    left join tb_products as t2
        on t1.product_id = t2.product_id
    group by 1,2,3
),

rankeamento as (
    select *,
        row_number() over (
            partition by seller_id 
            order by qntd desc, valor_venda desc
        ) as ranking
    from sellers
)

select *
from rankeamento
where ranking = 1
order by valor_venda desc;
```

---

## 📊 Possíveis aplicações
- Identificação de produtos estratégicos por seller  
- Apoio a decisões comerciais  
- Priorização de estoque e catálogo  
- Análise de performance de vendas  

---

## 📁 Dataset
- Olist E-commerce Public Dataset  

---

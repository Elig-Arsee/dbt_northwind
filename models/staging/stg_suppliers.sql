with
    products as (
        select *
        from {{source("northwind", "suppliers")}}
    )

select *
from products
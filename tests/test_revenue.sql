{{ config(error_if = '>10') }} --também pode usar a conf. severity = 'warn' ou outras neste link https://docs.getdbt.com/reference/resource-configs/severity
with
    orders as (
        select *
        from {{ref("stg_orders")}}
    )

    , order_details as (
        select *
        from {{ref("stg_order_details")}}
    )

    , test_that as (
        select order_date, sum(unit_price*quantity) as revenue
        from orders
        left join order_details on orders.order_id = order_details.order_id
        group by order_date
        order by order_date
    )

    select *
    from test_that
    --where revenue = 0

    
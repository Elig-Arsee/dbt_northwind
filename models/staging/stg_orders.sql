{{config(materialized = 'incremental', unique_key = 'order_id')}}

with
    orders as (
        select *
        from {{source('northwind', 'orders')}}
        {% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  -- (uses > to include records whose timestamp occurred since the last run of this model)
  where order_date > (select max(order_date) from {{ this }})

        {% endif %}
    )

    select *
    from orders
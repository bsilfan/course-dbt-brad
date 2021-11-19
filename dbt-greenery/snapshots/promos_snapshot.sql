{% snapshot promos_snapshot %}

    {{
        config(
          target_schema='snapshots',
          strategy='check',
          unique_key='promo_id',
          check_cols=['discout', 'status'],
        )
    }}

    select * from {{ source('tutorial', 'promos') }}

{% endsnapshot %}
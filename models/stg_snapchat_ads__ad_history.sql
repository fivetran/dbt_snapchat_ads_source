
with base as (

    select * 
    from {{ ref('stg_snapchat_ads__ad_history_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_snapchat_ads__ad_history_tmp')),
                staging_columns=get_ad_history_columns()
            )
        }}
    from base
),

final as (
    
    select 
        id as ad_id,
        name as ad_name,
        cast (created_at as {{ dbt_utils.type_timestamp() }}) as created_at,
        ad_squad_id,
        creative_id,
        cast (_fivetran_synced as {{ dbt_utils.type_timestamp() }}) as _fivetran_synced,
        cast (updated_at as {{ dbt_utils.type_timestamp() }}) as updated_at
    from fields
),

most_recent as (

    select 
        *,
        row_number() over (partition by ad_id order by _fivetran_synced desc) = 1 as is_most_recent_record
    from final
)

select * 
from most_recent

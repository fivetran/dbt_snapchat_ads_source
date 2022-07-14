
with base as (

    select * 
    from {{ ref('stg_snapchat_ads__ad_account_history_tmp') }}
),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_snapchat_ads__ad_account_history_tmp')),
                staging_columns=get_ad_account_history_columns()
            )
        }}
    from base
),

final as (
    
    select 
        id as ad_account_id,
        name as ad_account_name,
        cast (created_at as {{ dbt_utils.type_timestamp() }}) as created_at,
        advertiser, 
        currency,
        _fivetran_synced,
        timezone
    from fields
),

most_recent as (

    select 
        *,
        row_number() over (partition by ad_account_id order by updated_at desc) = 1 as is_most_recent_record
    from final
)

select * 
from most_recent

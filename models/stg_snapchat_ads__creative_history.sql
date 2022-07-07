
with base as (

    select * 
    from {{ ref('stg_snapchat_ads__creative_history_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_snapchat_ads__creative_history_tmp')),
                staging_columns=get_creative_history_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        id as creative_id,
        ad_account_id,
        name as creative_name,
        web_view_url as url,
        cast (_fivetran_synced as {{ dbt_utils.type_timestamp() }}) as _fivetran_synced
    from fields
), 

most_recent as (

    select 
        *,
        row_number() over (partition by creative_id order by _fivetran_synced desc) =1 as is_most_recent_record
    from final

)

select * from most_recent

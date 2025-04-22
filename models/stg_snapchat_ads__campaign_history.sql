{{ config(enabled=var('ad_reporting__snapchat_ads_enabled', true)) }}

with base as (

    select * 
    from {{ ref('stg_snapchat_ads__campaign_history_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_snapchat_ads__campaign_history_tmp')),
                staging_columns=get_campaign_history_columns()
            )
        }}

        {{ fivetran_utils.source_relation(
            union_schema_variable='snapchat_ads_union_schemas', 
            union_database_variable='snapchat_ads_union_databases') 
        }}

    from base

),

final as (

    select
        source_relation,
        id as campaign_id,
        ad_account_id,
        cast(created_at as {{ dbt.type_timestamp() }}) as created_at,
        name as campaign_name,
        cast(_fivetran_synced as {{ dbt.type_timestamp() }}) as _fivetran_synced,
        cast(updated_at as {{ dbt.type_timestamp() }}) as updated_at,
        cast(daily_budget_micro as {{ dbt.type_int() }}) as daily_budget_micro,
        cast(start_time as {{ dbt.type_timestamp() }}) as start_time,
        cast(end_time as {{ dbt.type_timestamp() }}) as end_time,
        cast(lifetime_spend_cap_micro as {{ dbt.type_int() }}) as lifetime_spend_cap_micro,
        status,
        objective,
        row_number() over (partition by source_relation, id order by _fivetran_synced desc) = 1 as is_most_recent_record
    from fields

)

select * 
from final

ADD source_relation WHERE NEEDED + CHECK JOINS AND WINDOW FUNCTIONS! (Delete this line when done.)

{{ config(enabled=var('ad_reporting__snapchat_ads_enabled', true)) }}

{{
    fivetran_utils.union_data(
        table_identifier='creative_url_tag_history', 
        database_variable='snapchat_ads_database', 
        schema_variable='snapchat_ads_schema', 
        default_database=target.database,
        default_schema='snapchat_ads',
        default_variable='creative_url_tag_history_source',
        union_schema_variable='snapchat_ads_union_schemas',
        union_database_variable='snapchat_ads_union_databases'
    )
}}
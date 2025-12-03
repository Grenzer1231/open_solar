select
    source,
    count(*) as record_count
from {{ ref('my_first_dbt_model') }}
group by 1

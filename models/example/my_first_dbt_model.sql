with base as (
    select 1 as id, 'solar'::text as source
)

select
    id,
    source,
    current_timestamp as created_at
from base

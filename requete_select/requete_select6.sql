/*
fil d'actualité: post des 3 derniers jours trier par date
*/

select 
post.*
from post
inner join account as sender on post.id_account=sender.id_account
where posting_date >= (NOW() - INTERVAL '3' DAY)
and posting_date < (NOW() - INTERVAL '1' DAY)
or (
    extract(year from posting_date) = extract(year from NOW())
    and extract(month from posting_date) = extract(month from NOW())
    and extract(day from posting_date) = extract(day from NOW())
    and (
        extract(hour from posting_time) <= extract(hour from NOW())
        or (
            extract(hour from posting_time) = extract(hour from NOW())
            and extract(minute from posting_time) <= extract(minute from NOW())
        )
        or (
            extract(hour from posting_time) = extract(hour from NOW())
            and extract(minute from posting_time) = extract(minute from NOW())
            and extract(SECOND from posting_time) <= extract(SECOND from NOW())
        )
    )
)
order by posting_date desc;
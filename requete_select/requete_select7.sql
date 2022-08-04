/*
fil d'actualité: post des 3 derniers jours trier par le nombre de reaction positive
*/

create TEMPORARY VIEW recent_post as
select 
post.*,
reaction_type,
count(reaction_type) as nombre_reactions_positives
from post
inner join account as sender on post.id_account=sender.id_account
inner join react_post on react_post.id_post=post.id_post
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
group by reaction_type, post.id_post, post.posting_date, post.posting_time, post.post_content, post.id_account
order by nombre_reactions_positives desc;



create TEMPORARY VIEW recent_positif_post as
select
reaction_type,
id_post, 
posting_date, 
posting_time, 
post_content, 
id_account,
nombre_reactions_positives
from recent_post
where reaction_type='love'
or reaction_type='like';



select
id_post, 
posting_date, 
posting_time, 
post_content, 
id_account,
sum(nombre_reactions_positives) as nombre_reactions_positives
from recent_positif_post
group by
nombre_reactions_positives,
id_post, 
posting_date, 
posting_time, 
post_content, 
id_account
order by nombre_reactions_positives desc;
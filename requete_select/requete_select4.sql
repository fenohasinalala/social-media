/*
MP entre deux comptes (id=1 et id=2), trier par date d'envoie des messages
*/

create TEMPORARY VIEW private_message as
select 
sender.first_name as sender_first_name,
receaver.first_name as receaver_first_name,
message.message_datetime,
message.message_content,
message.seen_datetime
from message
inner join account as receaver on message.id_account_receiver=receaver.id_account
inner join account as sender on message.id_account_sender=sender.id_account
where id_account_receiver=1
and id_account_sender=2

union
select 
sender.first_name as sender_first_name,
receaver.first_name as receaver_first_name,
message.message_datetime,
message.message_content,
message.seen_datetime
from message
inner join account as receaver on message.id_account_receiver=receaver.id_account
inner join account as sender on message.id_account_sender=sender.id_account
where id_account_receiver=2
and id_account_sender=1;

 

select 
*
from private_message
order by message_datetime desc;
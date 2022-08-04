/*
les comptes les plus actifs selon le nombre de msg envoyé dans la liste d'amie d'un compte lui y compris (id=1)
*/

create TEMPORARY VIEW friend_list1 as
select 
receaved.id_account,
receaved.first_name, 
receaved.last_name,
receaved.nickname,
send_invite.friendship_birthday
from send_invite
inner join account as receaved on send_invite.id_account_receiver=receaved.id_account
where id_account_sender=1
and is_accepted = true

union
select 
sender.id_account, 
sender.first_name, 
sender.last_name,
sender.nickname,
send_invite.friendship_birthday
from send_invite
inner join account as receaver on send_invite.id_account_receiver=receaver.id_account
inner join account as sender on send_invite.id_account_sender=sender.id_account
where id_account_receiver=1
and is_accepted = true;



select 
sender.first_name as sender_first_name,
count(message_content) as message_count
from message
inner join account as sender on message.id_account_sender=sender.id_account
where sender.id_account=1
group by sender_first_name

union
select 
sender.first_name as sender_first_name,
count(message_content) as message_count
from message
inner join friend_list1 as sender on message.id_account_sender=sender.id_account
group by sender_first_name
order by message_count desc;
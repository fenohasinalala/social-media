/*
9 amies recent d'un compte (id=1), trier par date d'ajout
*/

create TEMPORARY VIEW friend_list as
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
first_name, 
last_name
from friend_list
order by friendship_birthday desc 
limit 9;
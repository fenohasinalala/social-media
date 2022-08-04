/*
liste d'amies d'un compte (id=1)
*/

select 
receaved.first_name, 
receaved.last_name,
receaved.nickname,
receaved.profile_pic,
send_invite.friendship_birthday

from send_invite

inner join account as receaved on send_invite.id_account_receiver=receaved.id_account

where id_account_sender=1
and is_accepted = true

union
select 
sender.first_name, 
sender.last_name,
sender.nickname,
sender.profile_pic,
send_invite.friendship_birthday

from send_invite

inner join account as receaver on send_invite.id_account_receiver=receaver.id_account
inner join account as sender on send_invite.id_account_sender=sender.id_account

where id_account_receiver=1
and is_accepted = true
;
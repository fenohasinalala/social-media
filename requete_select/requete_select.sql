/*
invitations envoyées par un compte (id=1), non accepté
*/

select 
receaved.first_name as first_name_receiver, 
receaved.last_name as last_name_receiver

from send_invite

inner join account as receaved on id_account_receiver=id_account

where id_account_sender=1
and is_accepted = false;

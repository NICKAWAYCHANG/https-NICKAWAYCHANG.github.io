select * from Wallet 
select * from Game

-----------------------��id�d�߷|���C�����Q�å[�`SUM
select 
	w.member_id, g.game_type, SUM(bonus_point) as [total_bonus]
from Wallet w
join Game g on w.game_id = g.id
 
	where w.source_type = '�C��'
group by w.member_id, g.game_type

select * from Wallet 
	where source_type = '�C��' and member_id = 2

	select * from Wallet w 
	join Game g on w.game_id = g.id
	where w.source_type = '�C��' and g.game_type = '�Ķ��]����'

select * from Member_Game mg 
join Member m on mg.member_id = m.id 
	join Game g on mg.game_id = g.id 
	join Wallet w on w.game_id = g.id 
where m.id = 2 and g.game_type = '�Ķ��]����' and g.game_score is not null

select m.id, m.[name], g.game_type, g.game_score, g.create_at, w.bonus_point from Member_Game mg 
join Member m on mg.member_id = m.id 
	join Game g on mg.game_id = g.id 
	join Wallet w on w.game_id = g.id 
where m.id = 2 and g.game_type = '�Ķ��]����' and g.game_score is not null


select * from Member_Game mg 
join Member m 
on mg.member_id = m.id 
join Game g 
on mg.game_id = g.id 
join Wallet w 
on w.game_id = g.id 
where m.id = 1 and g.game_type = '�Ķ��]����' and g.game_score is not null

insert Game (game_type, check_status, game_score)
	values
		('�Ķ��]����', 1, 800),
		('�Ķ��]����', 1, 1200),
		('�Ķ��]����', 1, 2000);

INSERT INTO Member_Game(member_id, game_id)
VALUES
(1, 1002),
(2, 1003),
(1, 1004);


INSERT INTO Wallet(source_type, wallet_amount, bonus_point, credit_card_amount, member_id, game_id)
VALUES
('�C��', 0, 8, 0, 1, 1002),
('�C��', 0, 12, 0, 2, 1003),
('�C��', 0, 20, 0, 1, 1004);



--INSERT INTO Member_Campaign(member_id, campaign_id)
--VALUES
--(1, 1),
--(1, 2),
--(2, 1);

--/*����*/
--CREATE TABLE Campaign(
--id int primary key identity(1,1),
--title nvarchar(50),
--content nvarchar(200),
--max_total int,
--join_count int,
--begin_at datetime not null,
--end_at datetime not null,
--image varbinary(max),
--button_switch bit not null,
--employee_id int,
--foreign key (employee_id) references Employee(id) on delete set null,
--create_at datetime not null default getDate(),
--update_at datetime not null default getDate()
--);
--GO


------------------------------------------------------------------------------

--/*����*/
--CREATE TABLE Campaign(
--id int primary key identity(1,1),
--title nvarchar(50),
--content nvarchar(200),
--max_total int,
--join_count int,
--begin_at datetime not null,
--end_at datetime not null,
--image varbinary(max),
--button_switch bit not null,
--employee_id int,
--foreign key (employee_id) references Employee(id) on delete set null,
--create_at datetime not null default getDate(),
--update_at datetime not null default getDate()
--);
--GO

----------------------------------------------------------------------

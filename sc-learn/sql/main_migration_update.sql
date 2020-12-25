drop procedure if exists insert_menu;
DELIMITER ;;
create procedure insert_menu(in p_code varchar(128), in uuid char(32), in code varchar(128), in name varchar(16), in state tinyint(1))
begin
	DECLARE pid int;
	select m.id into pid from t_menu m where m.code = p_code;
	insert into t_menu(pid, uuid, code, name, state, created_at, updated_at) values(pid, uuid, code, name, state, sysdate(), sysdate());
end
;;
DELIMITER ;

call insert_menu(null, 'e5cb516ca1434112b5135220bbe31a10', 'm', '云众迭代交付', 0);
call insert_menu('m', '56da276be40f4b2290a5436848a5e031', 'm:user', '用户中心', 0);
call insert_menu('m:user', '5d996672e90d472d93aa2cfd37e74f01', 'm:user:search', '搜索用户', 0);
call insert_menu('m:user', 'c49dea29cf3046a5b551b0143b464349', 'm:user:show', '查看用户', 0);
call insert_menu('m:user', 'c357d6208e81474e8c9191e3179eec48', 'm:user:add', '添加用户', 0);
call insert_menu('m:user', 'fb47425d7db24cdbb553beae6d77661e', 'm:user:update', '更新用户', 0);
call insert_menu('m:user', 'e911436c140f411abb3e9639ee761b00', 'm:user:profile', '个人中心', 0);
call insert_menu('m:user', '316b2bc717994d5e88193f7443789fd6', 'm:user:delete', '删除用户', 0);
call insert_menu('m:user', '619911e18944496881943d2fdd949e6a', 'm:user:logout', '退出', 0);

insert into t_role(uuid, code, name, state, created_at, updated_at)
values('cbe068a492d34114b35d58425c83ba20', 'admin', '管理员', 0, sysdate(), sysdate());
insert into t_role(uuid, code, name, state, created_at, updated_at)
values('0a46d79058434b808dfb7ce8452a7be8', 'default', '普通用户', 0, sysdate(), sysdate());

insert into t_user(uuid, name, nickname, email, logo_path, password, state, created_at, updated_at)
values('3024939e84c64cc2ac48d9c236284378', 'yzkx', '云众可信', 'yzkx@cloudcrowd.com.cn', 'images/user/default_logo.png', '26e2f551e46c5adbe919f0a8c29eb9bac3c2c38cded9470b59154621', 0, sysdate(), sysdate());

drop procedure if exists insert_user_role;
DELIMITER ;;
create procedure insert_user_role(in user_name varchar(64), in role_code varchar(64))
begin
	DECLARE user_id int;
	DECLARE role_id int;
	select id into user_id from t_user where name = user_name;
	select id into role_id from t_role where code = role_code;
	insert into t_user_role(user_id, role_id, state, created_at, updated_at) values(user_id, role_id, 0, sysdate(), sysdate());
end
;;
DELIMITER ;

call insert_user_role('yzkx', 'admin');
call insert_user_role('yzkx', 'default');

drop procedure if exists insert_role_menu;
DELIMITER ;;
create procedure insert_role_menu(in role_code varchar(64), in menu_code varchar(128))
begin
	DECLARE role_id int;
	DECLARE menu_id int;
	select id into role_id from t_role where code = role_code;
	select id into menu_id from t_menu where code = menu_code;
	insert into t_role_menu(role_id, menu_id, state, created_at, updated_at) values(role_id, menu_id, 0, sysdate(), sysdate());
end
;;
DELIMITER ;

call insert_role_menu('admin', 'm:user:search');
call insert_role_menu('admin', 'm:user:show');
call insert_role_menu('admin', 'm:user:add');
call insert_role_menu('admin', 'm:user:update');
call insert_role_menu('admin', 'm:user:delete');
call insert_role_menu('admin', 'm:team:add');
call insert_role_menu('admin', 'm:team:update');
call insert_role_menu('admin', 'm:team:delete');

call insert_role_menu('default', 'm:user:profile');
call insert_role_menu('default', 'm:user:logout');
call insert_role_menu('default', 'm:team:search');
call insert_role_menu('default', 'm:team:show');
call insert_role_menu('default', 'm:team:quit');
call insert_role_menu('default', 'm:canvas:search');
call insert_role_menu('default', 'm:canvas:show');
call insert_role_menu('default', 'm:iter:search');
call insert_role_menu('default', 'm:iter:show');
call insert_role_menu('default', 'm:task:finish');
call insert_role_menu('default', 'm:taskowner:add');
call insert_role_menu('default', 'm:taskowner:delete');

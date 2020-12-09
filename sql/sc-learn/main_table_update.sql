create table t_user
(
   id                   int(11) not null auto_increment,
   uuid                 char(32),
   name                 varchar(64),
   nickname             varchar(64),
   email                varchar(128),
   logo_path            varchar(255),
   password             varchar(64),
   state                tinyint(1),
   created_at           datetime,
   updated_at           datetime,
   primary key (id)
);
create unique index USER_UUID_UNIQ_IND on t_user(uuid);
create unique index USER_NAME_UNIQ_IND on t_user(name);
create unique index USER_EMAIL_UNIQ_IND on t_user(email);
create index USER_STATE_IND on t_user(state);

create table t_role
(
   id                   int(11) not null auto_increment,
   uuid                 char(32),
   code                 varchar(64),
   name                 varchar(16),
   state                tinyint(1),
   created_at           datetime,
   updated_at           datetime,
   primary key (id)
);
create unique index ROLE_UUID_UNIQ_IND on t_role(uuid);
create unique index ROLE_CODE_UNIQ_IND on t_role(code);

create table t_user_role
(
   id                   int(11) not null auto_increment,
   user_id              int(11),
   role_id              int(11),
   state                tinyint(1),
   created_at           datetime,
   updated_at           datetime,
   primary key (id)
);
create unique index UR_UID_RID_UNIQ_IND on t_user_role(user_id, role_id);

create table t_menu
(
   id                   int(11) not null auto_increment,
   pid                  int(11),
   uuid                 char(32),
   code                 varchar(128),
   name                 varchar(16),
   link                 text,
   state                tinyint(1),
   created_at           datetime,
   updated_at           datetime,
   primary key (id)
);
create index MENU_PID_IND on t_menu(pid);
create unique index MENU_UUID_UNIQ_IND on t_menu(uuid);
create unique index MENU_CODE_UNIQ_IND on t_menu(code);

create table t_role_menu
(
   id                   int(11) not null auto_increment,
   role_id              int(11),
   menu_id              int(11),
   state                tinyint(1),
   created_at           datetime,
   updated_at           datetime,
   primary key (id)
);
create unique index RM_RID_MID_UNIQ_IND on t_role_menu(role_id, menu_id);

create table t_email_template(
   id                   int(11) not null auto_increment,
   uuid                 char(32),
   msg_type             varchar(128),
   content              text,
   state                tinyint(1),
   created_at           datetime,
   updated_at           datetime,
   primary key (id)
);
create unique index MAIL_TEMP_UUID_UNIQ_IND on t_email_template(uuid);
create unique index MAIL_TEMP_MTYPE_UNIQ_IND on t_email_template(msg_type);

create table t_message_template(
   id                   int(11) not null auto_increment,
   uuid                 char(32),
   msg_type             varchar(128),
   content              text,
   state                tinyint(1),
   created_at           datetime,
   updated_at           datetime,
   primary key (id)
);
create unique index MSG_TEMP_UUID_UNIQ_IND on t_message_template(uuid);
create unique index MSG_TEMP_MTYPE_UNIQ_IND on t_message_template(msg_type);

create table t_message(
   id                   int(11) not null auto_increment,
   uuid                 char(32),
   title                varchar(128),
   content              text,
   msg_type             varchar(128),
   sender_uuid          char(32),
   sender               varchar(128),
   receiver_uuid        char(32),
   receiver             varchar(128),
   state                tinyint(1),
   created_at           datetime,
   updated_at           datetime,
   primary key (id)
);
create unique index MSG_UUID_UNIQ_IND on t_message(uuid);
create index MSG_MSG_TYPE_IND on t_message(msg_type);
create index MSG_SD_UUID_IND on t_message(sender_uuid);
create index MSG_RCV_UUID_IND on t_message(receiver_uuid);
create index MSG_STATE_IND on t_message(state);

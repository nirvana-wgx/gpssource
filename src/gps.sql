--车辆管理
 
alter table relation
add column tablename varchar(100);
 
 
 
create table menu(
        code VARCHAR2(8) not null,
       name VARCHAR2(100) not null,
       url VARCHAR2(50) ,
       parentCode VARCHAR2(8) not null
    );
insert into menu 
value ('1','车辆管理','/leftMenu.page?parentCode=1','0');
insert into menu 
value ('11','车辆一览','','1');
insert into menu 
value ('12','新增车辆','','1');
insert into menu 
value ('13','机械种类配置','','1');
insert into menu 
value ('14','机械类型配置','','1');
update menu  set url ='jsp/vechiclemanager/list.page' where code=11;
update menu  set url ='jsp/vechiclemanager/modify.page' where code=12;
update menu  set url ='jsp/vechiclemanager/query.page?d_type=jxzl' where code=13;
update menu  set url ='jsp/vechiclemanager/query.page?d_type=jxlx' where code=14;
update menu  set name ='机械类型配置' where code=14;

insert into menu 
value ('2','账户管理','/leftMenu.page?parentCode=2','0');
insert into menu 
value ('21','创建账户','','2');
insert into menu 
value ('22','账户修改','','2');
insert into menu 
value ('23','账户管理','','2');
insert into menu 
value ('24','密码修改','','2');
update menu  set url ='jsp/accountmanager/update.page?type=add' where code=21;
update menu  set url ='jsp/accountmanager/update.page?type=update' where code=22;
update menu  set url ='jsp/accountmanager/query.page' where code=23;
update menu  set url ='jsp/accountmanager/update_password.jsp' where code=24;

insert into menu 
value ('3','车辆分布','/leftMenu.page?parentCode=3','0');
insert into menu 
value ('31','车辆分布','','3');
 insert into menu 
value ('32','电子围栏','','3');
 insert into menu 
value ('33','越界报警','','3');
update menu  set url ='jsp/vehicledistr/distrbute.page' where code=31;
update menu  set url ='jsp/vehicledistr/elecFenc.page' where code=32;
update menu  set url ='jsp/vehicledistr/outAlarm.page' where code=33;
 

insert into menu 
value ('4','统计分析','/leftMenu.page?parentCode=4','0');
 insert into menu 
value ('41','日工作时间统计','','4');
 
  insert into menu 
value ('42','月工作时间统计','','4');
 
  insert into menu 
value ('43','日里程统计','','4');
 insert into menu 
value ('44','月里程统计','','4');
update menu  set url ='jsp/statisanaly/DeviceInf.page?type=1' where code=41;
update menu  set url ='jsp/statisanaly/DeviceInf.page?type=2' where code=42;
update menu  set url ='jsp/statisanaly/DeviceInf.page?type=3' where code=43;
update menu  set url ='jsp/statisanaly/DeviceInf.page?type=4' where code=44;

--delete from menu where code in(21,22)
--清除表除了root的用户
select * from account where name <>  '%root%';
--delete  from account where name like '%root%';
--delete from account  where aid ='201306141138371030'
update account  set pass='1' , parentname='rootParent';
update account set aid='2013061011194952649' where name='root';
select concat(date_format(now(),'%Y%m%d%H%i%S'),ROUND(ROUND(RAND(),5)*100000))

select * from account  order by  aid limit 6,5 ;
 
 --创建数据字典表
--drop table dictionary;
select * from dictionary ;
 create table dictionary(
	 d_code  varchar(20) not null primary key,
	 d_value varchar(50),
	 d_type  varchar(10),
	 d_typeName varchar(100) 
 );
 --drop table account_dictionary;
 select * from account_dictionary
create table account_dictionary(
account_name varchar(100) not null,
d_type  varchar(10) not null,
d_code varchar(20) not null
);

select * from dictionary t where 1=1
      		and exists (
      		select t1.d_code from account_dictionary t1 where t1.account_name ='root' and t.d_code=t1.d_code
      		)
 --可选机械种类列表
 insert into dictionary 
 values ('jxzl01','挖掘机','jxzl','可选机械种类列表');
 insert into dictionary 
 values ('jxzl02','推土机','jxzl','可选机械种类列表');
 
 --车辆查看状态
 insert into dictionary 
 values ('clzt01','车辆测试','clzt','车辆查看状态');
 insert into dictionary 
 values ('clzt02','车辆入库','clzt','车辆查看状态');
  insert into dictionary 
 values ('clzt03','车辆销售','clzt','车辆查看状态');
 
 --可选机械类型列表 
 insert into dictionary 
 values ('BM01','BM01','jxlx','可选机械类型列表');
 insert into dictionary 
 values ('BM02','BM02','jxlx','可选机械类型列表');
 
  --下发命令设置 
 insert into dictionary 
 values ('GE0001','信息立即回传命令','xfml','下发命令设置 ');
 insert into dictionary 
 values ('GE0003','系统重启','xfml','下发命令设置 ');
 insert into dictionary 
 values ('GE0020','系统重启次数回传','xfml','下发命令设置 ');
 --锁车命令
 insert into dictionary 
 values ('LK0001','解锁','scml','锁车命令 ');
  insert into dictionary 
 values ('LK3011','第一路立即锁车','scml','锁车命令 ');
  insert into dictionary 
 values ('LK3013','第一路判断锁车','scml','锁车命令 ');
   insert into dictionary 
 values ('LK3021','第二路立即锁车','scml','锁车命令 ');
  insert into dictionary 
 values ('LK3023','第二路判断锁车','scml','锁车命令 ');
  insert into dictionary 
 values ('LK3031','第三路立即锁车','scml','锁车命令 ');
  insert into dictionary 
 values ('LK3033','第三路判断锁车','scml','锁车命令 ');
  insert into dictionary 
 values ('LK3041','第四路立即锁车','scml','锁车命令 ');
  insert into dictionary 
 values ('LK3043','第四路判断锁车','scml','锁车命令 ');
  insert into dictionary 
 values ('LK30A1','所有路立即锁车','scml','锁车命令 ');
  insert into dictionary 
 values ('LK30A3','所有路判断锁车','scml','锁车命令 ');
 --自锁车命令

 insert into dictionary 
 values ('LK5001','所有类型自锁车','zscml','自锁车命令 ');
  insert into dictionary 
 values ('LK5005','总线通信异常','zscml','自锁车命令 ');
  insert into dictionary 
 values ('LK5011','GPS天线异常','zscml','自锁车命令 ');
  insert into dictionary 
 values ('LK5015','开壳','zscml','自锁车命令 ');
  insert into dictionary 
 values ('LK5021','长时间不入网','zscml','自锁车命令 ');
--设备设置
 insert into dictionary 
 values ('GE3007','定时回传时间间隔设置','sbsz','设备设置 ');
  insert into dictionary 
 values ('GE3011','工作小时设置','sbsz','设备设置 ');
--其他设置 
insert into dictionary 
 values ('GE3001','ID设置','qtsz','其他设置 ');
 
 insert into dictionary 
 values ('GE3005','回传方式设置','qtsz','其他设置');
 
 insert into dictionary 
 values ('GE3015','实时时间设置','qtsz','其他设置');
 
 insert into dictionary 
 values ('GE3017','休眠时间设置','qtsz','其他设置 ');
 
 insert into dictionary 
 values ('GE3021','不入网自锁车时间间隔设置','qtsz','其他设置');
 
 insert into dictionary 
 values ('GE3013','监控状态设置','qtsz','其他设置');
 --回传消息显示列表
insert into dictionary 

select displayitem ,displayitem,'xslb','回传消息显示列表' from displayitems where account='root';
select distinct d_type,d_typeName from dictionary t where 1=1

--messagebm添加位置信息字段
alter table messagebm add positioninfo varchar(200);
--messagebm添加是否越界字段
alter table messagebm add isoutline varchar(1);

--2013-6-24
CREATE SEQUENCE   SEQ_ACCOUNT  MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
CREATE SEQUENCE   SEQ_LOG MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;

/**===========================新增表===================================**/
--ADD BY WGX
--DISCRITION:最新车辆数据信息表
--2013-06-24
-- Create table
create table VEHICLEINFNEW
(
  MBMID               VARCHAR2(32) not null,
  VEHICLEID           VARCHAR2(30) not null,
  DEVICEID            VARCHAR2(10) not null,
  INFOTYPE            VARCHAR2(30) not null,
  RECEIVETIME         DATE not null,
  GPSLOCATE           VARCHAR2(10) not null,
  GPSSHELL            VARCHAR2(10) not null,
  GPSANTENNA          VARCHAR2(10) not null,
  GPSRELAY4           VARCHAR2(10) not null,
  GPSRELAY3           VARCHAR2(10) not null,
  GPSRELAY2           VARCHAR2(10) not null,
  GPSRELAY1           VARCHAR2(10) not null,
  GPSSLEEP            VARCHAR2(10) not null,
  GPSMINITOR          VARCHAR2(10) not null,
  GPSPATTERN          VARCHAR2(20) not null,
  GPSAUTOLOCKTWOMONTH VARCHAR2(4) not null,
  GPSAUTOLOCKSHELL    VARCHAR2(10) not null,
  GPSAUTOLOCKANTENNA  VARCHAR2(10) not null,
  GPSAUTOLOCKMAIN     VARCHAR2(10) not null,
  CARENGINE           VARCHAR2(10) not null,
  CARKEY              VARCHAR2(10) not null,
  SATELLITEVISIBLE    VARCHAR2(4) not null,
  SATELLITEUSABLE     VARCHAR2(4) not null,
  LATITUDE            VARCHAR2(15) not null,
  LONGITUDE           VARCHAR2(15) not null,
  SPEED               VARCHAR2(20) not null,
  LOCATION            VARCHAR2(10) not null,
  LOCATETIME          DATE not null,
  VOLTAGE             VARCHAR2(10) not null,
  WORKTIME            VARCHAR2(20) not null,
  WATERTEMPERATURE    VARCHAR2(10) not null,
  OILTEMPERATURE      VARCHAR2(10) not null,
  OILPRESSURE         VARCHAR2(10) not null,
  OILLEVEL            VARCHAR2(10) not null,
  ROTARYSPEED         VARCHAR2(15) not null,
  WARNYS              VARCHAR2(4) not null,
  WARNCD              VARCHAR2(4) not null,
  WARNRY              VARCHAR2(4) not null,
  WARNYY              VARCHAR2(4) not null,
  WARNSW              VARCHAR2(4) not null,
  WARNYW              VARCHAR2(4) not null,
  WARNYL              VARCHAR2(4) not null,
  WARNKL              VARCHAR2(4) not null,
  WARNDYDY            VARCHAR2(4) not null,
  COLLECTTIME         DATE not null,
  BACKUP              VARCHAR2(10) not null,
  ENVTEMPERATURE      VARCHAR2(10) not null,
  OUTALARM            VARCHAR2(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table VEHICLEINFNEW
  add constraint VEHICLEINFNEW_PRIMARYKEY primary key (MBMID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate indexes 
create index VEHICLEINFNEW_DEVICEID on VEHICLEINFNEW (DEVICEID)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
  
  --车辆保养信息
create table maintenance (
          maid varchar2(20) not null primary key,
          vehicleid varchar2(30)  ,
          fitting varchar2(50)  ,
          selltime date  ,
          expiretime date  ,
          maintenancetime date,
          action varchar2(20)  ,
          isovertime varchar2(1)  ,
          state varchar2(10)  ,
          creater varchar2(15)  ,
          createtime date  ,
          remark varchar2(100)
        );

create index maintenance_vehicleid on maintenance (vehicleid)
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
--2013-6-25  创建主键车辆主键序列号
 CREATE SEQUENCE   SEQ_RELATION MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
 
 --2013-6-26 修改车辆表字段、入库与销售的字段
		add   storagecreator varchar2(100);
        alter table relation 
        add    storagetime varchar2(100);
        alter table relation 
        add    storageremark varchar2(100);
 		alter table relation 
        add    buyname varchar2(100);
        alter table relation 
        add    buytime varchar2(100);
        alter table relation 
        add    payway varchar2(100);
        alter table relation 
        add    prepay varchar2(100);
        alter table relation 
        add    paymonth varchar2(100);
        alter table relation 
        add    payterm varchar2(100);
        alter table relation 
        add    paywarndate varchar2(100);
        --创建还款表主键与保养表主键
        CREATE SEQUENCE   SEQ_REFUND MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
        CREATE SEQUENCE   SEQ_MAINTENANCE MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
        --创建还款表
         create table refund(
            rid int not null primary key,  
    	      frid int not null,  
    	      refundmoney  varchar2(200) , 
    	      refundtime  varchar2(200) ,  
    	      remainmoney  varchar2(200) 
        );
        
--ADD BY WGX 2013-06-26 越界报警表    
-- Create table
create table OUTAREAALARM
(
  ID        VARCHAR2(32) not null,
  VEHICLEID VARCHAR2(30) not null,
  DEVICEID  VARCHAR2(10) not null,
  TYPE      VARCHAR2(20) not null,
  MODEL     VARCHAR2(20) not null,
  OWNERNAME VARCHAR2(20),
  ALARMTIME VARCHAR2(26),
  CREATTIME VARCHAR2(26)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table OUTAREAALARM
  add constraint OUTAREAALARMID primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
  
  --2013-06-28 创建表
		CREATE SEQUENCE   seq_commandorigin MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
		-- 说明 这张表有关键字作为字段 被我删除，重新创建
		drop table commandorigin;
       create table commandorigin(
         coid int not null primary key,
         device varchar2(100) ,
         sim varchar2(100) ,
         command varchar2(100) ,
         description varchar2(100) ,
         sendtime varchar2(100) ,
         state varchar2(100) ,
         username varchar2(100) 
       )
   --电子围栏绑定配置表
        -- Create table
        create table EFENCALARM
        (
          ID         VARCHAR2(32) not null,
          DEVICEID   VARCHAR2(30),
          FENNAME    VARCHAR2(50),
          FENCONTENT VARCHAR2(500),
          CREATTIME  VARCHAR2(30),
          TYPE       VARCHAR2(1) default '1' not null
        )
        tablespace USERS
          pctfree 10
          initrans 1
          maxtrans 255
          storage
          (
            initial 64K
            minextents 1
            maxextents unlimited
          );
        -- Add comments to the columns 
        comment on column EFENCALARM.TYPE
          is '1-入界 2-出界';
        -- Create/Recreate primary, unique and foreign key constraints 
        alter table EFENCALARM
          add constraint EFENCALARM_ID primary key (ID)
          using index 
          tablespace USERS
          pctfree 10
          initrans 2
          maxtrans 255
          storage
          (
            initial 64K
            minextents 1
            maxextents unlimited
          );
          
          
          insert into menu 
values ('5','报警功能','/leftMenu.page?parentCode=5','0');

insert into menu 
values ('51','机械设备报警','/alarm_search.page?page_type=machine','5');

insert into menu 
values ('52','GPS设备报警','/alarm_search.page?page_type=gps','5');

insert into menu 
values ('53','销售报警','/alarm_search.page?page_type=sell','5');

insert into menu 
values ('54','服务报警','/alarm_search.page?page_type=service','5');
        
 
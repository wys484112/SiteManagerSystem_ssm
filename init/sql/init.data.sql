/*
SQLyog 企业版 - MySQL GUI v7.14 
MySQL - 5.6.16-log : Database - i_wenyiba_com
*********************************************************************
*/

/*所有的表数据插入*/

/*Data for the table `u_permission` */

insert  into `u_permission`(`id`,`url`,`name`) values 
(1,'/permission/index.shtml','权限列表'),
(2,'/permission/addPermission.shtml','权限添加'),
(3,'/permission/deletePermissionById.shtml','权限删除'),
(4,'/permission/addPermission2Role.shtml','权限分配'),
(5,'/permission/allocation.shtml','权限分配'),
(6,'/role/addRole2User.shtml','角色分配保存'),
(7,'/role/deleteRoleById.shtml','角色列表删除'),
(8,'/role/addRole.shtml','角色列表添加'),
(9,'/role/index.shtml','角色列表'),
(10,'/role/clearRoleByUserIds.shtml','用户角色分配清空'),
(11,'/role/allocation.shtml','角色分配'),
(12,'/member/list.shtml','用户列表'),
(13,'/member/online.shtml','在线用户'),
(14,'/member/changeSessionStatus.shtml','用户Session踢出'),
(15,'/member/forbidUserById.shtml','用户激活&禁止'),
(16,'/member/deleteUserById.shtml','用户删除'),
(17,'/site/index.shtml','工地列表'),
(18,'/site/addSite.shtml','工地添加'),
(19,'/site/deleteSiteById.shtml','工地删除'),
(20,'/site/addSite2Role.shtml','工地分配'),
(21,'/site/allocation.shtml','工地分配');

/*Data for the table `u_role` */

insert  into `u_role`(`id`,`name`,`type`) values 
(1,'系统管理员','888888'),
(3,'权限角色','100003'),
(4,'用户中心','100002'),
(5,'工地班长','100004'),
(6,'工地填表人','100005'),
(7,'工地工程师/专员','100006'),
(8,'工地审核专员','100007'),
(9,'工地临时人员','100008');


/*Data for the table `u_role_permission` */

insert  into `u_role_permission`(`rid`,`pid`) values 
(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(1,20),(1,21),
(3,1),(3,2),(3,3),(3,4),(3,5),(3,6),(3,7),(3,8),(3,9),
(4,10),(4,11),(4,12),(4,13),(4,14),
(5,17),(5,18),(5,19),(5,20),(5,21);

/*Data for the table `u_user` */

insert  into `u_user`(`id`,`nickname`,`email`,`pswd`,`create_time`,`last_login_time`,`status`) values 
(1,'管理员','admin','57eb72e6b78a87a12d46a7f5e9315138','2016-06-16 11:15:33','2016-06-16 11:24:10',1),
(11,'test','test','76122e23133a3f54ef9292d6be9d6e71','2016-05-26 20:50:54','2016-06-16 11:24:35',1);

/*Data for the table `u_user_role` */

insert  into `u_user_role`(`uid`,`rid`) values 
(1,1),
(11,5),
(11,6),
(11,7),
(11,8),
(11,9);



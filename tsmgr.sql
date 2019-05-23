/*
Navicat MySQL Data Transfer

Source Server         : lhdb
Source Server Version : 50726
Source Host           : 127.0.0.1:3306
Source Database       : tsmgr

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2019-05-22 14:32:05
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for classes
-- ----------------------------
DROP TABLE IF EXISTS `classes`;
CREATE TABLE `classes` (
  `classname` varchar(255) NOT NULL COMMENT '班级名：专业简称；（方向）；级；班别，计算机（应用）163',
  `major` varchar(255) NOT NULL COMMENT '专业',
  `school` varchar(255) NOT NULL COMMENT '学院',
  PRIMARY KEY (`classname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of classes
-- ----------------------------
INSERT INTO `classes` VALUES ('计算机（应用）163', '计算机科学与技术', '计算机学院');

-- ----------------------------
-- Table structure for courses
-- ----------------------------
DROP TABLE IF EXISTS `courses`;
CREATE TABLE `courses` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `coursename` varchar(255) NOT NULL COMMENT '课程名称',
  `school` varchar(255) NOT NULL COMMENT '开设学院',
  `teachername` varchar(255) NOT NULL,
  `roomlocation` varchar(255) NOT NULL COMMENT '上课地点',
  `lessontype` varchar(255) NOT NULL COMMENT '课程类型：实验课，公共课、基础课、专业基础课、必修课、选修课、专业选修课',
  `time` date NOT NULL,
  `lessonno` varchar(255) NOT NULL COMMENT '第几节课，1-2，7-8，这种,因为一般都是两节课连在一起',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of courses
-- ----------------------------
INSERT INTO `courses` VALUES ('1', 'C语言程序设计I', '计算机学院', '余震侠', 'H2202', '公共课', '2019-04-29', '1-2');

-- ----------------------------
-- Table structure for labclassevaluatetables
-- ----------------------------
DROP TABLE IF EXISTS `labclassevaluatetables`;
CREATE TABLE `labclassevaluatetables` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `teachername` varchar(255) NOT NULL COMMENT '授课教师',
  `coursename` varchar(255) NOT NULL COMMENT '课程名称',
  `classname` varchar(255) NOT NULL COMMENT '上课班级',
  `roomlocation` varchar(255) NOT NULL COMMENT '授课位置',
  `compiler` varchar(255) NOT NULL COMMENT '编辑者',
  `time` date NOT NULL,
  `lessonno` varchar(255) NOT NULL COMMENT '第几节课，1-2，7-8，这种,因为一般都是两节课连在一起',
  `theme` varchar(255) NOT NULL COMMENT '授课主题',
  `t1` int(4) unsigned NOT NULL COMMENT '备课充分，有完整的实验教案或讲义，熟悉实验内容，实验目的明确，内容充实，符合教学大纲要求；',
  `t2` int(4) unsigned NOT NULL COMMENT '分组及人数符合实验要求，指导教师讲授具有启发性，熟悉仪器设备，操作示范正确，熟练。',
  `t3` int(4) unsigned NOT NULL COMMENT '普通话熟练，口头语言表达清楚准确，富有感染力和吸引力，采用板书或其他教学手段（如多媒体、直观教学）演示和介绍实验内容效果良好。',
  `t4` int(4) unsigned NOT NULL COMMENT '实验各环节时间把握恰当，注重引导学生思考和学生实际动手能力的培养，注重探索与改进实验教学方法，重视课堂内外师生双向交流。',
  `t5` int(4) unsigned NOT NULL COMMENT '遵守教学与课堂纪律，上课通信工具关闭，不迟到早退，准时上下课；',
  `t6` int(4) unsigned NOT NULL COMMENT '为人师表，注重教态仪表和言行身教，教书的同时注重育人，引导学生积极向上，不对学生宣讲负面和具有消极影响的言论；',
  `t7` int(4) NOT NULL COMMENT '对学生要求严格，善于管理学生上课出勤和课堂纪律，对原始实验数据审查严格，对实验报告批阅认真规范',
  `t8` int(4) unsigned NOT NULL COMMENT '学生实验兴趣浓，思维活跃，注意力集中，实验秩序纪律好，通过本节实验课的教学，学生能掌握本节课的教学内容，感觉受启发，收获大。',
  `generallevel` int(4) unsigned NOT NULL COMMENT '总分',
  `generalcomment` varchar(255) NOT NULL COMMENT '综合评语',
  `labmgrlevel` int(4) unsigned NOT NULL COMMENT '按时开门，环境整洁，实验仪器设备维护完好，台套数满足教学要求；实验室管理规范，室内醒目位置有文字式的管理制度与操作规范，',
  `iscolleage` int(4) unsigned DEFAULT NULL COMMENT '非同行检查性听课的人员可以不对“教学内容”模块第1—2项作出评价，其评价总分按第4—8项得分总和的1.49倍计算得出。',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for normalclassevaluatetables
-- ----------------------------
DROP TABLE IF EXISTS `normalclassevaluatetables`;
CREATE TABLE `normalclassevaluatetables` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `teachername` varchar(255) NOT NULL,
  `coursename` varchar(255) NOT NULL,
  `classname` varchar(255) NOT NULL,
  `roomlocation` varchar(255) NOT NULL,
  `compiler` varchar(255) NOT NULL COMMENT '编辑者',
  `time` date NOT NULL,
  `lessonno` varchar(255) NOT NULL COMMENT '第几节课，1-2，7-8，这种,因为一般都是两节课连在一起',
  `theme` varchar(255) NOT NULL,
  `t1` int(4) unsigned NOT NULL COMMENT '教学内容和目标明确，符合教学大纲要求',
  `t2` int(4) unsigned NOT NULL COMMENT '教学内容娴熟，问题阐述收放自如',
  `t3` int(4) unsigned NOT NULL COMMENT '讲述条理清晰，概念准确，重点突出',
  `t4` int(4) unsigned NOT NULL,
  `t5` int(4) unsigned NOT NULL,
  `t6` int(4) unsigned NOT NULL COMMENT '有先进的教学理念、实用的教学方法，教学设计精心、课堂效果好',
  `t7` int(4) unsigned NOT NULL COMMENT '能启发引导学生积极、主动思考',
  `t8` int(4) unsigned NOT NULL COMMENT '与学生交流互动好，课堂氛围活跃',
  `t9` int(4) unsigned NOT NULL COMMENT '学生注意力集中，课堂纪律好',
  `t10` int(4) NOT NULL COMMENT '通过本节课的教学内容，学生能掌握本节课的教学内容，感觉受启发，收获大',
  `generallevel` int(4) unsigned NOT NULL COMMENT '总评',
  `teachercondition` int(4) unsigned NOT NULL COMMENT '1，提前进教室准备；2，迟到；3，早退',
  `classatomspere` int(4) unsigned NOT NULL COMMENT '课堂氛围',
  `studentscondition` int(4) unsigned NOT NULL COMMENT '学生情况',
  `playphone` int(4) unsigned NOT NULL,
  `bookcondition` int(4) unsigned NOT NULL COMMENT '教材情况',
  `lookupcondition` int(4) unsigned NOT NULL COMMENT '抬头情况',
  `sitecondition` int(4) unsigned NOT NULL COMMENT '就坐情况',
  `teachingshape` int(4) unsigned NOT NULL COMMENT '授课形式',
  `iscolleage` int(4) unsigned DEFAULT NULL COMMENT '非同行检查性听课的人员可以不对“教学内容”模块第1—2项作出评价，其评价总分按第4—8项得分总和的1.49倍计算得出。',
  `generalcomment` varchar(255) NOT NULL COMMENT '总体评价',
  `other` varchar(255) DEFAULT NULL COMMENT '其他',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for rooms
-- ----------------------------
DROP TABLE IF EXISTS `rooms`;
CREATE TABLE `rooms` (
  `roomlocation` varchar(255) NOT NULL COMMENT '教室位置：校区，H——航空港，L——龙泉，R——人南；（用途）；第i教学楼；楼层里各教室的编号',
  `roomusage` varchar(255) DEFAULT NULL COMMENT '教室昵称，用于对教室备注，比如，H5301为“ACM训练基地”',
  `roomtype` varchar(255) NOT NULL COMMENT '类型：教室, 实验室',
  PRIMARY KEY (`roomlocation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sgmembers
-- ----------------------------
DROP TABLE IF EXISTS `sgmembers`;
CREATE TABLE `sgmembers` (
  `id` int(255) NOT NULL AUTO_INCREMENT COMMENT '用户账户id',
  `sgmname` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sgmname` (`sgmname`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for systemimformation
-- ----------------------------
DROP TABLE IF EXISTS `systemimformation`;
CREATE TABLE `systemimformation` (
  `id` int(11) NOT NULL,
  `collegename` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `schoolname` varchar(100) DEFAULT NULL,
  `forbidteacher` tinyint(2) DEFAULT NULL COMMENT '0都允许1禁止登录;2禁止注册;3禁止登录和注册.',
  `forbidtsmember` tinyint(2) DEFAULT NULL,
  `noticeteacher` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `noticetsmember` varchar(500) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of systemimformation
-- ----------------------------
INSERT INTO `systemimformation` VALUES ('1', '成都信息工程大学', '计算机学院', '0', '0', '请教师们尽快完成课程评价任务！', '请尽快完成课程评价任务！');

-- ----------------------------
-- Table structure for tasks
-- ----------------------------
DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taskexecuter` varchar(255) NOT NULL,
  `teachername` varchar(255) NOT NULL,
  `coursename` varchar(255) NOT NULL,
  `roomlocation` varchar(255) NOT NULL,
  `lessontype` varchar(255) DEFAULT NULL,
  `time` date NOT NULL,
  `lessonno` varchar(255) NOT NULL,
  `comment` varchar(255) DEFAULT '' COMMENT '备注',
  `classtype` int(4) unsigned NOT NULL COMMENT '0,1实验课',
  `finished` int(4) unsigned NOT NULL DEFAULT '0',
  `ntid` int(11) unsigned NOT NULL DEFAULT '0',
  `ltid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for teachers
-- ----------------------------
DROP TABLE IF EXISTS `teachers`;
CREATE TABLE `teachers` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户账户id',
  `teachername` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `teachername` (`teachername`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `username` varchar(64) NOT NULL COMMENT '登录名',
  `sgmname` varchar(10) DEFAULT NULL,
  `teachername` varchar(10) DEFAULT NULL,
  `password` varchar(128) NOT NULL,
  `registedate` datetime NOT NULL,
  `type` int(11) NOT NULL COMMENT '1，管理员；2，督导员；3，老师',
  PRIMARY KEY (`username`),
  KEY `sgmname` (`sgmname`) USING BTREE,
  KEY `teachername` (`teachername`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('admin', null, null, '21232f297a57a5a743894a0e4a801fc3', '2019-05-03 13:37:08', '3');

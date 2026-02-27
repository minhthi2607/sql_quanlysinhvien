create database quanlysinhvien;

use quanlysinhvien;

create table Class(
	ClassId int not null auto_increment primary key,
    ClassName varchar(60) not null,
    StartDate datetime not null,
    Status bit
);

create table Student(
	StudentId int not null auto_increment primary key,
    StudentName varchar(30) not null,
    Address varchar(50),
    Phone varchar(20),
    Status bit,
    ClassId int not null ,
    foreign key (ClassId) references Class(ClassId)
);

create table Subject(
	SubId int not null auto_increment primary key,
    SubName varchar(30) not null,
    Credit tinyint not null default 1 check (Credit >= 1 ),
    Status bit default 1
);

create table Mark(
	MarkId int not null auto_increment primary key,
    SubId int not null,
    StudentId int not null,
    Mark float default 0 check (Mark between 0 and 100),
    ExamTimes tinyint default 1,
    unique (SubId, StudentId),
    foreign key (SubId) references Subject(SubId),
    foreign key (StudentId) references Student(StudentId)
);

insert into Class value(1, 'a1', '2008-12-20', 1);
insert into Class value(2, 'a2', '2008-12-22', 1);
insert into Class value(3, 'b3', current_date() , 0);

insert into Student (StudentName, Address, Phone, Status, ClassId) value('Hung', 'Ha Noi', '123456789', 1, 1);
insert into Student (StudentName, Address, Status, ClassId) value('Hoa', 'Hai Phong',  1, 1);
insert into Student (StudentName, Address, Phone, Status, ClassId) value('Manh', 'HCM', '147853648', 0, 1);

insert into Subject value(1, 'cf', 5,1), 
(2, 'c', 6,1),
(3, 'hdj', 5,1),
(4, 'rdbms', 10,1);

insert into Mark (SubId, StudentId, Mark, ExamTimes)
value(1,1,8,1),
(1,2,10,2),
(2,1,12,1);

select * from Subject;
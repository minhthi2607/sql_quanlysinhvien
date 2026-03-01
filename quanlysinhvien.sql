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

select * from Student;
select * from Student
where Status = true;

select * from Subject
where Credit < 10;	

select s.StudentId, s.StudentName, c.ClassName
from Student s join Class c on s.ClassId = c.ClassId;

select s.StudentId, s.StudentName, c.ClassName
from Student s join Class c on s.ClassId = c.ClassId
where c.ClassName = 'a1';


SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark
FROM Student S join Mark M on S.StudentId = M.StudentId join Subject Sub on M.SubId = Sub.SubId;

SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark
FROM Student S join Mark M on S.StudentId = M.StudentId join Subject Sub on M.SubId = Sub.SubId
WHERE Sub.SubName = 'cf';


select * from Student where StudentName like 'h%';
select * from Class;
select * from Class where StartDate like '____-12-%';
select * from Subject;
select * from Mark;
select * from Subject where Credit between 3 and 5;
select * from Student;
SET SQL_SAFE_UPDATES = 0;
update Student set ClassId = 2 where StudentName = 'Hung';
SET SQL_SAFE_UPDATES = 1;

select s.StudentName, sub.SubName, m.Mark
from Student s
inner join Mark m on s.StudentId = m.StudentId
inner join Subject sub on m.SubId = sub.SubId
order by m.mark desc, s.StudentName asc;

use quanlysinhvien;
select address , count(studentid) as 'soluonghocvien'
from student 
group by address;

select s.studentid ,s.studentname, avg(mark)
from student s join mark m on m.studentid = s.studentid
group by s.studentid, s.studentname;


select s.studentid, s.studentname, avg(mark)
from student s join mark m on s.studentid = m.studentid
group by s.studentid, s.studentname
having avg(mark) > 15;

select s.studentid, s.studentname, avg(mark)
from student s join mark m on s.studentid = m.studentid
group by s.studentid, s.studentname; 

SELECT S.StudentId, S.StudentName, AVG(Mark)
FROM Student S join Mark M on S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName
HAVING AVG(Mark) >= ALL (SELECT AVG(Mark) FROM Mark GROUP BY Mark.StudentId);

select * from subject
where credit = (select max(credit) from subject);

select * from subject s
join mark m on m.subid = s.subid
where mark = (select max(mark) from mark);

select s.studentid, s.studentname , avg(mark) as avg_mark
from student s join mark m on s.studentid = m.studentid

group by s.studentid, s.studentname
order by avg_mark desc;
